<template>
  <LayoutBase>
    <template v-slot:sidebar>
    </template>

    <template v-slot:topbar>
      <v-toolbar-title>Application</v-toolbar-title>
      <v-container>
        <v-row justify="end">

          <v-col cols="1">
            <UserAvatar
              :user="currentUser"
            />
          </v-col>

        </v-row>
      </v-container>
    </template>

    <template v-slot:main>
      <v-list class="pa-8">
        <v-list-item>
          <NewProjectCard  class="ma-2"/>
        </v-list-item>
      </v-list>
    </template>
  </LayoutBase>
</template>

<script setup lang="ts">
import { computed } from 'vue'

import { useCurrentUserStore } from '@/stores/CurrentUser.ts'

import LayoutBase from '@/components/layouts/Base.vue'
import UserAvatar from '@/components/atoms/UserAvatar.vue'
import NewProjectCard from '@/components/molecules/NewProjectCard.vue'

const current_user_store = useCurrentUserStore()

const currentUser = computed(() => current_user_store.user)
</script>
