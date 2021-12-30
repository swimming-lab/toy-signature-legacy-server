package com.github.bestheroz.main.web.contract;

import com.github.bestheroz.main.web.member.MemberDAO;
import com.github.bestheroz.main.web.tablevo.mbr_contract_hire_lst.TableMbrContractHireLstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_contract_hire_lst.TableMbrContractHireLstVO;
import com.github.bestheroz.main.web.tablevo.mbr_contract_img_hst.TableMbrContractImgHstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_contract_img_hst.TableMbrContractImgHstVO;
import com.github.bestheroz.main.web.tablevo.mbr_contract_mst.TableMbrContractMstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_contract_mst.TableMbrContractMstVO;
import com.github.bestheroz.main.web.tablevo.mbr_contract_send_hst.TableMbrContractSendHstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_contract_send_hst.TableMbrContractSendHstVO;
import com.github.bestheroz.main.web.tablevo.mbr_contract_sign_lst.TableMbrContractSignLstDAO;
import com.github.bestheroz.main.web.tablevo.mbr_contract_sign_lst.TableMbrContractSignLstVO;
import com.github.bestheroz.main.web.tablevo.mbr_info_mst.TableMbrInfoMstDAO;
import com.github.bestheroz.standard.common.constant.CommonCode;
import com.github.bestheroz.standard.common.exception.BusinessException;
import com.github.bestheroz.standard.common.util.DateUtils;
import com.github.bestheroz.standard.common.util.MapperUtils;
import com.github.bestheroz.standard.common.util.SessionUtils;
import com.github.bestheroz.standard.common.util.SmsUtils;
import com.google.common.collect.ImmutableSet;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@Service
@Slf4j
public class ContractService {
    @Resource ContractDAO contractDAO;
    @Resource MemberDAO memberDAO;
    @Resource TableMbrContractMstDAO tableMbrContractMstDAO;
    @Resource TableMbrContractHireLstDAO tableMbrContractHireLstDAO;
    @Resource TableMbrContractSignLstDAO tableMbrContractSignLstDAO;
    @Resource TableMbrContractSendHstDAO tableMbrContractSendHstDAO;
    @Resource TableMbrContractImgHstDAO tableMbrContractImgHstDAO;
    @Resource TableMbrInfoMstDAO tableMbrInfoMstDAO;


    @Transactional
    public int insertForm(final ContractVO contractVO) {
        // 기초 데이터 셋팅
        final int contractId = 1;   // 계약서 코드 하드코딩, TODO com_contract_mst 에서 조회하기
        final int contractSt = CommonCode.CONTRACT_ST_ING;
        final int customerId = SessionUtils.getCustomerId();

        contractVO.setContractId(contractId);
        contractVO.setContractSt(contractSt);
        contractVO.setCustomerId(customerId);
        contractVO.setParContractId(contractId);

        final TableMbrContractMstVO tableMbrContractMstVO = MapperUtils.toObject(contractVO, TableMbrContractMstVO.class);
        final TableMbrContractHireLstVO tableMbrContractHireLstVO = MapperUtils.toObject(contractVO, TableMbrContractHireLstVO.class);
        final TableMbrContractSignLstVO tableMbrContractSignLstVO = MapperUtils.toObject(contractVO, TableMbrContractSignLstVO.class);

        // 쿼리 실행
        this.tableMbrContractMstDAO.insert(tableMbrContractMstVO);
        int contractNo = tableMbrContractMstVO.getContractNo();
        contractVO.setContractNo(contractNo);
        tableMbrContractHireLstVO.setContractNo(contractNo);
        this.tableMbrContractHireLstDAO.insert(tableMbrContractHireLstVO);
        tableMbrContractSignLstVO.setContractNo(contractNo);
        tableMbrContractSignLstVO.setSignatureType(0);
        this.tableMbrContractSignLstDAO.insert(tableMbrContractSignLstVO);

        return contractNo;
    }

