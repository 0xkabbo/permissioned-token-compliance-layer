// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ComplianceRegistry.sol";

contract CompliantToken is ERC20 {
    ComplianceRegistry public registry;

    constructor(
        string memory name, 
        string memory symbol, 
        address _registry
    ) ERC20(name, symbol) {
        registry = ComplianceRegistry(_registry);
    }

    /**
     * @dev Hook that is called before any transfer of tokens. 
     * Includes minting and burning.
     */
    function _update(address from, address to, uint256 value) internal virtual override {
        // Allow minting (from address(0)) without check, or check 'to' address
        if (from != address(0)) {
            require(registry.isVerified(from), "Sender not verified");
        }
        
        // Allow burning (to address(0)) without check, or check 'from' address
        if (to != address(0)) {
            require(registry.isVerified(to), "Recipient not verified");
        }

        super._update(from, to, value);
    }

    function mint(address to, uint256 amount) external {
        // In production, add onlyOwner modifier
        _mint(to, amount);
    }
}
