import { defineStore } from 'pinia'

import { Project, ProjectNew } from '@/types/Project'

interface ProjectCollection { [key: number]: Project }

export const useProjectsStore = defineStore('projects', () => {
  const all: ProjectCollection = reactive({})

  const commit_project = (project: Project | null) => {
    if (project) {
      all[project.id] = project
    }
  }

  const load_all = async () => {
    const response = await useFetchGET<Project[]>(apiRoutes.api_v1_projects_path())
    const projects = (response.data.value ?? [])
    projects.forEach(commit_project)
  }

  const load = async (id: number) => {
    const response = await useFetchGET<Project>(apiRoutes.api_v1_project_path(id))
    commit_project(response.data.value)
  }

  const create = async (data: ProjectNew) => {
    const response = await useFetchPOST<Project>(apiRoutes.api_v1_projects_path(), { body: data })
    commit_project(response.data.value)
  }

  const update = async (id: number, data: { name: String; }) => {
    const response = await useFetchPATCH(apiRoutes.api_v1_project_path(id), { body: data })
    commit_project(response.data.value)
  }

  const update_locales = async (id: number, locales: String[]) => {
    const response = await useFetchPATCH(apiRoutes.api_v1_project_path(id), { body: { locales: locales } })
    commit_project(response.data.value)
  }

  return { all, load_all, load, create, update, update_locales }
})
