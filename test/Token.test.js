/* eslint-disable no-undef */
const Token = artifacts.require('./Token');

require('chai').use(require('chai-as-promised')).should();

contract(Token, accounts => {
   const name = 'My name';
   const symbol = 'Symbol';
   const decimals = 10;
   const totalSupply = 10;
   let token;

   beforeEach(async () => {
      token = await Token.new();
   });

   describe('deployment', () => {
      it('tracks the name', async () => {
         const result = await token.name();
         console.log(result);
         result.should.equal(name);
      });

      it('tracks the symbol', async () => {
         const result = await token.symbol();
         result.should.equal(symbol);
      });
      it('tracks the decimals', async () => {
         const result = await token.decimals();
         result.should.equal(decimals);
      });
      it('tracks the total supply', async () => {
         const result = await token.totalSupply();
         result.should.equal(totalSupply);
      });
   });
});
