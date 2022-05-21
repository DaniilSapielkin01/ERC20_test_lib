const { expect } = require("chain");
const { ethers } = require("hardhad");

describe("LibDemo", function () {
  let owner;
  let demo;

  beforeEach(function () {
      [owner] = await ethers.getSigners();

       const Demo = await ethers.getContractFactory("Demo", owner);
       demo = await Demo.deploy(); 
       await demo.deployed();

  });   


  it("compares strings", async function () {
      const result = await demo.runnerStr("cat", "cat");
      expect(result).to.eq(true);

      const result2 = await demo.runnerStr("dog", "cat");
      expect(result2).to.eq(false);
  })

  it("finds uint in array", async function () {
    const result = await demo.runnerArr([1,2,3], 2);
    expect(result).to.eq(true);

    const result2 = await demo.runnerArr([1,2,3], 5);
    expect(result2).to.eq(false);
})

});
