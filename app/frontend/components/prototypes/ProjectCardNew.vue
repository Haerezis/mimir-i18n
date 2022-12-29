<template>
  <v-card
    :height="card_size"
    :width="card_size"
    :rounded="rounded"
    class="d-flex align-center justify-center"
  >
    <v-icon :size="icon_size" >mdi-plus</v-icon>
  </v-card>
</template>


<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps({
  size: {
    type: Number,
    default: () => 192,
  },
  rounded: {
    type: [Boolean, String],
    default: "xl"
  }
})

const card_size = computed(() => props.size)
const icon_size = computed(() => card_size.value * (2/3))
</script>
