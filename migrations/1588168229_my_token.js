const MyToken = artifacts.require("MyToken");
const MyTokenICO = artifacts.require("MyTokenICO");


module.exports = function (_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(MyToken).then(async () => {
    var instance = await MyToken.deployed();
    const MOCOwner = await instance.getMakerAddress();
    return _deployer.deploy(MyTokenICO, 1, MOCOwner, MyToken.address);
  })
};