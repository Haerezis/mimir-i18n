import { defineStore } from 'pinia'


import AccessKey from '@/types/AccessKey'

interface AccessKeyCollection { [id: number]: AccessKey }

export function useAccessKeysStore(project_id: number, ...args: any[]) {
  return defineStore(`access_keys_[${project_id}]`, () => {

    const collection: AccessKeyCollection = reactive({})

    const all = computed(() => Object.values(collection))

    const commit = (access_key: AccessKey | null) => {
      if (access_key) {
        collection[access_key.id] = access_key
      }
    }

    const load_all = async () => {
      const response = await useFetchGET<AccessKey[]>(apiRoutes.api_v1_project_access_keys_path(project_id))
      const projects = response.data.value ?? []
      projects.forEach(commit)
    }

    const create = async (data: { name: string }) => {
      const response = await useFetchPOST<AccessKey>(apiRoutes.api_v1_project_access_keys_path(project_id), { body: data })
      commit(response.data.value)
    }

    const update = async (id: number, data: { name?: string, value?: string }) => {
      if (!collection[id]) {
        throw `No AccessKey found with id ${id}`
      }

      const response = await useFetchPATCH<AccessKey>(apiRoutes.api_v1_project_access_key_path(project_id, id), { body: data })
      commit(response.data.value)
    }

    const destroy = async (id: number) => {
      if (!collection[id]) {
        throw `No AccessKey found with id ${id}`
      }

      await useFetchDELETE<AccessKey>(apiRoutes.api_v1_project_access_key_path(project_id, id))
      delete collection[id]
    }

    return { collection, all, load_all, create, update, destroy }
  })(...args)
}
