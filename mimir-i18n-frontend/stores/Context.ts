import { defineStore } from 'pinia'

import { Project } from '@/types/Project'

export const useContextStore = defineStore('context', () => {
  const display_configuration = reactive({
    search_text: "",
    locales: [],
    show_original: false,
  })


  const translations_filters = reactive({
    text: "",
    locales: [],
  })

  return { display_configuration }
})
