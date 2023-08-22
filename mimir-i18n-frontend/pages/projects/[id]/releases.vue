<template>
<div>
  <v-card class="ma-10">
    <release-table
      :items="releases"
      :project_id="project.id"
      @delete="delete_release"
    />
  </v-card>
</div>
</template>

<script setup lang="ts">
import ReleaseTable from '@/components/elements/Release/Table.vue'

const props = defineProps({
  project: {
    type: Object as PropType<Project>,
    required: true
  }
})

const release_store = useReleasesStore(props.project.id)
release_store.load_all()

const releases = computed(() => release_store.all)

const delete_release = (key) => release_store.destroy(key.id)
</script>

