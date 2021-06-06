import { getFixture } from './support/fixture';
import InitialClass from './../src/initial_class';

test("initial test", async (done) => {
  let fixture = getFixture("some_data.txt")
  expect(fixture.toString()).toEqual("File content.\n")

  done()
})
