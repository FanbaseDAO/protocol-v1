// contracts/FanbaseMusic.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FanbaseMusic is ERC721, Ownable {
    uint256 public nextTokenId;

    event TokenMinted(address indexed to, uint256 tokenId);

    constructor()
      ERC721("FanbaseMusic", "FBM")
      Ownable(msg.sender)
    {}

    /// @notice Mint a new token to `to`. No URI parameter.
    function mint(address to) external returns (uint256) {
        uint256 tokenId = nextTokenId;
        nextTokenId += 1;
        _safeMint(to, tokenId);
        emit TokenMinted(to, tokenId); // Emit the event
        return tokenId;
    }
}