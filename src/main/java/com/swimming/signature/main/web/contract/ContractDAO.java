package com.github.bestheroz.main.web.contract;

import com.github.bestheroz.main.web.tablevo.mbr_contract_mst.TableMbrContractMstVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface ContractDAO {
    List<ContractVO> searchHire(final ContractVO contractVO);
    List<ContractVO> list(final ContractVO contractVO);
    List<ContractVO> excelList(final ContractVO contractVO);
    ContractVO info(final ContractVO contractVO);

    void insert(final TableMbrContractMstVO tableMbrContractMstVO);

    void contractDel(final int contractNo);

    String selectVersion();
}
