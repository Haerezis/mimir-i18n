<template>
<div class="d-flex flex-grow-1" ref="root_ref">
  <v-text-field
    placeholder="Search for key or value"
    prepend-inner-icon="mdi-magnify"
    clearable
    solo
    flat
    hide-details
    v-model="context_store.display_configuration.search_text"
  >
    <template #append>
      <v-btn icon class="mr-4" @click="menu_opened = true">
        <v-icon>mdi-tune</v-icon>
      </v-btn>
    </template>
  </v-text-field>

  <v-menu
    v-model="menu_opened"
    :close-on-content-click="false"
    class="menu"
    :style="menu_style"
  >
    <v-list :width="root_bounding_box.width.value">
      <v-list-subheader class="text-subtitle-1 font-weight-bold">
        Locales
      </v-list-subheader>
      <v-list-item
        v-for="locale in project.locales"
        :key="locale"
        class="ml-4"
      >
        <v-checkbox
          v-model="context_store.display_configuration.locales"
          :value="locale"
          :label="`[${locale.toUpperCase()}] ${ISO6391.getName(locale)}`"
          hide-details
          density="compact"
        />
      </v-list-item>

      <v-list-subheader class="text-subtitle-1 font-weight-bold">
        Display Options
      </v-list-subheader>
      <v-list-item class="ml-4">
        <v-checkbox
          v-model="context_store.display_configuration.show_original"
          :value="true"
          label="Show Original"
          hide-details
          density="compact"
        />
      </v-list-item>
      </v-list>
  </v-menu>
</div>
</template>

<script setup lang="ts">
import ISO6391 from 'iso-639-1'
import { useElementBounding } from '@vueuse/core'

const props = defineProps({
  project: {
    type: Object as PropType<Project>,
    required: true
  },
})

const context_store = useContextStore()

context_store.display_configuration.locales = props.project.locales

watch(props.project, (new_value, old_value) => context_store.display_configuration.locales = new_value.locales)
watch(props.project.locales, (new_value, old_value) => context_store.display_configuration.locales = new_value)

const root_ref = ref(null)
const root_bounding_box = useElementBounding(root_ref)

const menu_opened = ref(false)
const menu_style = reactive({
  position: "absolute",
  top: computed(() => `${root_bounding_box.bottom.value + 1}px`),
  left: computed(() => `${root_bounding_box.left.value}px`),
  "min-width": computed(() => `${root_bounding_box.width.value}px`) 
})
</script>

<style scoped>
.menu {
}
</style>
