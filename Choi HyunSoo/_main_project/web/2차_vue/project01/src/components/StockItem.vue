<template>
    <div>
        <!-- <li class="stock_info" v-for="stock in stocks" :key="stock.com" onclick="/detail:stock.com_code"> -->
        <!-- <router-link to="/detail/" {{ $route.stock.com_code }}> -->
            <!-- stock_tit -->
            <li class="stock_tit">
                <div @click="orderedStocks">주식명</div>
                <div @click="showlist">금일종가</div>
                <div>익일예측</div>
                <div>등락 적중률</div>
                <div>최근 한달 수익률</div>
                <div>최근 한달 오차범위</div>
            </li>
            <!-- stock_tit -->        
        <router-link to="/detail">
            <li class="stock_info" v-for="stock in stocks" :key="stock.com">
                    <!-- 주식명 -->
                    <div>{{ stock.com_name }}</div>
                    <!-- 금일 종가 -->
                    <div class="price">{{ stock.tod_price }}
                        <span class="up" v-if="stock.tod_status > 0">▲</span>
                        <span class="down" v-else-if="stock.tod_status < 0">▼</span>
                        <span class="nomal" v-else>-</span>
                    </div>
                    <!-- 익일 예측 종가 -->
                    <div class="price">{{ stock.tom_price }}
                        <span class="up" v-if="stock.tom_status > 0">▲</span>
                        <span class="down" v-else-if="stock.tom_status < 0">▼</span>
                        <span class="nomal" v-else>-</span>
                    </div>
                    <!-- 등락 적중률 -->
                    <div class="nomal">
                        <span class="perc">{{ Math.round(stock.mean_match_status*100) }}%</span>
                        <div class="graph"><span class="bar" :style="{ width: Math.round(stock.mean_match_status*100) + '%' }"></span></div>
                    </div>
                    <!-- 최근 한달 수익률 -->
                    <div class="plus" v-if="stock.tod_return > 1">        
                        <span class="perc">{{ Math.round(Math.abs(1-stock.tod_return)*100) }}%</span>
                        <div class="graph"><span class="bar" :style="{ width: Math.round(Math.abs(1-stock.tod_return)*100/2) + '%' }"></span></div>
                    </div>
                    <div class="minus" v-else-if="stock.tod_return < 1">
                        <span class="perc">{{ Math.round(Math.abs(1-stock.tod_return)*100) }}%</span>
                        <div class="graph"><span class="bar" :style="{ width: Math.round(Math.abs(1-stock.tod_return)*100/2) + '%' }"></span></div>
                    </div>
                    <div class="nomal" v-else>
                        <span class="perc">0%</span>
                        <div class="graph"><span class="bar" :style="{ width: Math.round(Math.abs(1-stock.tod_return)*100/2) + '%' }"></span></div>            
                    </div>
                    <!-- 최근 한달 오차범위 -->
                    <div class="nomal">
                        <h3>{{ stock.mean_price_error }}%</h3>
                    </div>
            </li>
        </router-link>
    </div>
</template>

<script>
import lodash from 'lodash'
import axios from '../plugins/axios.min.js';
export default {
    name: 'stock-item',
    data: function() { 
        return {
            stocks: []
            // msg: "aa"
        }
    },
    props: ['msg'],
    created: function() {
                console.log('msg:' + this.msg);
                axios.get('http://localhost:8081/' + this.msg)
                    .then(res => {
                        this.stocks = res.data;
                        console.log(this.stocks);
                    })
                    .catch(error => {
                        console.log(error);
                    })
                },
    methods: {
        orderedStocks: function() {
            console.log('click: orderedStocks - item');
            return lodash.orderBy(this.stocks, ['com_name'], ['desc']);
            // console.log(this.stocks);
        },
        showlist: function() {
            console.log(this.stocks);
        }
    },
    routeds: [

    ],
    computed: {
        // sortedArray: function() {
        //     function compare(a, b) {
        //         if (a.name < b.name)
        //             return -1;
        //         if (a.name > b.name)
        //             return 1;
        //         return 0;
        //     }
        //     return this.stocks.sort(compare);
        // }
    }
}

</script>

<style scoped>

</style>