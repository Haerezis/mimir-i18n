import { defineStore } from 'pinia'

import { Translation, ApiTranslation } from '@/types/Translation'

interface PersistedTranslation {
  original: Translation;
  current: Translation;
}

interface PersistedTranslationCollection {
  [id: number]: PersistedTranslation;
}

export function useTranslationsStore(project_id: number, ...args: any[]) {
  return defineStore(`translations_[${project_id}]`, () => {
    const persisted: PersistedTranslationCollection = reactive({})

    const unsaved: Ref<Translation[]> = ref([])

    const flagged_for_deletion_ids: Ref<number[]> = ref([])

    const all = computed(() => Array<Translation>().concat(
      Object.values(persisted).map((pt) => pt.current),
      unsaved.value)
    )

    const translation_original = (id: number) => persisted[id]?.original

    const translation_status = computed(() => ((translation: Translation) => {
      if (translation.id == null || unsaved.value.includes(translation)) {
        return "to_create"
      }
      if (flagged_for_deletion_ids.value.includes(translation.id)) {
        return "to_delete"
      }

      const original = translation_original(translation.id)
      if (original) {
        const dirty_key = translation.key != original.key
        const dirty_value = Object.entries(translation.values).some(([locale, value]) => value.value != original.values[locale].value)

        if (dirty_key || dirty_value) {
          return "to_update"
        }
      }

      return null
    }))

    const pending_changes = computed(() => {
      const retval = {
        untouched: Array<Translation>(),
        to_create: Array<Translation>(),
        to_update: Array<Translation>(),
        to_delete: Array<Translation>(),
      }

      all.value.forEach((translation) => {
        const status = translation_status.value(translation)
        retval[status || 'untouched'].push(translation)
      })

      return retval
    })

    const load_all = async () => {
      const response = await useFetchGET<ApiTranslation[]>(apiRoutes.api_v1_project_translations_path(project_id))
      const translations = response.data.value ?? []
      translations.forEach((data) => {
        const translation = (new Translation()).init_from_api(data)
        if (translation.id) {
          persisted[translation.id] = { original: translation, current: translation.clone() }
        }
      })
    }

    const has_pending_changes = computed(() => {
      return (
        pending_changes.value.to_create.length +
        pending_changes.value.to_update.length +
        pending_changes.value.to_delete.length
      ) > 0
    })

    const send_pending_changes_to_remote = async () => {
      const { to_create, to_update, to_delete } = pending_changes.value

      let request_data: any[] = []

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

      useFetchPOST(apiRoutes.do_many_api_v1_project_translations_path(project_id), { body: request_data })
        .then((response) => {
          (response.data.value ?? []).forEach((item: any) => {
            if (item.action == 'create') {
              const translation = new Translation().init_from_api(item.retval)
              persisted[translation.id] = { original: translation, current: translation.clone() }

              const index = unsaved.value.findIndex((t) => t.uuid == item.id)
              if (index >= 0) {
                unsaved.value.splice(index, 1)
              }
            }
            else if (item.action == 'update') {
              const translation = new Translation().init_from_api(item.retval)
              persisted[translation.id] = { original: translation, current: translation.clone() }
            }
            else if (item.action == 'delete') {
              const translation_id = item.retval.id

              delete persisted[translation_id]

              const index = flagged_for_deletion_ids.value.indexOf(translation_id)
              if (index >= 0) {
                flagged_for_deletion_ids.value.splice(index, 1)
              }
            }
          })
        })
        .catch((response) => {
          response.data.forEach((item: any) => {
            if (item.status != "error") {
              return;
            }

            if (item.action == 'update' || item.action == 'delete') {
              const persisted_translation = Object.values(persisted).find((i) => i.current.uuid == item.id)
              persisted_translation.current.error_messages = item.error_messages || []
            }
            else if (item.action == 'create') {
              const translation = unsaved.value.find((t) => t.uuid == item.id)
              if (translation) {
                translation.error_messages = item.error_messages || []
              }
            }
          })
          throw "Error on do_many"
        })
    }

    //STORE QUERY
    const add = (translation: Translation) => {
      if (translation.id) {
        return
      }

      unsaved.value.push(translation)
    }

    const flag_for_deletion = (translation: Translation) => {
      const new_index = unsaved.value.indexOf(translation)
      if (new_index >= 0) {
        unsaved.value.splice(new_index, 1)
      }
      else if (persisted[translation.id] && !flagged_for_deletion_ids.value.includes(translation.id)) {
        flagged_for_deletion_ids.value.push(translation.id)
      }
    }

    const unflag_for_deletion = (translation: Translation) => {
      const index = flagged_for_deletion_ids.value.indexOf(translation.id)
      if (index >= 0) {
        flagged_for_deletion_ids.value.splice(index, 1)
      }
    }

    return { all, translation_original, translation_status, pending_changes, load_all, has_pending_changes, send_pending_changes_to_remote, add, flag_for_deletion, unflag_for_deletion }
  })(...args)
}
