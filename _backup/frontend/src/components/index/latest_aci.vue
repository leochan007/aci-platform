<template>
<v-data-table hide-actions :headers="fields" :items="tableData" :loading="loading" class="elevation-1">
  <template slot="items" slot-scope="props">
    <tr class="text-xs-left" @click="viewDetail(props.item.hash)">
      <td>{{ props.item.account }}</td>
      <td>{{ props.item.name }}</td>
      <td>{{ props.item.personId }}</td>
      <td>{{ props.item.moralCrisisType }}</td>
      <td>{{ transDatetime(props.item.recordTime) }}</td>
      <td>
        <div v-if="props.item.txId=='' || props.item.txId==undefined">
          {{ $t("message.empty_hash") }}
        </div>
        <div v-else>
          <div>
            <a :href="eostracer_url + props.item.txId">{{ props.item.txId }}</a>
            </a>
          </div>
        </div>
      </td>
    </tr>
  </template>
</v-data-table>
</template>

<style scoped>
.content {
  font-size: 30px;
  color: #ffffff;
  width: 100%;
  height: 300px;
  text-align: center;
}
</style>

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
  computed: {

    fields: function() {
      return [{
          value: 'account',
          align: 'left',
          sortable: false,
          text: this.$t("message.tbl_account")
        },
        {
          value: 'name',
          align: 'left',
          sortable: false,
          text: this.$t("message.tbl_name")
        },
        {
          value: 'person_id',
          align: 'left',
          sortable: false,
          text: this.$t("message.tbl_person_id")
        },
        {
          value: 'moralCrisisType',
          align: 'left',
          sortable: false,
          text: this.$t("message.tbl_moral_crsis_type")
        },
        {
          value: 'record_time',
          align: 'left',
          sortable: false,
          text: this.$t("message.tbl_record_time")
        },
        {
          value: 'tx_id',
          align: 'left',
          sortable: false,
          text: this.$t("message.tbl_tx_id")
        }
      ]
    },
  },
  data() {
    return {
      eostracer_url: eostracer_url,
      loading: true,
      tableData: []
    };
  },
  created() {
    this.fetchData();
  },
  mounted() {},
  methods: {

    viewDetail(hash) {
      this.$router.push({
        path: "/aci_detail/" + hash
      });
    },

    transDatetime(_datetime) {
      return toLocalTime(_datetime, this.$i18n.locale);
    },

    fetchData() {
      let self = this;

      let params = {
        search_type: "0",
        search_txt: "",
        page: 0,
        page_size: 5
      };

      self.$http.get("/aci_api/creditinquiry/list?" + qs.stringify(params)).then(
        response => {
          if (response.status == 200) {
            self.tableData = response.data.data.lst;
            console.log(self.tableData);
            self.loading = false;
          }
        },
        response => {
          console.log(response);
        }
      );
    }
  }
};
</script>
