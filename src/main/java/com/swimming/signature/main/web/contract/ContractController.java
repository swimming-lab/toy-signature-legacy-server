package com.github.bestheroz.main.web.contract;

import com.github.bestheroz.main.web.equip.EquipService;
import com.github.bestheroz.main.web.equip.EquipVO;
import com.github.bestheroz.main.web.member.MemberService;
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
import javax.mail.Session;
import java.util.List;

@Controller
@Slf4j
public class ContractController {
    @Resource ContractService contractService;
    @Resource EquipService equipService;
    @Resource MemberService memberService;
    private final String prefix = "/main";
    private final String redirect = "redirect:";
    private final String infoUrl = "/contract/info.view";
    private final String listUrl = "/contract/list.view";


    /**
     * 계약서 작성 메인
     * @return
     */
    @GetMapping(value = {"/contract/main.view"})
    public String mainView() {
        return prefix + "/contract/main";
    }

    /**
     * 계약서 관리 리스트
     * @return
     */
    @GetMapping(value = {"/contract/list.view"})
    public ModelAndView listView() {
        ModelAndView mav = new ModelAndView();

        Object isChecked = SessionUtils.getAttributeObject("isChecked");
        if (isChecked != null && (Boolean) isChecked) {
            mav.setViewName(prefix + "/contract/list");
        } else {
            // 게정 패스워드 체크 리다이렉트
            mav.addObject("returnUrl", "/contract/list.view");
            mav.setViewName(redirect + "/member/passwordCheck.view");
        }

        return mav;
    }

    /**
     * 계약서 관리 리스트
     * @return
     */
    @GetMapping(value = {"/contract/load.view"})
    public ModelAndView loadView() {
        ModelAndView mav = new ModelAndView();

        Object isChecked = SessionUtils.getAttributeObject("isChecked");
        if (isChecked != null && (Boolean) isChecked) {
            mav.addObject("formType", CommonCode.FORM_TYPE_NEW_LOAD);
            mav.setViewName(prefix + "/contract/list");
        } else {
            // 게정 패스워드 체크 리다이렉트
            mav.addObject("returnUrl", "/contract/load.view");
            mav.setViewName(redirect + "/member/passwordCheck.view");
        }

        return mav;
    }

    /**
     * 완료된 계약서 보기
     * @param contractVO
     * @return
     */
    @GetMapping(value = {"/contract/readForm.view"})
    public ModelAndView readFormView(final ContractVO contractVO) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName(prefix + "/contract/form");
        SessionUtils.removeAttribute("formType");

        if (contractVO.getContractNo() != null) {
            ContractVO loadContractVO = this.contractService.getContractVO(contractVO);

            if (loadContractVO != null && loadContractVO.getContractSt() == 2) {
                mav.addObject("contractVO", loadContractVO);
                mav.addObject("equipVOList", this.equipService.getEuipVOList());
                mav.addObject("memberVO", SessionUtils.getMemberVO());
                mav.addObject("formType", CommonCode.FORM_TYPE_READ_ONLY);
            } else {
                // 예외사항 > 메인으로 리다이렉트
                mav.setViewName(redirect + "/main/main.view");
            }
        } else {
            // 예외사항 > 메인으로 리다이렉트
            mav.setViewName(redirect + "/main/main.view");
        }

