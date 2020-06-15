<template>
  <div class="home">
    <!-- <img alt="Vue logo" src="../assets/logo.png">
    <HelloWorld msg="Welcome to Your Vue.js App"/> -->
    <div class="inner">
      <!-- 타이틀 -->
      <strong>[ 차별화된 주가 예측 시스템 ]</strong>
      <hr>
      <p>
          기존의 주가예측보다 농작물 가격과의 상관성을 더한 예측으로 약 10% 향상된 예측율<br>
          ( 예상 수익율 10% / 정확도 80% )
      </p>
      <a class="btn no1" href=#>More Explaination</a>      
      <!--stock_wrap -->
      <div class="stock_wrap">
        <div class="text_wrap">
            <h1 class="cont_tit">Top5 Hot Stock Today</h1>
            <div class="date">
                <span class="today">2020.05.28</span>
            </div>
        </div>

        <div class="stock_list" id="stock-list">
          <ul>
              <!-- stock_tit -->
              <!-- <li class="stock_tit">
                  <div onclick="orderedStocks">주식명</div>
                  <div>금일종가</div>
                  <div>익일예측</div>
                  <div>등락 적중률</div>
                  <div>최근 한달 수익률</div>
                  <div>최근 한달 오차범위</div>
              </li> -->
              <!-- stock_tit -->
              
              <!-- stock_info 하나의 주식 정보-->
              <stockItem msg=""></stockItem>
          </ul>
        </div>
      </div>
      <router-link to="/total">
        <a class="btn no2">viewMore</a>
      </router-link>      
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import StockItem from '@/components/StockItem.vue'

export default {
  // data:{
  //   // today: new Date().toISOString(0, 10)
  //   today: 'aaaaaaaaaaaaa'
  // },
  components: {
    StockItem
  }
}
// document.getElementsByClassName("today").innerHTML = new Date().toISOString(0, 10)

</script>
