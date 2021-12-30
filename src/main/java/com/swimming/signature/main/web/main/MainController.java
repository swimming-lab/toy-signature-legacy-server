package com.github.bestheroz.main.web.main;

import com.github.bestheroz.main.web.contract.ContractService;
import com.github.bestheroz.main.web.login.MLoginService;
import com.github.bestheroz.standard.common.util.SessionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

@Controller
public class MainController {
    @Resource MLoginService mLoginService;
    @Resource ContractService contractService;
    private final String prefix = "/main";

    /**
     * 메인
     * @return
     */
    @GetMapping(value = {"/main/main.view"})
    public ModelAndView mainView() {
        ModelAndView mav = new ModelAndView();
        mav.addObject("memberVO", SessionUtils.getMemberVO());
        mav.setViewName(prefix + "/main/main");
        mav.addObject("isChecked", SessionUtils.getAttributeObject("isChecked"));
        //버전 조회
        mav.addObject("appVersion",contractService.selectVersion());

        //다이렉트 로그인일 경우 메인 접근 시 로그인 페이지 이동
        if("direct".equals(SessionUtils.getAttribute("mode"))){
            mav.setViewName(prefix + "/login/main");
        }


        return mav;
    }

    @GetMapping(value = {"/main/test.view"})
    public String testView() {
        // 메인페이지 이동
        return prefix + "/main/test";
    }
}
