<template>
  <v-card>
    {{ value.name }}
  </v-card>
</template>


<script setup lang="ts">
const props = defineProps({
  value: {
    type: Object,
    required: true
  }
})
</script>
