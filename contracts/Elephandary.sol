// SPDX-License-Identifier: MIT
/*                 
                                                           @@@@@@@@@@@                                        
                                                        @@@@@@@@@@@@@@@(                        
                                                     @@@          &@@, #@@@@                    
                                                    @@              @@     @@@                 
                                        @@@@@@@@@@@@@                      @@/   @@@@@@        
                                 &@@@@@@%           @@                .     @@@   @@@ @@@       
                             .@@@&                  @@@              @@/    @@#    @@  @@       
                           ,@@&                      &@@             #     (@@     @@  @@      
                          @@@                          @@@,       @@@      @@     @@@  @@      
                         .@@                              @@@@@@@@@        @@@@@@@@    @@      
                         &@@                                                          @@@       
                         @@(                                    #&@@                &@@(        
                          @@@                                   @@ &@@@&        /@@@@           
                          %@@                                  @#%     (@@@@@@@@&               
                           @@                 *&@@@@@@@.       @@                               
                           @@/      /@@@@@@@@%(       @@      @@@                               
                           @@&      @@,               @@      @@                                
                           &@@      @@                @@      @@                                
                            @@      @@(               @@      @@                                
                            @@#     (@@               @@@     @@                                
                             (@@@@@@@#                  &@@@@@#                                 
                                      



 /$$$$$$$$ /$$                     /$$                                 /$$                              
| $$_____/| $$                    | $$                                | $$                              
| $$      | $$  /$$$$$$   /$$$$$$ | $$$$$$$   /$$$$$$  /$$$$$$$   /$$$$$$$  /$$$$$$   /$$$$$$  /$$   /$$
| $$$$$   | $$ /$$__  $$ /$$__  $$| $$__  $$ |____  $$| $$__  $$ /$$__  $$ |____  $$ /$$__  $$| $$  | $$
| $$__/   | $$| $$$$$$$$| $$  \ $$| $$  \ $$  /$$$$$$$| $$  \ $$| $$  | $$  /$$$$$$$| $$  \__/| $$  | $$
| $$      | $$| $$_____/| $$  | $$| $$  | $$ /$$__  $$| $$  | $$| $$  | $$ /$$__  $$| $$      | $$  | $$
| $$$$$$$$| $$|  $$$$$$$| $$$$$$$/| $$  | $$|  $$$$$$$| $$  | $$|  $$$$$$$|  $$$$$$$| $$      |  $$$$$$$
|________/|__/ \_______/| $$____/ |__/  |__/ \_______/|__/  |__/ \_______/ \_______/|__/       \____  $$
                        | $$                                                                   /$$  | $$
                        | $$                                                                  |  $$$$$$/
                        |__/                                                                   \______/


@author:   Baris Arya CANTEPE  (@bcantepe)


*/
pragma solidity ^0.8.4 ;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol" ;


