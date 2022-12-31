<template>
  <layout-base>
    <template v-slot:sidebar="slotProps">
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
      
          <v-list-item-content>
            <v-list-item-title>
              <span>
              {{ item.title }}
              </span>
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </template>


    <template v-slot:topbar>
      <v-toolbar-title>{{ project.name }}</v-toolbar-title>
    </template>


    <template v-slot:main>
      <router-view :project="project" :locales="locales"></router-view>
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

const props = defineProps({
  id: {
    type: [Number, String],
    required: true,
  }
})

const projects_store = useProjectsStore()

const project = computed(() => projects_store.all[Number(props.id)])

const locales = ref(project.value.locales)

const link_params = { id: props.id }
const link_items = [
  { title: 'Translations',  route_name: 'project-translations', icon: 'mdi-translate' },
  { title: 'Settings',      route_name: 'project-settings', icon: 'mdi-cog' },
  { title: 'Members',       route_name: 'project-members', icon: 'mdi-account-multiple' },
  { title: 'Releases',      route_name: 'project-releases', icon: 'mdi-radar' },
  { title: 'Import',        route_name: 'project-import', icon: 'mdi-application-import' },
]
</script>
