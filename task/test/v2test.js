const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

describe("testing v2", function () {
  async function contractFixture() {
    const contractFactory = await ethers.getContractFactory("contractA");
    const [owner] = await ethers.getSigners();
    const contractv1 = await upgrades.deployProxy(
      contractFactory,
      [owner.address],
      {
        initializer: "initializer",
      }
    );
    const contractAv2Factory = await ethers.getContractFactory("contractAv2");
    await upgrades.upgradeProxy(contractv1.address, contractAv2);
    return contract;
  }
  it("test for struct initialzation..", async function () {
    const contract = await loadFixture(contractFixture);
  });
});
