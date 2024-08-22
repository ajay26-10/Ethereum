// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

contract Book {

    struct MyBook{
        string title;
        uint price;
        address owner;
        bool sold;
    }
   
    address [] public buyers;

    MyBook public b1;


    function getBook() public view returns(string memory, uint) {
        return (b1.title,b1.price);
    }
    
    function setBook(string memory bookname, uint bookprice) public {
        b1.title = bookname;
        b1.price = bookprice;
    }

    function convertToWie(uint amount) public pure returns(uint){
        return amount*1000000000000000000;
    }

    function buyBook() public payable{
        require(convertToWie(b1.price)<=msg.value, "Insufficient Funds");
            b1.owner = msg.sender;
            buyers.push(b1.owner);
            b1.sold=true;
            uint balance = msg.value-convertToWie(b1.price);
            if(balance>0){
                payable (msg.sender).transfer(balance);
            }
        
    }

    function buyersCount() public view returns(uint){
        return (buyers.length);
    }

}