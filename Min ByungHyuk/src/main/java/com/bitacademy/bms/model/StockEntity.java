package com.bitacademy.bms.model;




import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Entity
@Getter
@Setter
@Table(name = "stock_predict")
public class StockEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idx;

    @Column(name = "com_name")
    private String com_name;

    @Column(name = "com_code")
    private int com_code;

    @Column(name = "date")
    private Date date;

    @Column(name = "tod_price")
    private String tod_price;

    @Column(name = "tod_status")
    private String difference;

    @Column(name = "tom_price")
    private String tom_price;

    @Column(name = "tom_status")
    private String tom_status;

    @Column(name = "match_status")
    private String match_status;

    @Column(name = "price_error")
    private String price_error;

    @Column(name = "return")
    private String Yield;

}


