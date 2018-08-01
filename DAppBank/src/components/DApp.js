import Web3 from 'web3'
import abi from './abi'

class BankSystem {
  constructor () {
    this.web3 = new Web3(window.web3.currentProvider)
    this.bank = this.loadSmartContract()
  }

  loadSmartContract () {
    let tokenAddr = '0x4b5380a25a3142fd81672594ac2f7288ed1c67e9'

    let contract = new this.web3.eth.Contract(abi, tokenAddr)

    return contract
  }

  async deposit (amount) {
    let accounts = await this.web3.eth.getAccounts()
    let etherAmt = this.web3.utils.toWei(amount.toString())

    let options = {
      from: accounts[0],
      value: etherAmt
    }

    let balance = await this.bank.methods.deposit().send(options)
    return balance
  }
}

export default BankSystem
