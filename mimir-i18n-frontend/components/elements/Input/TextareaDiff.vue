<template>
  <v-textarea
    v-model="localValue"
    :background-color="background_color"
    rows="1"
    auto-grow
    hide-details="auto"
    counter
  >
    <template v-if="dirty" #append>
      <v-tooltip top>
        <template #activator="{ on, attrs }">
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
  modelValue: {
    type: String,
    required: true
  },
  original: {
    type: String,
  },
})

const emit = defineEmits(['update:modelValue'])

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

const dirty = computed(() => (props.original != null) && localValue.value != props.original)

const background_color = computed(() => dirty.value ? 'yellow' : '')

const rollback = () => localValue.value = props.original
</script>
