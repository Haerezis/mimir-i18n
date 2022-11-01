import * as Vue from 'vue'
import * as VueRouter from 'vue-router'

import App from '../App.vue'

const myApp = Vue.createApp(App)

const myRouter = VueRouter.createRouter({
  history: VueRouter.createWebHistory(),
  routes: [],
})


myApp.use(myRouter)

document.addEventListener('DOMContentLoaded', () => {
  myApp.mount('#app')
})
