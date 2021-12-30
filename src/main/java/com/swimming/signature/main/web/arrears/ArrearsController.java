package com.github.bestheroz.main.web.arrears;

import com.github.bestheroz.main.web.tablevo.mbr_arrears_lst.TableMbrArrearsLstVO;
import com.github.bestheroz.standard.common.constant.CommonCode;
import com.github.bestheroz.standard.common.exception.BusinessException;
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
public class ArrearsController {
    @Resource ArrearsService arrearsService;
    private final String prefix = "/main";
    private final String redirect = "redirect:";


    @GetMapping(value = {"/arrears/form.view"})
    public ModelAndView formView(final ArrearsVO arrearsVO) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName(prefix + "/arrears/form");

        if (arrearsVO.getArrearsId() != null) {
            TableMbrArrearsLstVO loadArrearsVO = this.arrearsService.getArrearsVO(arrearsVO);

            if (loadArrearsVO != null) {
                mav.addObject("arrearsVO", loadArrearsVO);
                mav.addObject("formType", CommonCode.ARREARS_FORM_TYPE_UPDATE);
            } else {
                mav.addObject("formType", CommonCode.ARREARS_FORM_TYPE_NEW);
            }
        } else {
            mav.addObject("formType", CommonCode.ARREARS_FORM_TYPE_NEW);
        }

        return mav;
    }

    @PostMapping(value = "/arrears/save.json")
    @ResponseBody
    public JsonObject saveForm(final ArrearsVO arrearsVO) {
        if (arrearsVO.getArrearsId() != null) {
            this.arrearsService.updateForm(arrearsVO);
        } else {
            int arrearsId = this.arrearsService.insertForm(arrearsVO);
            this.arrearsService.sendEmail(arrearsId);
        }

        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }

    @PostMapping(value = "/arrears/remove.json")
    @ResponseBody
    public JsonObject remove(final ArrearsVO arrearsVO) {
        this.arrearsService.remove(arrearsVO);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }

    @GetMapping(value = {"/arrears/list.view"})
    public ModelAndView listView() {
        ModelAndView mav = new ModelAndView();
//        Object isChecked = SessionUtils.getAttributeObject("isChecked");
//        if (isChecked != null && (Boolean) isChecked) {
            mav.setViewName(prefix + "/arrears/list");
//        } else {
//            // 계약서 패스워드 체크 리다이렉트
//            mav.setViewName(redirect + "/arrears/check.view");
//        }

        return mav;
    }

    @PostMapping(value = "/arrears/list.json")
    @ResponseBody
    public List<ArrearsVO> list(final ArrearsVO arrearsVO) {
        return this.arrearsService.list(arrearsVO);
    }
}
