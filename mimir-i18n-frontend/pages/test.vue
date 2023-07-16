<template>
  <NuxtLayout>
    <template #foo>
      FOO
    </template>
    <template #bar>
      BAR
    </template>
  </NuxtLayout>
</template>

<script setup>
  definePageMeta({
    layout: "test"
  })
  console.log("fuckme")
</script>
