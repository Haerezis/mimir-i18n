import Vue from 'vue'
import { defineStore } from 'pinia'

import axios from "@/plugins/axios"
import Routes from '@/plugins/routes'

import Translation from '@/types/Translation'

export const useTranslationsStore = defineStore('translations', {
  state: () => ({
    persisted: {} as { [key: number]: Translation },
    new: [] as Translation[],
  }),
  getters: {
    all: (state) => state.new.concat(Object.values(state.persisted)),
    by_project_id: (state) => ((id) => useTranslationsStore().all.filter((t) => t.project_id == id)),
    //get pending actions
  },
  actions: {
    load_all(project_id: number) {
      return axios.get(Routes.api_v1_project_translations_path(project_id))
        .then((response) => {
          response.data.forEach((translation_data) => {
            const translation = new Translation().init_from_api(translation_data)
            Vue.set(this.all, translation.id, translation)
          })
        })
    },
    //create
    //update key
    //update value (via locale)
    //flag for removal
    //Apply pending actions
  },
})
