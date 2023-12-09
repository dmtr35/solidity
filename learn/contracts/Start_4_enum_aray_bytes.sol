// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo4 {
    // Enum - создаем свой тип данных
    enum Status {Paid, Delivered, Received}
    // Status - тип данных; currentStatus название;
    Status public currentStatus; 

    function pay() public {
        currentStatus = Status.Paid;
    }

    function delivered() public {
        currentStatus = Status.Delivered;
    }



    // Aray
    //uint-тип данных в массиве, днина небольше 10элементов
    uint[10] public items = [1,2,3];
    // массив строк
    string[5] public str = ['1','2','3'];

    function demo() public {
        items[0] = 100;  // присваиваем значение нулевому индексу
        items[1] = 200;
        items[4] = 400;
        str[0] = "hi";
    }

    // вложенные массивы с фиксированой длиной
    // массив inside имеет длину 2, а внутриние могут иметь длину 3
    uint[3][2] public inside;

    function demoInside() public {
        inside = [
            [3,4,5],
            [6,7,8]
        ];
        
        inside[0][0] = 100;
        inside[1][0] = 200;
        inside[1][2] = 500;
    }

    // массивы с динамической длинной
    uint[] public dynamic;
    uint public len;

    function demoDynamic() public{
        dynamic.push(4);
        dynamic.push(5);
        len = dynamic.length;
    }

    // задаем временный массив в памяти
    function semplMemory() public view returns (uint[] memory){
        uint[] memory tempArray = new uint[](10); // (размерность)
        tempArray[0] = 100;
        return tempArray;
    }


    // массивы с последовательностью байт (от 1 --> 32 bytes)
    bytes32 public myVar = "test";
    bytes public myDynVar = "test";

    // можем померять длину байтовых строк
    function lenStr() public view returns(uint) {
        // return myVar.length;
        return myDynVar.length;
    }

    function lenByte() public view returns(bytes1) {
        // return myVar.length;
        return myDynVar[0];
    }


}














