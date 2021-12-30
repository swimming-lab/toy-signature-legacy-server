package com.github.bestheroz.main.web.pc;

import com.github.bestheroz.main.web.contract.ContractService;
import com.github.bestheroz.main.web.contract.ContractVO;
import com.github.bestheroz.main.web.login.MLoginService;
import com.github.bestheroz.main.web.member.MemberVO;
import com.github.bestheroz.standard.common.exception.BusinessException;
import com.github.bestheroz.standard.common.file.excel.ExcelService;
import com.github.bestheroz.standard.common.file.excel.ExcelVO;
import com.github.bestheroz.standard.common.util.SessionUtils;
import com.github.bestheroz.standard.context.abstractview.AbstractExcelXView;
import com.google.gson.JsonObject;
import org.springframework.mobile.device.Device;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
public class PcController {
    @Resource MLoginService mLoginService;
    @Resource PcService pcService;
    @Resource ContractService contractService;

    private final String prefix = "/main";
    private final String redirect = "redirect:";

    /**
     * 로그인 메인
     * @return
     */
    @GetMapping(value = {"/pc/login/main.view"})
    public String mainView(Device device, final HttpServletRequest request) {
        // 자동로그인
//        if (this.mLoginService.isAutoLogin(request)) {
//            return redirect + "/pc/main/main.view";
//        } else {
            // 세션 초기화
            SessionUtils.logout();
            // 로그인 메인페이지 이동
            return prefix + "/pc/loginMain";
//        }
    }

    /**
     * 임대인 조회 페이지
     * @return
     */
    @GetMapping(value = "/pc/login/search.view")
    public ModelAndView lesseeView(final String mode) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("mode",mode);
        mav.setViewName(prefix + "/pc/loginSearch");

        return mav;
    }

    /**
     * 관리 패스워드 입력 페이지
     * @param customerId
     * @return
     */
    @GetMapping(value = "/pc/login/password.view")
    public ModelAndView loginView(final String customerId) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName(prefix + "/pc/loginPassword");
        mav.addObject("customerId", customerId);

        return mav;
    }

    /**
     * 로그인 처리 프로세스
     * @param memberVO
     * @return
     */
    @PostMapping(value = "/pc/login/password.json")
    @ResponseBody
    public JsonObject loginProcess(final HttpServletRequest request, final HttpServletResponse response, final MemberVO memberVO) {
        this.pcService.loginProcess(request, memberVO);
        this.mLoginService.setAutoLogin(response);
        return BusinessException.SUCCESS_NORMAL.getJsonObject();
    }

    /**
     * 계약서 관리 리스트
     * @return
     */
    @GetMapping(value = {"/pc/main/contractList.view"})
    public ModelAndView listView() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName(prefix + "/pc/contractList");

        return mav;
    }

    @PostMapping(value = "/pc/main/contractList.xlsx", produces = "application/vnd.ms-excel")
    public String getContractListExcel(final Model model, final ContractVO contractVO) {
        model.addAttribute(AbstractExcelXView.FILE_NAME, "메뉴리스트");

        final List<ExcelVO> excelVOList = new ArrayList<>();
        AbstractExcelXView.addHeader(excelVOList, "계약서번호", "contractNo", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "equip_model", "equipModel", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "regist_no", "registNo", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "insurance_yn", "insuranceYn", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "routine_yn", "routineYn", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "work_nm", "workNm", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "work_loc_nm", "workLocNm", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "issuer_nm", "issuerNm", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "builder_nm", "builderNm", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "work_dy", "workDy", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "work_start_time", "workStartTime", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "work_end_time", "workEndTime", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "use_amt", "useAmt", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "work_conts", "workConts", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "payday_over_no", "paydayOverNo", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "payday_in_no", "paydayInNo", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "agent_nm", "agentNm", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "contract_st", "contractSt", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "reg_dt", "regDt", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "reg_id", "regId", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "upd_dt", "updDt", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "upd_id", "updId", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "bizco_nm", "bizcoNm", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "bizco_reg_no", "bizcoRegNo", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "name", "name", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "tel_no", "telNo", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "work_agent_nm", "workAgentNm", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "work_agent_tel_no", "workAgentTelNo", ExcelService.CellType.STRING_CENTER);
        AbstractExcelXView.addHeader(excelVOList, "equip_nm", "equipNm", ExcelService.CellType.STRING_CENTER);

        model.addAttribute(AbstractExcelXView.EXCEL_VOS, excelVOList);

        model.addAttribute(AbstractExcelXView.LIST_DATA, this.contractService.excelList(contractVO));

        return ExcelService.VIEW_NAME;
    }
}
