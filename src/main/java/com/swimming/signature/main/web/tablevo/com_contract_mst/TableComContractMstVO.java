package com.github.bestheroz.main.web.tablevo.com_contract_mst;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class TableComContractMstVO implements Serializable {
    private static final long serialVersionUID = -1316594557905077296L;

    private Integer         contractId;         //'계약서ID'
    private String          contractNm;         //'계약서명'
    private String          useYn;              //'사용여부'
    private LocalDateTime   regDt;              //'등록일시'
    private Integer         regId;              //'등록자'
    private LocalDateTime   updDt;              //'수정일시'
    private Integer         updId;              //'수정자'
}
