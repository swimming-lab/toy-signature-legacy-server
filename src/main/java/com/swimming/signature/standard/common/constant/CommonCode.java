package com.github.bestheroz.standard.common.constant;

import org.joda.time.LocalDateTime;

@SuppressWarnings("ALL")
public class CommonCode {
    /**
     * <pre>
     * 이 클래스의 필드로 등록된 값들은 JSP에서 자동으로 EL 표현식으로 사용할 수 있도록 (스프링 구동시) InitWebConstantContext에서 세팅하고 있습니다.
     * 이 곳에서 상수로 정의 후 JSP에서 바로 불러 사용하시면 됩니다.
     * 예) ${PATH_JS}
     * </pre>
     */

    public static final String RESOUCE_VERSION = "?ver=" + LocalDateTime.now().toString();

//    public static final String CONTEXT_PATH = "http://signaturewas.cdn1.cafe24.com";
    public static final String CONTEXT_PATH = "";
    public static final String PATH_RESOURCES = CONTEXT_PATH.concat("/resources");
    public static final String PATH_JS = PATH_RESOURCES.concat("/js");
    public static final String PATH_IMAGE = PATH_RESOURCES.concat("/images");
    public static final String PATH_CSS = PATH_RESOURCES.concat("/css");
    public static final String PATH_PLUGIN = PATH_RESOURCES.concat("/plugin");
    public static final String PATH_SIGNATURE = PATH_RESOURCES.concat("/files/signature");
    public static final String PATH_CONTRACT = PATH_RESOURCES.concat("/files/contract");
    public static final String PATH_PUBLISH = PATH_RESOURCES.concat("/publish");
    public static final String FILEPATH_TEXT_EDITOR = "/textEditor/";
    public static final String YES = "YES";
    public static final String NO = "NO";
    // CommonResponseException 에 정의된 필드와 같다.
    public static final String RESPONSE_CODE = "code";
    public static final String RESPONSE_MESSAGE = "message";
    public static final String RESPONSE_DATA = "data";


    // #어플리케이션 변수
    // 관리자
    public static final int ADMINISTRATOR = 0;                  // 관리자
    public static final int OPERATOR = 1;                       // 운영자

    // 로그인
    public static final int LOGIN_AUTO_YES = 1;                 // 자동 로그인
    public static final int LOGIN_AUTO_NO = 0;                  // 자동 로그인
    public static final String LOGIN_AUTO_COOKIE_NAME = "signature_autologin";
    public static final String MEMBER_ST_USED = "1";            // 회원 상태 - 사용
    public static final String MEMBER_ST_REMOVE = "9";          // 회원 상태 - 탈퇴

    // 계약서
    public static final int FORM_TYPE_NEW = 10;                 // 새로작성
    public static final int FORM_TYPE_NEW_LOAD = 20;            // 새로작성(불러오기)
    public static final int FORM_TYPE_UPDATE = 30;              // 수정하기
    public static final int FORM_TYPE_READ_ONLY = 40;           // 완료된 계약서 보기
    public static final int CONTRACT_ST_ING = 1;                // 계약서 상태 - 진행중
    public static final int CONTRACT_ST_DONE = 2;               // 계약서 상태 - 완료

    // 체불신고
    public static final int ARREARS_ST_WAIT = 0;                // 체불신고 상태 - 대기
    public static final int ARREARS_ST_CONFIRM = 1;             // 체불신고 상태 - 승인
    public static final int ARREARS_ST_REJECT = 2;              // 체불신고 상태 - 거부
    public static final int ARREARS_ST_REMOVE = 3;              // 체불신고 상태 - 삭제

    public static final int ARREARS_FORM_TYPE_NEW = 10;         // 새로작성
    public static final int ARREARS_FORM_TYPE_UPDATE = 20;      // 새로작성(불러오기)

    // 이메일
    public static final String ADMIN_EMAIL_RECEIVER = "khd1982@gmail.com";
//    public static final String ADMIN_EMAIL_RECEIVER = "sooyoung209@naver.com";

    protected CommonCode() {
        throw new UnsupportedOperationException();
    }
}
