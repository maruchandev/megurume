<script setup>
import { ref } from 'vue'
import AppHeader from './AppHeader.vue'

const user = ref(null)

function logout() {
  // 認証APIを実装したら、ここでログアウトAPIを呼び出します。
  user.value = null
}
</script>

<template>
  <AppHeader :user="user" @logout="logout" />
</template>
