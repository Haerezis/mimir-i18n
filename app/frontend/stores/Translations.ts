import { defineStore } from 'pinia'

import axios from "@/plugins/axios"
import Routes from '@/plugins/routes'

import Translation from '@/types/Translation'

export const useTranslationsStore = defineStore('translations', {
  state: () => ({
    translations: {} as { [key: number]: Translation },
  }),
  getters: {
    by_project_id: (state) => ((id) => Object.values(state.translations).filter((t) => t.project_id == id)),
    //get pending actions
  },
  actions: {
    load_all(project_id: number) {
      return axios.get(Routes.api_v1_project_translations_path(project_id))
        .then((response) => {
          response.data.forEach((translation_data) => {
            const translation = new Translation().initFromApi(translation_data)
            this.translations[translation.id] = translation
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
