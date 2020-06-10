package com.bitacademy.bms.model;


import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;


/**
 *
 * 상관관계 계산시 필요한 항목
 *  cor value 값을 곱함
 */
@Entity
@Getter
@Setter
@Table(name="stock_corr")
public class CorrEntity {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;

    @Column(name="stock_A")
    private String name;

    @Column(name="stock_B")
    private String value;

    @Column(name="cor_value")
    private double cor_value;




}
