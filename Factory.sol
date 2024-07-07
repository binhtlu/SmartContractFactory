// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./NewErc20.sol";
import "./PrivateErc721.sol";
import "./PrivateErc1155.sol";

contract ErcFactory is Ownable {
    uint256 public createErc20Fee = 0;
    uint256 public createErc721Fee = 0;
    uint256 public createErc1155Fee = 0;

    event CreatedErc20(
        string name_,
        string symbol_,
        uint256 aTotalSupply,
        address anAddr
    );
    event createdErc721(string name_, string symbol_, address anAddr);
    event createdErc1155(address anAddr);

    event SetCreateErc20Fee(uint256 fee);
    event SetCreateErc721Fee(uint256 fee);
    event SetCreateErc1155Fee(uint256 fee);
    constructor() Ownable(msg.sender) {}

    function newErc20(
        string memory name_,
        string memory symbol_,
        uint256 aTotalSupply_
    ) public payable {
        require(
            msg.value >= createErc20Fee,
            "insufficient fee to create Erc20"
        );
        NewERC20 aNewToken = new NewERC20(name_, symbol_, aTotalSupply_);
        aNewToken.transfer(msg.sender, aTotalSupply_);
        emit CreatedErc20(name_, symbol_, aTotalSupply_, address(aNewToken));
    }
    function PrivateErc721(
        string memory name_,
        string memory symbol_,
        uint256 limit
    ) public payable {
        require(
            msg.value >= createErc721Fee,
            "insufficient fee to create Erc721"
        );
        NewERC721 aNewToken = new NewERC721(name_, symbol_, msg.sender, limit);
        emit createdErc721(name_, symbol_, address(aNewToken));
    }

    function PrivateErc1155(uint256 limit) public payable {
        require(
            msg.value >= createErc1155Fee,
            "insufficient fee to create Erc1155"
        );
        NewERC1155 aNewToken = new NewERC1155(msg.sender, limit);
        emit createdErc1155(address(aNewToken));
    }

    function setCreateErc20Fee(uint256 fee) public onlyOwner {
        createErc20Fee = fee;
        emit SetCreateErc20Fee(fee);
    }

    function setCreateErc721Fee(uint256 fee) public onlyOwner {
        createErc721Fee = fee;
        emit SetCreateErc721Fee(fee);
    }
    function setCreateErc1155Fee(uint256 fee) public onlyOwner {
        createErc1155Fee = fee;
        emit SetCreateErc1155Fee(fee);
    }

    function withdraw(uint256 amount) public onlyOwner {
        (bool success, ) = owner().call{value: amount}("");
        require(success, "withdraw failed");
    }
}
