package com.bitacademy.bms.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;


/**
 * Rest 방식으로 Json 형태 Data Set
 * key Value Map 형태로 관리
 * Tod_Price 금일종가 Tom_Price 예측종가
 */
@Getter
@Setter
@AllArgsConstructor
public class Chartdata {
    public Date  date;
    public String tod_price;
    public String tom_price;
}
