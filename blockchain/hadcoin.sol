// Hadcoins ICO
pragma solidity ^0.4.22;

contract hadcoin_ico{
    uint public max_hadcoins = 1000000; // maximum hadcoins for sale
    uint public usd_to_hadcoins= 1000; // USD to hadcoin conversion rate
    uint public total_hadcoins_bought = 0; // total number of hadcoins bought by investor
    
    // map from investor address to its equity in hadcoins and USD
    mapping (address => uint) equity_hadcoins;
    mapping (address => uint) equity_usd;
    
    // check if an investor can buy hadcoins
    modifier can_buy_hadcoins(uint usd_invested){
        require(usd_invested * usd_to_hadcoins + total_hadcoins_bought <= max_hadcoins);
    }
    
    // get the equity in hadcoins for investor
    function equity_in_hadcoins(address investor) external constant returns(uint){
        return equity_hadcoins[investor];
    }
    
    // get the equity in USD for investor
    function equity_in_usd(address investor) external constant returns(uint){
        return equity_usd[investor];
    }
    
    // buy hadcoins
    function buy_hadcoins(address investor, uint usd_invested) external
    can_buy_hadcoins(usd_invested){
        uint hadcoins_bought = usd_invested * usd_to_hadcoins;
        equity_hadcoins[investor] += hadcoins_bought;
        equity_usd[investor] = equity_hadcoins[investor] / 1000;
        total_hadcoins_bought += hadcoins_bought;
    }
    // sell hadcoins
    function sell_hadcoins(address investor, uint hadcoins_sold) external{
        equity_hadcoins[investor] -= hadcoins_sold;
        equity_usd[investor] = equity_hadcoins[investor] / 1000;
        total_hadcoins_bought -= hadcoins_sold;
    }
    
}