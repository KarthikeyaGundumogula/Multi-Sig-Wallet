//SPDX-License-Identifier:MIT

pragma solidity ^0.8.9;

contract contractAv2{
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
    struct inputs {
        uint ip1;
        uint ip2;
    }
    inputs I1;

    function initializeStruct() public {
        I1=inputs(a,0);
    }


    function setA(uint ipA,uint ipB) public onlyOwner() noReentrancy(){
        I1.ip1+=ipA;
        I1.ip2=ipB;
    }

    function getA() public view returns(uint ,uint  ){
        return (I1.ip1,I1.ip2);
    }
}