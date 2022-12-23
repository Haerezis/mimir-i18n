import { defineStore } from 'pinia'

import axios from "@/plugins/axios"
import Routes from '@/plugins/routes'

import Translation from '@/types/TranslationKey.ts'

export const useTranslationsStore = defineStore('translations', {
  state: () => ({
    translations: {} as { [key: number]: Translation },
  }),
  getters: {
    byProjectId: (state) => { (id) => { Object.values(state.translations).filter((t) => t.project_id == id) } },
    //get pending actions
  },
  actions: {
    loadAll(project_id: number) {
      return axios.get(window.Routes.api_v1_project_translations_path(project_id))
        .then((response) => {
          response.data.forEach((translation) => this.translations[translation.id] = translation)
        })
    },
    //create
    //update key
    //update value (via locale)
    //flag for removal
    //Apply pending actions
  },
})