    @Transactional
    public int updateForm(final ContractVO contractVO) {
        TableMbrContractMstVO loadContractVO = this.getTableContractVO(contractVO);
        if (loadContractVO == null || loadContractVO.getContractSt() == CommonCode.CONTRACT_ST_DONE) {
            log.error(BusinessException.FAIL_INVALID_PARAMETER.getJsonObject().toString(), contractVO);
            throw BusinessException.FAIL_INVALID_PARAMETER;
        }

        // 기초 데이터 셋팅
        final int customerId = SessionUtils.getCustomerId();
        final int contractNo = loadContractVO.getContractNo();
        final int contractId = loadContractVO.getContractId();
        final int contractSt = CommonCode.CONTRACT_ST_ING;

        contractVO.setContractNo(contractNo);
        contractVO.setCustomerId(customerId);
        contractVO.setContractId(contractId);
        contractVO.setContractSt(contractSt);
        contractVO.setParContractId(contractId);

        final TableMbrContractMstVO tableMbrContractMstVO = MapperUtils.toObject(contractVO, TableMbrContractMstVO.class);
        final TableMbrContractHireLstVO tableMbrContractHireLstVO = MapperUtils.toObject(contractVO, TableMbrContractHireLstVO.class);
        final TableMbrContractSignLstVO tableMbrContractSignLstVO = MapperUtils.toObject(contractVO, TableMbrContractSignLstVO.class);

        // 쿼리 실행
        this.tableMbrContractMstDAO.update(tableMbrContractMstVO, Collections.singleton("contractNo"), null);
        this.tableMbrContractHireLstDAO.update(tableMbrContractHireLstVO, Collections.singleton("contractNo"), null);
        tableMbrContractSignLstVO.setSignatureType(0);
        this.tableMbrContractSignLstDAO.update(tableMbrContractSignLstVO, Collections.singleton("contractNo"), null);

        return contractNo;
    }

    @Transactional
    public int complete(final ContractVO contractVO) {
        ContractVO loadContractVO = this.getContractVO(contractVO);
        if (loadContractVO == null) {
            log.error(BusinessException.FAIL_INVALID_PARAMETER.getJsonObject().toString(), contractVO);
            throw BusinessException.FAIL_INVALID_PARAMETER;
        } else if (loadContractVO.getContractSt() == CommonCode.CONTRACT_ST_DONE) {
            log.error(BusinessException.FAIL_CONTRACT_ALREADY_DONE.getJsonObject().toString(), contractVO);
            throw BusinessException.FAIL_CONTRACT_ALREADY_DONE;
        }

        // 기초 데이터 셋팅
        final int contractSt = CommonCode.CONTRACT_ST_DONE;
        contractVO.setContractSt(contractSt);

        final TableMbrContractMstVO tableMbrContractMstVO = MapperUtils.toObject(contractVO, TableMbrContractMstVO.class);
        final TableMbrContractSendHstVO tableMbrContractSendHstVO = MapperUtils.toObject(contractVO, TableMbrContractSendHstVO.class);

        // 쿼리 실행
        this.tableMbrContractMstDAO.update(tableMbrContractMstVO, Collections.singleton("contractNo"), null);

        // TODO 계약서 이미지 저장
        contractVO.setContractId(loadContractVO.getContractId());
        this.saveContractImagePath(contractVO);

        // sms 임대인 발송
//        SmsUtils.sendSMS(SessionUtils.getMemberVO().getTelNo(), SmsUtils.getContractTemplate(loadContractVO));
        SmsUtils.sendSMS2(SessionUtils.getMemberVO().getTelNo(), SmsUtils.getContractTemplate(loadContractVO), contractVO.getImgPath());
        tableMbrContractSendHstVO.setContractId(loadContractVO.getContractId());
        tableMbrContractSendHstVO.setCustomerId(SessionUtils.getCustomerId());
        tableMbrContractSendHstVO.setSendDt(DateUtils.getLocalDateTimeNow());
        tableMbrContractSendHstVO.setSendTp("1");
        tableMbrContractSendHstVO.setMobTelNo(SessionUtils.getMemberVO().getTelNo());
        this.tableMbrContractSendHstDAO.insert(tableMbrContractSendHstVO);

        // sms 임차인(현장대리인) 발송
//        SmsUtils.sendSMS(loadContractVO.getWorkAgentTelNo(), SmsUtils.getContractTemplate(loadContractVO));
        SmsUtils.sendSMS2(loadContractVO.getWorkAgentTelNo(), SmsUtils.getContractTemplate(loadContractVO), contractVO.getImgPath());
        tableMbrContractSendHstVO.setSendTp("2");
        tableMbrContractSendHstVO.setMobTelNo(loadContractVO.getWorkAgentTelNo());
        this.tableMbrContractSendHstDAO.insert(tableMbrContractSendHstVO);

        return contractVO.getContractNo();
    }

