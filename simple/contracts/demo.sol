// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./ILogger.sol";

contract Demo {

     // interface - прописывается там какие функции могут 
     // быть задействованы в принципе, какие аргументы 
     // они приниют, и что возвращают, но реализацию мы не можем видеть

    ILogger logger;
    constructor(address _logger) {
        logger = ILogger(_logger);
    }

    function payment(address _from, uint _number) public view returns(uint) {
       return logger.getEntry(_from, _number);
    }

    receive() external payable {
        logger.log(msg.sender, msg.value);
    }
}