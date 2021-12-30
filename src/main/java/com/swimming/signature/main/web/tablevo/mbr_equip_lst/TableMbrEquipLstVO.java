package com.github.bestheroz.main.web.tablevo.mbr_equip_lst;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class TableMbrEquipLstVO implements Serializable {
    private static final long serialVersionUID = -1316594557905077296L;

    private Integer         customerId;         //'회원ID'
    private Integer         equipCd;            //'보유장비코드'
    private String          equipModel;         //'보유장비모델'
    private Integer         seq;                //'순번'
    private String          registNo;           //'차량번호'
    private String          insuranceYn;        //'보험가입여부'
    private String          routineYn;          //'정기검사여부'
    private LocalDateTime   regDt;              //'등록일시'
    private Integer         regId;              //'등록자'
    private LocalDateTime   updDt;              //'수정일시'
    private Integer         updId;              //'수정자'
}
