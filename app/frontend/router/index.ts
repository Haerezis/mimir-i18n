import Root from '../components/views/Root.vue'
import Project from '../components/views/Project.vue'
import ProjectTranslations from '../components/views/Project/Translations.vue'
import ProjectSettings from '../components/views/Project/Settings.vue'
import ProjectMembers from '../components/views/Project/Members.vue'
import ProjectReleases from '../components/views/Project/Releases.vue'
import ProjectImport from '../components/views/Project/Import.vue'

const routes = [
  {
    name: 'root',
    path: '',
    component: Root
  },
  {
    name: 'project',
    path: 'project/:id',
    component: Project,
    props: true,
    children: [
      {
        name: 'project-translations',
        path: 'translations',
        alias: '',
        component: ProjectTranslations
      },
      {
        name: 'project-settings',
        path: 'settings',
        component: ProjectSettings,
      },
      {
        name: 'project-members',
        path: 'members',
        component: ProjectMembers,
      },
      {
        name: 'project-releases',
        path: 'releases',
        component: ProjectReleases,
      },
      {
        name: 'project-import',
        path: 'import',
        component: ProjectImport,
      }
    ]
  }
]

export default routes;
