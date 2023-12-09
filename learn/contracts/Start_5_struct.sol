// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo5 {
    // Struct (типа обьекты на js)
    
    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint totalPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balances;

    function getPayment(address _addr, uint _index) public view returns(Payment memory){
        return balances[_addr].payments[_index];
    }


    function pay(string memory message) public payable{
        // номер платежа
        uint paymentNum = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;

        Payment memory newPayment = Payment(
            msg.value, // количество денег в поле uint amount;
            block.timestamp, // блок времени записываем в поле uint timestamp;
            msg.sender, // от кого платеж;
            message
        );
        

        balances[msg.sender].payments[paymentNum] = newPayment;
    }

}