# Elephandary Smart Contract

This repository contains the Elephandary smart contract which is an ERC721A-based contract used for managing a collection of non-fungible tokens (NFTs). It includes specific features such as owner functions, free minting, public minting, and team minting, among others.

## Contract Variables

- `maxSupply`: The total supply of tokens that can ever be minted.
- `maxFreeMint`: The maximum number of tokens that can be minted for free.
- `teamReservedSupply`: The number of tokens reserved for the team.
- `mintPrice`: The price of minting a token (in Ether).
- `maxFreeMintPerWallet`: The maximum number of free tokens that can be minted per wallet.
- `maxMintPerWallet`: The maximum number of tokens that can be minted per wallet.
- `maxMintPerTx`: The maximum number of tokens that can be minted per transaction.
- `teamMinted`: The number of tokens that the team has minted.
- `saleStatus`: The current status of the sale (true = active, false = inactive).
- `baseTokenUrl`: The base URL for the token metadata stored on IPFS.
- `tokenUrlSuffix`: The suffix for the token metadata URL (typically .json).
- `freeMinted`: A mapping that keeps track of the number of free tokens minted by each wallet.
- `KITTEN1`, `KITTEN2`, `KITTEN3`, `KITTEN4`: Constants representing addresses to which the proceeds from minting are distributed.

## Key Functions

### Minting Functions

- `freeMint()`: Allows a wallet to mint a token for free, subject to certain conditions.
- `publicMint(uint256 amount_)`: Allows a wallet to mint a specified number of tokens, subject to certain conditions and a payment of ETH.
- `teamMint(address to, uint256 _amount)`: Allows the contract owner to mint a specified number of tokens to a given address, subject to certain conditions.

### Owner Functions

- `reduceSupply(uint256 _maxSupply)`: Allows the contract owner to reduce the maximum supply of tokens.
- `withdraw()`: Allows the contract owner to withdraw the balance of ETH held by the contract and distribute it equally among four specified addresses.
- `setMintPrice(uint256 mintPrice_)`, `setMaxMintPerWallet(uint256 maxMintPerWallet_)`, `setMaxMintPerTx(uint256 maxMintPerTx_)`, `setSaleStatus(bool saleStatus_)`, `setBaseTokenUrl(string memory _baseTokenUrl)`, `setTokenUrlSuffix(string memory _tokenUrlSuffix)`: These functions allow the contract owner to set various parameters of the contract.

### View Functions

- `_baseURI()`: Returns the base URI for the token metadata.
- `_suffix()`: Returns the suffix for the token metadata URL.
- `tokenURI(uint256 tokenId)`: Returns the complete URI for a token's metadata, subject to the token existing.

## Modifiers

- `mintRequirements (uint256 _amount)`: A modifier to check if a mint operation is valid.
- `onlyAccount()`: A modifier to check if the function is being called by an EOA (Externally Owned Account).

## Deployed Contract Addresses

The contract address on Ethereum mainnet and testnets will be provided soon.

## Note

This contract is for the Elephandary NFT project which is a collection of unique, programmatically generated Elephandary NFTs. Be sure to understand the functions and their conditions before interacting with the contract.
