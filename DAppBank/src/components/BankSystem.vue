<template>
  <div class="hello">
    <!-- CREATE ACCOUNT -->
    <hr />
    <h2>
      Create Account
    </h2>
    <label for="Account name">Account name</label>
    <input type="text" v-model="createAccountName" placeholder="Account name"><br>

    <button @click="createAccount">Create</button>

    <!-- DEPOSIT -->
    <hr />
    <h2>
      Deposit
    </h2>
    <label for="Account name">Account name</label>
    <input type="text" v-model="depositAccountName" placeholder="Account name"><br>

    <label for="Amount">Amount</label>
    <input type="number" v-model="depositAmount" placeholder="Amount"><br>

    <button @click="deposit">Deposit</button>

    <!-- WITHDRAW -->
    <hr />
    <h2>
      Withdraw
    </h2>
    <label for="Account name">Account name</label>
    <input type="text" v-model="withdrawAccountName" placeholder="Account name"><br>

    <label for="Amount">Amount</label>
    <input type="number" v-model="withdrawAmount" placeholder="Amount"><br>

    <button @click="withdraw">Withdraw</button>

    <!-- CHECK BALANCE -->
    <hr />
    <h2>
      Check Balance
    </h2>
    <label for="Account name">Account name</label>
    <input type="text" v-model="checkBalanceAccountName" placeholder="Account name"><br>

    <button @click="check">Check</button>

    <br />
    <br />
    <div>
      <label for="Balance">Balance</label>
      {{ AccountBalance }}
    </div>

    <!-- ACCOUNT DETAIL -->
    <hr />
    <h2>
      Account Inquiry
    </h2>
    <label for="Account name">Account name</label>
    <input type="text" v-model="accountInquiryAccountName" placeholder="Account name"><br>

    <button @click="inquiry">Inquiry</button>
    <br />
    <br />
    <div>
      <label for="Account Number">Account Number</label>
      {{ inquiryAccountNumber }}
    </div>
    <div>
      <label for="Name">Name</label>
      {{ inquiryAccountName }}
    </div>
    <div>
      <label for="Balance">Balance</label>
      {{ inquiryAccountBalance }}
    </div>

    <!-- INCREASE YEAR -->
    <hr />
    <h2>
      Increase Year
    </h2>
    <label for="Account name">Year</label>
    <input type="text" v-model="yearToIncrease" placeholder="Year"><br>

    <label for="Rate">Rate</label>
    <input type="text" v-model="interestRate" placeholder="Rate"><br>
    <button @click="increaseYear">Increase</button>
  </div>
</template>

<script>
export default {
  name: 'BankSystem',
  data () {
    return {
      // Intial System Accounts
      accounts: [
        {
          number: '84983390593904',
          name: 'Nattapon',
          balance: 0
        },
        {
          number: '5489932903290',
          name: 'Nimakul',
          balance: 0
        }
      ],

      // Create Account
      createAccountName: 'CDGGABLE',

      // Deposit
      depositAccountName: 'Nattapon',
      depositAmount: 0,

      // Withdraw
      withdrawAccountName: 'Nattapon',
      withdrawAmount: 0,

      // Check Balance
      checkBalanceAccountName: 'Nattapon',
      AccountBalance: 0,

      // Account Detail
      accountInquiryAccountName: 'Nattapon',
      inquiryAccountNumber: '',
      inquiryAccountName: '',
      inquiryAccountBalance: 0,

      // Increase Year
      yearToIncrease: 1,
      interestRate: 10
    }
  },
  methods: {
    // Create Account
    createAccount () {
      console.log(this.createAccountName)

      let accountName = this.createAccountName
      let accountNumber = this.randomAccountNumber()

      this.accounts.push({
        number: accountNumber,
        name: accountName,
        balance: 0
      })
    },

    // Deposit
    deposit () {
      let accountIndex = this.getAccountIndexByName(this.depositAccountName)
      if (accountIndex === -1) {
        alert('Account not found')
        return
      }

      // Validate Input here

      this.accounts[accountIndex].balance += parseInt(this.depositAmount)
    },

    // Withdraw
    withdraw () {
      let accountIndex = this.getAccountIndexByName(this.withdrawAccountName)
      if (accountIndex === -1) {
        alert('Account not found')
        return
      }

      // Validate Input here

      this.accounts[accountIndex].balance -= parseInt(this.withdrawAmount)
    },

    // Check Balance
    check () {
      let accountIndex = this.getAccountIndexByName(this.checkBalanceAccountName)
      if (accountIndex === -1) {
        alert('Account not found')
        return
      }

      // Validate Input here
      this.AccountBalance = this.accounts[accountIndex].balance
    },

    // Account Detail
    inquiry () {
      let accountIndex = this.getAccountIndexByName(this.accountInquiryAccountName)
      if (accountIndex === -1) {
        alert('Account not found')
        return
      }

      let account = this.accounts[accountIndex]
      this.inquiryAccountNumber = account.number
      this.inquiryAccountName = account.name
      this.inquiryAccountBalance = account.balance
    },

    // Increase Year
    increaseYear () {
      // This has a bug that can increase only 1 year per request
      for (var i = 0; i < this.accounts.length; i++) {
        let interest = this.accounts[i].balance * parseInt(this.interestRate) / 100
        this.accounts[i].balance += interest
      }
      console.log(this.yearToIncrease)
    },

    // Utility
    randomAccountNumber () {
      return parseInt(Math.random() * 9999999999).toString()
    },

    getAccountIndexByName (accountName) {
      return this.accounts.map(account => account.name).indexOf(accountName)
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
