const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");
const { loadFixtures } = require("@nomicfoundation/hardhat-network-helpers");

describe("testing v2", function () {
  async function contractFixture() {
    const contractFactory = await ethers.getContractFactory("contractA");
    const [owner] = await ethers.getSigners();
    const contract = await upgrades.deployProxy(contractFactory, [owner], {
      initializer: "initializer",
    });
    return contract;
  }
  it("test for struct initialzation..", async function () {
    const contract = await loadFixtures(contractFixture);
    console.log(await contract.getA());
  });
});
