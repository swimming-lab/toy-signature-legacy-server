package com.github.bestheroz.main.web.member;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class MemberVO implements Serializable {
    private static final long serialVersionUID = 8300621111265295274L;

    // member
    private Integer         customerId;         //'회원ID'
    private String          bizcoNm;            //'상호'
    private String          bizcoRegNo;         //'사업자등록번호'
    private String          name;               //'성명'
    private String          nationIdNo;         //'주민등록번호'
    private String          telNo;              //'연락처'
    private String          zipNo;              //'우편번호'
    private String          addrOffice;         //'기본주소'
    private String          addrOfficeDtl;      //'상세주소'
    private String          bankCd;             //'은행코드'
    private String          accontNo;           //'계좌번호'
    private String          appPassword;        //'앱비밀번호'
    private String          memberPassword;     //'계정관리비밀번호'
    private String          memberSt;          //'회원상태(1:회원, 9:탈퇴)'
    private String          viewBizcoYn;         //사업자번호 노출여부
    private LocalDateTime   regDt;              //'등록일시'
    private Integer         regId;              //'등록자'
    private LocalDateTime   updDt;              //'수정일시'
    private Integer         updId;              //'수정자'

    private Integer         isAutoLogin;        //'자동로그인 체크'

    // admin
    private Integer         adminTp;            //'어드민 여부(0:관리자,1:운영자)'

    // 검색 파라미터
    private String          search;             //'검색 키워드'
    private Integer         range;              //'검색 범위'
    private Integer         offset;
    private Integer         limit;
}
