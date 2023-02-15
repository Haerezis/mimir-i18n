<template>
  <v-form
    v-model="local_value"
    @submit.stop="emit('submit', form_data)"
    ref="form"
  >
    <v-text-field
      label="Name"
      v-model="form_data.name"
      :rules="nameRules"
    ></v-text-field>

    <v-text-field
      v-if="!!initial_data?.value"
      label="Key"
      v-model="form_data.value"
      :rules="valueRules"
    ></v-text-field>

    <slot name="submit">
      <v-btn :disabled="!local_value" @click="submit">Submit</v-btn>
    </slot>
  </v-form>
</template>

<script setup lang="ts">
import { ref, reactive, computed, PropType, watch } from 'vue'

import { AccessKey } from '@/types/AccessKey'

const props = defineProps({
  value: {
    type: Boolean,
    default: () => false,
  },
  initial_data: {
    type: Object as PropType<AccessKey>,
  },
  name_banlist: {
    type: Array as PropType<Array<string>>,
    default: () => []
  }
})

const emit = defineEmits(['input', 'submit'])

const _local_value = ref(props.value)
watch(() => props.value, (v) => _local_value.value = v)
const local_value = computed({
  get() { return _local_value.value },
  set(v) {
    _local_value.value = v
    emit('input', v)
  }
})


const form = ref(null)

const form_data: AccessKey = reactive({
  name: props.initial_data?.name || "",
  value: props.initial_data?.value || ""
})

const nameRules = [
  (v) => !!v || "Cannot be empty",
  (v) => (!!props.initial_data?.name && props.initial_data?.name == v) || !props.name_banlist.includes(v) || "Name already taken",
]
const valueRules = [
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

