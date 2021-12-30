package com.github.bestheroz.main.web.admin;

import com.github.bestheroz.main.web.arrears.ArrearsVO;
import com.github.bestheroz.main.web.member.MemberVO;
import com.github.bestheroz.standard.common.constant.CommonCode;
import com.github.bestheroz.standard.common.exception.BusinessException;
import com.github.bestheroz.standard.common.util.SessionUtils;
import com.google.gson.JsonObject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

@Controller
@Slf4j
public class AdminController {
    @Resource AdminService adminService;
    private final String prefix = "/main";
    private final String redirect = "redirect:";

    /**
     * 회원관리
     */
    @GetMapping(value = {"/admin/member.view"})
    public ModelAndView adminMember(final AdminVO adminVO) {
        ModelAndView mav = new ModelAndView();

        if (SessionUtils.getMemberVO().getAdminTp() != null) {
            Object isChecked = SessionUtils.getAttributeObject("isChecked");
            if (isChecked != null && (Boolean) isChecked) {
                mav.setViewName(prefix + "/admin/member");
            } else {
                // 게정 패스워드 체크 리다이렉트
                mav.addObject("returnUrl", "/admin/member.view");
                mav.setViewName(redirect + "/member/passwordCheck.view");
            }
        } else {
            mav.setViewName(redirect + "/main/main.view");
        }

        return mav;
    }

    @PostMapping(value = "/admin/memberList.json")
    @ResponseBody
    public List<MemberVO> adminMemberList(final AdminVO adminVO) {
        return this.adminService.getMemberVOList(adminVO);
    }

    @GetMapping(value = {"/admin/memberInfo.view"})
    public ModelAndView adminMemberInfo(final MemberVO memberVO) {
        ModelAndView mav = new ModelAndView();

        if (SessionUtils.getMemberVO().getAdminTp() != null) {
            mav.addObject("memberVO", this.adminService.getMemberVO(memberVO));
            mav.addObject("isAdmin", true);
            mav.setViewName(prefix + "/member/mypage");
        } else {
            mav.setViewName(redirect + "/main/main.view");
        }

        return mav;
    }

    @PostMapping(value = "/admin/removeMember.json")
    @ResponseBody
    public JsonObject adminRemoveMember(final MemberVO memberVO) {
        this.adminService.removeMember(memberVO);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }

    /**
     * 채불신고 관리
     */
    @GetMapping(value = {"/admin/arrears.view"})
    public ModelAndView adminArrears(final AdminVO adminVO) {
        ModelAndView mav = new ModelAndView();

        if (SessionUtils.getMemberVO().getAdminTp() != null) {
            Object isChecked = SessionUtils.getAttributeObject("isChecked");
            if (isChecked != null && (Boolean) isChecked) {
                mav.setViewName(prefix + "/admin/arrears");
            } else {
                // 게정 패스워드 체크 리다이렉트
                mav.addObject("returnUrl", "/admin/arrears.view");
                mav.setViewName(redirect + "/member/passwordCheck.view");
            }
        } else {
            mav.setViewName(redirect + "/main/main.view");
        }

        return mav;
    }

    @PostMapping(value = "/admin/arrearsList.json")
    @ResponseBody
    public List<ArrearsVO> adminArrearsList(final AdminVO adminVO) {
        return this.adminService.getArrearsVOList(adminVO);
    }

    @PostMapping(value = "/admin/confirmArrears.json")
    @ResponseBody
    public JsonObject adminConfirmArrears(final ArrearsVO arrearsVO) {
        this.adminService.setArrearsProcSt(arrearsVO, CommonCode.ARREARS_ST_CONFIRM);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }

    @PostMapping(value = "/admin/rejectArrears.json")
    @ResponseBody
    public JsonObject adminRejectArrears(final ArrearsVO arrearsVO) {
        this.adminService.setArrearsProcSt(arrearsVO, CommonCode.ARREARS_ST_REJECT);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }
}
