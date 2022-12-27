//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract contractAv2{
    uint a;
    bool aIsSet;
    function getA() public view  returns(uint) {
        require(aIsSet,"a is not set");
        return a;
    }
    struct inputsA {
        uint ipA;
        uint ipB;
    }
    inputsA iA;
    function initializeStruct() private {
        iA=inputsA(a,0);
    }
    function setA(uint _ipA,uint _ipB) public {
        aIsSet=false;
        iA.ipA+=_ipA;
        iA.ipB+=_ipB;
        aIsSet=true;
    }
}