const MyERC20 = artifacts.require("MyERC20");

contract("MyERC20", accounts => {  

  // 测试 increaseSupply 函数  
  it("should increase supply", async function () {  
    const instance=await MyERC20.deployed();
    instance.owner=accounts[0];
    await instance.increaseSupply(1);
  });

  // 测试 transfer 函数  
  it("should transfer token", async function () {  
    const instance=await MyERC20.deployed();  
    await instance.transfer(accounts[1], 1);  
  });



  // 测试 transferFrom 函数  
  it("should transfer from owner to other address", async function () {  
    const instance=await MyERC20.deployed();
    //await instance.transfer(accounts[1], 1);  
    await instance.transferFrom(accounts[1], accounts[0], 1);  
  }); 
    // 测试 decreaseSupply 函数    
  it("should decrease supply", async function () {    
    const instance=await MyERC20.deployed();
    await instance.decreaseSupply(1) ;    
  });   
});  
