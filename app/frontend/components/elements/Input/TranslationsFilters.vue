<template>
  <v-menu tile bottom offset-y content-class="elevation-4 menu" :close-on-content-click="false">
  <template v-slot:activator="{ on, attrs }">

    <v-text-field
      placeholder="Search for key or value"
      prepend-inner-icon="mdi-magnify"
      class="pa-0 ma-0"
      clearable
      solo
      flat
      hide-details
      v-model="value.text"
    >
      <template v-slot:append>
        <v-btn icon v-bind="attrs" v-on="on">
          <v-icon>mdi-tune</v-icon>
        </v-btn>
      </template>
    </v-text-field>
  </template>

  <template class="fuck">
    <ul>
      <li>PLACEHOLDER</li>
      <li>FOR</li>
      <li>FILTERS</li>
      <li>FORM</li>
    </ul>
  </template>
  </v-menu>
</template>

<script setup lang="ts">
import { PropType, ref } from 'vue'
import ISO6391 from 'iso-639-1'

import { Project } from '@/types/Project.ts'

const props = defineProps({
  project: {
    type: Object as PropType<Project>,
    required: true
  },
  value: {
    type: Object,
    default: () => ({
      text: "",
      locales: project.value.locales,
    })
  }
})
</script>

<style scoped>
.menu {
  background-color: white;
}
</style>
