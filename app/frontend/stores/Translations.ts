import Vue from 'vue'
import { defineStore } from 'pinia'

import axios from "@/plugins/axios"
import Routes from '@/plugins/routes'

import Translation from '@/types/Translation'

interface PersistedTranslation {
  original: Translation;
  current: Translation;
}
interface StatePersistedTranslation {
  [id: Number]: PersistedTranslation; 
}

export const useTranslationsStore = defineStore('translations', {
  state: () => ({
    persisted: {} as StatePersistedTranslation,
    new: [] as Translation[],
    deleted_ids: [] as Number[],
    display_configuration: {
      search_text: "",
      locales: [],
      show_original: false,
    },
  }),
  getters: {
    all: (state) => ((project_id: number = null) => {
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
        return "to_delete"
      }
      if(state.new.includes(translation)) {
        return "to_create"
      }
      if(original) {
        const dirty_key = translation.key != original.key
        const dirty_value = Object.entries(translation.values).some(([locale, value]) => value.value != original.values[locale].value)

        if(dirty_key || dirty_value) {
          return "to_update"
        }
      }
      
      return null
    }),
    all_by_status: (state) => ((project_id: number) => {
      const retval = {
        untouched: [],
        to_create: [],
        to_update: [],
        to_delete: [],
      }

      state.all(project_id).forEach((translation) => {
        const status = state.translation_status(translation)
        retval[status || 'untouched'].push(translation)
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
    do_many(project_id: number, pending: { to_create?: Translation[]; to_update?: Translation[]; to_delete?: Translation[] }) {
      const to_create = (pending.to_create || [])
      const to_update = (pending.to_update || [])
      const to_delete = (pending.to_delete || [])

      let request_data = []

      request_data = request_data.concat(
        to_create.map((translation) => ({
          id: translation.uuid,
          action: "create",
          data: translation.to_json()
        }))
      )
      request_data = request_data.concat(
        to_update.map((translation) => ({
          id: translation.uuid,
          action: "update",
          data: translation.to_json()
        }))
      )
      request_data = request_data.concat(
        to_delete.map((translation) => ({
          id: translation.uuid,
          action: "delete",
          data: translation.id
        }))
      )

      return axios.post(Routes.do_many_api_v1_project_translations_path(project_id), request_data)
        .then((response) => {
          response.data.forEach((item) => {
            if(item.action == 'create') {
              const translation = new Translation().init_from_api(item.retval)
              Vue.set(this.persisted, translation.id, {original: translation, current: translation.clone()})

              const index = this.new.findIndex((t) => t.uuid == item.id)
              if (index >= 0) {
                this.new.splice(index, 1)
              }
            }
            else if(item.action == 'update') {
              const translation = new Translation().init_from_api(item.retval)

              Vue.set(this.persisted, translation.id, {original: translation, current: translation.clone()})
            }
            else if(item.action == 'delete') {
              const translation_id = item.retval.id

              Vue.delete(this.persisted, translation_id)

              const index = this.deleted_ids.indexOf(translation_id)
              if (index >= 0) {
                this.deleted_ids.splice(index, 1)
              }
            }
          })
        })
        .catch((response) => {
          response.data.forEach((item) => {
            if(item.status != "error") {
              return;
            }

            if(item.action == 'update' || item.action == 'delete') {
              const persisted_translation = this.persisted.find((i) => i.current.uuid == item.id)
              persisted_translation.current.error_messages = item.error_messages || []
            }
            else if(item.action == 'create') {
              const translation = this.new.find((t) => t.uuid == item.id)
              translation.error_messages = item.error_messages || []
            }
          })
          throw "Error on do_many"
        })
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
