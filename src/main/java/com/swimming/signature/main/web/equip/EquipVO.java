package com.github.bestheroz.main.web.equip;

import lombok.Data;

import java.io.Serializable;


@Data
public class EquipVO implements Serializable {
    private static final long serialVersionUID = 8300621111265295274L;

    // equip
    private Integer         customerId;         //'회원ID'
    private Integer         equipCd;            //'보유장비코드'
    private String          equipModel;         //'보유장비모델'
    private String          equipNm;            //'장비명'
    private Integer         seq;                //'순번'
    private String          registNo;           //'등록번호'
    private String          insuranceYn;        //'보험가입여부'
    private String          routineYn;          //'정기검사여부'
}
