<template>
  <v-card width="100%" class="card-hover" :color="color">
    <v-btn
      v-if="status != 'to_delete'"
      icon
      class="card-menu-btn"
      @click.prevent="emit('delete', value)"
    >
      <v-icon>mdi-close</v-icon>
    </v-btn>
    <v-btn
      v-else
      icon
      class="card-menu-btn"
      @click.prevent="emit('undelete', value)"
    >
      <v-icon>mdi-check</v-icon>
    </v-btn>

    <v-card-title class="ma-0 pr-10">
      <input-textfield-diff
        v-model="value.key"
        :original="original ? original.key : null"
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
            <v-textarea
              v-if="show_original"
              v-model="original.values[locale].value"
              label="Original"
              disabled
              rows="1"
              auto-grow
              hide-details
              counter
              class="pt-0 pb-2 mt-0"
            />
            <input-textarea-diff
              v-model="value.values[locale].value"
              :original="original ? original.values[locale].value : null"
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
  original: {
    type: Translation,
  },
  status: {
    type: String,
  },
  locales: {
    type: Array as PropType<string[]>,
    required: true
  },
  show_original: {
    type: Boolean,
    default: false,
  }
})

const emit = defineEmits(['delete'])

const translation_values = computed(() => props.locales.map((locale) => props.value.values[locale]))

const colors = {
  to_create: "green",
  to_update: "yellow",
  to_delete: "red"
}
const color = computed(() => colors[props.status])
</script>

<style scoped>
.row + .row {
  margin-top: 0;
}
</style>
