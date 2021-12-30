package com.github.bestheroz.main.web.equip;

import com.github.bestheroz.main.web.tablevo.com_equip_mst.TableComEquipMstDAO;
import com.github.bestheroz.main.web.tablevo.com_equip_mst.TableComEquipMstVO;
import com.github.bestheroz.main.web.tablevo.mbr_equip_lst.TableMbrEquipLstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_equip_lst.TableMbrEquipLstVO;
import com.github.bestheroz.standard.common.exception.BusinessException;
import com.github.bestheroz.standard.common.util.MapperUtils;
import com.github.bestheroz.standard.common.util.SessionUtils;
import com.google.common.collect.ImmutableSet;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;

@Service
@Slf4j
public class EquipService {
    @Resource EquipDAO equipDAO;
    @Resource TableMbrEquipLstDAO tableMbrEquipLstDAO;
    @Resource TableComEquipMstDAO tableComEquipMstDAO;

    public List<EquipVO> getEuipVOList() {
        return this.equipDAO.getEquipVOList(SessionUtils.getMemberVO());
    }

    public List<TableComEquipMstVO> getComEuipMstVOList() {
        return this.tableComEquipMstDAO.getList(new TableComEquipMstVO(), null, "equip_cd ASC");
    }

    @Transactional
    public int insert(final EquipVO equipVO) {
        // 기초 데이터 셋팅
        equipVO.setCustomerId(SessionUtils.getCustomerId());
        equipVO.setSeq(0);

        // 쿼리 실행
        this.equipDAO.insert(equipVO);
        return equipVO.getSeq();
    }

    @Transactional
    public void update(final EquipVO equipVO) {
        equipVO.setCustomerId(SessionUtils.getCustomerId());
        TableMbrEquipLstVO loadArrearsVO = this.getEquipVO(equipVO);
        if (loadArrearsVO == null) {
            log.error(BusinessException.FAIL_INVALID_PARAMETER.getJsonObject().toString(), equipVO);
            throw BusinessException.FAIL_INVALID_PARAMETER;
        }

        // 기초 데이터 셋팅
        equipVO.setCustomerId(SessionUtils.getCustomerId());
        final TableMbrEquipLstVO tableMbrEquipLstVO = MapperUtils.toObject(equipVO, TableMbrEquipLstVO.class);

        // 쿼리 실행
        this.tableMbrEquipLstDAO.update(tableMbrEquipLstVO, ImmutableSet.of("seq", "customerId"), null);
    }

    @Transactional
    public void remove(final EquipVO equipVO) {
        equipVO.setCustomerId(SessionUtils.getCustomerId());
        TableMbrEquipLstVO loadArrearsVO = this.getEquipVO(equipVO);
        if (loadArrearsVO == null) {
            log.error(BusinessException.FAIL_INVALID_PARAMETER.getJsonObject().toString(), equipVO);
            throw BusinessException.FAIL_INVALID_PARAMETER;
        }

        // 기초 데이터 셋팅
        final TableMbrEquipLstVO tableMbrEquipLstVO = MapperUtils.toObject(equipVO, TableMbrEquipLstVO.class);

        // 쿼리 실행
        this.tableMbrEquipLstDAO.delete(tableMbrEquipLstVO, ImmutableSet.of("seq", "customerId"));
    }

    public TableMbrEquipLstVO getEquipVO(final EquipVO equipVO) {
        // 기초 데이터 셋팅
        equipVO.setCustomerId(SessionUtils.getCustomerId());
        final TableMbrEquipLstVO tableMbrEquipLstVO = MapperUtils.toObject(equipVO, TableMbrEquipLstVO.class);

        // 쿼리 실행
        return this.tableMbrEquipLstDAO.getVO(tableMbrEquipLstVO, ImmutableSet.of("seq", "customerId"));
    }
}
