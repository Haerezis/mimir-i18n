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
        v-model="translations_store.display_configuration.search_text"
      >
        <template v-slot:append>
          <v-btn icon v-bind="attrs" v-on="on">
            <v-icon>mdi-tune</v-icon>
          </v-btn>
        </template>
      </v-text-field>

    </template>

    <template>
      <v-subheader class="text-subtitle-1 font-weight-bold">
        Locales
      </v-subheader>
      <v-list>
        <v-list-item
          v-for="locale in project.locales"
          :key="locale"
        >
          <v-checkbox
            v-model="translations_store.display_configuration.locales"
            :value="locale"
            :label="`[${locale.toUpperCase()}] ${ISO6391.getName(locale)}`"
            class="my-0 pl-4"
          />
        </v-list-item>
      </v-list>

      <v-subheader class="text-subtitle-1 font-weight-bold">
        Display Options
      </v-subheader>
      <v-list>
        <v-list-item>
          <v-checkbox
            v-model="translations_store.display_configuration.show_original"
            :value="true"
            label="Show Original"
            class="my-0 pl-4"
          />
        </v-list-item>
      </v-list>
    </template>
  </v-menu>
</template>

<script setup lang="ts">
import { PropType, watch } from 'vue'
import ISO6391 from 'iso-639-1'

import { Project } from '@/types/Project.ts'

import { useTranslationsStore } from '@/stores/Translations.ts'

const props = defineProps({
  project: {
    type: Object as PropType<Project>,
    required: true
  },
})

const translations_store = useTranslationsStore()

translations_store.display_configuration.locales = props.project.locales

watch(props.project, (new_value, old_value) => translations_store.display_configuration.locales = new_value.locales)
watch(props.project.locales, (new_value, old_value) => translations_store.display_configuration.locales = new_value)
</script>

<style scoped>
.menu {
  background-color: white;
}
</style>
