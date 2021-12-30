package com.github.bestheroz.main.web.tablevo.admin_mbr_mst;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class TableAdminMbrMstVO implements Serializable {
    private static final long serialVersionUID = -1316594557905077296L;


    private Integer         customerId;         //'회원ID'
    private Integer         adminTp;            //'권한등급(0:관리자,1:운영자)'
    private String          useYn;              //'사용여부'
    private LocalDateTime   regDt;              //'등록일시'
    private Integer         regId;              //'등록자'
    private LocalDateTime   updDt;              //'수정일시'
    private Integer         updId;              //'수정자'
}
