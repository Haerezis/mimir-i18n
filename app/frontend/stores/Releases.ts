import Vue from 'vue'
import { defineStore } from 'pinia'

import axios from "@/plugins/axios"
import Routes from '@/plugins/routes'

import Release from '@/types/Release'

export const useReleasesStore = defineStore('releases', {
  state: () => ({
    collection: {} as {[id: Number]: Release },
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
      return axios.get(Routes.api_v1_project_releases_path(project_id))
        .then((response) => {
          response.data.forEach((release_data) => {
            Vue.set(this.collection, release.id, release)
          })
        })
    },
    create(project_id: number) {
      return axios.post(Routes.api_v1_project_releases_path(project_id))
        .then((response) => {
          const release_data = response.data
          Vue.set(this.collection, release.id, release)
        })
    },
    delete(project_id: number, release_id: number) {
      return axios.delete(Routes.api_v1_project_release_path(project_id, release_id))
        .then((response) => {
          Vue.delete(this.collection, release_id)
        })
    },
    export_url(project_id: number, release_id: number = null) {
      release_id = !!release_id ? release_id : "HEAD"
      return Routes.export_api_v1_project_release_path(project_id, release_id)
    }
  },
})

