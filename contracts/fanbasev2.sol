// contracts/FanbaseMusic.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol"; // For safer token ID management
import "@openzeppelin/contracts/utils/Strings.sol"; // For converting uint256 to string for URI

contract FanbaseMusic is ERC721, Ownable {
    using Counters for Counters.Counter;
    using Strings for uint256; // For _baseURI and _tokenURI

    Counters.Counter private _tokenIdCounter;

    // Optional: Base URI for metadata
    string private _baseTokenURI;

    // Optional: Mapping for individual token URIs (if different from base)
    mapping(uint256 => string) private _tokenURIs;

    event TokenMinted(address indexed to, uint256 tokenId, string tokenURI);
    event BaseURIUpdated(string newBaseURI);

    constructor(
        string memory name,
        string memory symbol,
        string memory baseTokenURI_
    )
        ERC721(name, symbol)
        Ownable(msg.sender)
    {
        _baseTokenURI = baseTokenURI_;
    }

    /// @notice Sets the base URI for all tokens. Can only be called by the owner.
    /// @param newBaseURI The new base URI.
    function setBaseURI(string memory newBaseURI) external onlyOwner {
        _baseTokenURI = newBaseURI;
        emit BaseURIUpdated(newBaseURI);
    }

    /// @dev See {ERC721-_baseURI}.
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    /// @dev See {ERC721-_tokenURI}.
    /// Returns the individual token URI if set, otherwise falls back to the base URI + token ID.
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        // If a specific URI is set for this token, return it
        if (bytes(_tokenURIs[tokenId]).length > 0) {
            return _tokenURIs[tokenId];
        }

        // Otherwise, construct from base URI and token ID
        string memory base = _baseURI();
        return bytes(base).length > 0
            ? string.concat(base, tokenId.toString())
            : "";
    }

    /// @notice Mints a new token to `to` with an optional specific `tokenURI_`.
    /// Can only be called by the owner.
    /// @param to The address to mint the token to.
    /// @param tokenURI_ Optional: The specific URI for this token. If empty, the default _tokenURI logic applies.
    function mint(address to, string memory tokenURI_) external onlyOwner returns (uint256) {
        require(to != address(0), "FanbaseMusic: mint to the zero address");

        _tokenIdCounter.increment();
        uint256 newTokenId = _tokenIdCounter.current();

        _safeMint(to, newTokenId);

        if (bytes(tokenURI_).length > 0) {
            _setTokenURI(newTokenId, tokenURI_);
        }

        // Emit the event with the actual tokenURI that will be used
        string memory finalTokenURI = tokenURI(newTokenId);
        emit TokenMinted(to, newTokenId, finalTokenURI);

        return newTokenId;
    }

    /// @notice Sets a specific URI for an individual token. Can only be called by the owner.
    /// @param tokenId The ID of the token.
    /// @param _uri The URI to set for the token.
    function _setTokenURI(uint256 tokenId, string memory _uri) internal {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _uri;
    }
}