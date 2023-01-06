<template>
  <v-form
    :value="value"
    @input="emit('input', $event)"
    @submit.stop="emit('submit', data)"
    ref="form"
  >
    <v-text-field
      label="Key"
      v-model="data.key"
      :rules="keyRules"
    ></v-text-field>

    <v-divider/>

    <v-list>
      <v-list-item v-for="locale in project.locales" :key="locale">
        <v-text-field
          :label="locale.toUpperCase()"
          v-model="data.values[locale].value"
          :rules="keyRules"
        />
      </v-list-item>
    </v-list>

    <slot name="submit">
      <v-btn :disabled="!value" @click="submit">Submit</v-btn>
    </slot>
  </v-form>
</template>

<script setup lang="ts">
import { ref, reactive, computed, PropType } from 'vue'

import ISO6391 from 'iso-639-1'

import Project from '@/types/Project'
import { Translation } from '@/types/Translation'


const props = defineProps({
  value: {
    type: Boolean,
    default: () => false,
  },
  project: {
    type: Object as PropType<Project>,
    required: true,
  }
})

const form = ref(null)

const emit = defineEmits(['input', 'submit'])

const data: Translation = reactive((new Translation).init(props.project.id, "", props.project.locales))

const keyRules = [
  (v) => !!v || "Key is required"
]

const clear = () => form.value.reset()
const submit = () => {
  if(form.value.validate()) {
    emit('submit', data)
  }
}
defineExpose({
  clear,
  submit,
})
</script>
  
  