import { assert, expect } from "chai";

describe("basic", () => {
  it("should run a basic test", () => {
    const compare1: number = 1;
    const compare2: number = 2;

    assert(compare1 !== compare2);
    expect(compare1 === 1);
    expect(compare2 === 2);
  });
});