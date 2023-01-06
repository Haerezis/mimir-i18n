<template>
  <layout-base>
    <template v-slot:sidebar="slotProps">

      <v-list nav>
        <v-list-item
          :to="{ name: 'project-translations', params: link_params }"
          link
        >
          <v-list-item-icon>
            <v-icon>mdi-translate</v-icon>
          </v-list-item-icon>
          <v-list-item-title class="font-weight-bold">
            {{ project.name }}
          </v-list-item-title>
        </v-list-item>
      </v-list>

      <v-list
        dense
        nav
      >
        <v-list-item
          v-for="item in link_items"
          :key="item.title"
          :to="{ name: item.route_name, params: link_params }"
          link
        >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>
      
          <v-list-item-title>
            {{ item.title }}
          </v-list-item-title>
        </v-list-item>
      </v-list>
    </template>


    <template v-slot:topbar>
      <input-translations-filters v-model="filters" :project=project />
    </template>


    <template v-slot:main>
      <router-view :project="project" :filters="filters"></router-view>
    </template>
  </layout-base>
</template>


<script lang="ts">
export default {
  name: "Project"
};
</script>

<script setup lang="ts">
import { ref, reactive, computed } from 'vue'

import { useProjectsStore } from '@/stores/Projects.ts'

import LayoutBase from '@/components/layouts/Base.vue'
import InputTranslationsFilters from '@/components/elements/Input/TranslationsFilters.vue'

const props = defineProps({
  id: {
    type: [Number, String],
    required: true,
  }
})

const projects_store = useProjectsStore()

const project = computed(() => projects_store.all[Number(props.id)])

const link_params = computed(() => ({ id: props.id }))
const link_items = [
  { title: 'Settings',      route_name: 'project-settings', icon: 'mdi-cog' },
  { title: 'Members',       route_name: 'project-members', icon: 'mdi-account-multiple' },
  { title: 'Releases',      route_name: 'project-releases', icon: 'mdi-radar' },
  { title: 'Import',        route_name: 'project-import', icon: 'mdi-application-import' },
]

const filters = reactive({
  text: "",
  locales: project.value.locales,
})
</script>
