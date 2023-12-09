// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Demo6 {
    // области видимости:
    //1.public - можно вызывать из вне смарт контракта, так и изнутри контракта
    //2.external - к функции можно обращаться только из вне смарт контракта
    //3.internal - к функции можно обращаться только из внутри смарт контракта, или контракты которые наследуют
    //4.privet - только из внутри смарт контракта, но не из его потомков

    // Модификатор:
    //view - функция может читать данные в блокчейне, но их не модифицировать(считать баланс смарт контракта,)

    // function getBalance_test() public view returns(uint balance) {
    //     balance = address(this).balance;
    // }

    string message = "hello";  // state

    function getBalance() public view returns(uint) {
        uint balance = address(this).balance;
        return balance;
    }

   function getMessage() external view returns(string memory){  // для строки нужно указать место хранения "memory"
        return message;
    }

    // Модификатор:
    //pure - тоже вызывается через call но она не может читать внешние данные
    function rate(uint amount) public pure returns(uint){  // pure не может брать аргументы из блокчейна
        return amount * 3;
    }

    // transaction
    // функции которые вызываются через транзакции, задавать значение переменным в блокчейне
    function setMessage(string memory newMessage) external { // передаем в функцию сообщение которое мы присвоим переменной в блокчейне
        message = newMessage; // переменная newMessage была временная, стала постоянной message
    }

    uint public balance;
    // Модификатор:
    // payable - в эту функцию можно будет присылать деньги
    function pay() public payable {
        balance += msg.value;   // мы пометили функцию payable и в msg.value будет количество средств которое сюда прислали
    }

    // =========================================
    // receive function. чтобы просто смарт контракт принимал средства без вызова функции
    receive() external payable {
        // функция может быть пустой
    }
    // fallback function - применяется если относительно смарт-контракта была вызвана транзакция с неизвестным именем функции
    fallback() external payable {

    }
}