package com.bitacademy.bms.model;


import lombok.*;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import java.util.Date;
/**
 * Jpa Native Query 사용하여 Return 받음
 * AllArgsConstructor -> Native Query 사용시 필요 (전체리스트표시기능)
 * NoArgsConstructor  -> 사용자가 선택한 하나의 주식 항목을 할떄 필요
 */
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CompletionEntity {

    //주식명
    private String com_name;
    // 금일종가
    private Integer com_code;
    //익일예측
    private Date tod;
    //금일종가
    private String tod_price;
    //금일종가 상승여부
    private String tod_status;
    //명일예측종가
    private String tom_price;
    //명일예측종가 상승여부
    private String tom_status;
    //익일예측
    private Double next_day_return;
    //등락적중여부
    private Double mean_match_status;
    //평균오차범위
    private Double mean_price_error;

    private Double tod_return;

}
