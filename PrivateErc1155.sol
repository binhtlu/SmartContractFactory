// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
//0xf9d22d4d3351F4c87968Ab395dfF2D19a64e1359
contract PrivateERC1155 is ERC1155, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    uint256 public totalLimit;

    constructor(address _owner, uint256 _limit) ERC1155("") Ownable(_owner) {
        totalLimit = _limit;
    }

    function mint(
        address _to,
        string memory _uri,
        uint256 _quantity
    ) public onlyOwner returns (uint256) {
        require(_tokenIdCounter.current() < totalLimit, "limited");
        uint256 tokenId = _tokenIdCounter.current();
        bytes memory tokenUri = bytes(_uri);
        _mint(_to, tokenId, _quantity, tokenUri);
        _tokenIdCounter.increment();
        return tokenId;
    }
}
