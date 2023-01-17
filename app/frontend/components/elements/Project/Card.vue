<template>
  <v-card
    :to="{ name: 'project-translations', params: { id: value.id } }"
    width="100%"
    class="card-hover"
  >
    <v-btn icon class="menu-btn" @click.prevent="">
      <v-icon>mdi-dots-vertical</v-icon>
    </v-btn>

    <v-card-title>
      {{ value.name }}
    </v-card-title>

    <v-card-subtitle>
      <v-icon></v-icon>
      {{ value.owner.fullname }}
    </v-card-subtitle>
    
    <v-card-text>
      <v-chip v-for="locale in locales" :key="locale">
        {{ locale }}
      </v-chip>
    </v-card-text>
  </v-card>
</template>


<script setup lang="ts">
import { PropType, computed } from 'vue'
import ISO6391 from 'iso-639-1'

import { Project } from '@/types/Project.ts'

const props = defineProps({
  value: {
    type: Object as PropType<Project>,
    required: true
  }
})

const locales = computed(() => props.value.locales.map((locale) => ISO6391.getName(locale)))
</script>

<style scoped>
.menu-btn {
  position: absolute;
  top: 0px;
  right: 0px;
}
</style>