contract Elephandary is ERC721A, Ownable {

// Contract Variables

uint256 public maxSupply = 4444;
uint256 public constant maxFreeMint = 1500 ;
uint256 public constant teamReservedSupply = 81;

uint256 public mintPrice = 0.007 ether ;
uint256 public maxFreeMintPerWallet = 1 ; 
uint256 public maxMintPerWallet = 6 ;
uint256 public maxMintPerTx = 5; 

uint256 public teamMinted; 
bool    public saleStatus;

string  public baseTokenUrl = "ipfs://Qewasdwfansjd/";
string  public tokenUrlSuffix = ".json";

mapping (address => uint256) public freeMinted ; // bool da olabilir

address constant KITTEN1   = 0x69CC9A9E7f38117dc40d850dF43eC21b6B416A47 ; // Mojo Jojo
address constant KITTEN2   = 0xd8925d9BC9D55b7a25428D3593b1b425388c6287 ; // Blossom
address constant KITTEN3   = 0x8c1715Ac3466547193567e403752960114CB3147 ; // Bubbles
address constant KITTEN4   = 0xd2ECFb430B55E0726b77Eb84380FB531cfdE1EA9 ; // Buttercup
//adresler en son tekrar kontrol edilsin hata olması ihtimaline karşı

constructor () ERC721A( "Elephandary" , "ELEPHAN") { }

// Mint

function freeMint () external onlyAccount() {

uint256 _maxFreeMint = 1500;
uint256 _teamReservedSupply = 81;
//Created variables again on memory to save gas. 

require(totalSupply() + 1 <= ( _maxFreeMint + _teamReservedSupply) , "Maximum free mint amount reached.");
require(_numberMinted(msg.sender) < 1 , "You already minted free." );
require(saleStatus == true , "Mint is inactive.");
    
freeMinted[msg.sender] += 1 ;
_safeMint(msg.sender, 1);
  
}


function publicMint (uint256 amount_) public payable mintRequirements(amount_) onlyAccount() {

_safeMint(msg.sender, amount_);

}


function teamMint(address to, uint256 _amount) external onlyOwner {

    require( teamMinted + _amount < teamReservedSupply + 1,   "No more Team mint" );
    require(totalSupply() + _amount < maxSupply + 1, "Max supply exceed");

    teamMinted += _amount;
    _safeMint(to, _amount);
  
  }


// Owner Functions

// This function can only reduce max supply. 
function reduceSupply (uint256 _maxSupply) external onlyOwner {

require(_maxSupply < maxSupply, "Supply can not be increased, only reduce.") ;

maxSupply = _maxSupply ;

}

function withdraw() external onlyOwner {

uint256 balance = address(this).balance ;
require (balance > 0 , "Zero balance, can not withdraw") ;

_withdraw(KITTEN1, (balance * 250) / 1000) ;
_withdraw(KITTEN2, (balance * 250) / 1000) ;
_withdraw(KITTEN3, (balance * 250) / 1000) ;
_withdraw(KITTEN4, (balance * 250) / 1000) ;

}

function _withdraw(address _address, uint256 _amount) private {
        (bool success, ) = _address.call{value: _amount}("");
        require(success, "Transfer failed.");   
        }

// Variable Changers
function setMintPrice (uint256 mintPrice_) external onlyOwner {
mintPrice = mintPrice_ ;
}

function setMaxMintPerWallet (uint256 maxMintPerWallet_) external onlyOwner {
maxMintPerWallet = maxMintPerWallet_ ;
}

function setMaxMintPerTx (uint256 maxMintPerTx_) external onlyOwner {
maxMintPerTx = maxMintPerTx_ ;
}

function setSaleStatus (bool saleStatus_) external onlyOwner {
    saleStatus = saleStatus_ ;
}

function setBaseTokenUrl(string memory _baseTokenUrl) public onlyOwner {
    baseTokenUrl = _baseTokenUrl;
  }

function setTokenUrlSuffix(string memory _tokenUrlSuffix) public onlyOwner {
    tokenUrlSuffix = _tokenUrlSuffix;
  }



// View Functions

  function _baseURI() internal view virtual override returns (string memory) {
    return baseTokenUrl;
  }

  function _suffix() internal view virtual returns (string memory) {
    return tokenUrlSuffix;
  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory)
  {
    if (!_exists(tokenId)) revert URIQueryForNonexistentToken();

    string memory baseURI = _baseURI();
    string memory suffix = _suffix();
    return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, _toString(tokenId), suffix)): "";
  
  }



// Modifiers

modifier mintRequirements (uint256 _amount) {
    require(_amount > 0 , "Mint amount can not be 0");
    require(totalSupply() + _amount <= ( maxSupply - teamReservedSupply)  , "Maximum mint amount reached"); 
    require(_numberMinted(msg.sender) + _amount <= maxMintPerWallet , "You've minted max amount" );
    require(_amount <= maxMintPerTx , "Max mint amount per tx exceed");
    require(saleStatus == true , "Public mint is inactive");
    require(msg.value >= _amount  * mintPrice , "Insufficient ETH");
    _;
    }

modifier onlyAccount() {
    // Contracts are not allowed
    require(msg.sender == tx.origin, "Only accounts ser.");
    _;
     }

}