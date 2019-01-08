<template>
<v-container>
  <v-layout row wrap class='headline'>
    <v-spacer></v-spacer>
    <v-flex class="text-lg-center">
      {{ $t("message.menu_about_us") }}
    </v-flex>
    <v-spacer></v-spacer>
  </v-layout>
  <v-divider></v-divider>
  <v-layout row wrap>
    <v-flex class='ml-5 body-1'> 
      {{ $t('message.about_us_msg') }}
    </v-flex>
  </v-layout>
</v-container>
</template>

<style scoped>
</style>

<script>
import bus from "@/utils/event";
import qs from "qs";

export default {
  components: {},
  computed: {},

  data() {
    return {
    }
  },
  created() {
  },
  mounted() {},
  methods: {
  }
};
</script>