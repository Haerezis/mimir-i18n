<template>
  <v-dialog
    v-model="localValue"
    :max-width="max_width || 500"
    persistent
  >
    <v-card>
      <v-responsive>
        <v-card-title>
          <h3>
            <slot name="title"></slot>
          </h3>
        </v-card-title>

        <v-card-text>
          <slot></slot>
        </v-card-text>

        <v-card-actions>
          <v-btn @click="cancel">
            <slot name="cancel-btn">No</slot>
          </v-btn>
          <v-spacer></v-spacer>
          <v-btn @click="accept" color="primary">
            <slot name="accept-btn">Yes</slot>
          </v-btn>
        </v-card-actions>
      </v-responsive>
    </v-card>
  </v-dialog>
</template>

<script setup lang="ts">
const props = defineProps({
  modelValue: Boolean,
  max_width: Number,
  accept_value: null,
})

const emit = defineEmits(['update:modelValue', 'accept'])

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


const cancel = () => {
  localValue.value = false
}

const accept = () => {
  emit('accept', props.accept_value)
  localValue.value = false
}
</script>
