const { ethers, upgrades } = require("hardhat");

async function main() {
  const ContractAv2 = await ethers.getContractFactory("contractAv2");
  console.log("Upgrading contract...");
  await upgrades.upgradeProxy(
    "0xD9dB318878Ed9f8062F4A0A894393636E3549946",
    ContractAv2
  );
  console.log("Contract Upgraded");
}

main()
  .then()
  .catch((e) => console.error(e));
