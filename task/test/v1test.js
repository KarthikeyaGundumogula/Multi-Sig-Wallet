const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");
const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const BN = require("bn.js");

describe("testing...", function () {
  it("checking owner rights ", async function () {
    let [x] = await ethers.getSigners();
    const contractFactory = await ethers.getContractFactory("contractA");
    const contract = await upgrades.deployProxy(contractFactory, [x.address], {
      initializer: "initializer",
    });
    await contract.deployed();

    await expect(await contract.getOwner()).to.equal(x.address);
  });

  it("checking getters and setters", async function () {
    const contractFactory = await ethers.getContractFactory("contractA");
    const [x] = await ethers.getSigners();
    const contract = await upgrades.deployProxy(contractFactory, [x.address], {
      initializer: "initializer",
    });
    await contract.deployed();
    let y = await contract.setA(ethers.BigNumber.from("9"));
    await y.wait();
    expect(ethers.BigNumber.from(await contract.getA())).to.equal(
      ethers.BigNumber.from("9")
    );
  });
});
