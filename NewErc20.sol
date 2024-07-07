// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NewERC20 is ERC20, Ownable {
    constructor(
        string memory name,
        string memory symbol,
        uint256 aTotalSupply
    ) ERC20(name, symbol) Ownable(msg.sender) {
        _mint(msg.sender, aTotalSupply);
    }
}
