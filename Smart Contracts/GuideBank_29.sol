pragma solidity ^0.4.24;

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

contract BankFeatures {
    event CreateAccount(string firstname, string lastname);
    event Deposit(uint amount, uint balance);
    event Withdraw(uint amount, uint balance);
    
    mapping (uint => address) public accountToOwner;
    mapping (address => uint) accountCount;
    
    modifier haveAccount() {
        require(accountCount[msg.sender] >= 0);
        _;
    }
    
    function createBankAccount(string firstname, string lastname, uint balance) public;
    function deposit(uint amount) public;
    function withdraw(uint amount) public;
    function checkBalance() public view returns (uint);
    function displayAccountDetail() public view returns (
        string firstname, 
        string lastname, 
        uint balance
    );
    function increaseYear(uint year) public view returns (uint);
}

contract GuideBank is BankFeatures {
    
    using SafeMath for uint;
    
    uint increasingYearDefault = 2;
    
    struct Account {
        string firstname;
        string lastname;
        uint balance;
    }
    
    Account[] public bankAccounts;
    
    function _createBankAccount(string _firstname, string _lastname, uint _balance) private {
        uint id = bankAccounts.push(Account(_firstname, _lastname, _balance)).sub(1);
        // accountToOwner[id] = msg.sender;
        accountCount[msg.sender] = id;
        emit CreateAccount(_firstname, _lastname);
    }
    
    function createBankAccount(string firstname, string lastname, uint balance) public {
        require(balance >= 0);
        _createBankAccount(firstname, lastname, balance);
    }
    
    function deposit(uint amount) public haveAccount {
        uint id = accountCount[msg.sender];
        Account storage myAccount = bankAccounts[id];
        myAccount.balance = myAccount.balance.add(amount);
        emit Deposit(amount, myAccount.balance);
    }

    function withdraw(uint amount) public haveAccount {
        uint id = accountCount[msg.sender];
        Account storage myAccount = bankAccounts[id];
        require(amount <= myAccount.balance);
        myAccount.balance = myAccount.balance.sub(amount);
        emit Withdraw(amount, myAccount.balance);
    }

    function checkBalance() public view haveAccount returns (uint) {
        uint id = accountCount[msg.sender];
        Account memory myAccount = bankAccounts[id];
        return myAccount.balance;
    }

    function displayAccountDetail() public view haveAccount returns (
        string firstname, 
        string lastname,
        uint balance
    ) {
        uint id = accountCount[msg.sender];
        Account memory myAccount = bankAccounts[id];
        return (myAccount.firstname, myAccount.lastname, myAccount.balance);
    }

    function increaseYear(uint year) public view haveAccount returns (uint) {
        uint id = accountCount[msg.sender];
        Account memory myAccount = bankAccounts[id];
        uint increase = myAccount.balance;
        for (uint i = 0; i < year ; i++) {
            increase = increase.mul(increasingYearDefault);
        }
        return increase;
    }
}