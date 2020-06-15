## BMS

### 프로젝트 명 : SPC(Stock Predict Service)
  - 주가 예측 시스템 :chart_with_upwards_trend:
  
### 1. 프로젝트 개요 :memo:
- **농작물 가격 예측으로 시작**. 하지만 **사용자에게 서비스 제공함에 충분하지 않은 아이템으로 판단**
- 사용자에게 필요한 서비스에 대해 고민하던 중 **농작물과 농업 관련 주식과 연관성이 있음을 확인**
- 농작물과 농업 관련 주식들의 상관관계 확인 후 주식별 상관관계가 있는 **`농작물을 추가해 주식 예측`을 진행했을 때 `주식만으로 예측`했을 때보다 예측률이 더 높아짐**
- 더 나아가 **유제품, 원유가격, 환율, 코스피 등 다양한 변수와 그에 관련된 주식을 추가해 사용자에게 주식 예측 서비스를 제공**하고자 함

### 2. 팀 소개 및 역할 :two_men_holding_hands:
<div>
  <img width="250" src="https://github.com/BMS-Bitacademy/BMS/blob/master/img/logo.png">
</div>
(Bigdata Marketing Service)

- 마케팅에 대해 관심도가 있어 사용자에게 예측 서비스를 제공하기 위해 만들어진 팀

> **민병혁**(팀장)
- Web Service 구현

> **최현수**(팀원)
- Data 수집 및 적재

> **권태양**(팀원)
- Data 처리 및 분석

### 3. 시스템 구성도
<div>
  <img width="800" src="https://github.com/BMS-Bitacademy/BMS/blob/master/img/시스템 구성도.png">
</div>

### 4. 구현 과정

#### 1) 데이터 수집
- **Python 라이브러리 Selenium, Beautiful soup을 이용**해 Crawling 진행
- 출처
  - [농산물1](https://www.kamis.or.kr) / [농산물2](https://www.garak.co.kr) / [주식](https://finance.naver.com) / [환율, 코스피](https://kr.investing.com) / [우유, 설탕, 계란](https://www.atfis.or.kr) / [원유](http://www.opinet.co.kr)
  
#### 2) 데이터 분석

> **1) 전처리**
  - 수집된 데이터를 하나의 DataFrame으로 처리
<div>
  <img width="500" src="https://github.com/BMS-Bitacademy/BMS/blob/master/img/데이터 합병.png">
</div>

> **2) 모델링**
  - 각 주식 별 상관관계가 있는 변수 확인 후 모델 학습할 조합 생성
<div>
  <img width="400" src="https://github.com/BMS-Bitacademy/BMS/blob/master/img/모델 조합.png">
</div>
  
  - **`GRU`(Gated recurrent unit) 모델 선정 과정**
    - 주식은 대략 20개 / 주식 별 조합은 3-4개
    - **총 7-80개의 모델 학습이 필요**
    - 시간 별 데이터가 아닌 일별 데이터로 주식 별 데이터의 수가 많지 않다고 판단
    - **RNN, LSTM이 아닌 `GRU`인 이유**
      - RNN  : 장기 의존성 문제(과거 데이터의 정보를 기억하는 기능이 떨어짐)
      - LSTM : 많은 모델 학습이 필요하기 때문에 학습이 빠른 GRU 선택
             : 소량의 데이터에 더 잘 학습되는 GRU 선택

