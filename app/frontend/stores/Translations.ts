import Vue from 'vue'
import { defineStore } from 'pinia'

import axios from "@/plugins/axios"
import Routes from '@/plugins/routes'

import Translation from '@/types/Translation'

interface StateTranslation {
  original: Translation;
  current: Translation;
}
interface StatePersisted {
  [id: Number]: StateTranslation; 
}

export const useTranslationsStore = defineStore('translations', {
  state: () => ({
    persisted: {} as StatePersisted,
    new: [] as Translation[],
    deleted_ids: [] as Number[],
  }),
  getters: {
    all: (state) => ((project_id = null) => {
      let retval = state.new.concat(Object.values(state.persisted).map((st) => st.current))
      if(project_id) {
        retval = retval.filter((t) => t.project_id == project_id)
      }

      return retval
    }),
    translation_original: (state) => ((id) => state.persisted[id]?.original),
    translation_status: (state) => ((translation: Translation) => {
      const original = state.translation_original(translation.id)

      if(state.deleted_ids.includes(translation.id)) {
        return "deleted"
      }
      if(state.new.includes(translation)) {
        return "new"
      }
      if(original) {
        const dirty_key = translation.key != original.key
        const dirty_value = Object.entries(translation.values).some(([locale, value]) => value.value != original.values[locale].value)

        if(dirty_key || dirty_value) {
          return "dirty"
        }
      }
      
      return null
    }),
    all_by_status: (state) => ((project_id: number) => {
      const retval = {
        new: [],
        deleted: [],
        dirty: [],
      }

      state.all(project_id).forEach((translation) => {
        const status = state.translation_status(translation)
        retval[status]?.push(translation)
      })

      return retval
    })
  },
  actions: {
    //API QUERY
    load_all(project_id: number) {
      return axios.get(Routes.api_v1_project_translations_path(project_id))
        .then((response) => {
          response.data.forEach((translation_data) => {
            const translation = new Translation().init_from_api(translation_data)
            Vue.set(this.persisted, translation.id, {original: translation, current: translation.clone()})
          })
        })
    },
    bulk_update() {
      //TODO
    },
    //STORE QUERY
    delete(translation: Translation) {
      const new_index = this.new.indexOf(translation)
      if (new_index >= 0) {
        this.new.splice(new_index, 1)
      }

      if(this.persisted[translation.id] && !this.deleted_ids.includes(translation.id)) {
        this.deleted_ids.push(translation.id)
      }
    },
    undelete(translation: Translation) {
      const deleted_ids_index = this.deleted_ids.indexOf(translation.id)
      if (deleted_ids_index >= 0) {
        this.deleted_ids.splice(deleted_ids_index, 1)
      }
    },
  },
})
