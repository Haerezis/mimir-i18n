<template>
<div>
  <v-data-table
    :headers="headers"
    :items="items"
    :items-per-page="10"
  >
    <template #top>
      <v-toolbar flat>
        <v-toolbar-title>Releases</v-toolbar-title>
        <v-spacer/>
        <v-btn @click="new_release">
          <v-icon>mdi-plus</v-icon>
          Create Release
        </v-btn>
      </v-toolbar>
    </template>

    <template #item.sha="{ item }">
      <div class="py-3">
        {{ item.raw.sha_short }}
        <pre v-if="item.raw.message" class="message pa-2 mt-1">{{ item.raw.message }}</pre>
      </div>
    </template>


    <template #item.created_at="{ item }">
      {{ (new Date(item.raw.created_at)).toLocaleString("fr-FR") }}
    </template>

    <template #item.export="{ item }">
      <v-text-field
        v-model="item.raw.export_url"
        variant="outlined"
        density="compact"
        readonly
        hide-details
        class="pr-0 align-center"
      >
        <template #append-inner>
          <v-divider vertical class="mx-2"/>
          <v-btn 
            icon="mdi-content-copy"
            flat
            @click="copy_to_clipboard(item.raw.export_url)"
          />
          <v-divider vertical class="mx-2"/>
          <v-btn 
            flat
            icon="mdi-eye-arrow-right-outline"
            @click="show_release_export(item.raw)"
          />
        </template>
      </v-text-field>
    </template>


    <template #item.actions="{ item }">
      <span v-if="item.raw.sha != 'CURRENT'">
        <v-btn icon="mdi-delete" flat @click="confirm_release_deletion(item.raw)"/>
      </span>
    </template>
  </v-data-table>

  <dialog-confirm
    v-if="delete_dialog"
    v-model="delete_dialog"
    :accept_value="delete_dialog_release"
    @accept="emit('delete', $event)"
  >
    <template #title>Confirm deletion</template>
    <template>Are you sure you want to delete the Release named '{{ delete_dialog_release.name }}' ?</template>
  </dialog-confirm>

  <dialog-form
    v-if="dialog_form"
    v-model="dialog_form"
    :project_id="project_id"
    />
</div>
</template>

<script setup lang="ts">
import DialogConfirm from '@/components/elements/Dialog/Confirm.vue'
import DialogForm from '@/components/elements/Release/DialogForm.vue'

const props = defineProps({
  items: {
    type: Array as PropType<Array<Release>>,
    required: true
  },
  project_id: {
    type: Number,
  }
})

const emit = defineEmits(['delete'])

const headers = [
  { title: 'Name', key: 'sha', width: '35%' },
  { title: 'Created at', key: 'created_at' },
  { title: 'Export', key: 'export', width: '45%', sortable: false },
  { title: 'Actions', key: 'actions', sortable: false },
]

const copy_to_clipboard = (str) => navigator.clipboard.writeText(str)

const delete_dialog = ref(false)
const delete_dialog_release = ref(null)
const confirm_release_deletion = (release) => {
  delete_dialog_release.value = release
  delete_dialog.value = true
}

const dialog_form = ref(false)
const release_instance = ref(null)

const new_release = () => {
  release_instance.value = null
  dialog_form.value = true
}


const show_release_export = async (release) => {
  if(!release.export) {
    const response = await useFetchGET(release.export_url)
    release.export = response?.data?.value
  }
  const blob = new Blob(
    [JSON.stringify(release.export)],
    {type: "application/json"}
  )
  const blob_url = URL.createObjectURL(blob)
  window.open(blob_url, '_blank').focus();
}
</script>

<style>
.message {
 word-break: normal;
 overflow-x: auto;
 border-left: 3px solid gainsboro;
 color: grey
}
</style>
