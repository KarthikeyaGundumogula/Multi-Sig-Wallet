//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;
import "./IAccessReg.sol";

contract MultiSigWallet{
    event approve(address indexed owner,uint txId);
    event deposit(address indexed sender,uint value,uint balance);
    event submitTx(address indexed owner,uint indexed txId,address indexed to,uint value);
    event revokeTx(address indexed owner, uint indexed txId);
    event executeTx(uint indexed txId);
    uint requiredVotes;
    address[] owners;
    mapping(address=>bool)  isOwner;
    struct Tx{
        address to;
        uint value;
        uint numOfVotes;
        bool isExecuted;
    }

    modifier onlyOwner(){
        require(isOwner[msg.sender],'only owners can perform this operation');
        _;
    }

    modifier txExists(uint txId){
        require(txId<Transactions.length,'transaction does not exist');
        _;
    }

    modifier txNotExecuted(uint txId){
        require(!Transactions[txId].isExecuted,'transaction is already executed');
        _;
    }

    modifier notApproved(uint txId){
        require(!isApproved[txId][msg.sender],'owner already approved');
        _;
    }

    Tx[] public Transactions;
    mapping(uint=>mapping(address=>bool)) public isApproved;

    IAccessReg accessReg;
    constructor() {
        address regContract=0xf8b0EbD0D438B00C05F431128FB0bD9a625AA7cb;
        accessReg=IAccessReg(regContract);
    }

    function intializeOwners() public {
        owners=accessReg.getAllsigners();
        for(uint i=0;i<owners.length;i++){
            isOwner[owners[i]]=true;
        }
        uint x=owners.length*3;
        uint y=x/5;
        if(x%5>0){
            y+=1;
        }
        requiredVotes=y;
    }

    receive() payable external {
        emit deposit(msg.sender,msg.value,address(this).balance);
    }

    function submitTransaction(address _to,uint _value) external onlyOwner() {
        uint txId=Transactions.length;
        Transactions.push(Tx({
            to:_to,
            value:_value,
            numOfVotes:0,
            isExecuted:false
        }));

        emit submitTx(msg.sender,txId,_to,_value);
    }

    function approveTx(uint _txId)external 
    onlyOwner()
    txExists(_txId)
    txNotExecuted(_txId)
    notApproved(_txId) {
        Tx storage transaction = Transactions[_txId];
        transaction.numOfVotes+=1;
        isApproved[_txId][msg.sender]=true;
        emit approve(msg.sender,_txId);
    }

    function executeTransaction(uint _txId) external
    onlyOwner()
    txNotExecuted(_txId)
    txExists(_txId)
    {
        Tx storage transaction = Transactions[_txId];
        require(transaction.numOfVotes>=requiredVotes,'not enough votes to execute Tx');
        (bool success, )=transaction.to.call{value:transaction.value}("");
        require(success,'Transaction Failed');
        transaction.isExecuted=true;
        emit executeTx(_txId);
    }

    function revokeTransaction(uint _txId)public 
    onlyOwner()
    txNotExecuted(_txId)
    txExists(_txId)
    {
        Tx storage transaction=Transactions[_txId];
        transaction.numOfVotes-=1;
        isApproved[_txId][msg.sender]=false;
        emit revokeTx(msg.sender,_txId);
    }

    function getOwners() external view returns(address[] memory){
        return owners;
    }

    function getTransaction(uint _txId) external view returns(Tx memory){
        return Transactions[_txId];
    }

    function getTransactions() external view returns(uint ){
        return Transactions.length-1;
    }
}