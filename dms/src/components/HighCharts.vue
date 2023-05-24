<template>
    <div class="highChart">
        <div id="chart"></div>
    </div>
</template>

<script>
import Highcharts from 'highcharts';

export default {
    name: 'HighchartsComponent',
    mounted() {
        Highcharts.chart('chart', {
            chart: {
                type: 'pie',
                options3d: {
                    enabled: true,
                    alpha: 45,
                },
                zIndex: 1,
            },
            plotOptions: {
                pie: {
                    size: '100%', // kích thước của biểu đồ
                    center: ['50%', '50%'], // căn chỉnh biểu đồ luôn nằm giữa
                    borderWidth: 0,
                    slicedOffset: 0,
                    cursor: 'pointer',
                    allowPointSelect: true,
                    innerSize: 100,
                    depth: 80,
                    dataLabels: {
                        zIndex: 2, // Đánh z-index cho các data label
                    },
                },
            },
            series: [
                {
                    colorByPoint: true,
                    innerSize: '90%', // độ rộng của các thành phần bgc
                    borderRadius: '50%', // border-radius của các bgc item
                    dataLabels: {},
                    data: [
                        { name: 'Approved', y: 20, color: '#28B78D' },
                        { name: 'Rejected', y: 12, color: '#F94D4D' },
                        { name: 'Pending', y: 10, color: '#EA7F00' },
                    ],
                },
            ],
        })
    }
}
</script>
<style lang="scss" scoped>
@import "@/assets/style/_reset.scss";
@import "@/assets/style/_global.scss";

::v-deep .highcharts-credits {
  display: none;
}

::v-deep .highcharts-label {
  text {
    display: none;
  }
}
::v-deep .highcharts-data-label-connector {
  display: none;
}

::v-deep .highcharts-screen-reader-region-before-0 {
  display: none;
}

.chart-note {
  width: 100%;
  background-color: var(--backgroud);
  padding: 0 24px;
  border-bottom-left-radius: 16px;
  border-bottom-right-radius: 16px;
  &--item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 16px 0;
    border-bottom: 1px solid var(--border-color);
  }
}
::v-deep .highcharts-exporting-group {
  display: none;
}

#chart {

  width: 100% !important;
  height: 262px !important;
  background-color: var(--backgroud);
  padding: 6px 0;
  overflow: hidden;
}
.chart-page {
  position: relative;
}


.chart-txt {
  position: absolute;
  top: 49%;
  left: 50%;
  transform: translate(-50%,-50%);
  z-index: 1;
  width: 155px;
  height: 155px;
  background-color: var(--backgroud);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  border-radius: 50%;
  &--name {
    position: absolute;
    top: 35%;
    left: 50%;
    transform: translate(-50%,-50%);
    font-weight: 600;
    font-size: 24px;
    color: var(--text-color--2);
  }
  &--count {
    position: absolute;
    top: 60%;
    left: 50%;
    transform: translate(-50%,-50%);
    font-weight: 600;
    font-size: 40px;
    color: var(--text-color--1);

  }
}
</style>