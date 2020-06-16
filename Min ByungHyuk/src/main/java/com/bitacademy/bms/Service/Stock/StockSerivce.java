package com.bitacademy.bms.Service.Stock;


import com.bitacademy.bms.model.CompletionEntity;
import com.bitacademy.bms.model.StockEntity;

import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


public interface StockSerivce {

    List<StockEntity> findAllByDateBetween(Date start, Date end);

    List<CompletionEntity>getFullList();

    List<CompletionEntity>getHomeList();

    List<CompletionEntity>getSimilarList(String name);

    Collection<HashMap<String, String>> getChartDataList(int code);

    CompletionEntity findCompletionEntityByName(String name, List<CompletionEntity> completionEntityList);

    CompletionEntity findCompletionEntityByComCode(int code, List<CompletionEntity> completionEntityList);

    String getPredictDay(Date lastDate);


}
