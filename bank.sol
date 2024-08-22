// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Bank {
    uint public count;
    mapping(address=>uint) balanceLedger;
    mapping(uint=>address) ledgerCount;
    address public admin;

    constructor() {
        admin=msg.sender;
    }

    modifier onlyAdmin(){
        require(admin==msg.sender,"Unauthorized Access!!!");
        _;
    }

    modifier balanceCheck(uint amt){
        require(balanceLedger[msg.sender]>=amt, "Insufficient Funds");
        _;
    }

    function deposit()public payable{
        if(balanceLedger[msg.sender]==0){
            ledgerCount[++count]=msg.sender;
        }
        balanceLedger[msg.sender]+=msg.value;
    }

    function withdraw(uint amt)public balanceCheck(amt){
        // require(balanceLedger[msg.sender]>=amt,"Insufficient Funds. You are broke");
        balanceLedger[msg.sender]-=amt;
        payable (msg.sender).transfer(amt);
    }

    function transfer(address person, uint amt)public balanceCheck(amt){
        // require(balanceLedger[msg.sender]>=amt,"Insufficient Funds. You cannot transfer" );
        balanceLedger[msg.sender]-=amt;
        payable (person).transfer(amt);
    }

    function monitorBalance()public view onlyAdmin returns(address,uint){
        uint maxBalance;
        address maxAddress;
        for(uint i=1;i<=count;i++){
            if(maxBalance<=balanceLedger[ledgerCount[i]]){
                maxAddress= ledgerCount[i];
                maxBalance= balanceLedger[maxAddress];
            }
        }
        return(maxAddress, maxBalance);
    }
}