<template>
  <v-app>
  </v-app>
</template>

<script setup lang="ts">
import { ref, reactive, computed } from 'vue'

import { useCurrentUserStore } from '@/stores/CurrentUser.ts'


const values = ref(['en'])
</script>
