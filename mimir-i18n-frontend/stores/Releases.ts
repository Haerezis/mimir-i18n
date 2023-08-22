import { defineStore } from 'pinia'


import Release from '@/types/Release'

interface ReleaseCollection { [id: number]: Release }

export function useReleasesStore(project_id: number, ...args: any[]) {
  return defineStore(`releases_[${project_id}]`, () => {

    const collection: ReleaseCollection = reactive({})

    const all = computed(() => Object.values(collection))

    const commit = (release: Release | null) => {
      if (release) {
        collection[release.id] = release
      }
    }

    const load_all = async () => {
      const response = await useFetchGET<Release[]>(apiRoutes.api_v1_project_releases_path(project_id))
      const projects = response.data.value ?? []
      projects.forEach(commit)
    }

    const create = async (data: { message: string }) => {
      const response = await useFetchPOST<Release>(apiRoutes.api_v1_project_releases_path(project_id), { body: data })
      commit(response.data.value)
    }

    const destroy = async (id: number) => {
      if (!collection[id]) {
        throw `No Release found with id ${id}`
      }

      await useFetchDELETE<Release>(apiRoutes.api_v1_project_release_path(project_id, id))
      delete collection[id]
    }

    return { collection, all, load_all, create, destroy }
  })(...args)
}
