// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo3 {
    string public myStr = "test";    // место хранения storage(blockchain)
    string public mySecondStr;
    mapping (address => uint) public payment;
    address public myAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; // storage

    function demo(string memory newValueStr, string memory newValueStr222) public {
        //string memory myTempStr = "temp";  // переменная работает только в функции
        mySecondStr = newValueStr222;
        myStr = newValueStr; 
    }

    // функция для получения количества эфира на счету
    function getBalance(address targetAddr) public view returns(uint) { 
        // view, транзакция вызывается через вызов. и что возвращает функция
        return targetAddr.balance;
    }

    // функция которая будет принимать эфир
    function receiveFunds() public payable {
        payment[msg.sender] = msg.value;
    }

    // функция для перевода эфира
    function transferTo(address targetAddr, uint amount) public {
        address payable _to = payable(targetAddr);
        _to.transfer(amount);
    }

}

















