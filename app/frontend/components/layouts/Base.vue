<template>
<div>
  <v-navigation-drawer
    :mini-variant="!drawer_is_open"
    app
  >
    <template v-slot:prepend>

      <router-link class="home-link" tag="span" to="/">
        <v-list-item class="pa-1">
          <v-list-item-avatar>
            <mimir-icon/>
          </v-list-item-avatar>
          <v-list-item-title>Mimir</v-list-item-title>
        </v-list-item>
      </router-link>

      <v-divider></v-divider>
    </template>

    <slot name="sidebar" :open="drawer_is_open"></slot>

    <template v-slot:append>
      <v-divider></v-divider>

      <v-list-item link @click="drawer_is_open = !drawer_is_open">
        <v-list-item-title v-if="drawer_is_open">Collapse sidebar</v-list-item-title>
        <v-icon>{{ drawer_btn_icon }}</v-icon>
      </v-list-item>
    </template>
  </v-navigation-drawer>




  <v-app-bar app elevation=1>

    <slot name="topbar"></slot>

  </v-app-bar>




  <v-main>

    <slot name="main"></slot>

  </v-main>
</div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, PropType } from 'vue'

import MimirIcon from '@/assets/icon.svg'

const drawer_is_open = ref(true)

const drawer_btn_icon = computed(() => `mdi-${drawer_is_open.value ? 'chevron-double-left' : 'chevron-double-right'}`)
</script>

<style scoped>
.home-link {
  text-decoration: none;
  cursor: pointer;
}
</style>
