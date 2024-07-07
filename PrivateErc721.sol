// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PrivateERC721 is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    uint256 public totalLimit;

    constructor(
        string memory _name,
        string memory _symbol,
        address _owner,
        uint256 _limit
    ) ERC721(_name, _symbol) Ownable(_owner) {
        totalLimit = _limit;
    }

    function mint(
        address _to,
        string memory _uri
    ) public onlyOwner returns (uint256) {
        require(_tokenIdCounter.current() < totalLimit, "limited");
        uint256 tokenId = _tokenIdCounter.current();
        _mint(_to, tokenId);
        _setTokenURI(tokenId, _uri);
        _tokenIdCounter.increment();
        return tokenId;
    }
}
