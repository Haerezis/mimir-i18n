import { defineStore } from 'pinia'

import axios from "@/plugins/axios"
import Routes from '@/plugins/routes'

import { Project, ProjectNew } from '@/types/Project.ts'

export const useProjectsStore = defineStore('projects', {
  state: () => ({
    all: {} as { [key: number]: Project },
    current_project_id: null,
  }),
  getters: {
    current: (state) => state.all[state.current_project_id],
  },
  actions: {
    load_all() {
      return axios.get(Routes.api_v1_projects_path())
        .then((response) =>
          response.data.forEach((project) => this.all[project.id] = project)
        )
    },
    load(id: number) {
      return axios.get(Routes.api_v1_project_path(id))
        .then((response) => {
          const project = response.data
          this.all[project.id] = project
          return project
        })
    },

    create(data: ProjectNew) {
      return axios.post(Routes.api_v1_projects_path(), data)
        .then((response) => {
          const project = response.data
          this.all[project.id] = project
          return project
        })
    },

    set_current_project(project: number | Project) {
      const id = (project instanceof number) ? project : project.id
      this.current_project_id = id
    }
  },
})
