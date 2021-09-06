pragma solidity >=0.4.22 <0.9.0;

contract PLToken {
    
    uint256 private supply;

    constructor() public {
        supply = 100000;
    }

    function totalSupply() public view returns(uint256) {
        return supply;
    }
}