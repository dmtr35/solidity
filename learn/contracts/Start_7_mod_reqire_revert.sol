// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Demo {
    // requir
    // revert
    // assert
    address owner;


    // event, обьявляем событие. indexed - можно сделать поиск по полю _from
    event Paid(address _from, uint _anount, uint _timestamp);


    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        pay();
    }

    function pay() public payable {
        // порождаем наше событие
        emit Paid(msg.sender, msg.value, block.timestamp);
    }

    // собственый модификатор, проверяющий является ли пользоватеть владельцем
    // _; - означает выйти из модификарова и выпонить тело функции
    modifier onlyOwner(address _to) {
        require(msg.sender == owner, "you are not an owner");
        require(_to != address(0), "incorrect address!");
        _;
        // проверки после тела функции
        // requier(...);
    }

    function withdraw(address payable _to) external onlyOwner(_to) {
        // require
        // если условие false - функция завершается и выдано сообщение:
        // require(msg.sender == owner, "you are not an owner");

        // revert
        // if(msg.sender != owner) {
        //     revert("you are not an owner");        // сообщение об ошибке
        // }

        // assert
        // если assert false то будет ошибка Panic, непонятно будет в чем ошибка
        // assert(msg.sender == owner);

        _to.transfer(address(this).balance);
    }

}