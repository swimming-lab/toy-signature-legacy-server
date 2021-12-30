package com.github.bestheroz.main.web.tablevo.mbr_login_hst;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class TableMbrLoginHstVO implements Serializable {
    private static final long serialVersionUID = -1316594557905077296L;


    private Integer         customerId;         //'회원ID'
    private String          connIp;             //'상호'
    private LocalDateTime   connDt;             //'등록일시'
}
