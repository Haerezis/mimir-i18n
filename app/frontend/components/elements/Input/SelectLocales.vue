<template>
<div>
  <v-autocomplete
    label="Locales"
    placeholder="Type language name..."
    hints="Type language name..."

    :items="locale_items"
    item-text="name"
    item-value="code"

    :value="value"
    @input="$emit('input', $event)"

    :rules="rules"
    
    multiple
    hide-details="auto"
  >
    <template v-slot:selection/>
  </v-autocomplete>

  <v-list class="pt-0">
    <v-list-item
      v-for="locale in sortedValue"
      :key="locale"
      class="pl-0"
    >
      <v-list-item-icon class="mr-2 mt-2 mb-2">
        <v-btn
          @click="$emit('input', value.filter((item) => (item != locale)))"
          icon
          text
        >
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </v-list-item-icon>
      <v-list-item-content class="mt-0 mb-0">
        {{ ISO6391.getName(locale) }}
      </v-list-item-content>
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
  },
  rules: {
    type: [Array, Function, String],
    default: () => []
  },
})

defineEmits(['input'])

const sortByName = (a,b) => a.name > b.name ? 1 : b.name > a.name ? -1 : 0

const locales = Object.fromEntries(ISO6391.getLanguages(props.locales).map((locale) => [locale.code, locale]))
const locale_items = Object.values(locales).sort(sortByName)

const sortedValue = computed(() => props.value.sort((a,b) => sortByName(locales[a], locales[b])))
</script>

