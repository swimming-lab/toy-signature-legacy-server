package com.github.bestheroz.main.web.tablevo.mbr_contract_mst;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class TableMbrContractMstVO implements Serializable {
    private static final long serialVersionUID = -1316594557905077296L;


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
    private LocalDateTime   regDt;              //'등록일시'
    private Integer         regId;              //'등록자'
    private LocalDateTime   updDt;              //'수정일시'
    private Integer         updId;              //'수정자'
}
