<template>
  <v-list-item>
    <template #prepend v-if="slots.prepend">
      <div class="collapsable-item--prepend d-flex justify-center align-center">
        <slot name="prepend" />
      </div>
    </template>

    <template #title v-if="!collapse">
      <div class="collapsable-item--main d-flex justify-center align-center">
        <slot />
      </div>
    </template>

    <template #append v-if="slots.append">
      <div class="collapsable-item--append d-flex justify-center align-center">
        <slot name="append" />
      </div>
    </template>
  </v-list-item>
</template>

<script setup lang="ts">
const props = defineProps({
  collapse: {
    type: Boolean,
    default: false
  }
})


const slots = useSlots()
</script>

<style scoped>
  .collapsable-item--prepend, .collapsable-item--main, .collapsable-item--append {
    width: fit-content
  }
</style>
