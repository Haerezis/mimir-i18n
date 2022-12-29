<template>
  <v-dialog
    :value="value"
    @input="emit('input', $event)"
    @click:outside="cancel"
    max-width="600"
  >
    <v-card>
      <v-card-title>
        <span class="text-h5">New project</span>
      </v-card-title>

      <v-card-text>
        <project-form-new
          ref="form"
          v-model="form_valid"
          @submit="create_project"
        >
          <template v-slot:submit><span/></template>
        </project-form-new>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn text :disabled="submitting" @click="cancel">Cancel</v-btn>
        <v-btn text :disabled="!form_valid || submitting" @click="submit">Create</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'

import ProjectFormNew from '@/components/elements/Project/FormNew.vue'

import { useProjectsStore } from '@/stores/Projects.ts'

const props = defineProps({
  value: {
    type: Boolean,
    default: false,
  }
})

const emit = defineEmits(['input'])

const form = ref(null)
const form_valid = ref(false)

const projects_store = useProjectsStore()

const submitting = ref(false)

const cancel = () => {
  form.value.clear()
  emit('input', false)
}

const submit = () => {
  //TODO submitting=true
  form.value.submit()
}

const create_project = (data) => {
  projects_store.create(data)
    .then((project) => {
    })
    .catch((error) => {})
    .then(() => emit('input', false))
}
</script>
