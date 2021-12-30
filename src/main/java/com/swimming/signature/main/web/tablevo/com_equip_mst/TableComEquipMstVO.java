package com.github.bestheroz.main.web.tablevo.com_equip_mst;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class TableComEquipMstVO implements Serializable {
    private static final long serialVersionUID = -1316594557905077296L;


    private Integer         equipCd;            //'보유장비코드'
    private String          equipModel;         //'보유장비모델'
    private String          equipNm;            //'장비명'
    private LocalDateTime   regDt;              //'등록일시'
    private Integer         regId;              //'등록자'
    private LocalDateTime   updDt;              //'수정일시'
    private Integer         updId;              //'수정자'
}
