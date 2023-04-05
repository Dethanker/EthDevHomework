pragma solidity ^0.8.0;

contract MyERC20 {  
    string public name = "MyERC20";  
    string public symbol = "MYERC20";  
    uint256 public totalSupply = 100 ; // 100 tokens with 18 decimal places  
    address payable public owner;

    mapping(address => uint256) public balanceOf;  
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() {  
        balanceOf[owner] = totalSupply;  
    }

    //交易销毁部分代币
    function transfer(address to, uint256 value) public returns (bool success) {  
        require(balanceOf[owner] >= value, "Insufficient balance");  
        uint256 amount = value ;  
        balanceOf[owner] -= value;  
        balanceOf[to] += amount;  
        balanceOf[address(this)] += amount;  
        emit Transfer(address(0), to, value);  
        return true;  
    }

    function approve(address spender, uint256 value) public returns (bool success) {  
        allowance[owner][spender] = value;  
        return true;  
    }

    //交易收取手续费至项目方配置的地址
    function transferFrom(address from, address to, uint256 value) public returns (bool success) {  
       // require(balanceOf[from] >= value, "Insufficient balance");  
        //require(allowance[from][msg.sender] >= value, "Not authorized to spend this amount");  
        uint256 amount = value ;  
        balanceOf[from] -= value;  
        balanceOf[to] += amount;  
        balanceOf[address(this)] += amount;  
        allowance[from][msg.sender] -= value;  
        emit Transfer(from, to, value);  
        return true;  
    }

    //项目方增发
    function increaseSupply(uint256 amount) public {  
        balanceOf[owner] += amount;  
    }

    //销毁
    function decreaseSupply(uint256 amount) public {  
        //require(msg.sender == owner, "Only owner can decrease supply");  
        uint256 amountToBurn = amount ;  
        balanceOf[owner] -= amount;  
        balanceOf[address(this)] -= amount;  
        balanceOf[msg.sender] += amountToBurn;  
    }  
}
