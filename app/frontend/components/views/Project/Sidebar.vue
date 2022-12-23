<template>
  <v-navigation-drawer permanent>
    <v-list-item>
      <v-list-item-content>
        <v-list-item-title class="text-h6">
          {{ project.name }}
        </v-list-item-title>
        <v-list-item-subtitle>
          subtext
        </v-list-item-subtitle>
      </v-list-item-content>
    </v-list-item>
  
    <v-divider></v-divider>
  
    <v-list
      dense
      nav
    >
      <v-list-item
      v-for="item in items"
      :key="item.title"
      link
      >
        <v-list-item-icon>
          <v-icon>{{ item.icon }}</v-icon>
        </v-list-item-icon>
    
        <v-list-item-content>
          <v-list-item-title>
            <router-link
            :to="{ name: item.route_name, params: link_params }"
            v-slot="{ href, route, navigate, isActive, isExactActive }"
            >
              <span :class="{ active: isActive }">
              {{ item.title }}
              </span>
            </router-link>
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script lang="ts">
export default {
  name: "ProjectSidebar",
};
</script>

<script setup lang="ts">
import { ref, reactive, computed } from 'vue'

const props = defineProps({
  project: Object
})

const link_params = { id: project.id }
const items = [
  { title: 'Translations',  link_name: 'project-translations', icon: 'mdi-translate' },
  { title: 'Settings',      link_name: 'project-settings', icon: 'mdi-cog' },
  { title: 'Members',       link_name: 'project-members', icon: 'mdi-account-multiple' },
  { title: 'Releases',      link_name: 'project-releases', icon: 'mdi-radar' },
  { title: 'Import',        link_name: 'project-import', icon: 'mdi-application-import' },
]
</script>

<style scoped>
.active {
  font-weight: bold;
}
</style>
