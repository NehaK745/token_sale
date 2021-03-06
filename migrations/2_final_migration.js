  
var DappToken = artifacts.require("./DogeToken.sol");
var DappTokenSale = artifacts.require("./DogeCrowdsale.sol");

module.exports = function(deployer) {
  deployer.deploy(DogeToken, 1000000).then(function() {
    // Token price is 0.001 Ether
    var tokenPrice = 1000000000000000;
    return deployer.deploy(DogeCrowdsale, DogeToken.address, tokenPrice);
  });
};