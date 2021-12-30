package com.github.bestheroz.main.web.tablevo.mbr_contract_img_hst;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class TableMbrContractImgHstVO implements Serializable {
    private static final long serialVersionUID = -1316594557905077296L;


    private Integer         contractNo;         //'계약번호'
    private Integer         contractId;         //'계약서ID'
    private Integer         customerId;         //'회원ID'
    private Integer         seq;                //'순번'
    private String          imgPath;            //'이미지경로'
    private String          imgNm;              //'이미지명'
    private LocalDateTime   regDt;              //'등록일시'
    private Integer         regId;              //'등록자'
    private LocalDateTime   updDt;              //'수정일시'
    private Integer         updId;              //'수정자'
}
