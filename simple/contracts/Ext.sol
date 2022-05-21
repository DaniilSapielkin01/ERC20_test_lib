// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;


library StrExt {
    /*В библиотека мы можем писать методы , функции*/

    // функция равенства
     function eq( string memory _str1, string memory _str2) public pure returns(bool) {
         // что бы сравнить две строки нужно посчиать их хэши
         return keccak256(abi.encode(_str1)) == keccak256(abi.encode(_str1));
     }
}

library ArrayExt {
    function inArray(uint[] memory arr, uint el ) internal pure returns(bool){
        for(uint i = 0; i < arr.length; i++) {
            if(arr[i] == el) {
                return true;
            }

            return false;
        }
    }
}