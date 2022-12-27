// scripts/upgrade_box.js
const { ethers, upgrades } = require("hardhat");

async function main() {
  const BoxV2 = await ethers.getContractFactory("contractAv2");
  console.log("Upgrading Box...");
  await upgrades.upgradeProxy(
    "0xbE9dE4D39C8c5dc6250f58c0fdEFf6c50015F588",
    BoxV2
  );
  console.log("Box upgraded");
}

main();
