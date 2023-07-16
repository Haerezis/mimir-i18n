<template>
  <v-card :color="color">
    <v-btn
      class="delete-btn"
      variant="flat"
      @click.prevent="emit(delete_btn.event, modelValue)"
    >
      <v-icon>{{ delete_btn.icon }}</v-icon>{{ delete_btn.text}}
    </v-btn>

    <v-card-title class="ma-0 mt-2 pr-10">
      <input-textfield-diff
        v-model="modelValue.key"
        :original="original ? original.key : null"
        label="Key"
        :regex="/^([a-z][a-z0-9]*\.)*[a-z][a-z0-9]*\.?$/i"
        class="input-field-width"
      />
    </v-card-title>

    <v-card-text>
      <v-container class="mx-0 px-0 input-field-width">
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
              persistent-counter
              class="pt-0 pb-2 mt-0"
            />
            <input-textarea-diff
              v-model="modelValue.values[locale].value"
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
import ISO6391 from 'iso-639-1'

import { Translation } from '@/types/Translation'

import InputTextareaDiff from '@/components/elements/Input/TextareaDiff.vue'
import InputTextfieldDiff from '@/components/elements/Input/TextfieldDiff.vue'

const props = defineProps({
  modelValue: {
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

const emit = defineEmits(['delete', 'undelete'])

const translation_values = computed(() => props.locales.map((locale) => props.modelValue.values[locale]))

const colors = {
  to_create: "green",
  to_update: "yellow",
  to_delete: "red"
}
const color = computed(() => colors[props.status])

const delete_btn = computed(() => {
  if(props.status == 'to_delete') {
    return {
      icon: "mdi-check",
      text: "Cancel",
      event: "undelete",
    }
  }
  else {
    return {
      icon: "mdi-close",
      text: "Delete",
      event: "delete",
    }
  }
})
</script>

<style scoped>
.row + .row {
  margin-top: 0;
}

.delete-btn {
  position: absolute;
  top: 0px;
  right: 0px;
}

.input-field-width {
  max-width: 1200px;
}
</style>
