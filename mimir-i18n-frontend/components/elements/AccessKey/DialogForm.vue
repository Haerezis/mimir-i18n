<template>
  <v-dialog
    v-model="localValue"
    @click:outside="cancel"
    max-width="600"
  >
    <v-card>
      <v-card-title>
        <span v-if="create_mode" class="text-h5">New Access Key</span>
        <span v-else class="text-h5">Update Access Key</span>
      </v-card-title>

      <v-card-text>
        <access-key-form
          ref="form"
          v-model="form_valid"
          :initial_data="persisted_instance"
          :name_banlist="name_banlist"
          @submit="create_or_update_access_key"
        >
          <template #submit><span/></template>
        </access-key-form>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn text :disabled="submitting" @click="cancel">Cancel</v-btn>
        <v-btn text :disabled="!form_valid || submitting" @click="submit">{{ create_mode ? 'Create' : 'Update' }}</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup lang="ts">
import AccessKeyForm from '@/components/elements/AccessKey/Form.vue'

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false,
  },
  project_id: {
    type: Number,
  },
  persisted_instance: {
    type: Object as PropType<AccessKey>,
  },
  name_banlist: {
    type: Array as PropType<Array<string>>,
    default: () => []
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

const create_mode = computed(() => !props.persisted_instance)


const access_keys_store = useAccessKeysStore(props.project_id)


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

const create_or_update_access_key = async (data) => {
  try {
    await create_mode.value ?
      access_keys_store.create(data) :
      access_keys_store.update(props.persisted_instance.id, data)
  }
  catch(error) {}
  localValue.value = false
  submitting.value = false
}
</script>
