<template>
  <v-form
    v-model="localValue"
    @submit.prevent="submit"
    ref="form"
  >
    <v-text-field
      label="Key"
      v-model="data.key"
      :rules="keyRules"
      @keydown.enter="submit"
    ></v-text-field>

    <v-divider/>

    <v-list>
      <v-list-item v-for="locale in project.locales" :key="locale">

        <v-textarea
          v-model="data.values[locale].value"
          :label="locale.toUpperCase()"
          @keydown.ctrl.enter="submit"
          rows="1"
          auto-grow
          hide-details="auto"
          counter
        />
      </v-list-item>
    </v-list>

    <slot name="submit">
      <v-btn :disabled="!localValue" @click="submit">Submit</v-btn>
    </slot>
  </v-form>
</template>

<script setup lang="ts">
import ISO6391 from 'iso-639-1'

import Project from '@/types/Project'
import { Translation } from '@/types/Translation'


const props = defineProps({
  modelValue: {
    type: Boolean,
    default: () => false,
  },
  project: {
    type: Object as PropType<Project>,
    required: true,
  }
})

const emit = defineEmits(['update:modelValue', 'submit'])

const _localValue = ref(props.modelValue)
const localValue = computed({
  get: () => _localValue.value,
  set: (newValue) => {
    _localValue.value = newValue
    emit("update:modelValue", newValue)
  }
})
watch(
  () => props.modelValue,
  (newValue) => _localValue.value = newValue
)

const form = ref(null)

const data = reactive((new Translation).init(props.project.id, "", props.project.locales))

const keyRules = [
  (v) => !!v || "Key is required"
]

const clear = () => {
  data.init(props.project.id, "", props.project.locales)
  form.value.resetValidation()
}
const submit = async () => {
  if(await form.value.validate()) {
    emit('submit', data.clone())
  }
}
defineExpose({
  clear,
  submit,
})
</script>
  
  
