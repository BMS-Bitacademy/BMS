package com.bitacademy.bms.Service.Stock;


import com.bitacademy.bms.Repository.StockRepositroy;
import com.bitacademy.bms.Service.corr.CorrService;
import com.bitacademy.bms.model.CompletionEntity;
import com.bitacademy.bms.model.CorrEntity;
import com.bitacademy.bms.model.StockEntity;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;


@Service
public class StockServiceImpl implements StockSerivce {

    @Autowired
    StockRepositroy stockRepositroy;

    @Autowired
    CorrService corrService;

    /**
     * Main 화면에 표시할 5개 리스트
     */
    public List<CompletionEntity> getHomeList() {

        List<CompletionEntity> completionEntityList = this.getFullList();
        Collections.sort(completionEntityList, new ListComparatorImpl());
        completionEntityList = completionEntityList.subList(0, 5);


        return completionEntityList;
    }

    /**
     * 전체리스트 표시
     */
    @Override
    public List<CompletionEntity> getFullList() {

        List<Object[]> resultList = stockRepositroy.getFullList();
        List<CompletionEntity> completionEntityList = resultList.stream().map(product -> new CompletionEntity(
                (String) product[0], (Integer) product[1], (Date) product[2], (String) product[3],
                (String) product[4], (String) product[5], (String) product[6], (Double) product[7],
                (Double) product[8], (Double) product[9],
                (Double) product[10])).collect(Collectors.toList());
        return completionEntityList;
    }


    /**
     * JPA 수정필요  -> Com_name , And between 변경필요 임시처리
     */
    @Override
    public List<StockEntity> findAllByDateBetween(Date start, Date end) {
        return stockRepositroy.findAllByDateBetween(start, end);
    }

    /**
     * 그래프화면에서 사용자가 선택한 주식명 한개
     */
    @Override
    public CompletionEntity findCompletionEntityByComCode(int Com_code, List<CompletionEntity> completionEntityList) {

        CompletionEntity seachItem = new CompletionEntity();
        for (CompletionEntity item : completionEntityList) {
            if (item.getCom_code()==Com_code) {
                seachItem = item;
                break;
            }
        }
        return seachItem;
    }
    @Override
    public CompletionEntity findCompletionEntityByName(String name, List<CompletionEntity> completionEntityList) {
        String seachItemName = name;
        CompletionEntity seachItem = new CompletionEntity();
        for (CompletionEntity item : completionEntityList) {
            if (item.getCom_name().equals(seachItemName)) {
                seachItem = item;
                break;
            }
        }
        return seachItem;
    }

    /**
     * 그래프항목에서 유사항목 리스트 생성
     */
    @Override
    public List<CompletionEntity> getSimilarList(String name) {

        String similarItemName;
        List<CompletionEntity> similarPlusList = new ArrayList<>();

        List<CorrEntity> corrEntityList = corrService.findAllByName(name);
        List<CompletionEntity> CompletionEntityList = this.getFullList();

        for (CorrEntity corr : corrEntityList) {
            if (corr.getCor_value() > 0.7) {
                similarItemName = corr.getValue();
                //이름없을수도있음 예외처리
                CompletionEntity similarItem = this.findCompletionEntityByName(similarItemName, CompletionEntityList);
                if (!(similarItem.getCom_name() == null))
                    similarPlusList.add(similarItem);

            }
        }
        similarPlusList.sort(new ListComparatorImpl());
        if (similarPlusList.size() >= 5) {
            similarPlusList = similarPlusList.subList(0, 5);
        }
        return similarPlusList;
    }



    /**
     * REST 방식(JSON)로 Return 할 Chart Data HashMap Collection 생성
     * startDate -> 조회시작날짜 2020-01-01 , endDate -> 마지막조회일 오늘날짜
     */
    @Override
    public Collection<HashMap<String, String>> getChartDataList(int code) {


        java.sql.Date startDate = java.sql.Date.valueOf("2019-12-31");
        Date endDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        List<StockEntity> stockEntityList = this.findAllByDateBetween(startDate, endDate);


        List<StockEntity> parseNameList = new ArrayList<>();
        Collection<HashMap<String, String>> jsonMap = new ArrayList<>();


        for (StockEntity stockEntity : stockEntityList) {
            if (code==stockEntity.getCom_code()) {
                parseNameList.add(stockEntity);
            }
        }



        //예측데이터 매칭필요로 i=1부터 시작한다.
        int size = parseNameList.size();
        for (int i = 1; i < parseNameList.size(); i++) {
            HashMap<String, String> map = new HashMap<>();
            String stockDate = dateFormat.format(parseNameList.get(i).getDate());
            String stockTod_price = parseNameList.get(i).getTod_price();
            String stockTom_price = parseNameList.get(i - 1).getTom_price();
            map.put("count", String.valueOf(i));
            map.put("date", stockDate);
            map.put("Tod_price", stockTod_price);
            map.put("Tom_price", stockTom_price);
            jsonMap.add(map);

            ///
            // 마지막날다음날 (예측한날의 데이터는 당일종가를 제외한 map을 생성해서 json list add
            //
            if (i == size - 1) {
                Date lastDate = parseNameList.get(i).getDate();
                String lastTomPrice = parseNameList.get(i).getTom_price();
                HashMap<String, String> predictMap = getPredictMap(lastDate, lastTomPrice);
                jsonMap.add(predictMap);
            }
        }

        return jsonMap;
    }

    //마지막날짜를 받아서 예측날짜로 변환
    @Override
    public String getPredictDay(Date lastDate) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(lastDate);
        calendar.add(Calendar.DATE, 1);
        return dateFormat.format(calendar.getTime());
    }

    // 마지막 예측날만  MAP 형태로 변환 하는 함수
    public HashMap<String, String> getPredictMap(Date lastDate, String TomPrice) {
        HashMap<String, String> predictMap = new HashMap<>();
        String stockPredictDate = getPredictDay(lastDate);
        String stockPredictTomPrice = TomPrice;
        predictMap.put("date", stockPredictDate);
        predictMap.put("Tom_price", stockPredictTomPrice);
        return predictMap;
    }


}



