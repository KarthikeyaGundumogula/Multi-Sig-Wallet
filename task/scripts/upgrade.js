const { ethers, upgrades } = require("hardhat");

async function main() {
  const ContractAv2 = await ethers.getContractFactory("contractAv2");
  console.log("Upgrading contract...");
  await upgrades.upgradeProxy(
    "0xC0E2f6b2A4b75ec42A3CE56C498B3e8cbB476dBa",
    ContractAv2
  );
  console.log("Contract Upgraded");
}

main()
  .then()
  .catch((e) => console.error(e));
