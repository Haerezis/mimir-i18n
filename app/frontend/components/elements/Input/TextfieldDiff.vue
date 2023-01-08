<template>
  <v-text-field
    v-model="value2"
    :label="label"
    :background-color="background_color"
    @keydown="validate"
    hide-details
  >
    <template v-if="dirty" v-slot:append>
      <v-tooltip top>
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            icon
            small
            v-bind="attrs"
            v-on="on"
            @click.stop="rollback"
          >
            <v-icon>mdi-arrow-u-left-top</v-icon>
          </v-btn>
        </template>
        <span>Rollback</span>
      </v-tooltip>
    </template>
  </v-text-field>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps({
  value: {
    type: String,
    required: true
  },
  original: {
    type: String,
  },
  label: {
    type: String,
  },
  regex: {
    type: RegExp,
  }
})

const emit = defineEmits(['input'])
const value2 = computed({
  get: () => props.value,
  set: (new_value) => {
    const current = props.value
    emit("input", new_value)
  }
})

const dirty = computed(() => (props.original != null) && props.value != props.original)

const background_color = computed(() => dirty.value ? 'yellow' : '')

const rollback = () => value2.value = props.original

const validate = ((event) => {
  //Always accept backspace/delete key
  if(event.key == "Backspace" || event.key == "Delete") {
    return
  }

  if(props.regex && !props.regex.test(`${props.value}${event.key}`)) {
    event.preventDefault()
  }
})
</script>
