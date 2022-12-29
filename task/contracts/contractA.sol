//SPDX-License-Identifier:MIT

pragma solidity ^0.8.9;

contract contractA{
    address admin;
    uint a;
    bool locked;

    function initializer(address _owner) public{
        admin=_owner;
    }

    modifier onlyOwner() {
        require(msg.sender==admin,"not the owner");
        _;
    }

    modifier noReentrancy(){
        require(!locked,"reentrancy");
        locked=true;
        _;
        locked=false;
    }

    function setA(uint inc) public noReentrancy() onlyOwner(){
        a=a+inc;
    }

    function getA() public view returns(uint ){
        return a;
    }

    function getOwner() public view returns(address ){
        return admin;
    }
}