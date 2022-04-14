const Web3 = require('web3');

const web3 = new Web3('HTTP://127.0.0.1:7545');

/* eslint-disable no-undef */
const Token = artifacts.require('Token');
const Exchange = artifacts.require('Exchange');

module.exports = async function (deployer) {
   const accounts = await web3.eth.getAccounts();

   await deployer.deploy(Token);

   const feeAccount = accounts[0];
   const feePercent = 10;

   await deployer.deploy(Exchange, feeAccount, feePercent);
};
