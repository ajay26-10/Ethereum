// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Diya {
    string username = "Diya";

    function getname() public view returns(string memory){
        return username;
    }

    function setname(string memory _username) public {
        username = _username;
    }
}