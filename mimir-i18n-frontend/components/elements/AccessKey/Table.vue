<template>
<div>
  <v-data-table
    :headers="headers"
    :items="items"
    :items-per-page="10"
  >
    <template #top>
      <v-toolbar flat>
        <v-toolbar-title>Access Keys</v-toolbar-title>
        <v-spacer/>
        <v-btn @click="new_item">
          <v-icon>mdi-plus</v-icon>
          Create Key
        </v-btn>
      </v-toolbar>
    </template>

    <template #item.value="{ item }">
      {{ "*".repeat(10) }}{{ item.raw.value.slice(-5) }}

      <v-icon @click="copy_item_to_clipboard(item.raw)">
        mdi-content-copy
      </v-icon>
    </template>

    <template #item.created_at="{ item }">
      {{ (new Date(item.raw.created_at)).toLocaleString("fr-FR") }}
    </template>


    <template #item.actions="{ item }">
      <v-icon @click="edit_item(item.raw)">
        mdi-pencil
      </v-icon>
      <v-icon @click="confirm_item_deletion(item.raw)">
        mdi-delete
      </v-icon>
    </template>
  </v-data-table>

  <dialog-confirm
    v-if="delete_dialog"
    v-model="delete_dialog"
    :accept_value="delete_dialog_item"
    @accept="emit('delete', $event)"
  >
    <template #title>Confirm deletion</template>
    <template>Are you sure you want to delete the Access Key named '{{ delete_dialog_item.name }}' ?</template>
  </dialog-confirm>

  <dialog-form
    v-if="dialog_form"
    v-model="dialog_form"
    :project_id="project_id"
    :persisted_instance="access_key_instance"
    :name_banlist="names"
    />
</div>
</template>

<script setup lang="ts">
import DialogConfirm from '@/components/elements/Dialog/Confirm.vue'
import DialogForm from '@/components/elements/AccessKey/DialogForm.vue'

const props = defineProps({
  items: {
    type: Array as PropType<Array<AccessKey>>,
    required: true
  },
  project_id: {
    type: Number,
  }
})

const emit = defineEmits(['delete'])

const headers = [
  { title: 'Name', key: 'name', width: '35%' },
  { title: 'Key', key: 'value', width: '35%' },
  { title: 'Created at', key: 'created_at' },
  { title: 'Actions', key: 'actions', sortable: false },
]

const copy_item_to_clipboard = (item) => navigator.clipboard.writeText(item.value)

const delete_dialog = ref(false)
const delete_dialog_item = ref(null)
const confirm_item_deletion = (item) => {
  delete_dialog_item.value = item
  delete_dialog.value = true
}

const names = computed(() => props.items.map((item) => item.name))

const dialog_form = ref(false)
const access_key_instance = ref(null)

const edit_item = (item) => {
  access_key_instance.value = item
  dialog_form.value = true
}
const new_item = () => {
  access_key_instance.value = null
  dialog_form.value = true
}
</script>
