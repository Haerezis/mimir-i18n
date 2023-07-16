<template>
<div>
  <v-list class="mb-16">
    <v-list-item
      v-for="translation in translations"
      :key="translation.uuid"
    >
      <translation-card
        class="ma-1"
        :modelValue="translation"
        :original="translations_store.translation_original(translation.id)"
        :status="translations_store.translation_status(translation)"
        :locales="translation_locales"
        :show_original="context_store.display_configuration.show_original"
        @delete = "translations_store.flag_for_deletion"
        @undelete = "translations_store.unflag_for_deletion"
      />
    </v-list-item>
  </v-list>

  <v-btn
    rounded
    position="fixed"
    location="bottom"
    class="new-btn mb-4"
    @click="show_translation_new_dialog = true"
  >
    <v-icon>mdi-plus</v-icon>
    New Translation
  </v-btn>
  <translation-dialog-new v-model="show_translation_new_dialog" :project="project" />

  <v-slide-y-reverse-transition>
    <v-btn
      v-if="show_save_btn"
      rounded
      position="fixed"
      location="bottom right"
      class="ma-4"
      @click="save_pending_changes"
    >
      <v-icon>mdi-content-save-outline</v-icon>
      Save
    </v-btn>
  </v-slide-y-reverse-transition>

</div>
</template>

<script setup lang="ts">
import TranslationDialogNew from '@/components/elements/Translation/DialogNew.vue'
import TranslationCard from '@/components/elements/Translation/Card.vue'

import { useTranslationsStore } from '@/stores/Translations.ts'

definePageMeta({
  alias: "index"
})

const props = defineProps({
  project: {
    type: Object as PropType<Project>,
    required: true
  }
})

const show_translation_new_dialog = ref(false)

const translations_store = useTranslationsStore(props.project.id)
const context_store = useContextStore()

translations_store.load_all()

const escapeRegExp = (string) => string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); // $& means the whole matched string
const translations = computed(() => {
  let retval = translations_store.all

  if(context_store.display_configuration.search_text) {
    const regex = new RegExp(`${escapeRegExp(context_store.display_configuration.search_text)}`, 'i')
    const fn = (t) => regex.test(t.key) || Object.values(t.values).some((v) => regex.test(v.value))
    retval = retval.filter(fn)
  }

  return retval
})

const translation_locales = computed(() => props.project.locales.filter((l) => context_store.display_configuration.locales.includes(l)))

const save_pending_changes = () => {
  translations_store.send_pending_changes_to_remote()
    .then(() => console.log("success"))
    .catch(() => console.log("error"))
}

const show_save_btn = computed(() => translations_store.has_pending_changes)
</script>

<style scoped>
.new-btn {
  left: 50%;
  transform: translateX(-50%);
}
</style>
