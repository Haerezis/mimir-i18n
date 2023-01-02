import { useCurrentUserStore } from '@/stores/CurrentUser.ts'
import { useProjectsStore } from '@/stores/Projects.ts'
import { useTranslationsStore } from '@/stores/Translations.ts'


function defaultErrorHandler(error) {
  console.log(error)
  if(error.status == 401) {
    window.location.replace('/login')
  }
  else {
//    window.location.replace('/error')
  }
}

function fetchInitialData(to, from, next) {
  const current_user_store = useCurrentUserStore()
  const projects_store = useProjectsStore()

  return Promise.all([
    current_user_store.load(),
    projects_store.load_all(),
  ])
    .then(() => {
      next()
    })
    .catch(defaultErrorHandler)
}

function fetchTranslations(to, from, next) {
  const translations_store = useTranslationsStore()

  return Promise.all([
    translations_store.load_all(to.params.id)
  ])
    .then(() => {
      next()
    })
    .catch(defaultErrorHandler)
}

export default {
  fetchInitialData,
  fetchTranslations,
}
