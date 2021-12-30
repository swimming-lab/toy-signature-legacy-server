package com.github.bestheroz.main.web.login;

import com.github.bestheroz.main.web.contract.ContractService;
import com.github.bestheroz.main.web.equip.EquipService;
import com.github.bestheroz.main.web.member.MemberVO;
import com.github.bestheroz.standard.common.constant.CommonCode;
import com.github.bestheroz.standard.common.exception.BusinessException;
import com.github.bestheroz.standard.common.util.SessionUtils;
import com.google.gson.JsonObject;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class MLoginController {
    @Resource MLoginService mLoginService;
    @Resource ContractService contractService;
    @Resource EquipService equipService;

    private final String prefix = "/main";
    private final String redirect = "redirect:";

    /**
     * 로그인 메인
     * @return
     */
    @GetMapping(value = {"/", "/login/main.view"})

    public ModelAndView mainView(Device device, final HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
//        Device deviceFromRequest = DeviceUtils.getCurrentDevice(request);
//        System.out.println("device: " + device);
//        System.out.println("device form request: " + deviceFromRequest);
//        System.out.println("device platform: " + device.getDevicePlatform());
        // PC 일 경우 PC 페이지로 이동
        if (device.isNormal()) {
            mav.setViewName(redirect + "/pc/login/main.view");
            return mav;
        }

        // 자동로그인
        if (this.mLoginService.isAutoLogin(request)) {
            mav.setViewName(redirect + "/main/main.view");
            return mav;
        } else {
            // 세션 초기화
            SessionUtils.logout();
            //버전 조회
            mav.addObject("appVersion",contractService.selectVersion());
            mav.setViewName(prefix + "/login/main");
            return mav;
        }
    }

    /**
     * 임대인 조회 페이지
     * @return
     */
    @GetMapping(value = "/login/search.view")
    public ModelAndView lesseeView(final String mode) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("mode",mode);
        mav.setViewName(prefix + "/login/search");

        return mav;
    }

    /**
     * 앱 패스워드 입력 페이지
     * @param customerId
     * @return
     */
    @GetMapping(value = "/login/login.view")
    public ModelAndView loginView(final String customerId) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName(prefix + "/login/login");
        mav.addObject("customerId", customerId);

        return mav;
    }

    /**
     * 외부장비 직접입력 시 패스워드 없이 로그인 처리
     * @param request
     * @param memberVO
     * @return
     */
    @GetMapping(value = "/login/direct.view")
    public ModelAndView loginView(final HttpServletRequest request, final MemberVO memberVO) {
        ModelAndView mav = new ModelAndView();
        this.mLoginService.directLoginProcess(request,memberVO);
        mav.addObject("comEquipMstVO", equipService.getComEuipMstVOList());
        mav.addObject("memberVO", SessionUtils.getMemberVO());
        mav.addObject("formType", CommonCode.FORM_TYPE_NEW);
        mav.addObject("mode","direct");
        mav.setViewName(prefix + "/contract/form");
        return mav;
    }

    /**
     * 로그인 처리 프로세스
     * @param memberVO
     * @return
     */
    @PostMapping(value = "/login/loginProcess.json")
    @ResponseBody
    public JsonObject loginProcess(final HttpServletRequest request, final HttpServletResponse response, final MemberVO memberVO) {
        this.mLoginService.loginProcess(request, memberVO);
        this.mLoginService.setAutoLogin(response);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }

    /**
     * 임대인 약관동의
     * @return
     */
    @GetMapping(value = "/login/agreement.view")
    public String agreementView() {
        return prefix + "/login/agreement";
    }

    /**
     * 임대인 회원가입
     * @return
     */
    @GetMapping(value = "/login/join.view")
    public String joinView() {
        return prefix + "/login/join";
    }

    /**
     * 로그아웃
     * @return
     */
    @GetMapping(value = "/login/logout.view")
    public ModelAndView logoutView(final HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        SessionUtils.logout();

        mav.setViewName(redirect + "/login/main.view");

        return mav;
    }

    /**
     * 앱 로그인 패스워드 초기화 요청
     * @param memberVO
     * @return
     */
    @PostMapping(value = "/login/resetAppPassword.json")
    @ResponseBody
    public JsonObject resetMemberPassword(final MemberVO memberVO) {
        this.mLoginService.resetAppPassword(memberVO);

        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }
}
