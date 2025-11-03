// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/*
 * Simple Decentralized Smart Bank
 * --------------------------------
 * - Users can deposit and withdraw Ether.
 * - No input fields (no parameters anywhere).
 * - All actions are recorded on-chain with events.
 * - 100% beginner friendly and deployable.
 */

contract SmartBank {
    mapping(address => uint256) private balances;

    event Deposited(address indexed user, uint256 amount, uint256 time);
    event Withdrawn(address indexed user, uint256 amount, uint256 time);

    // Deposit Ether into the contract
    function deposit() public payable {
        require(msg.value > 0, "Send some ETH to deposit");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value, block.timestamp);
    }

    // Withdraw your full balance
    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");
        balances[msg.sender] = 0;

        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount, block.timestamp);
    }

    // View your current balance
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Allow receiving Ether directly
    receive() external payable {
        deposit();
    }

    fallback() external payable {
        deposit();
    }
}
