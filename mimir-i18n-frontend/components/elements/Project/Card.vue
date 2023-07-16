<template>
  <v-card
    :to="{ name: 'projects-id-translations', params: { id: modelValue.id } }"
    class="card-hover"
  >
    <v-btn elevation=0 class="menu-btn" @click.prevent="">
      <v-icon>mdi-dots-vertical</v-icon>
    </v-btn>

    <v-card-title>
      {{ modelValue.name }}
    </v-card-title>

    <v-card-subtitle>
      <v-icon></v-icon>
      {{ modelValue.owner.fullname }}
    </v-card-subtitle>
    
    <v-card-text>
      <v-chip v-for="locale in locales" :key="locale">
        {{ locale }}
      </v-chip>
    </v-card-text>
  </v-card>
</template>


<script setup lang="ts">
import ISO6391 from 'iso-639-1'

const props = defineProps({
  modelValue: {
    type: Object as PropType<Project>,
    required: true
  }
})

const locales = computed(() => props.modelValue.locales.map((locale) => ISO6391.getName(locale)))
</script>

<style scoped>
.menu-btn {
  position: absolute;
  top: 0px;
  right: 0px;
}
</style>
