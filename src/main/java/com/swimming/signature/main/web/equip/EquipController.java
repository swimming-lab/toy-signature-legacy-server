package com.github.bestheroz.main.web.equip;


import com.github.bestheroz.standard.common.exception.BusinessException;
import com.github.bestheroz.standard.common.util.SessionUtils;
import com.google.gson.JsonObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class EquipController {
    @Resource EquipService equipService;
    private final String redirect = "redirect:";
    private String prefix = "/main";

    @PostMapping(value = "/equip/list.json")
    @ResponseBody
    public List<EquipVO> list() {
        return this.equipService.getEuipVOList();
    }

    @GetMapping(value = "/equip/list.view")
    public ModelAndView listView(final String mode) {
        ModelAndView mav = new ModelAndView();

//        Object isChecked = SessionUtils.getAttributeObject("isChecked");
//        if (isChecked != null && (Boolean) isChecked) {
            mav.addObject("memberVO", SessionUtils.getMemberVO());
            mav.addObject("comEquipMstVO", equipService.getComEuipMstVOList());
            mav.setViewName(prefix + "/equip/list");
//        } else {
//             게정 패스워드 체크 리다이렉트
//            mav.addObject("returnUrl", "/equip/list.view");
//            mav.setViewName(redirect + "/member/passwordCheck.view");
//        }

        return mav;
    }

    @PostMapping(value = "/equip/insert.json")
    @ResponseBody
    public JsonObject insert(final EquipVO equipVO) {
        int seq = this.equipService.insert(equipVO);

        JsonObject jsonObject = BusinessException.SUCCESS_NORMAL.getJsonObject();
        jsonObject.addProperty("seq", seq);

        return jsonObject;
    }

    @PostMapping(value = "/equip/update.json")
    @ResponseBody
    public JsonObject update(final EquipVO equipVO) {
        this.equipService.update(equipVO);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }

    @PostMapping(value = "/equip/remove.json")
    @ResponseBody
    public JsonObject remove(final EquipVO equipVO) {
        this.equipService.remove(equipVO);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }
}
