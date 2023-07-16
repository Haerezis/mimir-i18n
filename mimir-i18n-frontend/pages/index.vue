<template>
<NuxtLayout name="default">

  <template #topbar>
    <v-toolbar-title>Application</v-toolbar-title>
  </template>

  <template v-slot:sidebar="slotProps">
    <div class="d-flex">
    <v-spacer/>
    <CollapsableButton
      :collapse="!slotProps.open"
      @click="show_project_new_dialog = true"
      rounded
      min-width=0
      class="mt-2 px-3"
    >
      <template #default>
        <v-icon>mdi-plus</v-icon>
      </template>
      <template #append>
        <span class="pr-1">Create Project</span>
      </template>
    </CollapsableButton>
    <v-spacer/>
    </div>
    <project-dialog-new v-model="show_project_new_dialog" />
  </template>

  <template #main>
    <v-list>
      <v-list-item
        v-for="(project, id) in projects"
        :key="id"
      >
        <project-card
          :modelValue="project"
          class="ma-4"
        />
      </v-list-item>
    </v-list>
  </template>
</NuxtLayout>
</template>

<script setup lang="ts">
import ProjectCard from '@/components/elements/Project/Card'
import ProjectDialogNew from '@/components/elements/Project/DialogNew'
import CollapsableListItem from '@/components/elements/CollapsableListItem'
import CollapsableButton from '@/components/elements/CollapsableButton'

definePageMeta({
  layout: false
})

const projects_store = useProjectsStore()

projects_store.load_all()

const projects = projects_store.all

const show_project_new_dialog = ref(false)
</script>
