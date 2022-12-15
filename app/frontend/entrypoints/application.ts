import * as Vue from 'vue'

import App from '../App.vue'
import vuetify from '../plugins/vuetify'
import vuerouter from '../plugins/vue-router'

const myApp = Vue.createApp(App)

myApp.use(vuerouter)
myApp.use(vuetify)

document.addEventListener('DOMContentLoaded', () => {
  myApp.mount('#app')
}, { once: true })
