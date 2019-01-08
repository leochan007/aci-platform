<template>
  <div class="chart-container">
    <div id="userChart" style="height: 250px" >图表加载失败</div>
  </div>
</template>

<style>

.chart {
  background-color: white;
  border-radius: 4px;
}

.chart_left {
  border-right:#F2F2F2 10px solid;
}

</style>

<script>
  import bus from "@/utils/event";
  import { ON_NATION_CHANGE } from "@/config/constants";
  import { days_before } from '@/utils/dt_tools';
  import echarts from 'echarts';

  export default {
    data() {
      return {
        dates: null,
        datas: null,
        myChart: null,
      };
    },
    methods: {
      InitChartOption() {

        let self = this;

        //self.myChart.showLoading();

        if (self.$i18n == null) {
          console.log('null i18n')
          return
        }

        let option = {
          title: {
            text: self.$t('message.Transactions')
          },
          tooltip: {
            trigger: 'axis',
            axisPointer: {
              type: 'cross',
              label: {
                backgroundColor: '#6a7985'
              }
            }
          },
          legend: {
            data: [self.$t('message.TxsPerDay')]
          },
          toolbox: {
            feature: {
              saveAsImage: {}
            }
          },
          grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
          },
          xAxis: [
            {
              type: 'category',
              boundaryGap: false,
              data: this.dates,
            }
          ],
          yAxis: [
            {
              type: 'value',
              minInterval : 1,
              boundaryGap : [ 0, 0.1 ],
            }
          ],
          series: [
            {
              name: self.$t('message.TxsPerDay'),
              type: 'line',
              stack: 'Total',
              areaStyle: {normal: {}},
              data: this.datas,
            }
          ]
        };

        if (self.myChart != null) {
          self.myChart.setOption(option, true);
        }

        //self.myChart.hideLoading();

      },
      getUserChartInit() {
        let self = this;
        self.myChart = echarts.init(document.getElementById('userChart'));

        self.InitChartOption();

        window.onresize = function() {
          self.myChart.resize();
        }
      }
    },
    mounted () {
      let self = this;
      let days = 13;
      let dt = days_before(days);
      self.dates = [];
      self.datas = [];
      let dates = [];
      for (var i = 0; i<= days; i++) {
        self.dates.push(dt.format("MMM/Do"));
        dates.push(dt.format("YYYY-MM-DD"));
        dt = dt.add(1, 'days');
      }

      self.$http.post('/aci_api/creditinquiry/tx_count_lst', dates).then(response => {
          if (response.status == 200) {
            self.datas = response.data.data.txs_count;
            this.getUserChartInit();
          }
　　　　}, response => {
　　　　　　console.log(response);
　　　　});

      this.$nextTick(function () {
      })

      bus.$on(ON_NATION_CHANGE, (data) => {
        self.InitChartOption();
      })
    }
  };
</script>
