<template>
  <v-btn>
    <template #prepend v-if="slots.prepend && !collapse">
      <div class="collapsable-item--prepend d-flex justify-center align-center">
        <slot name="prepend" />
      </div>
    </template>

    <template #default>
      <div class="collapsable-item--main d-flex justify-center align-center">
        <slot />
      </div>
    </template>

    <template #append v-if="slots.append && !collapse">
      <div class="collapsable-item--append d-flex justify-center align-center">
        <slot name="append" />
      </div>
    </template>
  </v-btn>
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
