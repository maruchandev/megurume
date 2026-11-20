import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  server: {
    host: '0.0.0.0',
    // Docker Desktop may not forward Windows file-change events to the container.
    // Poll the mounted source so Vite can reload after files are saved.
    watch: {
      usePolling: true,
      interval: 500,
    },
    proxy: {
      '/api': 'http://backend:8000',
    },
  },
})
