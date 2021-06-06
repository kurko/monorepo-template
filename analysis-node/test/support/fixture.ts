import fs from 'fs';

export function getFixture(filename: string) {
  return fs.readFileSync(`./test/fixtures/${filename}`).toString();
}
