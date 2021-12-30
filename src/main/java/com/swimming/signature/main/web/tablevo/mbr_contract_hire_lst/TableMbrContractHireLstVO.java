package com.github.bestheroz.main.web.tablevo.mbr_contract_hire_lst;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class TableMbrContractHireLstVO implements Serializable {
    private static final long serialVersionUID = -1316594557905077296L;


    private Integer         contractNo;         //'계약번호'
    private Integer         contractId;         //'계약서ID'
    private Integer         customerId;         //'회원ID'
    private String          bizcoNm;            //'상호'
    private String          bizcoRegNo;         //'사업자등록번호'
    private String          name;               //'성명'
    private String          telNo;              //'회사전화'
    private String          workAgentNm;        //'현장대리인성명'
    private String          workAgentTelNo;     //'현장대리인연락처'
    private String          zipNo;              //'우편번호'
    private String          addrOffice;         //'기본주소'
    private String          addrOfficeDtl;      //'상세주소'
    private LocalDateTime   regDt;              //'등록일시'
    private Integer         regId;              //'등록자'
    private LocalDateTime   updDt;              //'수정일시'
    private Integer         updId;              //'수정자'
}
