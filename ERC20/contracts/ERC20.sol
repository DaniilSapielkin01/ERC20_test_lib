// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";

contract ERC20 is IERC20 {

    uint totalTokens;
    address owner;
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowances;
    string _name;
    string _symbol;

    function name() external view returns(string memory) {
        return _name;
    }

    function symbol() external view returns(string memory) {
      return _symbol;  
    }

    function decimals() external view returns(uint) {
        return 18; // 1 token = 18wei
    }

    function totalSupply() external view returns(uint) {
        return totalTokens;
    }

    modifier enoughTokens(address _from, uint _amount) {
        require(balanceOf(_from) >= _amount, "not enough tokent" );
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not a owner");
        _;
    }

    constructor(string memory name_, string memory symbol_, uint initialSupply, address _shop) {
        _name = name_;
        _symbol = symbol_;
        owner = msg.sender;
        mint(initialSupply, _shop);
    }

    function balanceOf(address _account) public view returns(uint) {
        return balances[_account];
    }

    function transfer(address _to, address _amount) external enoughTokens(msg.sender, _amount) {
        _beforeTokenTransfer(msg.sender, _to, _amount);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
    }

    function mint(uint _amount, address _shop) public onlyOwner {
        _beforeTokenTransfer(address(0), _shop, _amount);
        balances[_shop] += _amount;
        totalTokens += _amount;
        emit Transfer(address(0), _shop, _amount);
    }

    function burn(address _from, uint _amount) public onlyOwner enoughTokens(_from, _amount) {
        _beforeTokenTransfer(_from, address(0), _amount);
        balances[_from] -= _amount;
        totalTokens -= _amount;
    }

    function allowance(address owner_, address _spender) public view returns(uint) {
        return allowances[owner_][_spender];
    }

    function approve(address _spender,uint _amount) public {
        _approve(msg.sender, _spender, _amount);
    }

    function  _approve(address sender, address spender, uint amount) internal virtual {
        allowances[sender][spender] = amount;
        emit Approve(sender, spender, amount);
    }

    function transferFrom(address _sender, address _recipient, uint _amount)
     public enoughTokens(_sender, _amount) {
           _beforeTokenTransfer(_sender, _recipient, _amount);

           require(allowances[_sender][_recipient] >= _amount,"chekc allowance!");
           allowances[_sender][_recipient] -= _amount;

           balances[_sender] -= _amount;
           balances[_recipient] += _amount;
           emit Transfer(_sender, _recipient, _amount);
    }
    

    function _beforeTokenTransfer(
        address _from,
        address _to,
        uint _amount
    ) internal virtual {}

}

contract MCSToken is ERC20 {
    constructor(address shop) ERC20("MCSToken", "MCS", 20, shop){

    }
}

contract MShop {
    IERC20 public token;
    address payable public owner;
    event Bought(uint _amount, address indexed _buyer);
    event Sold(uint _amount, address indexed _seller);

    constructor() {
        token = new MCSToken(address(this));
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not a owner");
        _;
    }

    function sell(uint _amountToSell) external {
        require(
            _amountToSell > 0 &&
            token.balanceOf(msg.sender) >= _amountToSell,
            "incorrect amount!"
             );

             uint allowance = token.allowance(msg.sender, address(this));
             require(allowance >= _amountToSell, "check allowance");

             // кто забирает , откуда, и сколько забирает 
             token.transferFrom(msg.sender, address(this), _amountToSell);
             
             payable(msg.sender).transfer(_amountToSell);

             emit Sold(_amountToSell, msg.sender);
    }

    receive() external payable {
        uint tokensToBuy = msg.value; // 1 wei = 1token
        require(tokensToBuy > 0,"not enough funds!" );

        require(tokenBalance() >= tokensToBuy, "not enough tokens!");

        token.transfer(msg.sender, tokensToBuy);
        emit Bought(tokensToBuy, msg.sender);
    }

    function tokenBalance() public view returns(uint) {
        return token.balanceOf(address(this));
    }

}