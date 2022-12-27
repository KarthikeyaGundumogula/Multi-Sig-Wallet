const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");

describe("testing...", function () {
  it("checking owner rights ", async function () {
    const contractFactory = await ethers.getContractFactory("contractA");
    const contract = await upgrades.deployProxy(
      contractFactory,
      ["0x2103308394ed0e5a02d3d1516c7fa17f1076a9bb"],
      { initializer: "initializer" }
    );
    await contract.deployed();

    await expect(await contract.getOwner()).to.equal(
      ethers.utils.getAddress("0x2103308394ed0e5a02d3d1516c7fa17f1076a9bb")
    );
  });

  it("checking only admin", async function(){
    
    const contractFactory = await ethers.getContractFactory("contractA");
    const contract = await upgrades.deployProxy(
      contractFactory,
      ["0x2103308394ed0e5a02d3d1516c7fa17f1076a9bb"],
      { initializer: "initializer" }
    );
    await contract.deployed();
    expect(await contract.setA(9)).to.be.revertedWith("not the owner")
  })

});
