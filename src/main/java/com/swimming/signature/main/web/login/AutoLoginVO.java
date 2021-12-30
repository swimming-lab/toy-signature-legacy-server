package com.github.bestheroz.main.web.login;

import lombok.Data;
import org.joda.time.LocalDateTime;

import java.io.Serializable;


@Data
public class AutoLoginVO implements Serializable {
    private static final long serialVersionUID = 8300621111265295274L;

    // member
    private Integer         customerId;            //'회원ID'
    private String          appPassword;           //'앱비밀번호'
    private String          version;               //'쿠키버전'
    private LocalDateTime   createDt;              //'등록일시'
}
