import VueRouter from 'vue-router'

import routes from '@/router'

const router = new VueRouter({
  mode: 'history',
  routes: routes,
})

export const Plugin = VueRouter;
export const PluginInstance = router;
