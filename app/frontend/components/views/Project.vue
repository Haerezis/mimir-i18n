<template>
  <project-sidebar></project-sidebar>
  <router-view></router-view>
</template>

<script>
export default {
  name: "Project"
};
</script>

<script setup lang="ts">
import { ref, reactive, computed } from 'vue'

import ProjectSidebar from 'Project/Sidebar.vue'

const props = defineProps({
  id: String
})
</script>
