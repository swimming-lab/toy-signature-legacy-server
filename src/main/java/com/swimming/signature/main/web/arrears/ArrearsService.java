package com.github.bestheroz.main.web.arrears;

import com.github.bestheroz.main.web.tablevo.mbr_arrears_lst.TableMbrArrearsLstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_arrears_lst.TableMbrArrearsLstVO;
import com.github.bestheroz.standard.common.constant.CommonCode;
import com.github.bestheroz.standard.common.exception.BusinessException;
import com.github.bestheroz.standard.common.util.MapperUtils;
import com.github.bestheroz.standard.common.util.SessionUtils;
import com.github.bestheroz.standard.common.util.SmtpUtils;
import com.google.common.collect.ImmutableSet;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Slf4j
public class ArrearsService {
    @Resource TableMbrArrearsLstDAO tableMbrArrearsLstDAO;
    @Resource ArrearsDAO arrearsDAO;


    @Transactional
    public int insertForm(final ArrearsVO arrearsVO) {
        // 기초 데이터 셋팅
        arrearsVO.setCustomerId(SessionUtils.getCustomerId());
        arrearsVO.setProcSt(CommonCode.ARREARS_ST_WAIT);
        final TableMbrArrearsLstVO tableMbrArrearsLstVO = MapperUtils.toObject(arrearsVO, TableMbrArrearsLstVO.class);

        // 쿼리 실행
        this.tableMbrArrearsLstDAO.insert(tableMbrArrearsLstVO);

        return tableMbrArrearsLstVO.getArrearsId();
    }

    @Transactional
    public void updateForm(final ArrearsVO arrearsVO) {
        arrearsVO.setCustomerId(SessionUtils.getCustomerId());
        TableMbrArrearsLstVO loadArrearsVO = this.getArrearsVO(arrearsVO);
        if (loadArrearsVO == null || loadArrearsVO.getProcSt() != CommonCode.ARREARS_ST_WAIT) {
            log.error(BusinessException.FAIL_INVALID_PARAMETER.getJsonObject().toString(), arrearsVO);
            throw BusinessException.FAIL_INVALID_PARAMETER;
        }

        // 기초 데이터 셋팅
        final TableMbrArrearsLstVO tableMbrArrearsLstVO = MapperUtils.toObject(arrearsVO, TableMbrArrearsLstVO.class);

        // 쿼리 실행
        this.tableMbrArrearsLstDAO.update(tableMbrArrearsLstVO, ImmutableSet.of("arrearsId", "customerId"), null);
    }

    @Transactional
    public void remove(final ArrearsVO arrearsVO) {
        arrearsVO.setCustomerId(SessionUtils.getCustomerId());
        TableMbrArrearsLstVO loadArrearsVO = this.getArrearsVO(arrearsVO);
        if (loadArrearsVO == null || loadArrearsVO.getProcSt() != CommonCode.ARREARS_ST_WAIT) {
            log.error(BusinessException.FAIL_INVALID_PARAMETER.getJsonObject().toString(), arrearsVO);
            throw BusinessException.FAIL_INVALID_PARAMETER;
        }

        // 기초 데이터 셋팅
        arrearsVO.setCustomerId(SessionUtils.getCustomerId());
        final TableMbrArrearsLstVO tableMbrArrearsLstVO = MapperUtils.toObject(arrearsVO, TableMbrArrearsLstVO.class);
        tableMbrArrearsLstVO.setProcSt(CommonCode.ARREARS_ST_REMOVE);

        // 쿼리 실행
        this.tableMbrArrearsLstDAO.update(tableMbrArrearsLstVO, ImmutableSet.of("arrearsId", "customerId"), null);
    }

    public List<ArrearsVO> list(final ArrearsVO arrearsVO) {
        // 관리자 체크
        if (SessionUtils.getMemberVO().getAdminTp() != null) {
            arrearsVO.setAdminTp(SessionUtils.getMemberVO().getAdminTp());
        }

        // 기초 데이터 셋팅
        arrearsVO.setCustomerId(SessionUtils.getCustomerId());
//        arrearsVO.setProcSt(CommonCode.ARREARS_ST_REMOVE);

        // 쿼리 실행
        return this.arrearsDAO.list(arrearsVO);
    }

    public TableMbrArrearsLstVO getArrearsVO(final ArrearsVO arrearsVO) {
        // 기초 데이터 셋팅
        arrearsVO.setCustomerId(SessionUtils.getCustomerId());
        final TableMbrArrearsLstVO tableMbrArrearsLstVO = MapperUtils.toObject(arrearsVO, TableMbrArrearsLstVO.class);

        // 쿼리 실행
        return this.tableMbrArrearsLstDAO.getVO(tableMbrArrearsLstVO, ImmutableSet.of("arrearsId", "customerId"));
    }

    public void sendEmail(int arrearsId) {
        ArrearsVO arrearsVO = new ArrearsVO();
        arrearsVO.setArrearsId(arrearsId);

        TableMbrArrearsLstVO tableMbrArrearsLstVO = this.getArrearsVO(arrearsVO);

        SmtpUtils.sendGmail(CommonCode.ADMIN_EMAIL_RECEIVER, SmtpUtils.getArrearsSubject(), SmtpUtils.getArrearsTemplate(tableMbrArrearsLstVO));
    }
}
