package com.github.bestheroz.main.web.arrears;

import com.github.bestheroz.main.web.contract.ContractVO;
import com.github.bestheroz.main.web.tablevo.mbr_contract_mst.TableMbrContractMstVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface ArrearsDAO {
    List<ArrearsVO> list(final ArrearsVO arrearsVO);
    ContractVO info(final ContractVO contractVO);

    void insert(final TableMbrContractMstVO tableMbrContractMstVO);
}
