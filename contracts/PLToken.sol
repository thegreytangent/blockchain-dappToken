pragma solidity ^0.5.16;

contract PLToken {
    uint256 public totalSupply;
    string public name = "PLToken";
    string public symbol = "PLCOIN";

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }

    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        //Check if enough tokens;
        require(_value <= balanceOf[_from]);

        //Check allowance is big enough
        require(_value <= allowance[_from][msg.sender]);

        //Change balance;
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        //Update allowance;
        allowance[_from][msg.sender] -= _value;

        //Transfer event;
        emit Transfer(_from, _to, _value);
        return true;
    }
}
