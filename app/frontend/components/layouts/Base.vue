<template>
<div>
  <v-navigation-drawer
    :rail="rail"
    app
  >
    <template v-slot:prepend>
      <v-list>
          <router-link class="home-link" to="/">
            <v-list-item prepend-icon="mdi-home" title="Mimir" ></v-list-item>
          </router-link>
      </v-list>
      <v-divider></v-divider>
    </template>

    <slot name="sidebar"></slot>

    <template v-slot:append>
      <v-divider></v-divider>
      <v-list>
        <v-list-item @click="rail = !rail" :prepend-icon="drawer_btn_icon" title="Collapse sidebar" ></v-list-item>
      </v-list>
    </template>
  </v-navigation-drawer>


  <v-app-bar elevation=1>

    <slot name="topbar"></slot>

  </v-app-bar>




  <v-main>

    <slot name="main"></slot>

  </v-main>
</div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, PropType } from 'vue'

const rail = ref(false)

const drawer_btn_icon = computed(() => `mdi-${rail ? 'chevron-double-left' : 'chevron-double-right'}`)
</script>

<style scoped>
.home-link {
  text-decoration: none;
}
</style>
