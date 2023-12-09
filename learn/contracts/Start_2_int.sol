// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo2 {
    uint8 public myVal = 254;
    function inc() public {
        unchecked {     // отлавливает ошибки переполнения
            myVal ++;
        }
    }







    // uint public maximum = 55;

    // function demo() public {
    //     maximum += 55;
    // }





    // uint localUint = 42;
    // localUint + 1;
    // localUint - 1;
    // localUint * 2;
    // localUint / 2;
    // localUint ** 3;
    // localUint % 3;
    // -myInt;

    // localUint == 1;
    // localUint != 1;
    // localUint > 1;
    // localUint >= 1;
    


    // bool public myBool = true; // state
    // uint public myUint = 42;
    // function demo(uint _inputUint) public {
    //     uint licalUint = 42;
    // }

    // int public myInt = -42;
        
        
    // bool localBool = false;  // local
    // localBool && _inpotBool
    // localBool || _inpotBool
    // localBool == _inpotBool
    // localBool != _inpotBool
    // !localBool
}




