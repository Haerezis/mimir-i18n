import { useCurrentUserStore } from '@/stores/CurrentUser.ts'

function defaultErrorHandler(from, to, next) {
}

function fetchInitialData(from, to, next) {
  const currentUserStore = useCurrentUserStore()

  return currentUserStore.load()
    .then(() => {
      next()
    })
    .catch((error) => {
      if(error.response.status == 401) {
        window.location.replace('/login')
      }
      else {
        window.location.replace('/error')
      }
    })
}

export default {
  fetchInitialData,
}
