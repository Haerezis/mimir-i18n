<template>
  <v-app>
    <v-form>
      <LocalesSelect v-model="values"/>
    </v-form>
  </v-app>
</template>

<script setup lang="ts">
import { ref, reactive, computed } from 'vue'

import { useCurrentUserStore } from '@/stores/CurrentUser.ts'

import LocalesSelect from '@/components/molecules/LocalesSelect.vue'

const values = ref(['en'])
</script>
