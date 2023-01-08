<template>
  <v-dialog
    :value="value"
    @input="emit('input', $event)"
    @click:outside="cancel"
    max-width="600"
  >
    <v-card>
      <v-card-title>
        <span class="text-h5">New Translation</span>
      </v-card-title>

      <v-card-text>
        <translation-form-new
          ref="form"
          v-model="form_valid"
          :project="project"
          @submit="new_translation"
        >
          <template v-slot:submit><span/></template>
        </translation-form-new>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn text :disabled="submitting" @click="cancel">Cancel</v-btn>
        <v-btn text :disabled="!form_valid || submitting" @click="trigger_form_submit">Create</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup lang="ts">
import { ref, watch, PropType } from 'vue'

import Project from '@/types/Project'

import { useTranslationsStore } from '@/stores/Translations'

import TranslationFormNew from '@/components/elements/Translation/FormNew.vue'


const props = defineProps({
  value: {
    type: Boolean,
    default: false,
  },
  project: {
    type: Object as PropType<Project>,
    required: true,
  }
})

const emit = defineEmits(['input'])

const form = ref(null)
const form_valid = ref(false)

const translations_store = useTranslationsStore()

const submitting = ref(false)

watch(() => props.value, () => form.value?.clear())

const cancel = () => {
  form.value.clear()
  emit('input', false)
}

const trigger_form_submit = () => {
  form.value.submit()
}

const new_translation = (data) => {
  //TODO submitting=true
  translations_store.new.push(data)
  emit('input', false)
}
</script>
