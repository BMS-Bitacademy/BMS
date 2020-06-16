<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>
<link href="http://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
<style>
    .ns{font-family: 'Noto Sans KR', sans-serif;}

    .site-src {
        float: left; margin-right: 20px; font-size: 20px;
    }

    p {
        font-size: 20px;
    }
</style>

<div class="row">
    <div class="container">
        <br class="content-center">

        <h1 class="ns">주가 예측 시스템 (Stock Predict Service)</h1><br><br>

        <h3 class="ns">I. 프로젝트 개요</h3>
        <p class="ns">농작물 가격 예측으로  서비스   아이템으로 판단 사용자에게 필요한 서비스에 대해 고민하던 중 농작물과 관련된 연관성을 확인 </p>
        <p class="ns"> 농작물과 각 농업 관련 주식들의 상관관계 확인 후 각 주식별 상관관계가 있는 농작물을 추가해 시계열 예측을 진행했을 때
            더 높은 예측율 산출되어 유제품, 원유가격, 환율, 코스피 등 다양한 변수와 그에 관련된 주식을 추가하여 사용자에게 주식예측서비스를 제공하고자 함</p>
        <br><br><br><br><br>
        <h3 class="ns">II.팀 소개 및 역할</h3>
        <p class="ns">BMS (BigData marketing Service)</p>
        <P class="ns">마케팅에대한 관심도가있던 인원끼리모여 사용자에게 예측서비스를 제공하고자하는 취지의 모임</p>

        <p class="ns">민병혁 : Web Service 구현</p>
        <p class="ns">최현수 : Data 수집 및 적재 및 chart 시각화</p>
        <p class="ns">권태양 : Data 처리 및 분석</p>
        <br><br><br><br><br>
        <h3 class="ns">III.시스템 구성도 </h3>
        <div>
            <img src="assets/ImgList/System_cap.png" alt="System">
        </div>
        <br><br><br><br><br>
        <h3 class="ns">IV.구현 과정 </h3>
        <h5 class="ns">-데이터 수집 및 적재</h5><br>
        <img src="assets/ImgList/bs4.png" alt="bs4" width="300" height="300">
        <img src="assets/ImgList/selenium.png" alt="selenium" width="350" height="300">
        <img src="assets/ImgList/ArrowRight.png" alt="arrow" width="200">
        <img src="assets/ImgList/MariaDB.png" alt="Mairadbimg" width="300" height="300"><br><br>

        <h4 class="ns">사이트 출처</h4>
        <div class="site-src "> - 네이버금융 https://finance.naver.com<br>- 인베스팅닷컴 https://kr.investing.com<br>- 식품산업통계정보 https://www.atfis.or.kr</div>
        <div class="site-src " > - 농산물유통정보 https://www.kamis.or.kr<br>- 오피넷(국제유가) http://www.opinet.co.kr<br>- 서울특별시농수산식품공사 https://www.garak.co.kr</div>
        <br><br><br><br><br><br><br><br><br>
        <h3 class="ns">V.데이터 분석</h3>
        <br>
        <h5 class="ns">- 상관관계 분석</h5>
        <img src="assets/ImgList/모델%20조합.png" alt="Model" height="400" ><br>
        <br><br><br><br><br><br>
        <h5 class="ns">-모델 선정</h5>
        <img src="assets/ImgList/modelselect.png" alt="compare"><br>
        <br><br><br><br><br><br>
        <h5 class="ns">-모델 비교 </h5>
        <img src="assets/ImgList/모델비교2.png" alt="compare" ><br>
        <br><br><br><br><br><br>
        <h3 class="ns">VI.시각화</h3>
        <h5 class="ns">-Spring Boot , Vue.js D3.js 이용한 시각화</h5>
        <img src="assets/ImgList/MariaDB.png" alt="Mairadbimg" width="400" height="300">
        <img src="assets/ImgList/SpringDBget.png" alt="DBGET" width="200">
        <img src="assets/ImgList/spring.png" alt="Spring" width="400"><br>


        <button type="button" class="btn btn-primary  pull-right" onclick="location.href='/'">홈으로
        </button>
    </div>
</div>

