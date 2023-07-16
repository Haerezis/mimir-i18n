<template>
<div>
  <v-autocomplete
    label="Locales"
    placeholder="Type language name..."
    hints="Type language name..."

    :items="locale_items"
    item-title="name"
    item-value="code"

    v-model="localValue"

    :rules="rules"
    
    multiple
    hide-details="auto"
  >
    <template #selection/>
  </v-autocomplete>

  <v-list class="pt-0">
    <v-list-item
      v-for="locale in sortedValue"
      :key="locale"
      class="pl-0"
    >
      <template #prepend class="mr-2 mt-2 mb-2">
        <v-btn
          @click="localValue = localValue.filter((item) => (item != locale))"
          variant="plain"
          icon
        >
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </template>
      <div class="mt-0 mb-0">
        {{ ISO6391.getName(locale) }}
      </div>
    </v-list-item>
  </v-list>
</div>
</template>

<script setup lang="ts">
import ISO6391 from 'iso-639-1'

const props = defineProps({
  modelValue: {
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

const locales = Object.fromEntries(ISO6391.getLanguages(props.locales).map((locale) => [locale.code, locale]))
const compareLocaleByName = (a,b) => a.name > b.name ? 1 : b.name > a.name ? -1 : 0

const locale_items = Object.values(locales).sort(compareLocaleByName)

const sortedValue = computed(() => localValue.value.sort((a,b) => compareLocaleByName(locales[a], locales[b])))
</script>

