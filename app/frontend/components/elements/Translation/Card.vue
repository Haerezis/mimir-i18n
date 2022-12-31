<template>
  <v-card width="100%" class="card-hover">
    <v-btn icon @click.prevent="" class="card-menu-btn">
      <v-icon>mdi-dots-vertical</v-icon>
    </v-btn>

    <v-card-title class="flex-column align-start ma-0">
      {{ value.key }}
      <v-text-field/>
    </v-card-title>

    <v-card-text>
      <v-divider/>
      <v-list>
        <v-list-item v-for="locale in locales" class="flex-column align-start ma-0">
          <div>{{ locale }}</div>
          <v-textarea :value="value.values[locale]?.value" disabled rows="1" auto-grow hide-details>
            <template v-slot:prepend>
              Current
            </template>
          </v-textarea>
          <v-textarea label="Change value" class="pt-0 mt-0" rows="1" auto-grow hide-details>
            <template v-slot:prepend>Next</template>
          </v-textarea>
        </v-list-item>
      </v-list>
    </v-card-text>
  </v-card>
</template>

<script setup lang="ts">
import { PropType, computed, ref } from 'vue'
import ISO6391 from 'iso-639-1'

import { Translation } from '@/types/Translation.ts'

const props = defineProps({
  value: {
    type: Object as PropType<Translation>,
    required: true
  },
  locales: {
    type: Array as PropType<string[]>,
    required: true
  }
})

const foobar = ref("")
</script>
