// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IERC20 {
    function name() external view returns(string memory);
    function symbol() external view returns(string memory);
    function decimal() external view returns(uint);
   
    function totalSupply() external view returns(uint);
    function balanceOf(address _account) external view returns(uint);
    function transfer(address _to, uint _amount) external;
    // позволяет/проверяет  другому адрессу забрать ( n ) кол-во токенов, для 3го лица
    function allowance(address _owner, address _spender) external view returns(uint); 
    function approve(address _spender, uint _amount) external;
    function transferFrom(address _sender, address _recipient, uint amount) external;

    // благодаря indexed - индексированию мы можем в ethers найти все транзакции по индек-мым полям,
    // в одном событие можно до 3х indexed
    event Transfer( address indexed _from,address indexed _to, uint amount);
    event Approve(address indexed _owner, address indexed _to, uint amount);
}