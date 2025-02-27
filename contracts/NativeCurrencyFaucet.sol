// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importing OpenZeppelin's Ownable contract for ownership management
import "@openzeppelin/contracts/access/Ownable.sol";
// Importing OpenZeppelin's ReentrancyGuard to prevent reentrancy attacks
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

// Main contract for the Native Currency Faucet
contract NativeCurrencyFaucet is Ownable, ReentrancyGuard {
    // Cooldown period between native currency requests
    uint256 public cooldown = 24 hours;
    
    // Amount of native currency distributed per request
    uint256 public requestAmount = 0.01 ether;
    
    // Mapping to track the last request time for each user
    mapping(address => uint256) public lastRequestTime;
    
    // Mapping to track banned users
    mapping(address => bool) public bannedUsers;

    // Event emitted when native currency is requested
    event NativeCurrencyRequested(address indexed user, uint256 amount);
    // Event emitted when a user is banned
    event UserBanned(address indexed user);
    // Event emitted when a user is unbanned
    event UserUnbanned(address indexed user);

    // Constructor to initialize the contract with custom cooldown and request amount
    constructor(uint256 _cooldown, uint256 _requestAmount) Ownable() {
        cooldown = _cooldown;
        requestAmount = _requestAmount;
    }

    // Modifier to check if the user is not banned
    modifier notBanned() {
        require(!bannedUsers[msg.sender], "User is banned");
        _;
    }

    // Function to request native currency from the faucet
    function requestNativeCurrency() external nonReentrant notBanned {
        // Ensure the cooldown period has passed
        require(block.timestamp >= lastRequestTime[msg.sender] + cooldown, "Cooldown period not over");
        // Check if the faucet has enough balance
        require(address(this).balance >= requestAmount, "Insufficient faucet balance");

        // Update the last request time
        lastRequestTime[msg.sender] = block.timestamp;
        // Transfer native currency to the requester
        payable(msg.sender).transfer(requestAmount);

        // Emit the native currency request event
        emit NativeCurrencyRequested(msg.sender, requestAmount);
    }

    // Function for the owner to ban a user
    function banUser(address _user) external onlyOwner {
        bannedUsers[_user] = true;
        emit UserBanned(_user);
    }

    // Function for the owner to unban a user
    function unbanUser(address _user) external onlyOwner {
        bannedUsers[_user] = false;
        emit UserUnbanned(_user);
    }

    // Function for the owner to set a new cooldown period
    function setCooldown(uint256 _cooldown) external onlyOwner {
        cooldown = _cooldown;
    }

    // Function for the owner to set a new native currency request amount
    function setRequestAmount(uint256 _amount) external onlyOwner {
        requestAmount = _amount;
    }

    // Function for the owner to withdraw native currency from the faucet
    function withdrawNativeCurrency(uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount, "Insufficient balance");
        payable(msg.sender).transfer(_amount);
    }

    // Function to receive native currency deposits
    receive() external payable {}

    // Fallback function to receive native currency deposits
    fallback() external payable {}
} 
