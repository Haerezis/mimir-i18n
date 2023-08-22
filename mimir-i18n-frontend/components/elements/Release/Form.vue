<template>
  <v-form
    v-model="localValue"
    @submit.stop="emit('submit', form_data)"
    ref="form"
  >
    <v-textarea
      label="Commit message"
      v-model="form_data.message"
      :rules="messageRules"
    ></v-textarea>

    <slot name="submit">
      <v-btn :disabled="!localValue" @click="submit">Submit</v-btn>
    </slot>
  </v-form>
</template>

<script setup lang="ts">
import { Release } from '@/types/Release'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: () => false,
  },
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

const form_data: Release = reactive({
  message: "",
})

const messageRules = [
  (v) => !!v || "Cannot be empty",
]

const clear = () => form.value.reset()
const submit = () => {
  if(form.value.validate()) {
    emit('submit', form_data)
  }
}

defineExpose({
  clear,
  submit,
})
</script>

