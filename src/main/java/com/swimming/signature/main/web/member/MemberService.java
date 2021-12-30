package com.github.bestheroz.main.web.member;

import com.github.bestheroz.main.web.tablevo.mbr_equip_lst.TableMbrEquipLstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_info_mst.TableMbrInfoMstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_info_mst.TableMbrInfoMstVO;
import com.github.bestheroz.main.web.tablevo.mbr_login_hst.TableMbrLoginHstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_login_hst.TableMbrLoginHstVO;
import com.github.bestheroz.standard.common.constant.CommonCode;
import com.github.bestheroz.standard.common.exception.BusinessException;
import com.github.bestheroz.standard.common.util.ClientUtils;
import com.github.bestheroz.standard.common.util.MapperUtils;
import com.github.bestheroz.standard.common.util.SessionUtils;
import com.github.bestheroz.standard.common.util.SmtpUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Collections;
import java.util.List;

@Service
@Slf4j
public class MemberService {
    @Resource MemberDAO memberDAO;
    @Resource TableMbrInfoMstDAO tableMbrInfoMstDAO;
    @Resource TableMbrEquipLstDAO tableMbrEquipLstDAO;
    @Resource TableMbrLoginHstDAO tableMbrLoginHstDAO;

    public List<MemberVO> search(final MemberVO memberVO) {
        return this.memberDAO.search(memberVO);
    }

    public String selectViewBizcoYn(final int customerId) {
        return this.memberDAO.selectViewBizcoYn(customerId);
    }

    @Transactional
    public void joinProcess(final HttpServletRequest request, final MemberVO memberVO) {
        final TableMbrInfoMstVO tableMbrInfoMstVO = MapperUtils.toObject(memberVO, TableMbrInfoMstVO.class);

        // 사업자번호로 중복회원 확인
        final TableMbrInfoMstVO mbrInfoMstVO = this.tableMbrInfoMstDAO.getVO(tableMbrInfoMstVO, Collections.singleton("bizcoRegNo"));
        if (mbrInfoMstVO != null) {
            log.error(BusinessException.FAIL_EXIST_MEMBER.getJsonObject().toString(), memberVO);
            throw BusinessException.FAIL_EXIST_MEMBER;
        }

        // 회원 인서트
        this.memberDAO.insert(tableMbrInfoMstVO);

        // 로그인 히스토리
        final TableMbrLoginHstVO tableMbrLoginHstVO = MapperUtils.toObject(tableMbrInfoMstVO, TableMbrLoginHstVO.class);
        tableMbrLoginHstVO.setConnIp(ClientUtils.getClientIpAddr(request));
        this.tableMbrLoginHstDAO.insert(tableMbrLoginHstVO);

        // 세션 저장
        memberVO.setCustomerId(tableMbrInfoMstVO.getCustomerId());
        SessionUtils.setMemberVO(memberVO);
    }

    @Transactional
    public void update(final MemberVO memberVO) {
        final TableMbrInfoMstVO tableMbrInfoMstVO = MapperUtils.toObject(memberVO, TableMbrInfoMstVO.class);

        Integer adminTp = SessionUtils.getMemberVO().getAdminTp() != null ? SessionUtils.getMemberVO().getAdminTp() : null;
        int b = memberVO.getCustomerId() != null ? memberVO.getCustomerId() : 0;
        // 기초 데이터
        boolean isAdminMemberUpdate = SessionUtils.getMemberVO().getAdminTp() != null && memberVO.getCustomerId() != null;
        if (isAdminMemberUpdate) {
            tableMbrInfoMstVO.setCustomerId(memberVO.getCustomerId());
        } else {
            tableMbrInfoMstVO.setCustomerId(SessionUtils.getCustomerId());
        }
        tableMbrInfoMstVO.setBizcoNm(null);
        tableMbrInfoMstVO.setBizcoRegNo(null);
        tableMbrInfoMstVO.setMemberPassword(null);
        tableMbrInfoMstVO.setAppPassword(null);

        // 회원 업데이트
        this.tableMbrInfoMstDAO.update(tableMbrInfoMstVO, Collections.singleton("customerId"), null);

        // 세션 업데이트
        if (!isAdminMemberUpdate) {
            final TableMbrInfoMstVO mbrInfoMstVO = this.tableMbrInfoMstDAO.getVO(tableMbrInfoMstVO, Collections.singleton("customerId"));
            MemberVO updatedMemberVO = MapperUtils.toObject(mbrInfoMstVO, MemberVO.class);
            if (adminTp != null) {
                updatedMemberVO.setAdminTp(adminTp);
            }
            SessionUtils.setMemberVO(updatedMemberVO);
        }
    }

    @Transactional
    public void updatePassword(final MemberVO memberVO) {
        final TableMbrInfoMstVO tableMbrInfoMstVO = new TableMbrInfoMstVO();

        int a = SessionUtils.getMemberVO().getAdminTp();
        int b = memberVO.getCustomerId() != null ? memberVO.getCustomerId() : 0;
        // 기초 데이터
        boolean isAdminMemberUpdate = SessionUtils.getMemberVO().getAdminTp() != null && memberVO.getCustomerId() != null;
        if (isAdminMemberUpdate) {
            tableMbrInfoMstVO.setCustomerId(memberVO.getCustomerId());
        } else {
            tableMbrInfoMstVO.setCustomerId(SessionUtils.getCustomerId());
        }
        if (memberVO.getAppPassword() != null) {
            tableMbrInfoMstVO.setAppPassword(memberVO.getAppPassword());
        }
        if (memberVO.getMemberPassword() != null) {
            tableMbrInfoMstVO.setMemberPassword(memberVO.getMemberPassword());
        }

        // 회원 업데이트
        this.tableMbrInfoMstDAO.update(tableMbrInfoMstVO, Collections.singleton("customerId"), null);
    }

    public void check(final MemberVO memberVO) {
        final TableMbrInfoMstVO tableMbrInfoMstVO = MapperUtils.toObject(SessionUtils.getMemberVO(), TableMbrInfoMstVO.class);
        final TableMbrInfoMstVO mbrInfoMstVO = this.tableMbrInfoMstDAO.getVO(tableMbrInfoMstVO, Collections.singleton("customerId"));

        if (!StringUtils.equals(memberVO.getMemberPassword(), mbrInfoMstVO.getMemberPassword())) {
            log.warn(BusinessException.FAIL_INVALID_MEMBER_PWD.getJsonObject().toString());
            throw BusinessException.FAIL_INVALID_MEMBER_PWD;
        }

        // 세션 저장
        SessionUtils.setAttribute("isChecked", true);
    }

    public void resetMemberPassword() {
        SmtpUtils.sendGmail(CommonCode.ADMIN_EMAIL_RECEIVER, SmtpUtils.getResetMemberPasswordSubject(), SmtpUtils.getResetMemberPasswordTemplate(SessionUtils.getMemberVO()));
    }
}
