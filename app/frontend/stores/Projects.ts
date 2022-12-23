import { defineStore } from 'pinia'

import axios from "@/plugins/axios"
import Routes from '@/plugins/routes'

import Project from '@/types/Project.ts'

export const useProjectsStore = defineStore('projects', {
  state: () => ({
    projects: {} as { [key: number]: Project },
    current_project_id: null,
  }),
  getters: {
    current: (state) => state.projects[state.current_project_id],
  },
  actions: {
    loadAll() {
      return axios.get(window.Routes.api_v1_projects_path())
        .then((response) => {
          response.data.forEach((project) => this.projects[project.id] = project)
        })
    },
    load(id: number) {
      return axios.get(window.Routes.api_v1_project_path(id))
        .then((response) => {
          const project = response.data
          this.projects[project.id] = project
        })
    },

    setCurrentProject(project: number | Project) {
      const id = (project instanceof number) ? project : project.id
      this.current_project_id = id
    }
  },
})
