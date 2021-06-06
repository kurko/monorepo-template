import { Command } from './../../src/command';
import { getFixture } from './../support/fixture';
import processDouble from './../support/process_double';

const fixture = getFixture("fixture.txt");
const originalProcess = process;

afterEach(() => {
  delete process.env.NODE_ENV;
  delete process.argv;
})

test("report analysis", (done) => {
  const depth = 5
  let process = processDouble({
    argv: [
      "node",
      "some.js",
      "some-action",
      "--argument1",
      Buffer.from(fixture).toString("base64"),
      "--argument2"
    ]
  })

  let result = new Command({ processDouble: process })
  result.exec()

  setTimeout(() => {
    // In case you need to debug the output, uncomment the following:
    // console.log(process.stdoutBuffer())
    let stdout = process.stdoutBuffer()[0]
    let report = JSON.parse(stdout)

    expect(report.result).toStrictEqual(["John", "Mary"]);
    expect(report.arg2).toStrictEqual("second value");
    expect(report.arg1).toStrictEqual("some fixture\n");

    done()
  }, 50)
});