        return mav;
    }

    /**
     * 계약서 수정하기/이어쓰기/뒤로가기
     * @param contractVO
     * @return
     */
    @GetMapping(value = {"/contract/updateForm.view"})
    public ModelAndView updateFormView(final ContractVO contractVO) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName(prefix + "/contract/form");
        SessionUtils.removeAttribute("formType");

        if (contractVO.getContractNo() != null) {
            ContractVO loadContractVO = this.contractService.getContractVO(contractVO);

            if (loadContractVO != null && loadContractVO.getContractSt() == 1) {
                mav.addObject("contractVO", loadContractVO);
                mav.addObject("equipVOList", this.equipService.getEuipVOList());
                mav.addObject("memberVO", SessionUtils.getMemberVO());
                mav.addObject("formType", CommonCode.FORM_TYPE_UPDATE);
                mav.addObject("comEquipMstVO", equipService.getComEuipMstVOList());
                mav.addObject("mode",SessionUtils.getAttribute("mode"));
                SessionUtils.setAttribute("formType", CommonCode.FORM_TYPE_UPDATE);
            } else {
                // 예외사항 > 메인으로 리다이렉트
                mav.setViewName(redirect + "/main/main.view");
            }
        } else {
            // 예외사항 > 메인으로 리다이렉트
            mav.setViewName(redirect + "/main/main.view");
        }

        return mav;
    }

    /**
     * 계약서 새로작성/불러오기
     * @param contractVO
     * @return
     */
    @GetMapping(value = {"/contract/insertForm.view"})
    public ModelAndView insertView(final ContractVO contractVO) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName(prefix + "/contract/form");
        SessionUtils.removeAttribute("formType");

        List<EquipVO> equipVOList = this.equipService.getEuipVOList();
        if (equipVOList.size() == 0) {
            mav.addObject("isEmptyEquip", true);
        }
        mav.addObject("equipVOList", equipVOList);
        mav.addObject("comEquipMstVO", equipService.getComEuipMstVOList());
        mav.addObject("memberVO", SessionUtils.getMemberVO());
        mav.addObject("formType", CommonCode.FORM_TYPE_NEW);
        mav.addObject("mode", SessionUtils.getAttribute("mode"));
        if (contractVO.getContractNo() != null) {
            ContractVO loadContractVO = this.contractService.getContractVO(contractVO);

            if (loadContractVO != null) {
                mav.addObject("contractVO", loadContractVO);
                if (loadContractVO.getContractSt() == CommonCode.CONTRACT_ST_ING) {
                    mav.addObject("formType", CommonCode.FORM_TYPE_UPDATE);
                } else {
                    mav.addObject("formType", CommonCode.FORM_TYPE_NEW_LOAD);
                }
            }
        }

        return mav;
    }

    /**
     * 계약서 화면출력
     * @return
     */
    @GetMapping(value = {"/contract/convertContract.view"})
    public String convertContract() {
        return prefix + "/contract/convertContract";
    }
    /**
     * 약관
     * @return
     */
    @GetMapping(value = {"/contract/terms.view"})
    public String contractTerms() {
        return prefix + "/contract/terms";
    }

    /**
     * 계약서 폼 2단계(이미지)
     * @return
     */
    @GetMapping(value = {"/contract/info.view"})
    public ModelAndView infoView(final ContractVO contractVO) {
        ModelAndView mav = new ModelAndView();

        ContractVO loadContractVO = this.contractService.getContractVO(contractVO);
        if (loadContractVO != null) {
            mav.setViewName(prefix + "/contract/info");
            mav.addObject("contractVO", loadContractVO);
            mav.addObject("memberVO", SessionUtils.getMemberVO());
            if(loadContractVO.getUseAmt()!=null){
                mav.addObject("koAmt", this.contractService.convertAmt(loadContractVO.getUseAmt()));
            }
            mav.addObject("koCompareTime", this.contractService.compareTime(loadContractVO.getWorkStartTime(), loadContractVO.getWorkEndTime()));
            mav.addObject("contractHireVO", this.contractService.getContractHireLstVO(contractVO));
            mav.addObject("contractSignVO", this.contractService.getContractSignLstVO(contractVO));
            //사업자번호 노출여부 조회
            mav.addObject("viewBizcoYn", this.memberService.selectViewBizcoYn(SessionUtils.getCustomerId()));
        } else {
            // 메인으로 리다이렉트
            mav.setViewName(redirect + "/main/main.view");
        }

        return mav;
    }

    @GetMapping(value = {"/contract/sms.view"})
    public ModelAndView smsView(final ContractVO contractVO) {
        ModelAndView mav = new ModelAndView();

        ContractVO loadContractVO = this.contractService.getContractVO(contractVO);
        if (loadContractVO != null) {
            mav.setViewName(prefix + "/contract/sms");
            mav.addObject("contractVO", loadContractVO);
            mav.addObject("contractSendHstVO", this.contractService.getContractSendHst(contractVO));
            mav.addObject("contractImgVO", this.contractService.getContractImg(contractVO));
            mav.addObject("mode", SessionUtils.getAttribute("mode"));
        } else {
            // 메인으로 리다이렉트
            mav.setViewName(redirect + "/main/main.view");
        }

        return mav;
    }

    @PostMapping(value = "/contract/addSendSms.json")
    @ResponseBody
    public JsonObject addSendSms(final ContractVO contractVO) {
        int contractNo = this.contractService.addSendSms(contractVO);

        JsonObject jsonObject = BusinessException.SUCCESS_NORMAL.getJsonObject();
        jsonObject.addProperty("contractNo", contractNo);

        return jsonObject;
    }

    /**
     * 계약서 저장하기
     * @param contractVO
     * @return
     */
    @PostMapping(value = "/contract/formSave.json")
    @ResponseBody
    public JsonObject formSave(final ContractVO contractVO) {
        int contractNo = 0;
        if (contractVO.getContractNo() != null) {
            contractNo = this.contractService.updateForm(contractVO);
        } else {
            contractNo = this.contractService.insertForm(contractVO);
        }

        JsonObject jsonObject = BusinessException.SUCCESS_NORMAL.getJsonObject();
        jsonObject.addProperty("contractNo", contractNo);

        return jsonObject;
    }

    @PostMapping(value = "/contract/complete.json")
    @ResponseBody
    public JsonObject complete(final ContractVO contractVO) {
        int contractNo = 0;
        if (contractVO.getContractNo() != null) {
            contractNo = this.contractService.complete(contractVO);
        } else {
            log.error(BusinessException.FAIL_INVALID_PARAMETER.getJsonObject().toString(), contractVO);
            throw BusinessException.FAIL_INVALID_PARAMETER;
        }

        JsonObject jsonObject = BusinessException.SUCCESS_NORMAL.getJsonObject();
        jsonObject.addProperty("contractNo", contractNo);

        return jsonObject;
    }

    /**
     * 임차인 조회
     * @param contractVO
     * @return
     */
    @PostMapping(value = "/contract/searchHire.json")
    @ResponseBody
    public List<ContractVO> searchHire(final ContractVO contractVO) {
        return this.contractService.searchHire(contractVO);
    }

    /**
     * 계약서 조회
     * @param contractVO
     * @return
     */
    @PostMapping(value = "/contract/list.json")
    @ResponseBody
    public List<ContractVO> list(final ContractVO contractVO) {
        return this.contractService.list(contractVO);
    }

    /**
     * 계약서 삭제
     * @param contractNo
     * @return
     */
    @PostMapping(value = "/contract/del.json")
    @ResponseBody
    public JsonObject contractDel(final int contractNo) {
        this.contractService.contractDel(contractNo);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }
}
