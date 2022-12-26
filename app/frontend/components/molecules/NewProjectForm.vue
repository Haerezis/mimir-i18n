<template>
  <v-form v-model="form">
    <v-text-field
      label="Name"
      v-model="data.name"
      required
    ></v-text-field>

    <v-autocomplete
      multiple
      label="Locales"
      :items="locale_items"
      v-model="data.locales"
      required
    ></v-autocomplete>
    <v-list>
      <v-list-item
        v-for="locale in data.locales"
      >
        <v-list-item-title>
          {{ ISO6391.getName(locale) }}
        </v-list-item-title>

        <v-list-item-action>
          <v-btn icon>
            <v-icon icon="mdi-close"/>
          </v-btn>
        </v-list-item-action>
      </v-list-item>
    </v-list>
  </v-form>
</template>

<script lang="ts">
export interface ProjectFormData {
  name: string;
  locales: string[];
}
</script>

<script setup lang="ts">
import { ref, reactive, computed, PropType } from 'vue'
import ISO6391 from 'iso-639-1'

const props = defineProps({
  locales: {
    type: string[],
    default: ISO6391.getAllCodes()
  }
})

const form = ref(0)

const data: ProjectFormData = reactive({
  name: "",
  locales: ['en'],
})

const locale_items = computed(() => {
  return props.locales
    .map((locale) => ({ text: ISO6391.getName(locale), value: locale }) )
    .sort((locale_data) => locale_data.text )
})

</script>

