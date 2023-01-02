<template>
  <v-list>
    <v-list-item
      v-for="translation in translations"
      :key="translation.id"
      class="mt-6"
    >
      <translation-card :value="translation" :locales="locales" />
    </v-list-item>
  </v-list>
</template>

<script setup lang="ts">
import { PropType, computed } from 'vue'
import ISO6391 from 'iso-639-1'

import { Translation } from '@/types/Translation.ts'
import { Project } from '@/types/Project.ts'

import TranslationCard from '@/components/elements/Translation/Card.vue'

import { useTranslationsStore } from '@/stores/Translations.ts'

const props = defineProps({
  project: {
    type: Object as PropType<Project>,
    required: true
  },
  locales: {
    type: Array as PropType<string[]>,
    required: true
  }
})

const translations_store = useTranslationsStore()

const translations = computed(() => translations_store.by_project_id(props.project.id))
</script>
