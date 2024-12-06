// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { SignUpGatekeeper } from "https://github.com/privacy-scaling-explorations/maci/blob/dev/packages/contracts/contracts/gatekeepers/SignUpGatekeeper.sol";

/// @title WhitelistGatekeeper
/// @notice This contract restrict MACI signups to specific 
/// addresses that are whitelisted by the deployer
contract WhitelistGatekeeper is SignUpGatekeeper, Ownable(msg.sender) {

  /// @notice mapping where we will store addresses eligible to vote
  mapping(address => address) public whitelistAddresses;

  /// @notice the reference to the MACI contract
  address public maci;

  /// @notice custom errors
  error AlreadyRegistered();
  error OnlyMACI();
  error ZeroAddress();

  /// @notice creates a new SignUpTokenGatekeeper
  constructor() payable { }

  function addToWhitelist(address _user) public override onlyOwner {
    if (_user == address(0)) revert ZeroAddress();
    if(whitelistAddresses[_user]) revert AlreadyRegistered();

    whitelistAddresses[_user] = _user;
  }

  /// @notice Adds an uninitialised MACI instance to allow for signups
  /// @param _maci The MACI contract interface to be stored
  function setMaciInstance(address _maci) public override onlyOwner {
    if (_maci == address(0)) revert ZeroAddress();
    maci = _maci;
  }

  /// @notice Registers the user by added their address to a mapping stored on chain
  /// @param _user The user's Ethereum address.
  /// @param _data The ABI-encoded data from gatekeeper.
  function register(address _user, bytes memory _data) public override {
    //Verification to ensure caller is only the MACI contract
    if (maci != msg.sender) revert OnlyMACI();

    //_data param can be decoded into the expected data type the maci contract returns from the user attempting to register
    //For this example, it will not be used

    if(whitelistAddresses[_user]) revert AlreadyRegistered();
    //Adding the user to the mapping
    whitelistAddresses[_user] = _user
  }

  /// @notice Get the trait of the gatekeeper
  /// @return The type of the gatekeeper
  function getTrait() public pure override returns (string memory) {
    return "Whitelist";
  }
}