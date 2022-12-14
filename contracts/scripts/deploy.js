const {ethers} =require("hardhat");

async function main(){
  const factory=await ethers.getContractFactory("MultiSigWallet");
  console.log("deplying your contract");
  const deployer=await factory.deploy();
  console.log(deployer.address);
}

main();