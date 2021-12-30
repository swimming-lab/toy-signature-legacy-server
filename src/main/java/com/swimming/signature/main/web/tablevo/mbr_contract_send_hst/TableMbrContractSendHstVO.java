package com.github.bestheroz.main.web.tablevo.mbr_contract_send_hst;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class TableMbrContractSendHstVO implements Serializable {
    private static final long serialVersionUID = -1316594557905077296L;


    private Integer         contractNo;         //'계약번호'
    private Integer         contractId;         //'계약서ID'
    private Integer         customerId;         //'회원ID'
    private String          sendTp;             //'구분(1:임대인,2:임차인,3:추가1,4:추가2,5:추가3)'
    private String          mobTelNo;           //'핸드폰번호'
    private LocalDateTime   sendDt;             //'발송일시'
}
