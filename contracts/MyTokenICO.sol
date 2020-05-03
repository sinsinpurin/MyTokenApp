pragma solidity >=0.5.0 <0.7.0;
import "../node_modules/@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "../node_modules/@openzeppelin/contracts/math/SafeMath.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";


//このコントラクトはOpenZeppelin(release-v2.3.0) CrowdSaleを参考に作成した。

contract MyTokenICO is ReentrancyGuard {
    using SafeMath for uint256;

    uint256 private _rate;
    address payable private _MOCOwner;
    IERC20 private _token;
    uint256 private _weiRaised;

    constructor(uint256 rate, address payable MOCOwner, IERC20 token) public {
        require(rate > 0, "Crowdsale: rate is 0");
        require(
            MOCOwner != address(0),
            "Crowdsale: wallet is the zero address"
        );
        require(
            address(token) != address(0),
            "Crowdsale: token is the zero address"
        );
        _rate = rate;
        _MOCOwner = MOCOwner;
        _token = token;
    }

    event TokensPurchased(address beneficiary, uint256 value, uint256 amount);

    receive() external payable {
        buyMOC(msg.sender);
    }

    function token() public view returns (IERC20) {
        return _token;
    }

    function MOCOwner() public view returns (address payable) {
        return _MOCOwner;
    }

    function rate() public view returns (uint256) {
        return _rate;
    }

    function buyMOC(address beneficiary) public payable nonReentrant {
        uint256 weiAmount = msg.value;
        require(
            beneficiary != address(0),
            "Crowdsale: beneficiary is the zero address"
        );
        require(weiAmount != 0, "Crowdsale: weiAmount is 0");

        //購入するトークン量を計算
        uint256 tokens = _getTokenAmount(weiAmount);
        _weiRaised = _weiRaised.add(weiAmount);

        _token.transferFrom(_MOCOwner, msg.sender, tokens);
        _forwardFunds();
        emit TokensPurchased(beneficiary, weiAmount, tokens);
    }

    function _getTokenAmount(uint256 weiAmount)
        internal
        view
        returns (uint256)
    {
        return weiAmount.mul(_rate);
    }

    function _deliverTokens(address beneficiary, uint256 tokenAmount) internal {
        _token.transfer(beneficiary, tokenAmount);
    }

    function _processPurchase(address beneficiary, uint256 tokenAmount)
        internal
    {
        _deliverTokens(beneficiary, tokenAmount);
    }

    function _forwardFunds() internal {
        MOCOwner().transfer(msg.value);
    }
}
