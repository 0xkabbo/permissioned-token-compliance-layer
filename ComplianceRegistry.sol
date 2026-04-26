// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ComplianceRegistry is Ownable {
    mapping(address => bool) private _whitelist;

    event AddressVerified(address indexed account);
    event AddressRevoked(address indexed account);

    constructor() Ownable(msg.sender) {}

    function verify(address account) external onlyOwner {
        _whitelist[account] = true;
        emit AddressVerified(account);
    }

    function revoke(address account) external onlyOwner {
        _whitelist[account] = false;
        emit AddressRevoked(account);
    }

    function isVerified(address account) public view returns (bool) {
        return _whitelist[account];
    }
}
