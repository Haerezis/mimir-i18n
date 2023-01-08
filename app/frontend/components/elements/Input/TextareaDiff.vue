<template>
  <v-textarea
    v-model="value2"
    :background-color="background_color"
    rows="1"
    auto-grow
    hide-details="auto"
    counter
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
  </v-textarea>
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
})

const emit = defineEmits(['input'])
const value2 = computed({
  get: () => props.value,
  set: (new_value) => emit("input", new_value)
})

const dirty = computed(() => (props.original != null) && props.value != props.original)

const background_color = computed(() => dirty.value ? 'yellow' : '')

const rollback = () => value2.value = props.original
</script>
