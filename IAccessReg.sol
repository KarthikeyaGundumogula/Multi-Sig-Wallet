//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

interface IAccessReg{
   function getAllsigners() external view returns(address[] memory);
}
