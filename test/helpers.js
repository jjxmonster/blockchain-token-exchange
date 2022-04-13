import Web3 from 'web3';

export const EVM_REVERT = 'VM Exception while processing transaction: revert';
export const ETHER_ADDRESS = '0x0000000000000000000000000000000000000000';

export const ether = n => {
   return new Web3.utils.BN(Web3.utils.toWei(n.toString(), 'ether'));
};
export const tokens = n => ether(n);
