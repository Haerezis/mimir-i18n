import * as VueRouter from 'vue-router'

import routes from '@/router'

export default VueRouter.createRouter({
  history: VueRouter.createWebHistory(),
  routes: routes,
})
