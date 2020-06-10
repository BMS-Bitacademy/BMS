package com.bitacademy.bms.Repository;


import com.bitacademy.bms.model.CorrEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CorrRepositroy extends JpaRepository<CorrEntity, Long> {

    List<CorrEntity> findAllByName(String name);

}
