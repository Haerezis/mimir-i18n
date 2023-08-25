<template>
<div>
  <v-card class="ma-10">
    <access-key-table
      :items="access_keys"
      :project_id="project.id"
      @delete="delete_access_key"
      @update="update_access_key"
    />
    <v-card-text class="text-body-1">
      <p>Access Keys are used to authorize access to releases via the API (releases' export urls can be found on the Releases page).</p>
      <br/>
      <p>Set the HTTP header <code class="pa-2 rounded">{{ header_text }}</code> to grant access to the HTTP request to the release's export url.</p>
    </v-card-text>
  </v-card>
</div>
</template>

<script setup lang="ts">
import AccessKeyTable from '@/components/elements/AccessKey/Table.vue'

const props = defineProps({
  project: {
    type: Object as PropType<Project>,
    required: true
  }
})

const access_key_store = useAccessKeysStore(props.project.id)
access_key_store.load_all()

const access_keys = computed(() => access_key_store.all)

const delete_access_key = (key) => access_key_store.destroy(key.id)
const update_access_key = (key, data) => access_key_store.update(key.id, data)

const header_text = "Authorization: Bearer <ACCESS_KEY>"
</script>

<style scoped>
  code {
    background: #1a1b26;
    color: #9aa5ce;
  }
</style>
