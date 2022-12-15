<template>
  <v-navigation-drawer
    permanent
  >

    <div>
      Mimir
    </div>
  
    <v-divider></v-divider>

    <slot name="sidebar"></slot>
  
  </v-navigation-drawer>


  <v-app-bar
    outlined
  >
    <slot name="app-bar"></slot>
  </v-app-bar>

</template>
