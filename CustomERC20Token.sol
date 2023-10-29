// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract CustomERC20Token {

    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    address public owner;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory _tokenName, string memory _tokenSymbol, uint8 _tokenDecimals, uint256 _initialSupply) {
        name = _tokenName;
        symbol = _tokenSymbol;
        decimals = _tokenDecimals;
        totalSupply = _initialSupply * 10 ** uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_to != address(0), "It is impossible to transfer funds to 0 address");
        require(balanceOf[msg.sender] >= _value, "Insufficient funds");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approval(address _spender, uint256 _value) public returns (bool) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_from != address(0), "It is impossible to transfer funds from 0 address");
        require(_to != address(0), "It is impossible to transfer funds to 0 address");
        require(balanceOf[_from] >= _value, "Insufficient funds from source address");
        require(allowance[_from][msg.sender] >= _value, "Insufficient authorization");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }
}
