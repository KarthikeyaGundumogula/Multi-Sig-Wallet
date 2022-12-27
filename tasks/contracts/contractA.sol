// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract contractA {
    uint a;
    bool aIsSet;
    address owner;
    function setOwner(address _owner) public {
        owner=_owner;
    }
    struct inputsA {
        uint ipA;
        uint ipB;
    }
    inputsA iA;
    
    function setA(uint _inc) onlyOwner() public {
        aIsSet=false;
        a+=_inc;
        aIsSet=true;
    }
    function getA() public view  returns(uint) {
        require(aIsSet,"a is not set");
        return a;
    }

    modifier onlyOwner() {
        require(msg.sender==owner,"you are not the owner");
        _;
    }
}
