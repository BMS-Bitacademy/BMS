<template>
    <div class="inner">
        <div class="stock_wrap">
                <h1>- Total Stock List -</h1>
            <div class="stock_list" id="stock-list">
                <ul>
                    <!-- stock_info 하나의 주식 정보-->
                    <StockItem msg="total" ref=""></StockItem>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
// import lodash from 'lodash'
import StockItem from './StockItem.vue'
// import axios from '../plugins/axios.min.js';
export default {
    name: 'stock-item',
    components: {
        StockItem
    },
    methods: {
        order: function() {
            console.log('click: orderedStocks - total');
            this.$$emit.orderedStocks;
            // return _.orderBy(this.stocks, ['com_name'], ['desc']);
            // return lodash.orderBy(this.stocks, ['com_name'], ['desc']);
            // console.log(this.stocks);
        }
    }
    // data: function() { 
    //     return {
    //         stocks: []
    //     }
    // },
    // created: function() {
    //             axios.get('http://localhost:8081/total')
    //                 .then(res => {
    //                     this.stocks = res.data;
    //                     console.log(this.stocks);
    //                 })
    //                 .catch(error => {
    //                     console.log(error);
    //                 })
    //             }    
}
</script>