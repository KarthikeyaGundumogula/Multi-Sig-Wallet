require("@nomicfoundation/hardhat-toolbox");
require("@openzeppelin/hardhat-upgrades");
require("dotenv").config();
const URL=process.env.URL;
const PRIVATE_KEY=process.env.PRIVATE_KEY;
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks:{
    polygon:{
      url:URL,
      accounts:[PRIVATE_KEY]
    }
  }
};
