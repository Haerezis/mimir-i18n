<template>
<div>
  <v-card class="ma-10">
    <access-key-table
      :items="access_keys"
      @delete="delete_access_key"
      @update="update_access_key"
    />
  </v-card>
</div>
</template>

<script setup lang="ts">
import { PropType, ref, computed } from 'vue'

import { Project } from '@/types/Project.ts'
import Release from '@/types/Release.ts'
import AccessKey from '@/types/AccessKey.ts'

import { useReleasesStore } from '@/stores/Releases.ts'
import { useAccessKeysStore } from '@/stores/AccessKeys.ts'

import AccessKeyTable from '@/components/elements/AccessKey/Table.vue'

const props = defineProps({
  project: {
    type: Object as PropType<Project>,
    required: true
  }
})

const access_key_store = useAccessKeysStore()
const access_keys = computed(() => access_key_store.all(props.project.id))

const delete_access_key = (key) => access_key_store.delete(key.id)
const update_access_key = (key, data) => access_key_store.update(key.id, data)
</script>
