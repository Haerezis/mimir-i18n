import { useCurrentUserStore } from '@/stores/CurrentUser.ts'
import { useProjectsStore } from '@/stores/Projects.ts'

function defaultErrorHandler(from, to, next) {
}

function fetchInitialData(from, to, next) {
  const currentUserStore = useCurrentUserStore()
  const projectsStore = useProjectsStore()

  return Promise.all([
    currentUserStore.load(),
    projectsStore.loadAll(),
  ])
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
