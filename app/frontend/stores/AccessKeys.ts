import Vue from 'vue'
import { defineStore } from 'pinia'

import axios from "@/plugins/axios"
import Routes from '@/plugins/routes'

import AccessKey from '@/types/AccessKey'

export const useAccessKeysStore = defineStore('access_keys', {
  state: () => ({
    collection: {} as {[id: Number]: AccessKey },
  }),
  getters: {
    all: (state) => ((project_id: number = null) => {
      let retval = Object.values(state.collection)
      if(project_id) {
        retval = retval.filter((t) => t.project_id == project_id)
      }

      return retval
    }),
  },
  actions: {
    //API QUERY
    load_all(project_id: number) {
      return axios.get(Routes.api_v1_project_access_keys_path(project_id))
        .then((response) => {
          response.data.forEach((access_key_data) => {
            Vue.set(this.collection, access_key_data.id, access_key_data)
          })
        })
    },
    create(project_id: number, data: { name: string }) {
      return axios.post(Routes.api_v1_project_access_keys_path(project_id), data)
        .then((response) => {
          const access_key_data = response.data
          Vue.set(this.collection, access_key_data.id, access_key_data)
        })
    },
    update(id: number, data: { name?: string, value?: string }) {
      const access_key = this.collection[id]

      if (!access_key) {
        return;
      }

      return axios.patch(Routes.api_v1_project_access_key_path(access_key.project_id, access_key.id), data)
        .then((response) => {
          Vue.set(this.collection, access_key.id, response.data)
        })
    },
    delete(id: number) {
      const access_key = this.collection[id]

      if (!access_key) {
        return;
      }

      return axios.delete(Routes.api_v1_project_access_key_path(access_key.project_id, access_key.id))
        .then((response) => {
          Vue.delete(this.collection, access_key.id)
        })
    },
  },
})


