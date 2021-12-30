package com.github.bestheroz.main.web.tablevo.mbr_arrears_lst;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class TableMbrArrearsLstVO implements Serializable {
    private static final long serialVersionUID = -1316594557905077296L;


    private Integer         arrearsId;         //'체불신고ID',
    private Integer         customerId;         //'회원ID',
    private String          arrearsNm;          //'체불자이름',
    private String          bizcoNm;            //'상호',
    private String          bizcoRegNo;         //'사업자등록번호',
    private String          workStartDy;        //'작업시작일',
    private String          workEndDy;          //'작업종료일',
    private String          officeNo;           //'회사전화',
    private String          telNo;              //'연락처',
    private String          addTelNo;           //'추가연락처',
    private Integer         arrearsAmt;         //'피해금액',
    private String          workNm;             //'현장명',
    private String          workLocNm;          //'현장소재지',
    private String          arrearsConts;       //'체불상세내용',
    private Integer         procSt;             //'처리상태(0:대기,1:승인,2:거부,3:삭제요청,4:삭제완료)'
    private LocalDateTime   regDt;              //'등록일시'
    private Integer         regId;              //'등록자'
    private LocalDateTime   updDt;              //'수정일시'
    private Integer         updId;              //'수정자'
}
