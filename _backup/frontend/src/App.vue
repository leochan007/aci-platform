<template>
<v-app>

  <Header/>  
  <!--v-parallax height="100%" :src="require('@/assets/bg.jpg')">
  </v-parallax-->
  <Main/>
  <Footer/>

</v-app>
</template>

<style>
</style>

<script>

import Header from "@/layout/Header.vue"
import Main from "@/layout/Main.vue"
import Footer from "@/layout/Footer.vue"

export default {
  components: {
    Header,
    Main,
    Footer,
  },
  name: "app"
};
</script>
