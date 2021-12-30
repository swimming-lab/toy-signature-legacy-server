package com.github.bestheroz.main.web.pc;

import com.github.bestheroz.main.web.member.MemberDAO;
import com.github.bestheroz.main.web.member.MemberVO;
import com.github.bestheroz.main.web.tablevo.admin_mbr_mst.TableAdminMbrMstDAO;
import com.github.bestheroz.main.web.tablevo.admin_mbr_mst.TableAdminMbrMstVO;
import com.github.bestheroz.main.web.tablevo.mbr_info_mst.TableMbrInfoMstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_info_mst.TableMbrInfoMstVO;
import com.github.bestheroz.main.web.tablevo.mbr_login_hst.TableMbrLoginHstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_login_hst.TableMbrLoginHstVO;
import com.github.bestheroz.sample.web.login.LoginDAO;
import com.github.bestheroz.standard.common.constant.CommonCode;
import com.github.bestheroz.standard.common.exception.BusinessException;
import com.github.bestheroz.standard.common.util.ClientUtils;
import com.github.bestheroz.standard.common.util.MapperUtils;
import com.github.bestheroz.standard.common.util.SessionUtils;
import com.google.common.collect.ImmutableSet;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Collections;

@Service
@Slf4j
public class PcService {
    @Resource LoginDAO loginDAO;
    @Resource MemberDAO memberDAO;
    @Resource TableMbrInfoMstDAO tableMbrInfoMstDAO;
    @Resource TableMbrLoginHstDAO tableMbrLoginHstDAO;
    @Resource TableAdminMbrMstDAO tableAdminMbrMstDAO;

    @Transactional
    public void loginProcess(final HttpServletRequest request, final MemberVO vo) {
        final TableMbrInfoMstVO tableMbrInfoMstVO = MapperUtils.toObject(vo, TableMbrInfoMstVO.class);
        tableMbrInfoMstVO.setMemberSt(CommonCode.MEMBER_ST_USED);
        final TableMbrInfoMstVO mbrInfoMstVO = this.tableMbrInfoMstDAO.getVO(tableMbrInfoMstVO, ImmutableSet.of("customerId", "memberSt"));

        // 로그인 관문
        // 1. 유저가 없으면
        if (mbrInfoMstVO == null) {
            log.warn(BusinessException.FAIL_NOT_EXIST_MEMBER.getJsonObject().toString());
            throw BusinessException.FAIL_NOT_EXIST_MEMBER;
        }

        final MemberVO memberVO = MapperUtils.toObject(mbrInfoMstVO, MemberVO.class);
        // 2. 패스워드가 틀리면
        if (!StringUtils.equals(vo.getMemberPassword(), memberVO.getMemberPassword())) {
            log.warn(BusinessException.FAIL_NOT_ALLOWED_MEMBER.getJsonObject().toString());
            throw BusinessException.FAIL_NOT_ALLOWED_MEMBER;
        }

        // 로그인 히스토리
        final TableMbrLoginHstVO tableMbrLoginHstVO = MapperUtils.toObject(mbrInfoMstVO, TableMbrLoginHstVO.class);
        tableMbrLoginHstVO.setConnIp(ClientUtils.getClientIpAddr(request));
        this.tableMbrLoginHstDAO.insert(tableMbrLoginHstVO);

        // 관리자/운영자 체크
        final TableAdminMbrMstVO tableAdminMbrMstVO = MapperUtils.toObject(vo, TableAdminMbrMstVO.class);
        final TableAdminMbrMstVO loadAdminMbrMst = this.tableAdminMbrMstDAO.getVO(tableAdminMbrMstVO, Collections.singleton("customerId"));
        if (loadAdminMbrMst != null) {
            memberVO.setAdminTp(loadAdminMbrMst.getAdminTp());
        }

        // 세션 저장
        SessionUtils.setMemberVO(memberVO);
        SessionUtils.setAttribute("mode","");
    }
}
