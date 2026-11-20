<script setup>
defineProps({
  user: {
    type: Object,
    default: null,
  },
})

defineEmits(['logout'])
</script>

<template>
  <header class="app-header">
    <a class="brand" href="/" aria-label="メグルメ ホーム">メグルメ</a>

    <nav class="header-nav" aria-label="メインメニュー">
      <template v-if="user">
        <a v-if="user.role === 'employee'" href="/mypage">マイページ</a>
        <a v-if="user.role === 'admin'" href="/users">ユーザー一覧</a>
        <a href="/receipts">領収書提出一覧</a>
        <button class="logout-button" type="button" @click="$emit('logout')">
          ログアウト
        </button>
      </template>

      <a v-else href="/login">ログイン</a>
    </nav>
  </header>
</template>

<style scoped>
.app-header {
  min-height: 68px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
  padding: 0 clamp(20px, 5vw, 72px);
  background: #fff;
  border-bottom: 1px solid #e5ebe7;
}

.brand {
  color: #236b3a;
  font-size: 1.3rem;
  font-weight: 800;
  letter-spacing: 0.03em;
  text-decoration: none;
  white-space: nowrap;
}

.header-nav {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  flex-wrap: wrap;
  gap: 12px 24px;
}

.header-nav a,
.logout-button {
  color: #26352b;
  font: inherit;
  font-weight: 600;
  text-decoration: none;
}

.header-nav a:hover,
.logout-button:hover {
  color: #236b3a;
}

.logout-button {
  padding: 0;
  background: none;
  border: 0;
  cursor: pointer;
}

@media (max-width: 640px) {
  .app-header {
    align-items: flex-start;
    flex-direction: column;
    gap: 12px;
    padding-block: 16px;
  }

  .header-nav {
    justify-content: flex-start;
    gap: 12px 18px;
  }
}
</style>
