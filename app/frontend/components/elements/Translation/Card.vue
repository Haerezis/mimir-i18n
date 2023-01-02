<template>
  <v-card width="100%" class="card-hover">
    <v-btn icon @click.prevent="" class="card-menu-btn">
      <v-icon>mdi-dots-vertical</v-icon>
    </v-btn>

    <v-card-title class="flex-column align-start ma-0">
      {{ value.key }}
    </v-card-title>

    <v-card-text>
      <v-divider/>

      <v-container>
        <v-row v-for="locale in locales" :key="locale">
          <v-col cols="1" class="d-flex justify-end">
            <span class="pt-1">
              {{ locale.toUpperCase() }}
            </span>
          </v-col>

          <v-col>
            <card-translation-value-input v-model="value.values[locale]" class="pt-0 mt-0" />
          </v-col>
        </v-row>
      </v-container>
    </v-card-text>
  </v-card>
</template>

<script setup lang="ts">
import { PropType, computed, ref, reactive } from 'vue'
import ISO6391 from 'iso-639-1'

import { Translation } from '@/types/Translation'

import CardTranslationValueInput from '@/components/elements/Translation/Card_TranslationValueInput.vue'

const props = defineProps({
  value: {
    type: Translation,
    required: true
  },
  locales: {
    type: Array as PropType<string[]>,
    required: true
  }
})

const translation_values = computed(() => props.locales.map((locale) => props.value.values[locale]))
</script>
