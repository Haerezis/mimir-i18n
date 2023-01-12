<template>
<div>
  <v-btn
    @click="show_translation_new_dialog = true"
    rounded
  >
    <v-icon>mdi-plus</v-icon>
    New Translation
  </v-btn>
  <translation-dialog-new v-model="show_translation_new_dialog" :project="project" />

  <v-btn
    @click="save_modifications"
    rounded
  >
    Save Modifications
  </v-btn>

  <v-list>
    <v-list-item
      v-for="translation in translations"
      :key="translation.uuid"
      class="mt-6"
    >
      <translation-card
        :value="translation"
        :original="translations_store.translation_original(translation.id)"
        :status="translations_store.translation_status(translation)"
        :locales="translation_locales"
        :show_original="translations_store.display_configuration.show_original"
        @delete = "translations_store.delete"
        @undelete = "translations_store.undelete"
      />
    </v-list-item>
  </v-list>
</div>
</template>

<script setup lang="ts">
import { PropType, ref, computed } from 'vue'

import { Translation } from '@/types/Translation.ts'
import { Project } from '@/types/Project.ts'

import TranslationDialogNew from '@/components/elements/Translation/DialogNew.vue'
import TranslationCard from '@/components/elements/Translation/Card.vue'

import { useTranslationsStore } from '@/stores/Translations.ts'

const props = defineProps({
  project: {
    type: Object as PropType<Project>,
    required: true
  }
})

const show_translation_new_dialog = ref(false)

const translations_store = useTranslationsStore()

const escapeRegExp = (string) => string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); // $& means the whole matched string
const translations = computed(() => {
  let retval = translations_store.all(props.project.id)

  if(translations_store.display_configuration.search_text) {
    const regex = new RegExp(`${escapeRegExp(translations_store.display_configuration.search_text)}`, 'i')
    const fn = (t) => regex.test(t.key) || Object.values(t.values).some((v) => regex.test(v.value))
    retval = retval.filter(fn)
  }

  return retval
})

const translation_locales = computed(() => props.project.locales.filter((l) => translations_store.display_configuration.locales.includes(l)))

const all_by_status = computed(() => translations_store.all_by_status(props.project.id))
const save_modifications = () => {
  translations_store.do_many(props.project.id, all_by_status.value)
    .then(() => console.log("success"))
    .catch(() => console.log("error"))
}
</script>
