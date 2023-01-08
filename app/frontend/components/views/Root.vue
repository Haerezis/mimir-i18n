<template>
  <layout-base>
    <template v-slot:sidebar="slotProps">
      <v-list>
        <v-list-item class="pa-2">

          <v-btn
            v-if="slotProps.open"
            @click="show_project_new_dialog = true"
            rounded
          >
            <v-icon>mdi-plus</v-icon>
            Create Project
          </v-btn>
          <v-btn
            v-else
            @click="show_project_new_dialog = true"
            fab
            small
            elevation=2
          >
            <v-icon>mdi-plus</v-icon>
          </v-btn>
          <project-dialog-new v-model="show_project_new_dialog" />
        </v-list-item>
      </v-list>
    </template>

    <template v-slot:topbar>
      <v-toolbar-title>Application</v-toolbar-title>
    </template>

    <template v-slot:main>
      <v-list>
        <v-list-item
          v-for="(project, id) in projects"
          :key="id"
        >
          <project-card
            :value="project"
            class="ma-4"
          />
        </v-list-item>
      </v-list>
    </template>
  </layout-base>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'

import { useProjectsStore } from '@/stores/Projects.ts'

import LayoutBase from '@/components/layouts/Base.vue'
import ProjectCard from '@/components/elements/Project/Card.vue'
import ProjectDialogNew from '@/components/elements/Project/DialogNew.vue'

const projects_store = useProjectsStore()

const projects = computed(() => projects_store.all)

const show_project_new_dialog = ref(false)
</script>
