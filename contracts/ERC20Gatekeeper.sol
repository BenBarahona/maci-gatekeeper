// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { SignUpGatekeeper } from "https://github.com/privacy-scaling-explorations/maci/blob/dev/packages/contracts/contracts/gatekeepers/SignUpGatekeeper.sol";

/// @title WhitelistGatekeeper
/// @notice This contract restrict MACI signups to addresses
/// which have a minimum balance of the defined ERC20 token
contract ERC20Gatekeeper is SignUpGatekeeper, Ownable(msg.sender) {

  /// @notice Reference to the token the contract will be verifying,
  /// and the minimum amount required for registration
  ERC20 public immutable token;
  uint256 public immutable requiredAmount;

  /// @notice the reference to the MACI contract
  address public maci;

  /// @notice custom errors
  error AlreadyRegistered();
  error InsufficientTokenAmount();
  error OnlyMACI();
  error ZeroAddress();

  /// @notice creates a new SignUpTokenGatekeeper
  /// @param _token the address of the ERC20 contract
  /// @param _requiredAmount amount of tokens needed to register
  constructor(address _token, _requiredAmount) payable {
    token = ERC20(_token);
    requiredAmount = _requiredAmount;
  }

  /// @notice Adds an uninitialised MACI instance to allow for token signups
  /// @param _maci The MACI contract interface to be stored
  function setMaciInstance(address _maci) public override onlyOwner {
    if (_maci == address(0)) revert ZeroAddress();
    maci = _maci;
  }

  /// @notice Registers the user if they own the amount set on deployment of 
  /// the token.
  /// @param _user The user's Ethereum address.
  /// @param _data The ABI-encoded data from gatekeeper.
  function register(address _user, bytes memory _data) public override {
    //Verification to ensure caller is only the MACI contract
    if (maci != msg.sender) revert OnlyMACI();

    // Implement here your register logic!  Follow the suggested steps for
    // verifications, you may add any custom logic you feel fit

    //1. Check if user address has already registered, throw respective error
    //   use requiredAmount set on contract deployment for amount comparison.
    //   Remember to throw the InsufficientTokenAmount error if needed.

    //2. Check user balance for ERC20 token, and verify if enough funds are available
    //   If you are unsure how to do this, you can review the ERC20 docs for the
    //   token contract calls https://docs.openzeppelin.com/contracts/4.x/erc20

    //3. Add the user address to the mapping, to have a control of registered addresses

  }

  /// @notice Get the trait of the gatekeeper
  /// @return The type of the gatekeeper
  function getTrait() public pure override returns (string memory) {
    return "ERC20Token";
  }
}