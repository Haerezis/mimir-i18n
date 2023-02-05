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
    :accept-value="delete_dialog_item"
    @accept="emit('delete', $event)"
  >
    <template v-slot:title>Confirm deletion</template>
    <template>Are you sure you want to delete the Access Key named '{{ delete_dialog_item.name }}' ?</template>
  </dialog-confirm>

  <v-dialog v-model="new_dialog">
  </v-dialog>

  <v-dialog v-model="edit_dialog">
  </v-dialog>
</div>
</template>

<script setup lang="ts">
import { PropType, computed, ref, reactive } from 'vue'
import AccessKey from '@/types/AccessKey.ts'

import DialogConfirm from '@/components/elements/Dialog/Confirm.vue'

const props = defineProps({
  items: {
    type: Array as PropType<Array<AccessKey>>,
    required: true
  }
})

const headers = [
  { text: 'Name', value: 'name', width: '35%' },
  { text: 'Key', value: 'value', width: '35%' },
  { text: 'Created at', value: 'created_at' },
  { text: 'Actions', value: 'actions', sortable: false },
]

const copy_item_to_clipboard = (item) => navigator.clipboard.writeText(item.value)

const emit = defineEmits(['update', 'delete'])

const delete_dialog = ref(false)
const delete_dialog_item = ref(null)
const confirm_item_deletion = (item) => {
  delete_dialog_item.value = item
  delete_dialog.value = true
}

const edit_dialog = ref(false)
const edit_dialog_item = ref(null)
const edit_item = (item) => {}

const new_dialog = ref(false)
const new_dialog_item = ref(null)
const new_item = (item) => {}
</script>
