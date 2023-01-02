<template>
  <v-textarea
    v-model="value.value"
    :background-color="input_background_color"
    rows="1"
    auto-grow
    hide-details
  />
</template>

<script setup lang="ts">
import { PropType, computed, ref, watch } from 'vue'

import { TranslationValue } from '@/types/TranslationValue.ts'

const props = defineProps({
  value: {
    type: Object as PropType<TranslationValue>,
    required: true
  },
})

const emit = defineEmits(['input'])

const is_dirty = ref(props.value.is_dirty)
watch(props.value, (old_value, new_value) => is_dirty.value = props.value.is_dirty)

const input_background_color = computed(() => is_dirty.value ? 'yellow' : '')
</script>

