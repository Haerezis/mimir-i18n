<template>
  <v-avatar
    :size="size"
    :color="color"
  >
    <img
      v-if="picture_url"
      :src="picture_url"
      :alt="user_fullname"
    >
    <span
      v-else
      class="white--text text-h5">
      {{ initials }}
    </span>
  </v-avatar>
</template>

<script setup lang="ts">
import { ref, reactive, computed, PropType } from 'vue'

import stc from 'string-to-color'

import User from '@/types/User.ts'



const props = defineProps({
  user: {
    type: Object as PropType<User>,
    required: true,
  },
  size: {
    type: Number,
    default: 48
  }
})

const user_fullname = computed(() => `${props.user.firstname} ${props.user.lastname}`)

const color = computed(() => user_fullname ? stc(user_fullname.value) : stc(null))

const initials = computed(() => `${props.user.firstname.toUpperCase()[0]}${props.user.lastname.toUpperCase()[0]}`)
const picture_url = computed(() => props.user.picture?.small_url)
</script>
