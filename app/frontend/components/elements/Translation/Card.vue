<template>
  <v-card width="100%" class="card-hover">
    <v-btn icon @click.prevent="" class="card-menu-btn">
      <v-icon>mdi-dots-vertical</v-icon>
    </v-btn>

    <v-card-title class="ma-0 pr-10">
      <input-textfield-diff
        v-model="value.key"
        :original="value.key_original"
        label="Key"
        :regex="/^([a-z][a-z0-9]*\.)*[a-z][a-z0-9]*\.?$/i"
      />
    </v-card-title>

    <v-card-text>
      <v-container>
        <v-row v-for="locale in locales" :key="locale">
          <v-col cols="1" class="d-flex justify-end">
            <span class="pt-1">
              {{ locale.toUpperCase() }}
            </span>
          </v-col>

          <v-col>
            <input-textarea-diff
              v-model="value.values[locale].value"
              :original="value.values[locale].value_original"
              class="pt-0 mt-0"
            />
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

import InputTextareaDiff from '@/components/elements/Input/TextareaDiff.vue'
import InputTextfieldDiff from '@/components/elements/Input/TextfieldDiff.vue'

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

<style scoped>
.row + .row {
  margin-top: 0;
}
</style>
