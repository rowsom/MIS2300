//SPDX-License-Identifier: MIT
pragma solidity >=0.5.16 <0.9.0;
//pragma experimental ABIEncoderV2;
contract MISA3 {

    mapping(address => uint256) public balances;

    event PaymentSent(address indexed from, address indexed to, uint256 amount, string message);
    event PaymentReceived(address indexed from, uint256 amount);

    // return account balance of sender
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    // deposit function into contract
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit PaymentReceived(msg.sender, msg.value);
    }

    // transfer function from address to address
    function transfer(address to, uint256 amount, string calldata message) external {
        require(to != address(0), "Invalid recipient address");
        require(amount > 0, "Transfer amount must be greater than 0");
        require(amount <= balances[msg.sender], "Insufficient balance");
        
        balances[msg.sender] -= amount;
        balances[to] += amount;
        
        emit PaymentSent(msg.sender, to, amount, message);
    }

}