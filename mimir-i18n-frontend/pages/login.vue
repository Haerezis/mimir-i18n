<template>
  <div class="d-flex align-center justify-center" style="height: 100vh">
    <v-sheet width="400" class="mx-auto">
      <v-form fast-fail @submit.prevent="login">
        <v-text-field v-model="email" label="Email"></v-text-field>

        <v-text-field v-model="password" label="password"></v-text-field>

        <v-btn type="submit" color="primary" block class="mt-2">Sign in</v-btn>

      </v-form>
    </v-sheet>
  </div>
</template>

<script lang="ts" setup>
definePageMeta({
  layout: "simple",
  auth:  {
    unauthenticatedOnly: true,
//    navigateAuthenticatedTo: "/",
  }
})

const { signIn } = useAuth()

const email = ref('')
const password = ref('')
const error = ref('')

const login = () => {
  try {
    signIn(
      {
        user: {
          email: email.value,
          password: password.value
        }
      },
      { callbackUrl: '/' }
    )
  }
  catch(e) {
    error.value = e + ''
  }
}
</script>
