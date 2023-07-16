import { SessionData } from "#auth"

export default defineNuxtRouteMiddleware((to, from) => {
  const { data, status } = useAuth()
  const currentUserStore = useCurrentUserStore()

  const setter = (value: SessionData | undefined | null) => {
    if (status.value == 'authenticated' && value != undefined) {
      currentUserStore.setCurrentUser(value)
    }
  }

  setter(data.value)
  watch(data, setter)
})
