<template>
  <div class="home">
    <img src="../assets/logo.png">
    <BankSystem/>
  </div>
</template>

<script>
// @ is an alias to /src
import BankSystem from '@/components/BankSystem'

export default {
  name: 'home',
  components: {
    BankSystem
  }
}
</script>
