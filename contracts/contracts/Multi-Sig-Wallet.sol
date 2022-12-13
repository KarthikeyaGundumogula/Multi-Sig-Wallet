//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract MultiSigWallet{
    event approve(uint indexed txId);
    event deposit(address indexed sender,uint value,uint balance);
    event submitTx(address indexed owner,uint indexed txId);
    event cancelTx(address indexed owner, uint indexed txId);
    uint requiredVotes;
    address[] public owners;
    mapping(address=>bool) public isOwner;
    struct Tx{
        address to;
        uint value;
        uint numOfVotes;
        bool isExecuted;
    }

    Tx[] public Transactions;
    mapping(uint=>mapping(address=>bool)) public isApproved;

    function createWallet(address[] memory _owners,uint _requiredVotes) external{
        require(_owners.length>0,"wallet must have owners");
        require(_requiredVotes>0 && requiredVotes<_owners.length,"Invalid number of Votes");
        for(uint i=0;i<_owners.length;i++){
            address owner=_owners[i];
            require(owner!=address(0),'address is invalid');
            require(!isOwner[owner],'addresses must be unique');
            isOwner[owner]=true;
        }
        requiredVotes=_requiredVotes;
    }

    receive() payable external {
        emit deposit(msg.sender,msg.value,address(this).balance);
    }

    function submitTransaction()
}