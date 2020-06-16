package com.bitacademy.bms.Service.Stock;

import com.bitacademy.bms.model.CompletionEntity;

import java.util.Comparator;

public class ListComparatorImpl implements Comparator {

    @Override
    public int compare(Object o1, Object o2) {

        Double value1=((CompletionEntity)o1).getNext_day_return();
        Double value2=((CompletionEntity)o2).getNext_day_return();
        return Double.compare(value2,value1);

    }
}
