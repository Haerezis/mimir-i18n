<template>
<div>
  <v-data-table
    :headers="headers"
    :items="items"
    :items-per-page="10"
  >
    <template v-slot:top>
      <v-toolbar flat>
        <v-toolbar-title>Access Keys</v-toolbar-title>
        <v-spacer/>
        <v-btn @click="new_item">
          <v-icon>mdi-plus</v-icon>
          Create Key
        </v-btn>
      </v-toolbar>
    </template>

    <template v-slot:item.value="{ item }">
      {{ "*".repeat(10) }}{{ item.value.slice(-5) }}

      <v-icon @click="copy_item_to_clipboard(item)">
        mdi-content-copy
      </v-icon>
    </template>

    <template v-slot:item.created_at="{ item }">
      {{ (new Date(item.created_at)).toLocaleString("fr-FR") }}
    </template>


    <template v-slot:item.actions="{ item }">
      <v-icon @click="edit_item(item)">
        mdi-pencil
      </v-icon>
      <v-icon @click="confirm_item_deletion(item)">
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
    <template v-slot:title>Confirm deletion</template>
    <template>Are you sure you want to delete the Access Key named '{{ delete_dialog_item.name }}' ?</template>
  </dialog-confirm>

  <dialog-form
    v-if="dialog_form"
    v-model="dialog_form"
    :project_id="project_id"
    :persisted_instance="dialog_form_instance"
    :name_banlist="names"
    />
</div>
</template>

<script setup lang="ts">
import { PropType, computed, ref, reactive } from 'vue'
import AccessKey from '@/types/AccessKey.ts'

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

const emit = defineEmits(['update', 'delete'])

const headers = [
  { text: 'Name', value: 'name', width: '35%' },
  { text: 'Key', value: 'value', width: '35%' },
  { text: 'Created at', value: 'created_at' },
  { text: 'Actions', value: 'actions', sortable: false },
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
const dialog_form_instance = ref(null)

const edit_item = (item) => {
  dialog_form_instance.value = item
  dialog_form.value = true
}
const new_item = () => {
  dialog_form_instance.value = null
  dialog_form.value = true
}
</script>
