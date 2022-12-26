import { Plugin as VuetifyPlugin, PluginInstance as VuetifyInstance } from '@/plugins/vuetify'
import { Plugin as VueRouterPlugin, PluginInstance as VueRouterInstance } from '@/plugins/vue-router'
import { Plugin as PiniaPlugin, PluginInstance as PiniaInstance } from '@/plugins/pinia'

const registerPlugins = (app) => {
  app.use(PiniaPlugin)
  app.use(VuetifyPlugin)
  app.use(VueRouterPlugin)

  return {
    pinia: PiniaInstance,
    vuetify: VuetifyInstance,
    router: VueRouterInstance,
  }
}

export default registerPlugins
