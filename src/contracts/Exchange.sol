// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./Token.sol";


contract Exchange {
    using SafeMath for uint;
    // Variables
    address public feeAccount; // the account that receives exchange fees
    uint256 public feePercent; 
    address constant ETHER = address(0); // store Ether in tokens mapping with blank address
    mapping(address => mapping(address => uint256)) public tokens;

    event Deposit(address token, address user, uint256 amount, uint256 balance);
    event Withdraw(address token, address user, uint amount, uint balance);

    constructor(address _feeAccount, uint256 _feePercent)  {
        feeAccount = _feeAccount;
        feePercent = _feePercent;
    }

    fallback() external {
        revert();
    }

    function withdrawEther(uint _amount) public {
        require(tokens[ETHER][msg.sender]>= _amount);
        tokens[ETHER][msg.sender] = tokens[ETHER][msg.sender].sub(_amount);
        payable(msg.sender).transfer(_amount); 
        emit Withdraw(ETHER, msg.sender, _amount, tokens[ETHER][msg.sender]);
    }

    function depositEther() payable public {
        tokens[ETHER][msg.sender] = tokens[ETHER][msg.sender].add(msg.value);
        emit Deposit(ETHER, msg.sender, msg.value, tokens[ETHER][msg.sender]);
    }

    function depositToken(address _token, uint256 _amount) public {
        require(_token != ETHER);
        require(Token(_token).transferFrom(msg.sender, address(this), _amount));
        tokens[_token][msg.sender] = tokens[_token][msg.sender].add(_amount);
        emit Deposit(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    }
    
    function withdrawToken(address _token, uint256 _amount) public {
        tokens[_token][msg.sender] = tokens[_token][msg.sender].sub(_amount);
        require(Token(_token).transfer(msg.sender, _amount));
        emit Withdraw(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    }
}