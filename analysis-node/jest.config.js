module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  "testPathIgnorePatterns": [
    ".git/.*",
    "node_modules/.*"
  ],
  "transformIgnorePatterns": [
    "node_modules/.*",
    ".*\\.js"
  ],
  "cacheDirectory": ".jest-cache",
  globals: {
    'ts-jest': {
      isolatedModules: true
    }
  }
};
