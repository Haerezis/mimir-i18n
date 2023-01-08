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
        :locales="filters.locales"
        @delete = "translations_store.delete"
        @undelete = "translations_store.undelete"
      />
    </v-list-item>
  </v-list>
</div>
</template>

<script setup lang="ts">
import { PropType, ref, computed } from 'vue'
import ISO6391 from 'iso-639-1'

import { Translation } from '@/types/Translation.ts'
import { Project } from '@/types/Project.ts'

import TranslationDialogNew from '@/components/elements/Translation/DialogNew.vue'
import TranslationCard from '@/components/elements/Translation/Card.vue'

import { useTranslationsStore } from '@/stores/Translations.ts'

const props = defineProps({
  project: {
    type: Object as PropType<Project>,
    required: true
  },
  filters: {
    type: Object,
    default: () => ({
      text: "",
      locales: project.value.locales,
    })
  }
})

const show_translation_new_dialog = ref(false)

const translations_store = useTranslationsStore()

const translations = computed(() => translations_store.all(props.project.id))

const all_by_status = computed(() => translations_store.all_by_status(props.project.id))
</script>