    private TableMbrContractMstVO getTableContractVO(ContractVO contractVO) {
        contractVO.setCustomerId(SessionUtils.getCustomerId());
        final TableMbrContractMstVO tableMbrContractMstVO = MapperUtils.toObject(contractVO, TableMbrContractMstVO.class);
        return this.tableMbrContractMstDAO.getVO(tableMbrContractMstVO, ImmutableSet.of("contractNo", "customerId"));
    }

    @Transactional
    public int addSendSms(final ContractVO contractVO) {
        ContractVO loadContractVO = this.getContractVO(contractVO);
        if (loadContractVO == null) {
            log.error(BusinessException.FAIL_INVALID_PARAMETER.getJsonObject().toString(), contractVO);
            throw BusinessException.FAIL_INVALID_PARAMETER;
        }

        final TableMbrContractSendHstVO tableMbrContractSendHstVO = MapperUtils.toObject(contractVO, TableMbrContractSendHstVO.class);
        int count = this.tableMbrContractSendHstDAO.count(tableMbrContractSendHstVO, ImmutableSet.of("contractNo", "customerId"));
        if (count == 0) {
            log.error(BusinessException.FAIL_INVALID_PARAMETER.getJsonObject().toString(), tableMbrContractSendHstVO);
            throw BusinessException.FAIL_INVALID_PARAMETER;
        }

        // sms 발송
//        SmsUtils.sendSMS(tableMbrContractSendHstVO.getMobTelNo(), SmsUtils.getContractTemplate(loadContractVO));
        SmsUtils.sendSMS2(tableMbrContractSendHstVO.getMobTelNo(), SmsUtils.getContractTemplate(loadContractVO), this.getContractImg(contractVO).getImgPath());

        tableMbrContractSendHstVO.setSendTp(String.valueOf(count+1));
        tableMbrContractSendHstVO.setContractId(loadContractVO.getContractId());
        tableMbrContractSendHstVO.setSendDt(DateUtils.getLocalDateTimeNow());
        this.tableMbrContractSendHstDAO.insert(tableMbrContractSendHstVO);

        return tableMbrContractSendHstVO.getContractNo();
    }

    public List<ContractVO> searchHire(final ContractVO contractVO) {
        contractVO.setCustomerId(SessionUtils.getCustomerId());
        return this.contractDAO.searchHire(contractVO);
    }

    public List<ContractVO> list(final ContractVO contractVO) {
        contractVO.setCustomerId(SessionUtils.getCustomerId());
        return this.contractDAO.list(contractVO);
    }

    public List<ContractVO> excelList(final ContractVO contractVO) {
        contractVO.setCustomerId(SessionUtils.getCustomerId());
        return this.contractDAO.excelList(contractVO);
    }


    public ContractVO getContractVO(final ContractVO contractVO) {
        contractVO.setCustomerId(SessionUtils.getCustomerId());
        return this.contractDAO.info(contractVO);
    }

    public TableMbrContractHireLstVO getContractHireLstVO(final ContractVO contractVO) {
        final TableMbrContractHireLstVO tableMbrContractHireLstVO = MapperUtils.toObject(contractVO, TableMbrContractHireLstVO.class);
        return this.tableMbrContractHireLstDAO.getVO(tableMbrContractHireLstVO, Collections.singleton("contractNo"));
    }

    public TableMbrContractSignLstVO getContractSignLstVO(final ContractVO contractVO) {
        final TableMbrContractSignLstVO tableMbrContractSignLstVO = MapperUtils.toObject(contractVO, TableMbrContractSignLstVO.class);
        return this.tableMbrContractSignLstDAO.getVO(tableMbrContractSignLstVO, Collections.singleton("contractNo"));
    }

