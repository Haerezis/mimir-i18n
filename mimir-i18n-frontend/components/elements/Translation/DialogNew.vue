<template>
  <v-dialog
    v-model="localValue"
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
          <template #submit><span/></template>
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
import TranslationFormNew from '@/components/elements/Translation/FormNew.vue'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false,
  },
  project: {
    type: Object as PropType<Project>,
    required: true,
  }
})

const emit = defineEmits(['update:modelValue'])

const _localValue = ref(props.modelValue)
const localValue = computed({
  get: () => _localValue.value,
  set: (newValue) => {
    _localValue.value = newValue
    emit("update:modelValue", newValue)
  }
})
watch(
  () => props.modelValue,
  (newValue) => _localValue.value = newValue
)

const form = ref(null)
const form_valid = ref(false)

const translations_store = useTranslationsStore(props.project.id)

const submitting = ref(false)

watch(localValue, () => form.value?.clear())

const cancel = () => {
  form.value.clear()
  emit('update:modelValue', false)
}

const trigger_form_submit = () => {
  form.value.submit()
}

const new_translation = (translation) => {
  //TODO submitting=true
  translations_store.add(translation)
  emit('update:modelValue', false)
}
</script>
