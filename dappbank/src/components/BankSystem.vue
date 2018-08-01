<template>
  <div class="hello">
    <hr />
    <h2>
      Create Account
    </h2>
    <input type="text" v-model="userInputAccountName" placeholder="Account name"><br>
    <button @click="createAccount">Create</button>
  </div>
</template>

<script>
export default {
  name: 'BankSystem',
  data () {
    return {
      // Intial System Accounts
      accounts: {
        '84983390593904': {
          name: 'Nattapon',
          balance: 0
        }
      },

      // Create Account
      userInputAccountName: ''
    }
  },
  methods: {
    createAccount () {
      console.log(this.createAccountName)
      console.log()

      let accountName = this.userInputAccountName
      let accountNumber = this.randomAccountNumber()

      this.accounts[accountNumber] = {
        name: accountName,
        balance: 0
      }
    },

    randomAccountNumber () {
      return parseInt(Math.random() * 9999999999).toString()
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
