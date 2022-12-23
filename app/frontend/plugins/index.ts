import vuetify from '@/plugins/vuetify'
import vuerouter from '@/plugins/vue-router'
import pinia from '@/plugins/pinia'

const registerPlugins = (app) => {
  app.use(vuerouter)
  app.use(vuetify)
  app.use(pinia)

  return app
}

export default registerPlugins
