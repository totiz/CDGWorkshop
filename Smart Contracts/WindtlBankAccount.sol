pragma solidity ^0.4.24;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }


  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 _a, uint256 _b) internal pure returns (uint256 c) {
    // Gas optimization: this is cheaper than asserting 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (_a == 0) {
      return 0;
    }

    c = _a * _b;
    assert(c / _a == _b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 _a, uint256 _b) internal pure returns (uint256) {
    // assert(_b > 0); // Solidity automatically throws when dividing by 0
    // uint256 c = _a / _b;
    // assert(_a == _b * c + _a % _b); // There is no case in which this doesn't hold
    return _a / _b;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 _a, uint256 _b) internal pure returns (uint256) {
    assert(_b <= _a);
    return _a - _b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 _a, uint256 _b) internal pure returns (uint256 c) {
    c = _a + _b;
    assert(c >= _a);
    return c;
  }
}

contract BankAccount is Ownable {
    using SafeMath for uint;
    
    event CreateAccount(string firstName, string lastName, uint balance);
    event Deposit(uint amount, uint balance);
    event Withdraw(uint amount, uint balance);
    event CheckBalance(uint balance);
    event GetAccDetail(string firstName, string lastName, uint balance);
    event GetIntRate(uint intRate);
    
    uint initYear = now;
    uint intRate = 2;
    
    struct Account {
        string firstName;
        string lastName;
        uint balance;
    }
    
    Account[] public accounts;
    
    mapping (address => uint) ownerAccountCount;
    mapping (address => uint) addressToIndex;
    
    modifier haveAccount(){
        require(ownerAccountCount[msg.sender] > 0);
        _;
    }
    
    function createAccount(string _firstName, string _lastName, uint _balance) public {
        require(ownerAccountCount[msg.sender] == 0);
        uint id = accounts.push(Account(_firstName, _lastName, _balance)).sub(1);
        ownerAccountCount[msg.sender] = ownerAccountCount[msg.sender].add(1);
        addressToIndex[msg.sender] = id;
        emit CreateAccount(_firstName, _lastName, _balance);
    }
    
    function deposit(uint _balance) public haveAccount {
        accounts[addressToIndex[msg.sender]].balance = accounts[addressToIndex[msg.sender]].balance.add(_balance);
        emit Deposit(accounts[addressToIndex[msg.sender]].balance, _balance);
    }
    
    function withdraw(uint _balance) public haveAccount {
        Account storage acc = accounts[addressToIndex[msg.sender]];
        require(_balance < acc.balance);
        acc.balance = acc.balance.sub(_balance);
        emit Withdraw(acc.balance, _balance);
    }
    
    function checkBalance() public view haveAccount returns(uint) {
        emit CheckBalance(accounts[addressToIndex[msg.sender]].balance);
        return accounts[addressToIndex[msg.sender]].balance;
    }
    
    function getAccDetail() public view haveAccount returns(
        string firstName, 
        string lastName, 
        uint balance
        ) {
        require(ownerAccountCount[msg.sender] > 0);
        Account storage acc = accounts[addressToIndex[msg.sender]];
        firstName = acc.firstName;
        lastName = acc.lastName;
        balance = acc.balance;
        emit GetAccDetail(firstName, lastName, balance);
    }
    
    function incYear() public haveAccount {
        Account storage acc = accounts[addressToIndex[msg.sender]];
        acc.balance = acc.balance.add(acc.balance.mul(intRate).div(100));
        initYear.add(1 years);
    }
    
    function getIntRate() public view returns (uint) {
        emit GetIntRate(intRate);
        return intRate;
    }
    
    function setIntRate(uint _intRate) public onlyOwner {
        intRate = _intRate;
    }
    
}