import { CliArguments, AvailableArguments } from './../../src/cli/arguments';

let args: CliArguments;

export const availableArguments: AvailableArguments = {
  "help": { },
  "some-action": {
    "argument1": { withValue: true },
    "argument2": { withValue: true, default: "second value" }
  }
} as const;

test("arguments are recognized", () => {
  args = new CliArguments(
    [
      "node", "some-filename",
      "some-action",
      "--argument1",
      "arg1-value",
      "--argument2"
    ],
    availableArguments
  )

  expect(args.valueByName('action')).toBe("some-action");
  expect(args.valueByName('argument1')).toBe("arg1-value");
  expect(args.valueByName('argument2')).toBe("second value");
});
