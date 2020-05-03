# truffle MyToken MyTokenICO

# Token
- ERC20
- name "masaki obayashi coin"
- symbol "MOC"


# truffle console
### instance

set deployed contract
```
truffle(development)> let MT = await MyToken.deployed()
```

### balance of ethereum

```
truffle(development)> web3.eth.getBalance(accounts[1])
```

### balance of account token

```
truffle(development)> await MT.balanceOf(accounts[0]).then((BN) => BN.toString())
```

## how to use
```
truffle(development)> let MT = await MyToken.deployed()
truffle(development)> let MICO = await MyTokenICO.deployed()
truffle(development)> MT.approve(MICO.address,100)
truffle(development)> MICO.sendTransaction({from: accounts[1], value:10})
```