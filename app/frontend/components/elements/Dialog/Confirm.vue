<template>
  <v-dialog
    v-model="dialog"
    :max-width="max_width || 500"
    persistent
  >
    <v-card>
      <v-responsive>
        <v-card-title>
          <h3>
            <slot name="title"/></slot>
          </h3>
        </v-card-title>

        <v-card-text>
          <slot></slot>
        </v-card-text>

        <v-card-actions>
          <v-btn v-on:click="cancel">
            <slot name="cancel-btn"/>No</slot>
          </v-btn>
          <v-spacer></v-spacer>
          <v-btn v-on:click="accept" color="primary">
            <slot name="accept-btn"/>Yes</slot>
          </v-btn>
        </v-card-actions>
      </v-responsive>
    </v-card>
  </v-dialog>
</template>

<script setup lang="ts">
import { PropType, ref, computed, watch } from 'vue'

const props = defineProps({
  value: Boolean,
  max_width: Number,
  accept_value: null,
})

const emit = defineEmits(['input', 'accept'])

const _value = ref(props.value)
watch(() => props.value, (new_value) => { _value.value = new_value })
const dialog = computed({
  set(new_value) {
    _value.value = new_value
    emit('input', new_value)
  },
  get() {
    return _value
  }
})


const cancel = () => {
  dialog.value = false
}

const accept = () => {
  emit('accept', props.accept_value)
  dialog.value = false
}
</script>
