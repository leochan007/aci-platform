<template>
<v-container>
  <div v-if="show_cond == 0" class="display-1 text-lg-center">
    {{ $t("message.loading") }}
  </div>
  <div v-else-if="show_cond == 1" class="display-1 text-lg-center">
    {{ $t("message.no_aci_info") }}
  </div>
  <div v-else-if="show_cond == 2" class="body-1">

    <v-layout row wrap class='headline text-lg-center'>
      <v-flex>
        {{ $t("message.aci_info") }}
      </v-flex>
    </v-layout>
    <v-divider></v-divider>
    <v-layout row wrap>
      <v-flex class='ml-5'>
        {{ $t("message.tbl_account") }} :{{ account }}
      </v-flex>
      <v-flex class='ml-5'>
        {{ $t("message.tbl_register_time") }}:{{ transDatetime(register_time) }}
      </v-flex>
    </v-layout>
    <v-divider></v-divider>
    <v-layout row wrap>
      <v-flex class='ml-5'>
        {{ $t("message.tbl_name") }}:{{ name }}
      </v-flex>
      <v-flex class='ml-5'>
        {{ $t("message.tbl_person_id") }}:{{ person_id }}
      </v-flex>
    </v-layout>
    <v-divider></v-divider>
    <v-layout row wrap>
      <v-flex class='ml-5'>
        {{ $t("message.tbl_comments") }}:{{ comments }}
      </v-flex>
    </v-layout>
    <v-divider></v-divider>
    <v-divider></v-divider>
    <v-layout row wrap>
      <v-flex class='ml-5'>
        {{ $t("message.tbl_moral_crsis_type") }}:{{ moralCrisisType }}
      </v-flex>
      <v-flex class='ml-5'>
        {{ $t("message.tbl_record_time") }} :{{ transDatetime(record_time) }}
      </v-flex>
    </v-layout>
    <v-divider></v-divider>
    <v-layout row wrap>
      <v-flex class='ml-5'>
        {{ $t("message.tbl_reason") }}:{{ reason }}
      </v-flex>
    </v-layout>
    <v-divider></v-divider>
    <v-layout row wrap>
      <v-flex class='ml-5'>
        {{ $t("message.tbl_hash") }}:{{ hash }}
      </v-flex>
    </v-layout>
    <v-divider></v-divider>
    <v-layout row wrap>
      <v-flex class='ml-5'>
        {{ $t("message.tbl_tx_id") }}:
      </v-flex>
      <v-flex class='ml-7' v-if="tx_id=='' || tx_id==undefined">
        {{ $t("message.empty_hash") }}
      </v-flex>
      <v-flex class='ml-7' v-else>
        <a :href="eostracer_url + tx_id">{{ tx_id }}</a>
      </v-flex>
    </v-layout>
    <v-layout row wrap>
    </v-layout>
    <v-layout class="mt-5">
      <v-spacer></v-spacer>
      <v-btn dark @click="onBack">{{ $t("message.Back") }}</v-btn>
      <v-spacer></v-spacer>
    </v-layout>
  </div>
</v-container>
</template>

<script>
import bus from "@/utils/event";
import qs from "qs";
import {
  ts2dt_str,
  toLocalTime,
} from '@/utils/dt_tools';

import {
  eostracer_url
} from "@/config/app_config";

export default {
  components: {},
  computed: {},

  data() {
    return {
      show_cond: 0,
      eostracer_url: eostracer_url,
      create_time: 0,
      account: "",
      name: "",
      person_id: "",
      comments: "",
      register_time: 0,
      reason: "",
      record_time: 0,
      moralCrisisType: "",
      hash: "",
      tx_id: ""
    }
  },
  created() {
    this.fetchData();
  },
  mounted() {},
  methods: {

  transDatetime(_datetime) {
    return toLocalTime(_datetime, this.$i18n.locale);
  },

    fetchData() {
      let self = this;
      let hash = self.$route.params.hash;

      self.$http.get("/aci_api/creditinquiry/hash/" + hash).then(
        response => {
          if (response.status == 200) {
            if (response.data.error_code == 0) {
              self.create_time = response.data.data.createTime;
              self.account = response.data.data.account;
              self.name = response.data.data.name;
              self.person_id = response.data.data.personId;
              self.comments = response.data.data.comments;
              self.register_time = response.data.data.registerTime;
              self.reason = response.data.data.reason;
              self.record_time = response.data.data.recordTime;
              self.moralCrisisType = response.data.data.moralCrisisType;
              self.hash = response.data.data.hash;
              self.tx_id = response.data.data.txId;
              self.show_cond = 2
            } else {
              self.show_cond = 1
            }
          }
        },
        response => {
          console.log(response);
        }
      );
    },

    onBack() {
      let self = this;
      self.$router.go(-1);
      //self.$router.push({ path: "/" });
    }
  }
};
</script>
