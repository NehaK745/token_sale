// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import './DogeToken.sol';
contract DogeTokenSale {
   // address of admin
    address payable public  admin;
    // define the instance of DevToken
    DogeToken public dogetoken;
    // token price variable
    uint256 public tokenprice;
    // count of token sold vaariable
    uint256 public totalsold; 
     
    event Sell(address sender,uint256 totalvalue); 
   
    // constructor 
    constructor(address _tokenaddress,uint256 _tokenvalue){
        admin  = msg.sender;
        tokenprice = _tokenvalue;
        dogetoken  = DogeToken(_tokenaddress);
    }
   
    // buyTokens function
    function buyTokens() public payable{
    // check if the contract has the tokens or not
    require(dogetoken.balanceOf(address(this)) >= msg.value*tokenprice,'the smart contract dont hold the enough tokens');
    // transfer the token to the user
    dogetoken.transfer(msg.sender,msg.value*tokenprice);
    // increase the token sold
    totalsold += msg.value*tokenprice;
    // emit sell event for ui
     emit Sell(msg.sender, msg.value*tokenprice);
    }

    // end sale
    function endsale() public{
    // check if admin has clicked the function
    require(msg.sender == admin , ' you are not the admin');
    // transfer all the remaining tokens to admin
    dogetoken.transfer(msg.sender,dogetoken.balanceOf(address(this)));
    // transfer all the etherum to admin and self selfdestruct the contract
    selfdestruct(admin);
    }
 
}