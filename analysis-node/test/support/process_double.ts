export default function(customAttrs: object = {}): any {
  let stdoutBuffer = []

  return {
    argv: [],
    exit: (exitCode: number) => {},
    ...customAttrs,
    env: {
      ENGINE_BIN: process.env.ENGINE_BIN,
      ...customAttrs["env"] || {}
    },
    stderr: {
      write: (str) => {},
      ...customAttrs["stderr"] || {}
    },
    stdout: {
      write: (str) => { stdoutBuffer.push(str) },
      ...customAttrs["stdout"] || {}
    },
    stdoutBuffer: () => stdoutBuffer
  }
}
