import Vue from 'vue'
import { addDecorator } from '@storybook/vue';
import { Plugin as VuetifyPlugin, PluginInstance as VuetifyInstance } from '@/plugins/vuetify'

Vue.use(VuetifyPlugin)

export const parameters = {
  actions: { argTypesRegex: "^on[A-Z].*" },
  controls: {
    matchers: {
      color: /(background|color)$/i,
      date: /Date$/,
    },
  },
}

export const decorators = [
  (story, context) => {
    // wrap the passed component within the passed context
    const wrapped = story(context)
    // extend Vue to use Vuetify around the wrapped component
    return Vue.extend({
      vuetify: VuetifyInstance,
      components: { wrapped },
      template: `
        <v-app>
          <v-container fluid>
            <wrapped />
          </v-container>
        </v-app>
      `
    })
  },
]
