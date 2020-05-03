const MyTokenICO = artifacts.require("MyTokenICO");

const MyToken = artifacts.require("MyToken");
const assert = require('assert');

contract("MyTokenICO", function () {
  it("send success", async function () {
    let MICO = await MyTokenICO.deployed()
    MyToken.deployed().then(inst => inst.approve(MICO.address, 100))
    MyTokenICO.deployed().then(inst => inst.sendTransaction({ from: "0xdf81f6233147a64d6146Fb03B9050FC706753c99", value: 10 }))
    return true
  })
})
