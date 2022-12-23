import { defineStore } from 'pinia'

import axios from '@/plugins/axios'
import Routes from '@/plugins/routes'

import User from '@/types/User.ts'

export const useCurrentUserStore = defineStore('current_user', {
  state: () => ({
    user: null as User | null
  }),
  getters: {
  },
  actions: {
    load() {
      return axios.get(Routes.api_v1_current_user_path())
        .then((response) => {
          this.user = response.data
        })
    }
  },
})
