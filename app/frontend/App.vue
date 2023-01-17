<template>
  <v-app id="mimir-app">
    <router-view></router-view>
  </v-app>
</template>

<script>
export default {
  name: "App"
};
</script>

<style>
.card-hover:hover {
  background: rgba(0,0,0,0);
}
.card-hover:hover:before {
  opacity: .04;
}
</style>
