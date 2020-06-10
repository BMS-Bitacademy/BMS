package com.bitacademy.bms.Service.corr;

import com.bitacademy.bms.model.CorrEntity;

import java.util.List;

public interface CorrService {

    List<CorrEntity> findAllByName(String name);

}
