<template>
<NuxtLayout name="default">
  <template #sidebar="slotProps">

    <v-list nav>
      <v-list-item
        :to="{ name: 'projects-id-translations', params: link_params }"
        link
      >
        <template #prepend>
          <v-icon>mdi-translate</v-icon>
        </template>
        <template #title class="font-weight-bold">
          {{ project.name }}
        </template>
      </v-list-item>
    </v-list>

    <v-list
      density="compact"
      nav
    >
      <v-list-item
        v-for="item in link_items"
        :key="item.title"
        :to="{ name: item.route_name, params: link_params }"
        :title="item.title"
        link
      >
        <template #prepend>
          <v-icon>{{ item.icon }}</v-icon>
        </template>
      </v-list-item>
    </v-list>
  </template>


  <template #topbar>
    <input-translations-filters :project=project class="mx-2"/>
  </template>


  <template #main>
    <NuxtPage :project="project" />
  </template>
</NuxtLayout>
</template>


<script setup lang="ts">
import InputTranslationsFilters from '@/components/elements/Input/TranslationsFilters.vue'

definePageMeta({
  layout: false
})

const route = useRoute()

const projects_store = useProjectsStore()


const project_id = route.params.id
await projects_store.load(project_id)
const project = computed(() => projects_store.all[Number(project_id)])

const link_params = computed(() => ({ id: project_id }))
const link_items = [
  { title: 'Settings',      route_name: 'projects-id-settings', icon: 'mdi-cog' },
  { title: 'Members',       route_name: 'projects-id-members', icon: 'mdi-account-multiple' },
  { title: 'Releases',      route_name: 'projects-id-releases', icon: 'mdi-radar' },
  { title: 'Access Keys',   route_name: 'projects-id-access-keys', icon: 'mdi-key-chain' },
  { title: 'Import',        route_name: 'projects-id-import', icon: 'mdi-application-import' },
]
</script>
