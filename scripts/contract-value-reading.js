//hata veriyor

require('dotenv').config();
const RINKEBY_API_URL = process.env.RINKEBY_API_URL;
const Web3 = require('web3') ;
const web3 = new Web3(RINKEBY_API_URL);

const contract = require("../artifacts/contracts/Elephandary.sol/Elephandary.json");


const contractAddress = "0x11254790e7B8C25b657de8eD2866Eb7528551f73";
const nftContract = new web3.eth.Contract(contract.abi, contractAddress);

async function read() {
    const message = await nftContract.methods.maxFreeMint();
    console.log("The message is: " + message);
  }

 read() ;

//console.log(nftContract) ;

//console.log(val);
//console.log(nftContract.freeMinted["0x4169D3e685bEb30176AC657C4B93A0c1bc8c87a7"]) ;