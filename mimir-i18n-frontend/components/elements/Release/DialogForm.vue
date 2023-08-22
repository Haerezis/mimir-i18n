<template>
  <v-dialog
    v-model="localValue"
    @click:outside="cancel"
    max-width="600"
  >
    <v-card>
      <v-card-title>
        <span class="text-h5">New Release</span>
      </v-card-title>

      <v-card-text>
        <release-form
          ref="form"
          v-model="form_valid"
          @submit="create_release"
        >
          <template #submit><span/></template>
        </release-form>
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
import ReleaseForm from '@/components/elements/Release/Form.vue'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false,
  },
  project_id: {
    type: Number,
  },
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

const releases_store = useReleasesStore(props.project_id)


const form = ref(null)
const form_valid = ref(false)

const submitting = ref(false)

const cancel = () => {
  form.value.clear()
  localValue.value = false
}

const submit = () => {
  submitting.value = true
  form.value.submit()
}

const create_release = async (data) => {
  try {
    await releases_store.create(data)
  }
  catch(error) {}
  localValue.value = false
  submitting.value = false
}
</script>
