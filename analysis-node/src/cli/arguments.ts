interface ArgumentRules {
  withValue: boolean,
  default?: any
}

interface ActionOptions {
  [key: string]: ArgumentRules
}

export interface AvailableArguments {
  [key: string]: ActionOptions
}

const debug = false;

export class CliArguments {
  rawInput: string[];
  availableArguments: AvailableArguments;
  parsedInput: { [key: string]: string };

  constructor(rawInput: string[], availableArguments: AvailableArguments) {
    this.rawInput = rawInput;
    this.availableArguments = availableArguments;
    this.parsedInput = this.parse(rawInput);
  }

  action(): string {
    return this.parsedInput["action"];
  }

  valueByName(key: string): any {
    if (key == "action") {
      return this.action()
    }

    let value = this.parsedInput[key];
    const defaultValue = this.availableArguments[this.action()][key]["default"]

    if (typeof value === "undefined" && typeof defaultValue !== "undefined") {
      value = defaultValue
    }

    return value
  }

  parse(cliOptions: string[]): { string: string } | {} {
    let result: {[key: string]: string | boolean | number} = {};
    let action: string;
    let ignoreFirstTwoArgs = cliOptions[0] === "node";

    if (ignoreFirstTwoArgs) {
      cliOptions = cliOptions.slice(2);
    }

    cliOptions.forEach((value, index) => {
      if (debug) {
        console.log("each cliOption: value & index", value, index)
      }

      if (index === 0) {
        if (typeof(value) === undefined) {
          throw new Error(`Please specify an action.`);
        } else if (!Object.keys(this.availableArguments).includes(value)) {
          throw new Error(`Invalid action: ${value}`);
        }

        action = value
        result["action"] = value;
      } else if (value.match(/^-/)) {
        let option = value.replace(/^--?/, ''),
            actionOptions: ActionOptions = this.availableArguments[action],
            optionProperties;

        if (!Object.keys(actionOptions).includes(option)) {
          throw new Error(`Invalid option: ${value}.`);
        }

        optionProperties = actionOptions[option];

        if (optionProperties.withValue) {
          result[option] = cliOptions[index + 1];

        }

        if (optionProperties.default && typeof result[option] === "undefined") {
          result[option] = optionProperties.default || true;
        }

        if (debug) {
          console.log("arg + value", value, result[option])
        }
      }
    })
    return result;
  }
}
