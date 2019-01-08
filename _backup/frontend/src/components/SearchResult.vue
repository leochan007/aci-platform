<template>
<div>
  <div v-if="show_cond == 0" class="display-1 text-lg-center">
    {{ $t("message.loading") }}
  </div>
  <div v-else-if="show_cond == 1" class="body-1">
    <v-container fluid>

      <v-layout row wrap class='headline'>
        <v-spacer></v-spacer>
        <v-flex class="text-lg-center">
          {{ $t("message.tx_list") }}
        </v-flex>
        <v-spacer></v-spacer>
      </v-layout>

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

      <v-layout row wrap class="mt-2">
        <v-spacer></v-spacer>
        <v-flex class="text-lg-right">
          <b-select style="width:70px" @change="handleSizeChange" v-model="page_size" :options="page_sizes" />
        </v-flex>
        <v-flex class="text-lg-left">
          <b-pagination @change='handleCurrentChange' size="md" :total-rows="total_count" v-model="page" :per-page="page_size">
          </b-pagination>
        </v-flex>
        <v-spacer></v-spacer>
      </v-layout>

      <v-layout row wrap>
        <v-spacer></v-spacer>
        <v-btn dark @click="onBack">{{ $t("message.Back") }}</v-btn>
        <v-spacer></v-spacer>
      </v-layout>
    </v-container>
  </div>
</div>
</template>

<style scoped>
.table_tr:hover {
  cursor: pointer;
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
      loading: true,
      eostracer_url: eostracer_url,
      total_count: 0,
      greeting_msg: "",
      tableData: [],
      page: 1,
      page_sizes: [5, 10, 20, 50],
      page_size: 10,
      search_type: 0,
      search_txt: "",
      show_cond: 0
    };
  },
  created() {
    this.fetchData();
  },
  mounted() {},
  watch: {
    $route: "fetchData"
  },
  methods: {

    transDatetime(_datetime) {
      return toLocalTime(_datetime, this.$i18n.locale);
    },

    viewDetail(hash) {
      this.$router.push({
        path: "/aci_detail/" + hash
      });
    },
    onSearch() {
      let self = this;
      let query_cond = {
        search_type: self.search_type,
        search_txt: self.search_txt,
        page: self.page,
        page_size: self.page_size
      };
      self.$router.push({
        path: "/search",
        query: query_cond
      });
    },
    handleSizeChange(val) {
      this.page_size = val;
      this.page = 1;
      this.onSearch();
    },
    handleCurrentChange(val) {
      this.page = val;
      this.onSearch();
    },
    fetchData() {
      let self = this;
      let search_type = self.$route.query.search_type;
      let search_txt = self.$route.query.search_txt;
      let page = parseInt(self.$route.query.page);
      let page_size = parseInt(self.$route.query.page_size);
      if (search_type != undefined) {
        self.search_type = search_type;
      }
      if (search_txt != undefined) {
        self.search_txt = search_txt;
      }
      if (page != undefined && !isNaN(page)) {
        self.page = page;
      }
      if (self.page < 1) {
        self.page = 1;
      }
      if (
        page_size == undefined ||
        isNaN(page_size) ||
        self.page_sizes.indexOf(page_size) == -1
      ) {
        page_size = self.page_sizes[0];
      }
      self.page_size = page_size;
      let params = {
        search_type: self.search_type,
        search_txt: self.search_txt,
        page: self.page - 1,
        page_size: self.page_size
      };
      self.$http.get("/aci_api/creditinquiry/list?" + qs.stringify(params)).then(
        response => {
          //console.log('response:', response);
          if (response.status == 200) {
            self.total_count = response.data.data.total_count;
            self.tableData = response.data.data.lst;
            self.show_cond = 1
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
