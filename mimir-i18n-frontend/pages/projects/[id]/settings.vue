<template>
<div>
  <v-list>

    <v-list-item
      class="mt-6"
    >
      <v-card width="100%">
        <v-card-title>Rename project</v-card-title>
        <v-card-text>
          <v-form
            ref="rename_form"
            v-model="rename_form_valid"
            @submit.prevent="rename_form_submit"
          >
            <v-text-field
              label="Name"
              v-model="rename_form_name_value"
              :rules="rename_form_name_rules"
            ></v-text-field>

            <slot name="submit">
              <div class="d-flex justify-end">
                <v-btn :disabled="!rename_form_valid" @click="rename_form_submit">Submit</v-btn>
              </div>
            </slot>
          </v-form>
        </v-card-text>
      </v-card>
    </v-list-item>


    <v-list-item
      class="mt-6"
    >
      <v-card width="100%">
        <v-card-title>Change locales</v-card-title>
        <v-card-text>
          <v-form
            ref="locales_form"
            v-model="locales_form_valid"
            @submit.prevent="locales_form_submit"
          >
            <select-locales
              v-model="locales_form_locales_value"
              :locales="locales"
              :rules="locales_form_locales_rules"
            ></select-locales>

            <slot name="submit">
              <div class="d-flex justify-end">
                <v-btn :disabled="!locales_form_valid" @click="locales_form_submit">Submit</v-btn>
              </div>
            </slot>
          </v-form>
        </v-card-text>
      </v-card>
    </v-list-item>

  </v-list>
</div>
</template>

<script setup lang="ts">
import ISO6391 from 'iso-639-1'

import SelectLocales from '@/components/elements/Input/SelectLocales.vue'

const props = defineProps({
  project: {
    type: Object as PropType<Project>,
    required: true
  }
})

const locales = ISO6391.getAllCodes()
const projects_store = useProjectsStore()

const rename_form = ref(0)
const rename_form_valid = ref(false)
const rename_form_name_value = ref( JSON.parse( JSON.stringify(props.project.name)) )
const rename_form_name_rules = [ (v) => !!v || "Name is required" ]
const rename_form_submit = () => {
  if(rename_form.value.validate()) {
    projects_store.update(props.project.id, { name: rename_form_name_value.value })
    //TODO then/catch
  }
}

const locales_form = ref(0)
const locales_form_valid = ref(false)
const locales_form_locales_value = ref([...props.project.locales])
const locales_form_locales_rules = [ (v) => !!v.length || "At least one locale is required" ]
const locales_form_submit = () => {
  if(locales_form.value.validate()) {
    projects_store.update_locales(props.project.id, locales_form_locales_value.value)
    //TODO then/catch
  }
}
</script>
