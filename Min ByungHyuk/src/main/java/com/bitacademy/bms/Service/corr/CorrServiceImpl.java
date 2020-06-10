package com.bitacademy.bms.Service.corr;

import com.bitacademy.bms.Repository.CorrRepositroy;
import com.bitacademy.bms.model.CorrEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *  유사항목 이름으로 검색
 */
@Service

public class CorrServiceImpl implements CorrService {
    @Autowired
    CorrRepositroy corrRepositroy;
    @Override
    public List<CorrEntity> findAllByName(String name) {
        return corrRepositroy.findAllByName(name);
    }

}
