package com.github.bestheroz.standard.common.util;

import com.github.bestheroz.main.web.member.MemberVO;
import com.github.bestheroz.sample.web.login.LoginVO;
import com.github.bestheroz.standard.common.exception.BusinessException;
import com.google.gson.JsonObject;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.util.Enumeration;

@Slf4j
public class SessionUtils {
    public static final String SESSION_VALUE_OF_LOGIN_VO = "loginVO";
    public static final String SESSION_VALUE_OF_MEMBER_VO = "memberVO";

    private static final Logger LOGGER = LoggerFactory.getLogger(SessionUtils.class);

    protected SessionUtils() {
        throw new UnsupportedOperationException();
    }

    public static HttpSession getSession() {
        final ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        return attr.getRequest().getSession();
    }

    public static boolean isLoggedIn() {
        return getSession().getAttribute(SESSION_VALUE_OF_LOGIN_VO) != null;
    }

    public static boolean isNotLoggedIn() {
        return !isLoggedIn();
    }

    public static LoginVO getLoginVO() {
        try {
            final LoginVO loginVO = (LoginVO) getSession().getAttribute(SESSION_VALUE_OF_LOGIN_VO);
            if (loginVO == null) {
                log.warn(BusinessException.FAIL_TRY_LOGIN_FIRST.toString());
                throw BusinessException.FAIL_TRY_LOGIN_FIRST;
            }
            return loginVO;
        } catch (final Throwable e) {
            LOGGER.warn(ExceptionUtils.getStackTrace(e));
            throw e;
        }
    }

    public static void setLoginVO(final LoginVO loginVO) {
        getSession().setAttribute(SESSION_VALUE_OF_LOGIN_VO, loginVO);
        getSession().setAttribute("memberId", loginVO.getMemberId());
        getSession().setAttribute("memberName", loginVO.getMemberName());
    }

    public static String getMemberId() {
        try {
            final String memberId = (String) getSession().getAttribute("memberId");
            if (memberId == null) {
                log.warn(BusinessException.FAIL_TRY_LOGIN_FIRST.toString());
                throw BusinessException.FAIL_TRY_LOGIN_FIRST;
            }
            return memberId;
        } catch (final Throwable e) {
            LOGGER.warn(ExceptionUtils.getStackTrace(e));
            throw e;
        }
    }

    public static void logout() {
        getSession().invalidate();
    }

    public static boolean hasAttribute(final String name) {
        try {
            return getSession().getAttribute(name) != null;
        } catch (final Throwable e) {
            LOGGER.warn(ExceptionUtils.getStackTrace(e));
            return false;
        }
    }

    public static String getAttribute(final String name) {
        try {
            return (String) getSession().getAttribute(name);
        } catch (final Throwable e) {
            LOGGER.warn(ExceptionUtils.getStackTrace(e));
            return null;
        }
    }

    public static void setAttribute(final String name, final Object value) {
        getSession().setAttribute(name, value);
    }

    public static Integer getAttributeInteger(final String name) {
        try {
            return (Integer) getSession().getAttribute(name);
        } catch (final Throwable e) {
            LOGGER.warn(ExceptionUtils.getStackTrace(e));
            return null;
        }
    }

    public static Object getAttributeObject(final String name) {
        try {
            return getSession().getAttribute(name);
        } catch (final Throwable e) {
            LOGGER.warn(ExceptionUtils.getStackTrace(e));
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    public static <T> T getAttributeObject(final String name, final Class<T> returnType) {
        try {
            return (T) getSession().getAttribute(name);
        } catch (final Throwable e) {
            LOGGER.warn(ExceptionUtils.getStackTrace(e));
            return null;
        }
    }

    public static void removeAttribute(final String name) {
        getSession().removeAttribute(name);
    }

    public static void printAttributeList() {
        final JsonObject result = new JsonObject();
        try {
            for (final Enumeration<String> attributeNames = getSession().getAttributeNames();
                 attributeNames.hasMoreElements(); ) {
                final String nextElement = attributeNames.nextElement();
                result.addProperty(nextElement, MapperUtils.toString(getSession().getAttribute(nextElement)));
            }
            LOGGER.debug(result.toString());
        } catch (final Throwable e) {
            LOGGER.warn(ExceptionUtils.getStackTrace(e));
        }
    }

    public static JsonObject getAttributeJson(final HttpSession session) {
        final JsonObject result = new JsonObject();
        try {
            for (final Enumeration<String> attributeNames = session.getAttributeNames();
                 attributeNames.hasMoreElements(); ) {
                final String nextElement = attributeNames.nextElement();
                result.addProperty(nextElement, MapperUtils.toString(session.getAttribute(nextElement)));
            }
        } catch (final Throwable e) {
            LOGGER.warn(ExceptionUtils.getStackTrace(e));
        }
        return result;
    }

    /**
     * 메인프로젝트 세션유틸 추가 start
     */
    public static MemberVO getMemberVO() {
        try {
            final MemberVO memberVO = (MemberVO) getSession().getAttribute(SESSION_VALUE_OF_MEMBER_VO);
            if (memberVO == null) {
                log.warn(BusinessException.FAIL_TRY_LOGIN_FIRST.toString());
                throw BusinessException.FAIL_TRY_LOGIN_FIRST;
            }
            return memberVO;
        } catch (final Throwable e) {
            LOGGER.warn(ExceptionUtils.getStackTrace(e));
            throw e;
        }
    }

    public static void setMemberVO(final MemberVO memberVO) {
        getSession().setAttribute(SESSION_VALUE_OF_MEMBER_VO, memberVO);
        getSession().setAttribute("memberId", memberVO.getCustomerId());
        getSession().setAttribute("memberName", memberVO.getName());
    }

    public static boolean isMemberLoggedIn() {
        return getSession().getAttribute(SESSION_VALUE_OF_MEMBER_VO) != null;
    }

    public static boolean isNotMemberLoggedIn() {
        return !isMemberLoggedIn();
    }

    public static Integer getCustomerId() {
        try {
            final Integer memberId = (Integer) getSession().getAttribute("memberId");
            if (memberId == null) {
                log.warn(BusinessException.FAIL_TRY_LOGIN_FIRST.toString());
                throw BusinessException.FAIL_TRY_LOGIN_FIRST;
            }
            return memberId;
        } catch (final Throwable e) {
            LOGGER.warn(ExceptionUtils.getStackTrace(e));
            throw e;
        }
    }
    /**
     * 메인프로젝트 로그인 멤버 추가 end
     */
}
