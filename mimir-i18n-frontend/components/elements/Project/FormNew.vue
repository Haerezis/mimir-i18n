<template>
  <v-form
    :modelValue="modelValue"
    @update:modelValue="emit('update:modelValue', $event)"
    @submit.stop="emit('submit', data)"
    ref="form"
  >
    <v-text-field
      label="Name"
      v-model="data.name"
      :rules="nameRules"
    ></v-text-field>

    <select-locales
      v-model="data.locales"
      :locales="locales"
      :rules="localesRules"
    ></select-locales>

    <slot name="submit">
      <v-btn :disabled="!modelValue" @click="submit">Submit</v-btn>
    </slot>
  </v-form>
</template>

<script setup lang="ts">
import { ref, reactive, computed, PropType } from 'vue'

import ISO6391 from 'iso-639-1'

import SelectLocales from '@/components/elements/Input/SelectLocales.vue'
import { ProjectNew } from '@/types/Project'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: () => false,
  },
  locales: {
    type: Array as PropType<string[]>,
    default: () => ISO6391.getAllCodes()
  }
})

const form = ref(null)

const emit = defineEmits(['update:modelValue', 'submit'])

const data: ProjectNew = reactive({
  name: "",
  locales: [],
})

const nameRules = [
  (v) => !!v || "Name is required"
]
const localesRules = [
  (v) => !!v.length || "At least one locale is required"
]

const clear = () => form.value.reset()
const submit = async () => {
  if(await form.value.validate()) {
    emit('submit', data)
  }
}

defineExpose({
  clear,
  submit,
})
</script>

