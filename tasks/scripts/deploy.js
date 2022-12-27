// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const {ethers,upgrades } = require("hardhat");

async function main() {
  const factory =await ethers.getContractFactory("contractA")
  const contractA= await upgrades.deployProxy(factory,initilizer{[0x2103308394Ed0E5A02D3d1516C7fA17F1076A9bb],"setowner"})
  await contractA.deployed();
  console.log("contract is deployed at ",contractA.address);
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
