import * as Vue from 'vue'

import App from '@/App.vue'
import registerPlugins from '@/plugins'

const myApp = Vue.createApp(App)
registerPlugins(myApp)

document.addEventListener('DOMContentLoaded', () => {
  myApp.mount('#app')
}, { once: true })
