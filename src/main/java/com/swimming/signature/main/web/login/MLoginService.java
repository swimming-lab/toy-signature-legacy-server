package com.github.bestheroz.main.web.login;

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
import com.github.bestheroz.standard.common.util.*;
import com.google.common.collect.ImmutableSet;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.util.WebUtils;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Collections;

@Service
@Slf4j
public class MLoginService {
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
        if (!StringUtils.equals(vo.getAppPassword(), memberVO.getAppPassword())) {
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

    public void setAutoLogin(final HttpServletResponse response) {
        AutoLoginVO autoLoginVO = new AutoLoginVO();
        autoLoginVO.setCustomerId(SessionUtils.getCustomerId());
        autoLoginVO.setAppPassword(AesUtils.encrypt256(SessionUtils.getMemberVO().getAppPassword()));
        autoLoginVO.setVersion("1.0.0");

        String value = SerializeUtils.serializeObjectToString(autoLoginVO);

        // create a cookie
        Cookie cookie = new Cookie(CommonCode.LOGIN_AUTO_COOKIE_NAME, value);
        cookie.setPath("/");
        cookie.setMaxAge(60 * 60 * 24 * 30);    // 한달

        //add cookie to response
        response.addCookie(cookie);
    }

    public boolean isAutoLogin(final HttpServletRequest request) {
        Cookie cookie = WebUtils.getCookie(request, CommonCode.LOGIN_AUTO_COOKIE_NAME);
        if (cookie != null) {
            Object object = SerializeUtils.unserializeStringToObject(cookie.getValue());
            AutoLoginVO autoLoginVO = MapperUtils.toObject(object, AutoLoginVO.class);
            autoLoginVO.setAppPassword(AesUtils.decrypt256(autoLoginVO.getAppPassword()));

            MemberVO memberVO = MapperUtils.toObject(autoLoginVO, MemberVO.class);
            this.loginProcess(request, memberVO);

            if (SessionUtils.getMemberVO() != null) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public void resetAppPassword(final MemberVO memberVO) {
        final TableMbrInfoMstVO tableMbrInfoMstVO = MapperUtils.toObject(memberVO, TableMbrInfoMstVO.class);
        final TableMbrInfoMstVO mbrInfoMstVO = this.tableMbrInfoMstDAO.getVO(tableMbrInfoMstVO, Collections.singleton("customerId"));

        SmtpUtils.sendGmail(CommonCode.ADMIN_EMAIL_RECEIVER, SmtpUtils.getResetAppPasswordSubject(), SmtpUtils.getResetAppPasswordTemplate(mbrInfoMstVO));
    }

    @Transactional
    public void directLoginProcess(final HttpServletRequest request, final MemberVO vo) {
        TableMbrInfoMstVO tableMbrInfoMstVO = MapperUtils.toObject(vo, TableMbrInfoMstVO.class);
        tableMbrInfoMstVO.setMemberSt(CommonCode.MEMBER_ST_USED);
        final TableMbrInfoMstVO mbrInfoMstVO = this.tableMbrInfoMstDAO.getVO(tableMbrInfoMstVO, ImmutableSet.of("customerId", "memberSt"));
        // 유저가 없으면
        if (mbrInfoMstVO == null) {
            log.warn(BusinessException.FAIL_NOT_EXIST_MEMBER.getJsonObject().toString());
            throw BusinessException.FAIL_NOT_EXIST_MEMBER;
        }

        // 로그인 히스토리
        final TableMbrLoginHstVO tableMbrLoginHstVO = MapperUtils.toObject(mbrInfoMstVO, TableMbrLoginHstVO.class);
        tableMbrLoginHstVO.setConnIp(ClientUtils.getClientIpAddr(request));
        this.tableMbrLoginHstDAO.insert(tableMbrLoginHstVO);

        final MemberVO memberVO = MapperUtils.toObject(mbrInfoMstVO, MemberVO.class);
        // 세션 저장
        SessionUtils.setMemberVO(memberVO);
        SessionUtils.setAttribute("mode","direct");
    }
}
