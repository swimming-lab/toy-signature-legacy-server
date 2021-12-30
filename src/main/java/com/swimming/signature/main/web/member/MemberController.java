package com.github.bestheroz.main.web.member;


import com.github.bestheroz.standard.common.exception.BusinessException;
import com.github.bestheroz.standard.common.util.SessionUtils;
import com.google.gson.JsonObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.List;

@Controller
public class MemberController {
    @Resource MemberService memberService;
    private final String redirect = "redirect:";
    private String prefix = "/main";

    @PostMapping(value = "/member/search.json")
    @ResponseBody
    public List<MemberVO> search(final MemberVO memberVO) {
        return this.memberService.search(memberVO);
    }

    /**
     * 회원가입 프로세스
     * @param memberVO
     * @return
     */
    @PostMapping(value = "/login/joinProcess.json")
    @ResponseBody
    public JsonObject joinProcess(final HttpServletRequest request, final MemberVO memberVO) {
        this.memberService.joinProcess(request, memberVO);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }

    @PostMapping(value = "/login/joinProcessTest.json")
    @ResponseBody
    public JsonObject testjoinProcess(HttpServletRequest request) {
        // 모든 key 값들을 반환함
        Enumeration<String> names = request.getParameterNames();
        // 다음 값이 있다면 실행
        while(names.hasMoreElements()) {
            // 다음 값으로 넘어감
            String name = names.nextElement();
            System.out.println(name);
        }
//        Object memberVO = request.getParameter("memberVO[name]");
//        Object memberVO = request.getParameter("memberVO[name]");
//        Object memberVO = request.getParameter("memberVO[name]");
//        Object memberVO = request.getParameter("memberVO[name]");
//        Object memberVO = request.getParameter("memberVO[name]");
//        Object memberVO = request.getParameter("memberVO[name]");
//        Object memberVO = request.getParameter("memberVO[name]");
//        Object memberVO = request.getParameter("memberVO[name]");
//        Object memberVO = request.getParameter("memberVO[name]");
//        Object memberVO = request.getParameter("memberVO[name]");
//        Object memberVO = request.getParameter("memberVO[name]");
//        Object memberVO = request.getParameter("memberVO[name]");


//        Object equipVOList = request.getParameter("equipVOList");
//        final MemberVO amemberVO = MapperUtils.toObject(memberVO, MemberVO.class);
//        final List<EquipVO> aequipVOList = MapperUtils.toArrayList(equipVOList, EquipVO.class);


//        this.memberService.joinProcess(memberVO);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }

    @GetMapping(value = "/member/mypage.view")
    public ModelAndView mypageView() {
        ModelAndView mav = new ModelAndView();

        Object isChecked = SessionUtils.getAttributeObject("isChecked");
        if (isChecked != null && (Boolean) isChecked) {
            mav.addObject("memberVO", SessionUtils.getMemberVO());
            //사업자번호 노출여부 항목 조회
            mav.addObject("viewBizcoYn", this.memberService.selectViewBizcoYn(SessionUtils.getCustomerId()));
            mav.setViewName(prefix + "/member/mypage");
        } else {
            // 게정 패스워드 체크 리다이렉트
            mav.addObject("returnUrl", "/member/mypage.view");
            mav.setViewName(redirect + "/member/passwordCheck.view");
        }

        return mav;
    }

    @PostMapping(value = "/member/update.json")
    @ResponseBody
    public JsonObject update(final MemberVO memberVO) {
        this.memberService.update(memberVO);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }

    @PostMapping(value = "/member/updatePassword.json")
    @ResponseBody
    public JsonObject updatePassword(final MemberVO memberVO) {
        this.memberService.updatePassword(memberVO);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }

    /**
     * 패스워드 체크 페이지
     * @return
     */
    @GetMapping(value = {"/member/passwordCheck.view"})
    public ModelAndView passwordCheckView(final String returnUrl) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName(prefix + "/member/passwordCheck");
        mav.addObject("returnUrl", returnUrl);

        return mav;
    }

    /**
     * 패스워드 체크 응답
     * @param memberVO
     * @return
     */
    @PostMapping(value = "/member/passwordCheck.json")
    @ResponseBody
    public JsonObject check(final MemberVO memberVO) {
        this.memberService.check(memberVO);

        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }

    /**
     * 맴버 패스워드 초기화 요청
     * @return
     */
    @PostMapping(value = "/member/resetMemberPassword.json")
    @ResponseBody
    public JsonObject resetMemberPassword() {
        this.memberService.resetMemberPassword();

        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }
}
