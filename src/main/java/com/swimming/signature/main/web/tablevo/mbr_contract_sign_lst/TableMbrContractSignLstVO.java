package com.github.bestheroz.main.web.tablevo.mbr_contract_sign_lst;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class TableMbrContractSignLstVO implements Serializable {
    private static final long serialVersionUID = -1316594557905077296L;


    private Integer         contractNo;         //'계약번호'
    private Integer         contractId;         //'계약서ID'
    private Integer         customerId;         //'회원ID'
    private Integer         signatureType;      //'서명구분(10:임대인,20:임차인)'
    private String          signature;          //'서명데이터'
    private LocalDateTime   regDt;              //'등록일시'
    private Integer         regId;              //'등록자'
    private LocalDateTime   updDt;              //'수정일시'
    private Integer         updId;              //'수정자'
}
