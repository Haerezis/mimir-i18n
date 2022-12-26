import Vue from 'vue'

import registerPlugins from '@/plugins'

import App from '@/App.vue'

Vue.config.productionTip = false

const vueOptions = registerPlugins(Vue)

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    render: h => h(App),
    ...vueOptions
  }).$mount('#app')
}, { once: true })
