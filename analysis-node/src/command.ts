import { CliArguments, AvailableArguments } from './cli/arguments';
import { InitialClass } from 'analysis';

export const availableArguments: AvailableArguments = {
  "help": { },
  "some-action": {
    "argument1": { withValue: true },
    "argument2": { withValue: true, default: "second value" }
  }
} as const;

export class Command {
  args!: CliArguments;
  proc: any

  constructor(parameters?: { processDouble?: any }) {
    if (parameters?.processDouble) {
      this.proc = parameters!.processDouble
    } else {
      this.proc = process
    }

    try {
      this.args = new CliArguments(this.proc.argv.slice(2), availableArguments)
    } catch(e) {
      this.proc.stderr.write(`${e.message}\n`);
      this.proc.exit(1);
    }
  }

  /*
   * This is the entrypoint from the command-line.
   */
  exec(): void {
    /**
     * COMMAND 1
     */
    if (this.args.action() === "help") {
      this.proc.stdout.write("Not implemented yet");
      this.proc.exit(0);

    }
    /**
     * COMMAND 2
     */
    else if (this.args.action() === "some-action") {
      let data = {
        result: new InitialClass().stringList(),
        arg1: Buffer.from(this.args.valueByName('argument1'), 'base64').toString('utf8'),
        arg2: this.args.valueByName("argument2")
      }
      this.proc.stdout.write(JSON.stringify(data));
    }
  }
}
