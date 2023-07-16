// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: false },
  ssr: false,
  modules: [
    '@pinia/nuxt',
    '@sidebase/nuxt-auth',
    '@vueuse/nuxt',
    'nuxt-svgo',
  ],
  imports: {
    dirs: [
      'types',
      'stores',
    ],
  },
  css: [
    'vuetify/lib/styles/main.sass',
    '@mdi/font/css/materialdesignicons.min.css',
  ],
  build: {
    transpile: ['vuetify'],
  },
  vite: {
    define: {
      'process.env.DEBUG': false,
    },
  },
  runtimeConfig: {
    // Private keys are only available on the server
    //apiSecret: '123',
    // Public keys that are exposed to the client
    public: {
      apiBase: process.env.NUXT_PUBLIC_API_BASE
    }
  },

  auth: {
    globalAppMiddleware: true,
    baseURL: `${process.env.NUXT_PUBLIC_API_BASE}/`,
    provider: {
      type: 'local',
      sessionDataType: {
        id: 'number',
        firstname: 'string',
        lastname: 'string',
        email: 'string',
        picture: 'Picture'
      },
      endpoints: {
        signIn: { path: '/api/v1/users/sign_in', method: 'post' },
        signOut: { path: '/api/v1/users/sign_out', method: 'delete' },
        //signUp: { path: '/register', method: 'post' },
        getSession: { path: '/api/v1/current_user' },
      },
      token: {
        maxAgeInSeconds: 60 * 60 * 24 * 31
      },
    },
  },
})
