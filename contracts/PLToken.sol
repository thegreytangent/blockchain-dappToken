pragma solidity ^0.5.16;

contract PLToken {
    
    uint256 public totalSupply;
    string public name = "PLToken";
    string public symbol = "PLCOIN";

   event Transfer(address indexed _from, address indexed _to, uint256 _value);

    mapping( address => uint) public balanceOf;

    constructor(uint256 _initialSupply) public  {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }

    function transfer(address _to, uint _value) public returns (bool success){
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }






   




  


}