package com.bitacademy.bms.Repository;


import com.bitacademy.bms.model.StockEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Date;
import java.util.List;

public interface StockRepositroy extends JpaRepository<StockEntity, Long> {

    List<StockEntity> findAllByDateBetween(Date start, Date end );


    @Query(value="SELECT a.*, mean_match_status, mean_price_error, tod_return\n" +
            "FROM (SELECT com_name, com_code, DATE AS tod, tod_price, tod_status, tom_price, tom_status, ROUND((tom_price - tod_price) / tod_price * 100, 1) AS next_day_return\n" +
            "FROM stock_predict WHERE DATE = '2020-06-05') AS a LEFT OUTER JOIN(SELECT com_name,  round(AVG(MATCH_status),2) AS mean_match_status, round(AVG(price_error/tod_price)*100) AS mean_price_error , round(EXP(SUM(LOG(stock_predict.return))),2) AS tod_return\n" +
            "FROM stock_predict WHERE DATE > now()- INTERVAL 90 DAY GROUP BY com_name) AS b  ON a.com_name = b.com_name" ,nativeQuery = true)
    List<Object[]>getFullList();

}

