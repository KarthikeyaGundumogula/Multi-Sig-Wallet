const { ethers, upgrades } = require("hardhat");

async function main() {
  const ContractA = await ethers.getContractFactory("contractA");
  console.log("deploying your contract..");
  const contractA = await upgrades.deployProxy(
    ContractA,
    ['0x2103308394ed0e5a02d3d1516c7fa17f1076a9bb'],
    { initializer: "initializer" }
  );
  await contractA.deployed();
  console.log("contract is deployed is deployed at: ", contractA.address);
}

main()
  .then()
  .catch((e) => console.error(e));


  //0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0