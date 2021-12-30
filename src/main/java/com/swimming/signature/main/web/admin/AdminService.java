package com.github.bestheroz.main.web.admin;

import com.github.bestheroz.main.web.arrears.ArrearsVO;
import com.github.bestheroz.main.web.member.MemberVO;
import com.github.bestheroz.main.web.tablevo.mbr_arrears_lst.TableMbrArrearsLstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_arrears_lst.TableMbrArrearsLstVO;
import com.github.bestheroz.main.web.tablevo.mbr_info_mst.TableMbrInfoMstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_info_mst.TableMbrInfoMstVO;
import com.github.bestheroz.standard.common.constant.CommonCode;
import com.github.bestheroz.standard.common.exception.BusinessException;
import com.github.bestheroz.standard.common.util.MapperUtils;
import com.github.bestheroz.standard.common.util.SessionUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;

@Service
@Slf4j
public class AdminService {
    @Resource AdminDAO adminDAO;
    @Resource TableMbrInfoMstDAO tableMbrInfoMstDAO;
    @Resource TableMbrArrearsLstDAO tableMbrArrearsLstDAO;

    public List<MemberVO> getMemberVOList(final AdminVO adminVO) {
        // 관리자 체크
        if (SessionUtils.getMemberVO().getAdminTp() == null) {
            log.error(BusinessException.FAIL_NOT_PERMISSION.getJsonObject().toString(), SessionUtils.getMemberVO());
            throw BusinessException.FAIL_NOT_PERMISSION;
        }

        // 쿼리 실행
        return this.adminDAO.getMemberVOList(adminVO);
    }

    public TableMbrInfoMstVO getMemberVO(final MemberVO memberVO) {
        // 관리자 체크
        if (SessionUtils.getMemberVO().getAdminTp() == null) {
            log.error(BusinessException.FAIL_NOT_PERMISSION.getJsonObject().toString(), SessionUtils.getMemberVO());
            throw BusinessException.FAIL_NOT_PERMISSION;
        }

        final TableMbrInfoMstVO tableMbrInfoMstVO = MapperUtils.toObject(memberVO, TableMbrInfoMstVO.class);
        return this.tableMbrInfoMstDAO.getVO(tableMbrInfoMstVO, Collections.singleton("customerId"));
    }

    @Transactional
    public void removeMember(final MemberVO memberVO) {
        // 관리자 체크
        if (SessionUtils.getMemberVO().getAdminTp() == null) {
            log.error(BusinessException.FAIL_NOT_PERMISSION.getJsonObject().toString(), SessionUtils.getMemberVO());
            throw BusinessException.FAIL_NOT_PERMISSION;
        }

        // 기초 데이터 셋팅
        final TableMbrInfoMstVO tableMbrInfoMstVO = MapperUtils.toObject(memberVO, TableMbrInfoMstVO.class);
        tableMbrInfoMstVO.setMemberSt(CommonCode.MEMBER_ST_REMOVE);

        // 쿼리 실행
        this.tableMbrInfoMstDAO.update(tableMbrInfoMstVO, Collections.singleton("customerId"), null);
    }


    public List<ArrearsVO> getArrearsVOList(final AdminVO adminVO) {
        // 관리자 체크
        if (SessionUtils.getMemberVO().getAdminTp() == null) {
            log.error(BusinessException.FAIL_NOT_PERMISSION.getJsonObject().toString(), SessionUtils.getMemberVO());
            throw BusinessException.FAIL_NOT_PERMISSION;
        }

        // 쿼리 실행
        return this.adminDAO.getArrearsVOList(adminVO);
    }

    @Transactional
    public void setArrearsProcSt(final ArrearsVO arrearsVO, int procSt) {
        // 관리자 체크
        if (SessionUtils.getMemberVO().getAdminTp() == null) {
            log.error(BusinessException.FAIL_NOT_PERMISSION.getJsonObject().toString(), SessionUtils.getMemberVO());
            throw BusinessException.FAIL_NOT_PERMISSION;
        }

        // 기초 데이터 셋팅
        final TableMbrArrearsLstVO tableMbrArrearsLstVO = MapperUtils.toObject(arrearsVO, TableMbrArrearsLstVO.class);
        tableMbrArrearsLstVO.setProcSt(procSt);

        // 쿼리 실행
        this.tableMbrArrearsLstDAO.update(tableMbrArrearsLstVO, Collections.singleton("arrearsId"), null);
    }
}
