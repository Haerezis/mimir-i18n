<template>
  <v-dialog
    v-model="dialog"
    max-width="700px"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        rounded="lg"
        size=128
        v-bind="attrs"
        v-on="on"
      >
        <v-icon icon="mdi-plus" size="64" />
      </v-btn>
    </template>


    <v-card>
      <v-card-title>
        <span class="text-h5">New project</span>
      </v-card-title>

      <v-card-text>
        <NewProjectForm ref="form"/>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn
          text
          @click="cancel"
        >
          Cancel
        </v-btn>
        <v-btn
          text
          @click="submit"
        >
          Save
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'

import NewProjectCard from '@/components/molecules/NewProjectCard.vue'
import NewProjectForm from '@/components/molecules/NewProjectForm.vue'

const dialog = reactive(false)
const form = ref(null)

const cancel = () => {
  form.clear()
  dialog.value = false
}

const submit = () => {
  if(form.validate()) {

  }
}
</script>
