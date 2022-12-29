import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue2'
import { createSvgPlugin } from "vite-plugin-vue2-svg";

export default defineConfig({
  plugins: [
    RubyPlugin(),
    vue(),
    createSvgPlugin(),
  ],
})