    public TableMbrContractImgHstVO getContractImg(final ContractVO contractVO) {
        final TableMbrContractImgHstVO tableMbrContractImgHstVO = MapperUtils.toObject(contractVO, TableMbrContractImgHstVO.class);
        return this.tableMbrContractImgHstDAO.getVO(tableMbrContractImgHstVO, Collections.singleton("contractNo"));
    }

    public List<TableMbrContractSendHstVO> getContractSendHst(final ContractVO contractVO) {
        final TableMbrContractSendHstVO tableMbrContractSendHstVO = MapperUtils.toObject(contractVO, TableMbrContractSendHstVO.class);
        return this.tableMbrContractSendHstDAO.getList(tableMbrContractSendHstVO, Collections.singleton("contractNo"), "SEND_DT ASC");
    }

    private void saveContractImagePath(final ContractVO contractVO) {
        TableMbrContractImgHstVO tableMbrContractImgHstVO = this.getContractImg(contractVO);
        if (tableMbrContractImgHstVO != null) {
            // 테스트 데이터
            tableMbrContractImgHstVO.setImgPath(contractVO.getImgPath());
            this.tableMbrContractImgHstDAO.update(tableMbrContractImgHstVO, Collections.singleton("contractNo"), null);
        } else {
            tableMbrContractImgHstVO = MapperUtils.toObject(contractVO, TableMbrContractImgHstVO.class);
            // 기초 데이터 셋팅
            // 테스트 데이터
            tableMbrContractImgHstVO.setSeq(1);
            tableMbrContractImgHstVO.setImgNm("계약서");
//            tableMbrContractImgHstVO.setImgPath("http://image.kmib.co.kr/online_image/2018/0108/611211110012029154_2.jpg");
            this.tableMbrContractImgHstDAO.insert(tableMbrContractImgHstVO);
        }
    }

    // TODO 이미지 생성인데 지금 안씀, 나중에 사용할지 모름
    private String saveSignatureImage(String signature, HttpServletRequest request) {
        String returnPath = null;
        try {
            String sign = StringUtils.split(signature, ",")[1];
            String fileName = SessionUtils.getCustomerId() + ".png";

            String realPath = request.getServletContext().getRealPath("resources/files/signature/" + fileName);
            String resourcePath = CommonCode.PATH_SIGNATURE + "/" + fileName;

            FileUtils.writeByteArrayToFile(new File(realPath), Base64.decodeBase64(sign));
            returnPath = resourcePath;
        } catch (IOException e) {
            log.error(ExceptionUtils.getStackTrace(e));
        }

        return returnPath;
    }

    public String convertAmt(int amt) {
        String money = String.valueOf(amt);
        String[] han1 = {"", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구"};
        String[] han2 = {"", "십", "백", "천"};
        String[] han3 = {"", "만", "억", "조", "경"};
        StringBuffer result = new StringBuffer();
        int len = money.length();
        for (int i = len - 1; i >= 0; i--) {
            result.append(han1[Integer.parseInt(money.substring(len - i - 1, len - i))]);
            if (Integer.parseInt(money.substring(len - i - 1, len - i)) > 0) {
                result.append(han2[i % 4]);
            }
            if (i % 4 == 0) {
                result.append(han3[i / 4]);
            }
        }
        return result.toString();
    }

    public String compareTime(String start, String end) {
        int hour = 0, min = 0;
        try {
            SimpleDateFormat f = new SimpleDateFormat("HH:mm", Locale.KOREA);
            Date d1 = f.parse(start);
            Date d2 = f.parse(end);
            long diff = d2.getTime() - d1.getTime();
            int sec = (int) (diff / 1000);

            min = sec / 60;
            hour = min / 60;
            min = min % 60;
            //점심시간 제외 시작시간이 13시보다 작고 종료시간이 13시가 넘을 경우 1시간 삭제
            if(d1.getTime() <= 13 && d2.getHours() >= 13 ){
                hour = hour -1;
            }


        } catch (ParseException e) {
            e.printStackTrace();
        }

        return hour + "시간 " + (min > 0 ? min + "" : "");
    }
    @Transactional
    public void contractDel(final int contractNo) {
        this.contractDAO.contractDel(contractNo);
    }
    public String selectVersion() {
        return this.contractDAO.selectVersion();
    }
}
