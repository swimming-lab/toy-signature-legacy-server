package com.github.bestheroz.main.web.admin;

import lombok.Data;

import java.io.Serializable;


@Data
public class AdminVO implements Serializable {
    private static final long serialVersionUID = 8300621111265295274L;

    // 검색 파라미터
    private String          search;             //'검색 키워드'
    private Integer         range;              //'검색 범위'
    private Integer         offset;
    private Integer         limit;
}
