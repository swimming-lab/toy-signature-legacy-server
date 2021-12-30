package com.github.bestheroz.main.web.tablevo.com_code_mst;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class TableComCodeMstVO implements Serializable {
    private static final long serialVersionUID = -1316594557905077296L;


    private String          grpCodeCd;          //'그룹코드'
    private String          codeCd;             //'코드'
    private String          codeNm;             //'코드명'
    private String          useYn;              //'사용여부'
    private LocalDateTime   regDt;              //'등록일시'
    private Integer         regId;              //'등록자'
    private LocalDateTime   updDt;              //'수정일시'
    private Integer         updId;              //'수정자'
}
