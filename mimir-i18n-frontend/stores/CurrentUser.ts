import { defineStore } from 'pinia'

export const useCurrentUserStore = defineStore('current_user', () => {
  const user: Ref<User | null> = ref(null)

  const load = async () => {
    const response = await useFetch<User>(apiRoutes.api_v1_current_user_path())
    user.value = response.data.value

    return user
  }
  const setCurrentUser = (data: User) => {
    user.value = data
  }

  return { user, load, setCurrentUser }
})
