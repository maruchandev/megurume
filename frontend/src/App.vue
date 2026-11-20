<script setup>
import { ref } from 'vue'
import AppHeader from './AppHeader.vue'

const user = ref(null)
const apiStatus = ref('API確認前')

async function checkApi() {
  apiStatus.value = '確認中…'

  try {
    const response = await fetch('/api/health', {
      headers: { Accept: 'application/json' },
    })
    apiStatus.value = response.ok ? 'API接続OK' : `API応答: ${response.status}`
  } catch {
    apiStatus.value = 'APIに接続できません'
  }
}

function logout() {
  // 認証APIを実装したら、ここでログアウトAPIを呼び出します。
  user.value = null
}
</script>

<template>
  <AppHeader :user="user" @logout="logout" />

  <main class="page-content">
    <section class="card" aria-labelledby="page-title">
      <p class="eyebrow">MEGURUME</p>
      <h1 id="page-title">ホーム画面</h1>
      <p>共通ヘッダーの表示を確認できます。</p>
      <button type="button" @click="checkApi">API接続を確認</button>
      <p class="status" role="status">{{ apiStatus }}</p>
    </section>
  </main>
</template>
