package com.github.bestheroz.main.web.contract;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class ContractVO implements Serializable {
    private static final long serialVersionUID = 8300621111265295274L;

    // mbr_contract_mst
    private Integer         contractNo;         //'계약번호'
    private Integer         contractId;         //'계약서ID'
    private Integer         customerId;         //'회원ID'
    private Integer         equipCd;            //'보유장비코드'
    private String          equipModel;         //'보유장비모델'
    private String          registNo;           //'등록번호'
    private String          insuranceYn;        //'보험가입여부'
    private String          routineYn;          //'정기검사여부'
    private String          workNm;             //'현장명'
    private String          workLocNm;          //'현장소재지'
    private String          issuerNm;           //'발급자'
    private String          builderNm;          //'건설업자'
    private String          workDy;             //'계약및작업일'
    private String          workStartTime;      //'작업시작시간'
    private String          workEndTime;        //'작업종료시간'
    private Integer         useAmt;             //'사용금액'
    private String          workConts;          //'작업내용'
    private Integer         paydayOverNo;       //'지급일기준_초과'
    private Integer         paydayInNo;         //'지급일기준_이내'
    private String          agentNm;            //'대리인이름'
    private Integer         contractSt;         //'계약서진행상태(1:작성,2:완료)'
    private Integer         parContractId;      //'상위계약서ID(불러오기)'
    private LocalDateTime   updDt;              //'수정일시'

    // mbr_contract_hire_lst
    private String          bizcoNm;            //'상호'
    private String          bizcoRegNo;         //'사업자등록번호'
    private String          name;               //'성명'
    private String          telNo;              //'회사전화'
    private String          workAgentNm;        //'현장대리인성명'
    private String          workAgentTelNo;     //'현장대리인연락처'
    private String          zipNo;              //'우편번호'
    private String          addrOffice;         //'기본주소'
    private String          addrOfficeDtl;      //'상세주소'

    // com_equip_mst
    private String          equipNm;            //'장비명'

    // mbr_contract_img_hst
    private String          imgPath;            //'계약서 이미지 경로'

    // mbr_contract_send_hst
    private String          mobTelNo;           //'핸드폰번호'

    // mbr_contract_sign_lst
    private String          signature;          //'서명데이터'

    // 검색 파라미터
    private String          search;             //'검색 키워드'
    private Integer         range;              //'검색 범위'
    private Integer         offset;
    private Integer         limit;
}
