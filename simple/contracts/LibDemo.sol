// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

import "./Ext.sol";

contract LibDemo {
    /* using - используется для билбилотек, этот метот 
    позволяет росширять метоты у типа данных. Аналогия с  prototype в Js */ 
    using StrExt for string;
    using ArrayExt for uint[];

    function runnerArr(uint[] memory numbers, uint number ) internal pure returns(bool) {

       return  numbers.inArray(number);
         // or 
        //  ArrayExt.inArray(numbers, number); 
    }


    function runnerStr( string memory _str1, string memory _str2) internal pure returns(bool) {
       return  _str1.eq(_str2);
         // or 
        //  StrExt.eq(_str1, _str2); 
    }
} 
