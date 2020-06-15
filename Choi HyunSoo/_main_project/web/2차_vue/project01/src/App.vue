<template>
  <div id="app">
    <div class="header">
      <div class="inner">
        <div class="logo">
          <a href="#">BMS Solution</a>
        </div>
        <div class="menubox">
          <router-link to="/">
            <div class="menu1"><a href="/">Home</a></div>
          </router-link>
          <router-link to="/total">
            <div class="menu2"><a href="/">Stock Imformation</a></div>
          </router-link>
          <router-link to="/dev">
            <div class="menu3"><a href="#">Develope Process</a></div>
          </router-link>
        </div>
      </div>
    </div>
    <router-view/>

    <footer id="footer">
      <div class="inner"><p>농업관련 주식을 농작물 가격과의 상관관계를 확인 후 예측 주식만을 이용해 예측한 값보다 약 10% 더 좋은 예측율(예상 수익율 10% / 정확도 80%) 농업주가 예측 시스템<br>Create by BMS</p></div>
    </footer>    
  </div>
</template>

<style lang="scss" src="./assets/css/style.scss">
// #app {
//   font-family: Avenir, Helvetica, Arial, sans-serif;
//   -webkit-font-smoothing: antialiased;
//   -moz-osx-font-smoothing: grayscale;
//   text-align: center;
//   color: #2c3e50;
// }
</style>
