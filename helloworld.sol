// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract HelloWorld {
    uint data = 44;

    function get() public view returns (uint){
        return (data);
    }

    function set(uint _data) public {
        data = _data;
    }
}