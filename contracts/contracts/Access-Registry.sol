//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract AccessRegistry{
    address admin;
    address[] signers;
    address[] blackListedSigners;
    mapping(address=>bool) isBlackListed;
    mapping(address=>uint) blackListedToIndex;
    mapping(address=>bool) isSigner;
    mapping(address=>uint) signerToIndex;

    constructor () {
        admin=msg.sender;
    }

    modifier onlyAdmin(){
        require(msg.sender==admin,"You are not the owner of this contract");
        _;
    }

    modifier isExist(address sig){
        require(isSigner[sig],"signer does not exist");
        _;
    }

    modifier notExist(address sig){
        require(!isSigner[sig],"signer already exist `try revoking the Signer`");
        _;
    }

    modifier BlackListed(address sig){
        require(!isBlackListed[sig],"this Address is Blacklisted `contact Admin`");
        _;
    }

    function addSigner(address newSig) public onlyAdmin() notExist(newSig) BlackListed(newSig)
    {
        signers.push(newSig);
        isSigner[newSig]=true;
        signerToIndex[newSig]=signers.length-1;
    }

    function revokeSigner(address sig) public onlyAdmin() isExist(sig)
    {
        require(isSigner[sig],'signer does not Exist');
        uint index=signerToIndex[sig];
        signers[index]=signers[signers.length-1];
        isSigner[sig]=false;
        signers.pop();
    }

    function transferSigner(address from,address to) public onlyAdmin() isExist(from) notExist(to)
    {
        uint fromIndex=signerToIndex[from];
        signers[fromIndex]=to;
        isSigner[to]=true;
        isSigner[from]=false;
    }

    function renounceSigner(address sig) public onlyAdmin() notExist(sig) {
        isBlackListed[sig]=true;
        blackListedSigners.push(sig);
    }

    function removeFromBlackList(address sig) public onlyAdmin() 
    {
        require(isBlackListed[sig],"not a blackListedSigner");
        uint index=blackListedToIndex[sig];
        isBlackListed[sig]=false;
        blackListedSigners[index]=blackListedSigners[blackListedSigners.length-1];
        blackListedSigners.pop();
    }

    function getAllsigners() public view returns(address[] memory) 
    {
        return(signers);
    }

    function getAllBlackListed() public view returns(address[] memory){
        return(blackListedSigners);
    }

    function getOwner() public view returns(address)
    {
        return admin;
    }
}
