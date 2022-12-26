<template>
<div>
  <v-autocomplete
    label="Locales"
    placeholder="Type language name..."
    :items="locale_items"
    item-text="name"
    item-value="code"
    :value="value"
    @input="$emit('input', $event)"
    multiple
    persistent-placeholder
    hide-details
  >
    <template v-slot:selection=""/>
  </v-autocomplete>

  <v-list>
    <v-list-item
      v-for="locale in value"
      :key="locale"
    >
      <v-list-item-content>
        {{ ISO6391.getName(locale) }}
      </v-list-item-content>

      <v-list-item-action>
        <v-btn
          @click="$emit('input', value.filter((item) => (item != locale)))"
          icon
          text
        >
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </v-list-item-action>
    </v-list-item>
  </v-list>
</div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, PropType } from 'vue'
import ISO6391 from 'iso-639-1'

const props = defineProps({
  value: {
    type: Array as PropType<string[]>,
    default: () => [],
  },
  locales: {
    type: Array as PropType<string[]>,
    default: () => ISO6391.getAllCodes()
  }
})

defineEmits(['input'])

const log = (obj) => console.log(obj)

const locale_items = ISO6391.getLanguages(props.locales).sort((locale) => locale.name)
</script>

