// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Op {
    // uint demo;              // потрачено 67072 газа
    // ===============================================
    // uint128 a = 1;
    // uint128 b = 1;
    // uint256 c = 1;          // 113526
    // ===============================================
    // uint demo = 1;             // 89248
    // ===============================================
    // mapping(address => uint) payments;
    // function pay() external payable {
    //     require(msg.sender != address(0), "zero address");
    //     payments[msg.sender] = msg.value;
    // }                           // 140045
    // ===============================================
    // uint[10] payments;
    // function pay() external payable {
    //     require(msg.sender != address(0), "zero address");
    //     payments[0] = msg.value;
    // }                      // 140945
    // ===============================================
    // uint8[] demo = [1, 2, 3];     // 127282
    // ===============================================
    uint public result = 1;
    function doWork(uint[] memory data) public {
        uint temp = 1;
        for(uint i = 0; i < data.length; i++) {
            temp *= data[i];
        }
        result = temp;
    }                      // 297153   // 29824  = 326977
    // ===============================================

}

contract Un {
    // uint demo = 0;          // потрачено 69330 газа
    // ===============================================
    // uint128 a = 1;
    // uint256 c = 1;
    // uint128 b = 1;          // 135376
    // ===============================================
    // uint8 demo = 1;            // 89649
    // ===============================================
    // mapping(address => uint) payments;
    // function pay() external payable {
    //     address _from = msg.sender;
    //     require(_from != address(0), "zero address");
    //     payments[_from] = msg.value;
    // }                            // 141329
    // ===============================================
    // mapping(address => uint) payments;
    // function pay() external payable {
    //     require(msg.sender != address(0), "zero address");
    //     payments[msg.sender] = msg.value;
    // }                            // 140045
    // ===============================================
    // uint[] demo = [1, 2, 3];       // 158628
    // ===============================================
    uint public result = 1;
    function doWork(uint[] memory data) public {
        for(uint i = 0; i < data.length; i++) {
            result *= data[i];
        }
    }                    // 296301   // 30254  = 326555
    // ===============================================

}