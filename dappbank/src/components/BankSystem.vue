<template>
  <div class="hello">
    <!-- CREATE ACCOUNT -->
    <hr />
    <h2>
      Create Account
    </h2>
    <input type="text" v-model="createAccountName" placeholder="Account name"><br>
    <button @click="createAccount">Create</button>

    <!-- DEPOSIT -->
    <hr />
    <h2>
      Deposit
    </h2>
    <input type="text" v-model="depositAccountName" placeholder="Account name"><br>
    <input type="number" v-model="depositAmount" placeholder="Amount"><br>
    <button @click="deposit">Deposit</button>

    <!-- WITHDRAW -->
    <hr />
    <h2>
      Withdraw
    </h2>
    <input type="text" v-model="withdrawAccountName" placeholder="Account name"><br>
    <input type="number" v-model="withdrawAmount" placeholder="Amount"><br>
    <button @click="withdraw">Withdraw</button>

    <!-- CHECK BALANCE -->
    <hr />
    <h2>
      Check Balance
    </h2>
    <input type="text" v-model="checkBalanceAccountName" placeholder="Account name"><br>
    <button @click="check">Check</button>
    <div>
      <label for="Balance">Balance</label>
      {{ AccountBalance }}
    </div>
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
      AccountBalance: 0
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
