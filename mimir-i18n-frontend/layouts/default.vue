<template>
<div>
  <v-navigation-drawer
    :rail="!drawer_is_open"
    :rail-width="rails_width"
    permanent
  >
    <template #prepend>

      <NuxtLink class="home-link" to="/">
        <CollapsableListItem class="pa-1" :collapse="!drawer_is_open">
          <template #prepend>
            <MimirIcon class="mimir-icon my-2" />
          </template>
          <template #default>
            <span class="ml-4">Mimir</span>
          </template>
        </CollapsableListItem>
      </NuxtLink>

      <v-divider/>
    </template>

    <slot name="sidebar" :open="drawer_is_open"/>

    <template #append>
      <v-divider></v-divider>
      <CollapsableListItem
        class="collapse-button"
        :collapse="!drawer_is_open"
        @click.native="drawer_is_open = !drawer_is_open"
      >
        <template #default>
          Collapse sidebar
          <v-spacer/>
        </template>
        <template #append>
          <v-icon>{{ drawer_btn_icon }}</v-icon>
        </template>
      </CollapsableListItem>

    </template>
  </v-navigation-drawer>




  <v-app-bar elevation=1>
    <slot name="topbar"/>

    <v-spacer></v-spacer>
    <v-divider vertical inset/>
    <div class="px-4">
      <UserAvatar :user="current_user" />
    </div>
  </v-app-bar>




  <v-main>
    <slot name="main"/>
  </v-main>

  <slot />
</div>
</template>

<script setup lang="ts">
import UserAvatar from '@/components/elements/User/Avatar.vue'
import CollapsableListItem from '@/components/elements/CollapsableListItem'
import MimirIcon from '@/assets/icons/mimir.svg'

const drawer_is_open = ref(true)

const drawer_btn_icon = computed(() => `mdi-${drawer_is_open.value ? 'chevron-double-left' : 'chevron-double-right'}`)

const current_user_store = useCurrentUserStore()
const current_user = current_user_store.user

const rails_width = 56
</script>

<style scoped lang="scss">
.home-link, .home-link:visited {
  text-decoration: none;
  cursor: pointer;
  color: inherit;
}

.mimir-icon {
  width: 40px;
  height: 40px;
}

.collapse-button {
  min-height: 48px;
  cursor: pointer;
}
</style>
