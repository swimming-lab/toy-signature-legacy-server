
-- 회원정보
CREATE TABLE mbr_info_mst (
    customer_id int(10) NOT NULL AUTO_INCREMENT COMMENT '회원ID',
    bizco_nm	varchar(50) not null COMMENT '상호',
    bizco_reg_no	varchar(12) not null COMMENT '사업자등록번호',
    name	varchar(50) not null COMMENT '성명',
    nation_id_no	varchar(15)  COMMENT '주민등록번호',
    tel_no	varchar(20) COMMENT '연락처',
    zip_no	varchar(6) COMMENT '우편번호',
    addr_office	varchar(255) COMMENT '기본주소',
    addr_office_dtl varchar(255) COMMENT '상세주소',
    bank_cd	varchar(2) COMMENT '은행코드',
    accont_no	varchar(100) COMMENT '계좌번호',
    app_password	varchar(6) not null COMMENT '앱비밀번호',
    member_password	varchar(128) not null COMMENT '계정관리비밀번호',
    reg_dt	datetime not null COMMENT '등록일시',
    reg_id	int(10)	not null COMMENT '등록자',
    upd_dt	datetime not null COMMENT '수정일시',
    upd_id	int(10) not null COMMENT '수정자',
    PRIMARY KEY (customer_id)
);

-- 회원보유장비
CREATE TABLE mbr_equip_lst
(
    customer_id  int(10)     not null COMMENT '회원ID',
    equip_cd     smallint    not null COMMENT '보유장비코드',
    equip_model  varchar(10) not null COMMENT '보유장비모델',
    seq          tinyint     not null COMMENT '순번',
    regist_no    varchar(20) not null COMMENT '차량번호',
    insurance_yn varchar(1)  not null COMMENT '보험가입여부',
    routine_yn   varchar(1)  not null COMMENT '정기검사여부',
    reg_dt       datetime    not null COMMENT '등록일시',
    reg_id       int(10)     not null COMMENT '등록자',
    upd_dt       datetime    not null COMMENT '수정일시',
    upd_id       int(10)     not null COMMENT '수정자',
    PRIMARY KEY (customer_id, equip_cd, seq)
);

-- 보유장비관리
CREATE TABLE com_equip_mst
(
    equip_cd    smallint    not null COMMENT '보유장비코드',
    equip_model varchar(10) not null COMMENT '보유장비모델',
    equip_nm    varchar(50) not null COMMENT '장비명',
    reg_dt      datetime    not null COMMENT '등록일시',
    reg_id      int(10)     not null COMMENT '등록자',
    upd_dt      datetime    not null COMMENT '수정일시',
    upd_id      int(10)     not null COMMENT '수정자',
    PRIMARY KEY (equip_cd)
);

-- 로그인이력
CREATE TABLE mbr_login_hst (
    customer_id	int(10) not null COMMENT '회원ID',
    conn_dt	datetime not null COMMENT '접속일시',
    conn_ip	varchar(16) not null COMMENT '접속IP',
    PRIMARY KEY (customer_id,conn_dt)
);

-- 계약서관리
CREATE TABLE com_contract_mst (
    contract_id	int(3)	not null COMMENT '계약서ID',
    contract_nm	varchar(50) not null COMMENT '계약서명',
    use_yn	varchar(2) not null DEFAULT 'N' COMMENT '사용여부',
    reg_dt	datetime not null COMMENT '등록일시',
    reg_id	int(10)	not null COMMENT '등록자',
    upd_dt	datetime not null COMMENT '수정일시',
    upd_id	int(10) not null COMMENT '수정자',
    PRIMARY KEY (contract_id)
);

-- 회원_임대차계약서
CREATE TABLE mbr_contract_mst (
    contract_no	int(8)  NOT NULL AUTO_INCREMENT COMMENT '계약번호',
    contract_id	int(3) not null COMMENT '계약서ID',
    customer_id	int(10) not null COMMENT '회원ID',
    equip_cd	smallint(3) not null COMMENT '보유장비코드',
    equip_model  varchar(10) not null COMMENT '보유장비모델',
    regist_no	varchar(20) not null COMMENT '등록번호',
    insurance_yn	varchar(2) not null DEFAULT 'Y' COMMENT '보험가입여부',
    routine_yn	varchar(2) not null DEFAULT 'Y' COMMENT '정기검사여부',
    work_nm	varchar(100) not null COMMENT '현장명',
    work_loc_nm	varchar(100) not null COMMENT '현장소재지',
    issuer_nm	varchar(50) not null COMMENT '발급자',
    builder_nm	varchar(50) not null COMMENT '건설업자',
    work_dy	varchar(10) not null COMMENT '계약및작업일',
    work_start_time	varchar(5) not null COMMENT '작업시작시간',
    work_end_time	varchar(5) not null COMMENT '작업종료시간',
    use_amt	int	 not null COMMENT '사용금액',
    work_conts	varchar(255) COMMENT '작업내용',
    payday_over_no	tinyint	 not null COMMENT '지급일기준_초과',
    payday_in_no	tinyint	 not null COMMENT '지급일기준_이내',
    agent_nm	varchar(50)  COMMENT '대리인이름',
    contract_st	smallint(1) not null COMMENT '계약서진행상태(1:작성,2:완료)',
    par_contract_id	int(3) not null COMMENT '상위계약서ID(불러오기)',
    reg_dt	datetime not null COMMENT '등록일시',
    reg_id	int(10)	not null COMMENT '등록자',
    upd_dt	datetime not null COMMENT '수정일시',
    upd_id	int(10) not null COMMENT '수정자',
    PRIMARY KEY (contract_no)
);

-- 회원_임대차계약서_서명내역
CREATE TABLE mbr_contract_sign_lst (
    contract_no	int(8) NOT NULL COMMENT '계약번호',
    contract_id	int(3) not null COMMENT '계약서ID',
    customer_id	int(10) not null COMMENT '회원ID',
    signature_type	smallint(2) not null COMMENT '서명구분(10:임대인,20:임차인)',
    signature	text	 not null COMMENT '서명데이터',
    reg_dt	datetime not null COMMENT '등록일시',
    reg_id	int(10)	not null COMMENT '등록자',
    upd_dt	datetime not null COMMENT '수정일시',
    upd_id	int(10) not null COMMENT '수정자',
    PRIMARY KEY (contract_no)
);

-- 회원_임차인정보
CREATE TABLE mbr_contract_hire_lst (
    contract_no	int(8) NOT NULL COMMENT '계약번호',
    contract_id	int(3) not null COMMENT '계약서ID',
    customer_id	int(10) not null COMMENT '회원ID',
    bizco_nm	varchar(50) not null COMMENT '상호',
    bizco_reg_no	varchar(12)  COMMENT '사업자등록번호',
    name	varchar(50) not null COMMENT '성명',
    tel_no	varchar(20) not null COMMENT '회사전화',
    work_agent_nm	varchar(50) not null COMMENT '현장대리인성명',
    work_agent_tel_no	varchar(20) not null COMMENT '현장대리인연락처',
    reg_dt	datetime not null COMMENT '등록일시',
    reg_id	int(10)	not null COMMENT '등록자',
    upd_dt	datetime not null COMMENT '수정일시',
    upd_id	int(10) not null COMMENT '수정자',
    PRIMARY KEY (contract_no)
);

-- 회원_계약서전송이력
CREATE TABLE mbr_contract_send_hst (
    contract_no	int(8) NOT NULL COMMENT '계약번호',
    contract_id	int(3) not null COMMENT '계약서ID',
    customer_id	int(10) not null COMMENT '회원ID',
    send_tp	varchar(1) not null COMMENT '구분(1:임대인,2:임차인,3:추가1,4:추가2,5:추가3)',
    mob_tel_no	varchar(20) not null COMMENT '핸드폰번호',
    send_dt	datetime not null COMMENT '발송일시'
    --PRIMARY KEY (contract_no)
);

-- 회원_계약서이미지관리
CREATE TABLE mbr_contract_img_hst (
    contract_no	int(8) NOT NULL COMMENT '계약번호',
    contract_id	int(3) not null COMMENT '계약서ID',
    customer_id	int(10) not null COMMENT '회원ID',
    seq 	tinyint	not null COMMENT '순번',
    img_path	varchar(255) not null COMMENT '이미지경로',
    img_nm	varchar(255)  not null COMMENT '이미지명',
    reg_dt	datetime not null COMMENT '등록일시',
    reg_id	int(10)	not null COMMENT '등록자',
    upd_dt	datetime not null COMMENT '수정일시',
    upd_id	int(10) not null COMMENT '수정자',
    PRIMARY KEY (contract_no)
);

-- 회원_관리자
CREATE TABLE admin_mbr_mst (
    customer_id	int(10) not null COMMENT '회원ID',
    admin_tp	int(1) not null COMMENT '권한등급(0:관리자,1:운영자)',
    use_yn	varchar(2) not null default 'Y' COMMENT '사용여부',
    reg_dt	datetime not null COMMENT '등록일시',
    reg_id	int(10)	not null COMMENT '등록자',
    upd_dt	datetime not null COMMENT '수정일시',
    upd_id	int(10) not null COMMENT '수정자',
    PRIMARY KEY (customer_id)
);

-- 공통코드
CREATE TABLE com_code_mst (
    grp_code_cd	varchar(5) not null COMMENT '그룹코드',
    code_cd	varchar(5) not null COMMENT '코드',
    code_nm	varchar(255) not null COMMENT '코드명',
    use_yn	varchar(2) not null default 'Y' COMMENT '사용여부',
    reg_dt	datetime not null COMMENT '등록일시',
    reg_id	int(10)	not null COMMENT '등록자',
    upd_dt	datetime not null COMMENT '수정일시',
    upd_id	int(10) not null COMMENT '수정자',
    PRIMARY KEY (grp_code_cd,code_cd)
);

-- 회원_체불신고내역
CREATE TABLE mbr_arrears_lst (
    arrears_id int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '체불신고ID',
    customer_id	int(10) not null COMMENT '회원ID',
    arrears_nm	varchar(5) not null COMMENT '체불자이름',
    bizco_nm	varchar(50) not null COMMENT '상호',
    bizco_reg_no	varchar(12) COMMENT '사업자등록번호',
    work_start_dy	varchar(10) not null COMMENT '작업시작일',
    work_end_dy	varchar(10) not null COMMENT '작업종료일',
    office_no	varchar(20) COMMENT '회사전화',
    tel_no	varchar(20) COMMENT '연락처',
    add_tel_no	varchar(20) COMMENT '추가연락처',
    arrears_amt	int  not null COMMENT '피해금액',
    work_nm	varchar(100) not null COMMENT '현장명',
    work_loc_nm	varchar(100) not null COMMENT '현장소재지',
    arrears_conts    varchar(255) COMMENT '체불상세내용',
    proc_st 	int(1) COMMENT '처리상태(0:대기,1:승인,2:거부)',
    reg_dt	datetime not null COMMENT '등록일시',
    reg_id	int(10)	not null COMMENT '등록자',
    upd_dt	datetime not null COMMENT '수정일시',
    upd_id	int(10) not null COMMENT '수정자',
    PRIMARY KEY (arrears_id)
);



-- 기초 데이터 인서트
INSERT INTO mbr_info_mst (
    bizco_nm,
    bizco_reg_no,
    name,
    nation_id_no,
    tel_no,
    zip_no,
    addr_office,
    addr_office_dtl,
    bank_cd,
    accont_no,
    app_password,
    member_password,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
)
VALUES (
    '수영중기',
    '1234567890',
    '유수영',
    '8902091111111',
    '01092668883',
    '123456',
    '경기도 김포시 유현로 200',
    '풍무 푸르지오 1차 102동 903호',
    '11',
    '61670201123456',
    '111111',
    '4dff4ea340f0a823f15d3f4f01ab62eae0e5da579ccb851f8db9dfe84c58b2b37b89903a740e1ee172da793a6e79d560e5f7f9bd058a12a280433ed6fa46510a',
    now(),
    1,
    now(),
    1
);

INSERT INTO mbr_equip_lst (
    customer_id,
    equip_cd,
    equip_model,
    seq,
    regist_no,
    insurance_yn,
    routine_yn,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
    1,
    001,
    '2ka3sfds',
    1,
    '123가1322',
    'Y',
    'Y',
    now(),
    1,
    now(),
    1
);

INSERT INTO mbr_equip_lst (
    customer_id,
    equip_cd,
    equip_model,
    seq,
    regist_no,
    insurance_yn,
    routine_yn,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
     1,
     002,
     'vvvvvv',
     2,
     '432나7777',
     'N',
     'N',
     now(),
     1,
     now(),
     1
);
INSERT INTO mbr_equip_lst (
    customer_id,
    equip_cd,
    equip_model,
    seq,
    regist_no,
    insurance_yn,
    routine_yn,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
     1,
     003,
     'wlrpck5',
     3,
     '67나2288',
     'N',
     'Y',
     now(),
     1,
     now(),
     1
);

INSERT INTO com_equip_mst (
    equip_cd,
    equip_model,
    equip_nm,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
    001,
    '2ka3sfds',
    '포크레인',
    now(),
    1,
    now(),
    1
);
INSERT INTO com_equip_mst (
    equip_cd,
    equip_model,
    equip_nm,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
     002,
     'djfmv3fk',
     '덤프트럭',
     now(),
     1,
     now(),
     1
);
INSERT INTO com_equip_mst (
    equip_cd,
    equip_model,
    equip_nm,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
     003,
     'wlrpck5',
     '지게차',
     now(),
     1,
     now(),
     1
);

INSERT INTO com_contract_mst (
    contract_id,
    contract_nm,
    use_yn,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
)
VALUES (
    1,
    '계약서',
    'Y',
    now(),
    1,
    now(),
    1
);

INSERT INTO mbr_contract_mst
(
    contract_no,
    contract_id,
    customer_id,
    equip_cd,
    equip_model,
    regist_no,
    insurance_yn,
    routine_yn,
    work_nm,
    work_loc_nm,
    issuer_nm,
    builder_nm,
    work_dy,
    work_start_time,
    work_end_time,
    use_amt,
    work_conts,
    payday_over_no,
    payday_in_no,
    agent_nm,
    contract_st,
    par_contract_id,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
    1,
    1,
    1,
    002,
    'vvvvvv',
    '432나7777',
    'N',
    'N',
    '구래동 호반1차',
    '경기도 굼포시 구래동',
    '유수영',
    '강희동',
    '2020/04/27',
    '08:00',
    '17:00',
    '250000',
    '땅에 물줄거야',
    '5',
    '3',
    '강희동',
    1,
    1,
    now(),
    1,
    now(),
    1
);
INSERT INTO mbr_contract_mst
(
    contract_no,
    contract_id,
    customer_id,
    equip_cd,
    equip_model,
    regist_no,
    insurance_yn,
    routine_yn,
    work_nm,
    work_loc_nm,
    issuer_nm,
    builder_nm,
    work_dy,
    work_start_time,
    work_end_time,
    use_amt,
    work_conts,
    payday_over_no,
    payday_in_no,
    agent_nm,
    contract_st,
    par_contract_id,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
     2,
     1,
     1,
     003,
     'wlrpck5',
     '67나2288',
     'N',
     'Y',
     '풍무동 푸르지오 1차',
     '경기도 김포시 풍무동',
     '손오공',
     '배지터',
     '2020/05/06',
     '10:00',
     '19:00',
     '1230000',
     'jquery 서명 샘플데이터야',
     '2',
     '1',
     '피콜로',
     2,
     1,
     now(),
     1,
     now(),
     1
 );

INSERT INTO mbr_contract_hire_lst (
    contract_no,
    contract_id,
    customer_id,
    bizco_nm,
    bizco_reg_no,
    name,
    tel_no,
    work_agent_nm,
    work_agent_tel_no,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
    1,
    1,
    1,
    '두산건설',
    '11223344',
    '강희동',
    '01033004400',
    '김두한',
    '01044556677',
    now(),
    1,
    now(),
    1
);

INSERT INTO mbr_contract_hire_lst (
    contract_no,
    contract_id,
    customer_id,
    bizco_nm,
    bizco_reg_no,
    name,
    tel_no,
    work_agent_nm,
    work_agent_tel_no,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
     2,
     1,
     1,
     '코난건설',
     '99887766',
     '유명한',
     '01099998888',
     '유미란',
     '01088887777',
     now(),
     1,
     now(),
     1
);

INSERT INTO mbr_contract_sign_lst (
    contract_no,
    contract_id,
    customer_id,
    signature_type,
    signature,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
    1,
    1,
    1,
    20,
    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAvgAAADoCAYAAACaa5BRAAAgAElEQVR4Xu2dCcxdVfW3dwVShYICIUBBkCqIFoQCjVASwYEGylQgrQpCRYVCCdZWIKIhgE0AUSwFFSigVsa0KDK0BGhAEBqRNkhtFWUsIkOYBKpFCfLld/wW/9PznvHeM+777OTNO52zh2fte+9vr7P22sPeeeeddxwFAhCAAAQgAAEIQAACEPCCwDAEvhd2ZBAQgAAEIAABCEAAAhAICCDwmQgQgAAEIAABCEAAAhDwiAAC3yNjMhQIQAACEIAABCAAAQgg8JkDEIAABCAAAQhAAAIQ8IgAAt8jYzIUCEAAAhCAAAQgAAEIIPCZAxCAAAQgAAEIQAACEPCIAALfI2MyFAhAAAIQgAAEIAABCCDwmQMQgAAEIAABCEAAAhDwiAAC3yNjMhQIQAACEIAABCAAAQgg8JkDEIAABCAAAQhAAAIQ8IgAAt8jYzIUCEAAAhCAAAQgAAEIIPCZAxCAAAQgAAEIQAACEPCIAALfI2MyFAhAAAIQgAAEIAABCCDwmQMQgAAEIAABCEAAAhDwiAAC3yNjMhQIQAACEIAABCAAAQgg8JkDEIAABCAAAQhAAAIQ8IgAAt8jYzIUCEAAAhCAAAQgAAEIIPCZAxCAAAQgAAEIQAACEPCIAALfI2MyFAhAAAIQgAAEIAABCCDwmQMQgAAEIAABCEAAAhDwiAAC3yNjMhQIQAACEIAABCAAAQgg8JkDEIAABCAAAQhAAAIQ8IgAAt8jYzIUCEAAAhCAAAQgAAEIIPCZAxCAAAQgAAEIQAACEPCIAALfI2MyFAhAAAIQgAAEIAABCCDwmQMQgAAEIAABCEAAAhDwiAAC3yNjMhQIQAACEIAABCAAAQgg8JkDEIAABCAAAQhAAAIQ8IgAAt8jYzIUCEAAAhCAAAQgAAEIIPCZAxCAAAQgAAEIQAACEPCIAALfI2MyFAhAAAIQgAAEIAABCCDwmQMQgAAEIAABCEAAAhDwiAAC3yNjMhQIQAACEIAABCAAAQgg8JkDEIAABCAAAQhAAAIQ8IgAAt8jYzIUCEAAAhCAAAQgAAEIIPCZAxCAAAQgAAEIQAACEPCIAALfI2MyFAhAAAIQgAAEIAABCCDwmQMQgAAEIAABCEAAAhDwiAAC3yNjMhQIQAACEIAABCAAAQgg8JkDEIAABCAAAQhAAAIQ8IgAAt8jYzIUCEAAAhCAAAQgAAEIIPCZAxCAAAQgAAEIQAACEPCIAALfI2MyFAhAAAIQgAAEIAABCCDwmQMQgAAEIAABCEAAAhDwiAAC3yNjMhQIQAACEIAABCAAAQgg8JkDEIAABCAAAQhAAAIQ8IgAAt8jYzIUCEAAAhCAAAQgAAEIIPCZAxCAAAQgAAEIQAACEPCIAALfI2MyFAhAAAIQgAAEIAABCCDwmQMQgAAEIAABCEAAAhDwiAAC3yNjMhQIQAACEIAABCAAAQgg8JkDEIAABCAAAQhAAAIQ8IgAAt8jYzIUCEAAAoNOYPny5e6VV15xv/71r93DDz8c4Nhyyy3dRz/6UbfPPvu4fffdd9ARMX4IQGAACCDwB8DIDBECEICAbwT+8Y9/BAL+qaeecr///e/dbbfd5l588UW3evXq1KHusMMO7sgjj3T77befGzdunG9YGA8EIACBgAACn4kAAQhAAAKtJfCHP/zBrVq1yum7xLy+fvOb35TS3w033NDtsssubtasWXj2SyFKJRCAQFsIIPDbYgn6AQEIQGCACYSFvIl5fa+rSOiff/75bvz48XU1STsQgAAEKiOAwK8MLRVDAAIQgEAcAXnhFV4jT7xEvL4UctOGMnr0aDdp0iR35plntqE79AECEIBATwQQ+D1h4yYIQAACEMhLQIL+nnvuCQS9vvR7F8qKFSucBD8FAhCAQNcIIPC7ZjH6CwEIQKADBCTib7rpJvfzn/888NB3tSDyu2o5+g2BwSaAwB9s+zN6CEAAAqUR8EXUh4FssMEG7tlnn3UbbbRRaZyoCAIQgEDVBBD4VROmfghAAAIeE2iDqNcG2Xfeecdts802QepLbZQdNWqU23jjjYOc+I8++miQSvPyyy93f/zjHwtb46yzziImvzA1boAABJokgMBvkj5tQwACEOgogXnz5gWHSemrjvL+97/f7brrru5DH/pQ8KUDq+znIu1rQXLHHXcE4UN33nmne+uttzJvVztPPvlk5nVcAAEIQKAtBBD4bbEE/YAABCDQcgKKpZ8zZ04g6qvKemNC3sS8vuvrAx/4QOl01qxZ46699tpA7N9yyy2p9c+fPz/IrkOBAAQg0AUCCPwuWIk+ek1AQknCadiwYWuN0w71KWvwEkjyRIaFksIaqhJPZfWbepoloPkpUa/NsmVnv1FojQl5eeSbnIsrV650CxYscGeffXYs8AMOOMAtWrSoWWPQOgQgAIGcBBD4OUFxGQSiBOKEuf0tfG00x3ebcn5Hx2SLAC0EVGxBoL9LfGlBYD8zI/wmoBAcifqyTo3ddtttgzlkQr5JMZ9kOY3105/+dKJh//znP7sdd9yxb8PrPeC11157N/+/2tXrauLEiW7KlCl9108FEIAABBD4zAGvCUhw60AdfbeQgjgvZPh/caEHZYkc32BLpKmY6Nd3+1mhFrZg8G3cbRqP5rPmrASjij35Cc/58M/W9+g81+/rr7++e/nll4ONqXli09M4bLXVVu5Tn/qUmzx5crDhVRtgo2E2alN/s+9t4PqlL33JXXPNNbFdOeSQQ4JwHuO8atWqIdelLejzvI/Mnj3bfeMb32gDCvoAAQh0mAACv8PGo+vJBPQh+73vfS+IFX7zzTdB1TABif3tttsuEHJ6KhC3iAqLvPD/wwLQ/h4nCMP/a3i4Q5o3YRsdi/09zCTMKCyINY//85//BOkaTdRXFQdfJ7/3vOc97r///e+7i8FwKFkTC8Y0L771tUo+++yzT2lPTarsJ3VDAALtJoDAb7d96F0BAhYrLFHf5YN1CgyZSyHQF4E6BGtfHUy5WaE+KuEwMsuqU3RviT3p0/uGvm644Qa3evXqqrqeWi8CvxHsNAoB7wgg8L0z6WANyHJwS9Tnefw9WHR6G62F1kS96KrNPNDRmhWqEL5P4SL6XUU/d1VIprGIPnHIyvIS9d4b3/B90b+Jq2LXVcKM47zcYaFrtjIPuL7rtWIZcHrZLKv6FWaz5ZZbBnHocU8RouFCvc3Acu8Kp9K0RYHm4zrrrOP+9Kc/OW2ubZNDQDH42vtAgQAEINAPAQR+P/S4txECEkGWg3tQRb1En22ElRHiNiwmbWKMy6ZThyHD4jUqZNsUg10HizrbkHhVZpgi+ep1QJRi6I844ohgU6wJ46L9DsfY26LCFjr2P4ltxfzb4iC6h0B7aAalfPzjH3cLFy5c67U9KGMvY5z6PLjuuuvc/fffHyzcdt55ZzdhwgR32mmnuU022aSMJqgDAp0hgMDvjKnoqIXgXHjhhZXl4G6CslIFhmOxTbiHs9U0Jcqb4EGb5RCQUD722GNzP9nSPFQWF33Z5ulyetJ/LbYgNE+7bWTV3+1vGm/cptf+Wy+3BoXgvP766+6hhx5aq2Itou6+++5yGxuA2m688UZ37733BvMgzeFz1FFHudNPP92NHj16AKgwRAg4h8BnFnSCgD7Ilb6uTY/SDZzCOKL55aPe8/DvvZy+2Qkj0cnWENAiWF77rE24EvVf/vKXA1EffiLUmoHk6IjGeM899wTiLkvk5aiu0CXrrruuGzFiRPC10047uc0339xtscUW7r3vfe9aT9XsNS9hf/vttweZhaJF4r7XJyWFOu3JxfLSn3/++e7mm28uNKLDDz/cXXTRRcETKgoEfCaAwPfZuh6NTQLE0tP1MqxoSIvFJquuJGGTJMT5EO7FAtxTBwGJ3BkzZqQuhLUg1etJqRjb5qnPw0ieeoXtaKwm6vPcV+c14VN49X5h7z9yUsR5mc866yx35pln1tnFTrelxauY9VO0EZsCAZ8JIPB9tq4nY5MQ0ebAIkWPwSXQLdygq97JImPm2sEmIK+9xH1SMWGv67I2BLeFpIl588zXdUicPPJxWXR23313t2zZsp7wyKsfl7L36quvdgofoeQjMHfuXDd16tR8F6dcdfDBBxf2/vfdKBVAoEYCCPwaYYeb0ofsHXfc4X7729+6t99+261Zsyb4t4SobUbTo/NotouXXnrJrVix4t2q5B0yT7OFgUjc+lKUTUJxxGnFxLzGbydl+jJ+xgGBLAJ6jzjssMNSvfYKxdFrqc0ee4XZSMBrPHWH2sjDbs4Avafq57jNveb1tY3A4f7a6bRZ9gr/X/Hg22+//bvvW+H9OEXqGZRrH3vsMTdu3Dj34osvljLkK6+80n3lK18ppS4qgUDbCCDwG7LI2LFj3dKlSytr3TZomvjXh5Y8eG3+gI/CUNYPCZe40gXBUplxqRgC/5+AXiNaAKfF2iv0o99whjKBW8y85Zw3kVxmG1l1SdDrvVBC3pwk4XuGDRs2pAq952TtAdLYFIKjBYBiwxUnrsPJihRzVNh3nxw2RTjEXfvhD3/YPfHEE/1W8+79ePFLQ0lFLSSAwG/IKMOHDy/8xl9WV6Me/zaKf32QKl41Trjow1n/70qYQVl2ox4IGAG9Lo477rjgQKakogW9nhTqSWCTJbwBtgkxb2P/5Cc/6b7whS9kPuVLciwceuihuVONxtWhzbc6sXf99dd3r776anA+RN6i9+iw4B+0kMPHH3/cHXPMMW7JkiV5keW+7he/+IU7+uijc1/PhRDoCgEEfkOW2mCDDdy//vWvhlpPbjYs/vWzPlTqfmws8bLddtvFinuJFomEQfuAa91EoUONEdDrQ0+20lICNvmES69PbYi3TbBNgRIDC9mTpz6vQ0BiWouSaPnZz36Wa7GUtEDQE1vF8FsJP8Gwn/OKfo3FRL++1/0eXadNFy9e7E466ST317/+NVezI0eOdHvvvbebNm1a8DkhtnfddZe7+OKLY++XuJfIp0DANwII/IYsesghh7hbbrmlodZ7a9Y+UKoW/hIG8t5HixZF9913X6fCjHojzV0QiCcgsSJxn3YSrUI6JDLzCtp+WFvc+VVXXRWEozz33HOFPNP9tB29V0/27D2q17SfaWGB8rpnMVUolDK8RMvs2bODrEVZxfYf2B6EuIVGUh0StlpA6HAyPW3I6mtWX9rwf21o3mOPPXJ1RRvMtVk5vIgK35j2mav9cPvtt1+udrgIAl0hgMBv0FKnnnqqu/TSS53CdV5++eWgJ5tttllpG4jqGFo4xl/eMott7aftJIGvOrUoOuigg/qpnnsh0EkC2iQrEZMWbz9lypRgM21ZRW1ps6kdKBU+ZTYrHr2sPiTVo4WMeegtLWU/baY9OczDVbZRSFSv4j6p71FPf17RbycQS+x3ae+VcSiSCjNPmtG07DtnnHGG++53v9vP9OFeCLSOAAK/dSb5X4ckcu20Q4naXlOzNTW8cMyoPSov0hd9IMVlsZg0aZKbP39+kaq4FgKdJ5CVAlMDzOsljsIwwWghP9HvTcOz8BPbDGux6GX3Kyk0Jyss0E7YjtvInDesp+hYotmGsjL4yBFj2YG0MGq7dz/tSUqU1W677Zb78zFu87TqO+GEE9wll1xS1AxcD4FWE0Dgt9o8a3fu6aefdvJCXHbZZcFmrVdeeaVDvXfvPj63uP4sr9L1118fPOGIeqz0QaVTIxVnqY1reoSrvNUUCPhIQFly0rzyEqAS5Umvp64IeHsaGM0AVodNk0Jr1HZWFqIk+9x4441Blp66yvLly4NYc82FrEMB1S99tTGUR+MYP368e+GFFzLRHXDAAW7RokWZ1+kCPX3S3q64MnPmTHfBBRfkqoeLINAVAgj8rlgqoZ928Ive1O0xepY3p01Dtg/16PfwybMLFiyIPdrdxiHBr/GffPLJQez+I488EmSpOPDAAzuXGrRNtqEvzRLQ61nzOS0URgvd8847L1jgttUDb2ke7QTo6PdmKbuA75gxY2K7kZUaM+lk2rvvvjtwaDRVLF2nPOH6Stq8q8WUhL4WMW1JXKA9JupzVskTlhOuIy30s6onLVlj4P8QqJIAAr9Kug3XHRb94RjaVatWNdyz/M1bbO16663n9KGpg756Kfrw0odZ1EuohYT9vZd6uQcCVRCQ6JRnuOk497xj+9jHPhZkBdtzzz3d/vvvH7zO7OC9vHU0cZ3eFyXu4zYtp4Xm6HrZJy6TUdPiPo6j5pGeAkk4J73/S+grzKtJoX/OOee473znO5lTQWGaCtcsUtLC3Op+2lKk31wLgV4JIPB7Jdfx+8zzH34CoCHl3cDV9PC32Wab4ARI5UceNWpU8GjaPPm99i0q/i1UQPVx2EyvVLkvjoAEooSWBKZ+tu/6WU+gnn/++VaBsydq0SdtXRDxaSB1RsC8efNiL0kSfUknB2tBIAHdpOc+z6TRokRiNymMR9l+JPTrLrfffrtTyI2dFpzUflHPvdWTFoaFwK/b2rRXBwEEfh2UO9hG9HF/eEGQN1dzE8PWh6v2JrzxxhuB8F+9erV74IEHSuuKCZroYkAfSl0XO6VBGtCK7CmZNvKZaLe/6XtYzLcRkW2+tHkc/t7G/vbbJ22s1H6muJIUdy+7yuMfzWSUtQ+i375Wcb/e4yXm45IZ6P1NIr+uPQTiqXCzv//976lDlb2OP/74nnBorHPmzCm0mOupIW6CQEsIIPBbYoiudSP6BMB+N89km8ajD6tx48a5HXfc0W255ZbumWeeWctrGvcB10//LRwoHBKk+mxRoJ8tNKjt2Sz64eDDvSbUtag1sa5x2XyP/tzWMUuA2ibctsbC18kuTexpoRMXepN0urZey/LcZyUNqHN8RdpK82yLhUJ7qg7b0UIia2Ow5q3Cn3otSVmSVF+vGah67Qv3QaAOAgj8OigPYBuWL9u+myCSN/3NN99snEj06HcJ7aRFS9kLgLjBhxcF+r8tDsILgPBeAfu7hJv9rO8sGLKnlnnSw6I97GHvimgPj9RSSaaFmWWTGYwr0sJy9HrSe1b0dZSUtlHiXu8bXX/daUEjkR33dFZj0yJAZwFUMU4tILSfIa2o3ZUrVzod5tVrSRP4WZmSem2T+yDQJAEEfpP0B7jtsMffTm80D2kTIUAWb285tuW5Cnutwt5b27xs3t02Zi1S39VnWxTYz/pdp41uvvnmTvmj9bv+F366YIuGNi4YwqER4m8iXX01e4R/Vjy7FpS2iTLtBNi2vhw1ntGjR7vPfe5zQRejIr6t/W5jv9I89+rvQw89NMQTnyRAJe71XlC1d7sujnptSOQnOTQkkOXpLvNJRVLIU3TMZXjYEfh1zSTaaQsBBH5bLEE/1iIQ3vxrTwGa2ABsnn7LCpK22db6GfYAhxcGdipoF01tYj8q+uOeNBQdn3nP7bvdH/67/pZ2gmvRNuu6Xp51lfBTFntao/mibCBr1qxJ7E6eE1TrGkvX20kT9+uss4674oornLz74ZJ0mqreB+TVr8Kj3TRn5aC/8847E7shjtOnTy9lYZMmuq0DOufkwQcf7BuLbJXkPMKD3zdeKmghAQR+C41Cl5IJhNN9SiBZrGyd4t9Sd+q7PqAsPKKo3cJx3NENmCZmzSsdFr3mhW7iSUfRMbb9enlh7QlGWIRbv02MR0W6fg97bu3nvE895BWeMWNG6qKlDK9l2/nX1b+0FIlxMfSaExL3ui9adDiU7OejuLexSsRrjEnvMWVsws1zOnNSyFTReSN7brzxxom3IfCLEuX6LhBA4HfBSvQxFwET//fdd5977LHHgrCMusJn7Ch4+96r6M810JiLot5uXRINZ7EwnaVLl7q3337bDR8+PKgpnGs9HJ/ea1+qui+6MTnpqYKFEOj/8sxuuOGGAYtwaEGT4kzCPk44GreupFusys5l15u2iVSvU3nio+F4igmPO2wpaQNu2X1uQ31ynohdmvNEDg4dElU0TEmvR50qm/VUrqwDqNIOuRJr0mS2YcbRh7IJIPDLJkp9rSMgAas3ePte10Ff5uE3L3/RD8E2gLQP4KQFRDisJuvDOjqerLAfXd+kEC+bv/hI3MszmlS6mG6xbE5l1ZfFW+FPWmiF55icAjqdNm6vxiB6ecXQnjYl2aWXTbhpG52tnTLD07L2XrTxcLKyXgfUM7gEEPiDa/uBHbl5+k30S/jXIfotjl8fbvIcdlHwD+yk6XPgmnOHHXZYbPpFq1pzQnPSp0VNn9h6vl2vafFO2lStGPLoUxSxl+c+7p6yPMk9D6jhGzV/9b6VlspS72filHXQV5Y3XUMtOzuR+pb2Hp91uFbD+GkeAj0RQOD3hI2bfCSgDx59WWhP1ekx9aGjrBU77LCD23vvvd0nPvEJH7EO/JiSTj4Ng4nzJg88uB4A6PWr2Pm4PPZWXVw4RtqeCMI3/s8QCluS0E/b/5N1Em6ejbVlMs9aUGhhHQ5T7GHacQsEWkkAgd9Ks9CpthDQG78JftsUW+WG3vAGXkuHWHc8f1vY+9CPpMORwmMbxNCPMm0rASfPssRnWhrUpPCnpDSYhEvFW0nefIn4efPmJZpR72Py5kdTaur1oJOA00rc05V+5kvWIVplt9dPX7kXAmUSQOCXSZO6BoZA9AAv8/xXFepjefrtu8S/hfkQ0tHOaac5oTCRtL0Jgx760YvlxFOLbAl6feXZ+5H0hEQhOXF7IvTa0t/LzPney1jbfI/mt7z5ae952qSrBayVLLFdVtYca0/v09rMm1bizj5oM3f6BoG8BBD4eUlxHQRyErCDsGxTrwRIleE+5umXGJHY1yNwfVAiTnIarILLsk7nxDtcHLpeV7NmzXJ33XVX7puV0lLe5mhcuF6T2kwbF5rhc4773OAKXJi1gdUy7ajKLLFd9oI3LYOS+qPXYZ4FYgEcXAqB1hBA4LfGFHTEdwK2uTcc9lNluI94mviPfifsp7rZlpXfOy41Y3W96XbNes0oFERM855CrA2a8izrK24je1qmHPZC9DZf9J4m73ySN192+MxnPuN++tOfJjYgu+W1cd5eZm2uJTwuL0mu6yIBBH4XrUafvSJg4T5hz3+d+ftN/FvaSnsCYKfUegW74sFkeQzxDuczgF4LEvZpKUXDNUkcSmBK1Kc9uUrLlMPBYvlsk3SVFmOa/3PmzOmporJTVWYttNXJV199laxVPVmLm7pAAIHfBSvRx4EkYKfY2iZfWwBUGe4TBW0x/xL9Ek6k90yeiknx3HYH3uH0l7HmuYn6PJ5chd9oXtrczHqTIFNOFqFy/p8n0060pSoy2Sgz2ZIlSxIHVWae/XLIUQsEyiWAwC+XJ7VBoBYCYW+/PQGoOtzHBoboH2riLHFPKMBQZpq3CumQILQzKdJePIqXlpfevoq80JJOD5bnX21zJkURmtnXypsvO+V9TyozLab1TvPl9ddfT+xs2U8MsqlwBQTqJYDAr5c3rUGgUgL6YA1n+LGfTUxV2bg8/OE0n/qAzTr0psr+1FV3lrgve+NgXePqpx2FmGkhKAFve09Un6WaTctTH25Xnl0T9L1uGk+yj8Kl5NVH3Pdj6fR7szbg6u4qYu+XLVvm9thjj8TObbTRRqm5/KsjQs0QqI8AAr8+1rQEgcYJmOAPLwTCP1eV5tOEvmX6sfh+fddCQKVXAdck1DRxr3FJQEqgdrVYmJgONrJ5orHYz/qurxUrVrg1a9a49dZbr6+sJLYoFDPNmX7FtzLlxC0mFN6jJweU6gmI8+GHH+6STouVreXBL7Pceuut7uCDD06scsKECW7hwoVlNkldEGgdAQR+60xChyDQLAETbRb7rw/oujb9auS22dfEnYUE2f9sISDPn13bBLEscS9h2YZFi4lxO300LM7FzRZ99nP4e5VcLZWr7Gxx9GXxSsuUQ7hUlVYdWrfeP3QeRFrJOv22aI8nT57sFixYkHjbBRdc4GbOnFm0Wq6HQKcIIPA7ZS46C4HmCIRP9LWY6bQj6+vqaXhBEH5CsP3227uRI0cGj+LtKYF+1sJAIjf8d9Vh+bDDB4eFc2SH/37qqae6G264IXaIW221lVu0aJFTGEC4XtUlMWsLKLtZvw8bNiwRV3jBFb3IPOzWz6h4r8sGamfTTTd1O+20U9Ck2ST8XWO338sS8nHjSzo92IcnKnXas6y2lNko7dRba0fXKZNRvwf36b1JT27Sys0335zq4S9r7NQDgSYJIPCbpE/bEOg4gbDot5/rzPLTcXyd6L4WRGFxHk2raouqNgzmpptuig2J0hgULjUIe0LaYIdwH7Jy0YevtUOx+gnNSgrLCreTFC7UNnb0BwL9EEDg90OPeyEAgVgC4c294Z+j4SLga4aAvNlR0W77IkzAq2f9CK26R6b86wr1iBZtplVO9CqfGtQ91q60p6cpY8aMie2u9mu89dZbQ/6np0DysGedehtXadYJ0rpHsfmqnwIB3wkg8H23MOODQEsJxIWTRENO1HX7m36ObvRsQ4hQW/BGPe3h0CUT6m3ytpfJ7dvf/rY799xzh1SpzbQS911aqJTJpem60g5+UziOBHncE78vfvGL7tprry3U/eXLl7vx48e7F154IfU+0mMWwsrFHSaAwO+w8eg6BCDwf5tELQ5dXsNHH300SNEoT/U///nPd+N6w3H24fj6LI4vvfSSW7lyZexl5g1PqsPi8PPEFluMftTbHD5V2OoJe+Cz+u/z/5NOLNVmWnn083D3mU+TY9tiiy1iBbcdbKXFu2Lvo/nydd+ll17qtEDLW37wgx847Y1JK5MmTXLz58/PWyXXQaDTBBD4nTYfnYcABKomkJYFZPr06YGHmNIMgSRxL+9wXLhOM70czFYfe+wxp43ucSV8sJUW2ueff/6QJzAS/jpDIk959dVX3SabbJJ56eLFi91nP/vZzOu4AAI+EEDg+2BFxgABCFRCQBk5lOIvzkp2/OYAABVMSURBVNtPusVKkOeu9Oyzz3YKAYmW66+/3n3+85/PXQ8XVkNA3vm4OHp555977rkhjSr71LPPPrvW33W+wujRozM7qPAshWmllRNOOMFdcsklmXVxAQR8IYDA98WSjAMCECiVQFoudTz3paIuXFmSuA97hgtXyg2lEkiy0WWXXeaOP/74IW2dd9557vTTT1/r78qqo5j5rLLnnnu6Bx54IPGyESNGBAee7b777llV8X8IeEMAge+NKRkIBCBQFgGJe2X/iPPcE/5RFuXe6kHc98at7rviPPLqQ1qKyrgUl9OmTXOzZs1KDMG56qqr3DHHHJM6PC0otLCgQGCQCCDwB8najBUCEMgkIFEvoaHNutGCuM/EV+kFSVlZyIxSKfbClWtDuh16Fr5ZHvSlS5cm1qfFm06ZfeONN9a6ZsMNNwxC5SZOnDjkVNyvf/3r7uKLL07tI3nvC5uQGzwggMD3wIgMAQIQKIeAxL2EhB7nI+7LYVpGLbLLjBkzgrSK4aIMRrIVOe7LoFxeHQsWLHCTJ08eUmFSeE74wpkzZwYn2iYVefS/+c1vOon+q6++2un6tHLNNde4I488srzBURMEOkIAgd8RQ9FNCECgegJJp2Diua+efVoLWnQpm1G4KO+/xD057pu1TVzrJ510kvvJT34y5F95nrRoo60yIGmRkFQUPqeNus8//3zq4PXER5vhKRAYRAII/EG0OmOGAASGEFBavnnz5g35Oxs3m5ssCpOSuNeeiHDR6bTy5iPum7NNWstJC+U8Al/1Ku2lPPPRJzZFRnvUUUcFHn4KBAaVAAJ/UC3PuCEAgXcJJMV2Kw+3hD+lfgJJKUp1+JGEHwdY1W+TvC1OnTrVzZ07d8jlir8vkslGXnw9CYgLmcvqC3H3WYT4v+8EEPi+W5jxQQACqQQkFo899ti1rlFst/6uTX2U+gkkZcqZMmVKX17d+kcymC3268EPU5O4V/rM3/3ud7lgagGhJ3F58ufnqpCLINBRAgj8jhqObkMAAv0TiDulFnHfP9dea1AojkJy4jIY8TSlV6r135eU2ebkk092F110UeEOSdzvtddemffpMKszzjjDjRw5MvNaLoCA7wQQ+L5bmPFBAAKxBCQitVkvWoi5b2bCzJkzJziZNnr2gDbTaiFGppxm7NJLq/K6y4sfLaNGjXKPP/54L1W6gw8+2N16661r3StvvXLcy1u/995791QvN0HAVwIIfF8ty7ggAIFEAvIUb7fddkP+n3cTIGjLIyBbKEQqLs5aITkXXngh8fbl4a6tpmHDhsW21Wtmm7/97W9Oh1opLn/48OFOm2j1RIACAQjEE0DgMzMgAIGBIiAPscR91FOM577+aZAUa0+YVP22KLvFpDj8fffd12khTYEABKolgMCvli+1QwACLSMgcR9Nu4i4r9dI8tbLax+1g3oxffr0IFSHLDn12qTs1uRd/9GPfhRb7ZNPPkmK07KBUx8EIgQQ+EwJCEBgYAgojvvhhx9ea7yI+/rMr6cmEvbRQ6vUg1122SUIx5GHl9J9AoqXV9x8XNEiTramQAAC1RFA4FfHlpohAIEWEYg7yIqY+/oMpLSjM2bMGBIapXAcnVwqrz3FLwJJcfgapQ6z4imNX/ZmNO0igMBvlz3oDQQgUAGBOHG/cOFCN2HChApao8owAWUrktc+LvWlPLkS95xI6+eciXtiZiM988wzWdT5aXZG1RICCPyWGIJuQAAC1RCIO6WWsJxqWEdrFXulv4xLfSmPPuE49dihqVbiDpGzvsh7r1h8vPhNWYd2fSeAwPfdwowPAgNMIE7cc2BS9RMizWs/e/bswGtPGQwCEvCvvfZa7GCZC4MxBxhlMwQQ+M1wp1UIQKBiAtrEp5jvcCEsoFro8tTPmzcvVsCT075a9m2tPe51aH1VaJa8+JR8BC644AJ33XXXuWXLlgUHeyn07atf/Wq+m7lq4Agg8AfO5AwYAv4TiBMVZO6o1u5XXnmlU0jGfffdt1ZD5LSvlnvba9eiT0I+yYvPE7V8FjzkkEPcLbfcMuRiEgXk4zeIVyHwB9HqjBkCHhNQCsbDDjtsrREeeuihgfgk3rdcw5vHXqFQ0Th7tSSvvbhTBpuAQrK0FyOu4MVPnxtaOF999dWxJz3rznHjxrn7779/sCcYo48lgMBnYkAAAt4QUOz3mDFj1hrPPvvsE+RdR9yXZ2ZxlmAT1zhhr5z2Ev0TJ04sr1Fq6iwBzZGNN944sf948ePRJJ0GHL56xIgR7o033ujs3KDj1RFA4FfHlpohAIEaCUhE6JTasOCU0NSpqYj7cgwhYX/22WfHHlRlLZxxxhlu5syZMC8HuTe1xKWqtcHhxV/bzPfee6+bNWuWW7x4cab9R48e7VasWJF5HRcMHgEE/uDZnBFDwEsCcTm3tYGPHOv9m1sbZ7WvIS6XvdWucBx57eHdP28fa3jqqaeCBXhSYQP8/8ho42yRsLbLL7/cfe1rX/NxyjCmPgkg8PsEyO0QgEDzBOJifMl1359d9CREYTgS9nFhOFa79jdI2GuBRYFAGoE0L/6g58XXk0aF5BQpkyZNcvPnzy9yC9cOEAEE/gAZm6FCwEcCcR+MeAN7t7TF12d5ERX+JPHPYVW9sx60O7O8+NqzoYX5oJXTTjvNff/73y807Ntvv92NHz++0D1cPFgEEPiDZW9GCwGvCCTF3aeFkngFoKTBiONNN90UxNbrK61I2OuJibyxFAgUJZDmxVddg7Th9sEHH3RyRtx22225McprP23aNBbWuYkN7oUI/MG1PSOHQOcJxIkF8kLnN6s8qhZfnxaGoxqVz14ee4R9fr5cOZSA5pzCuZLy4itUR69h30O+TjzxRHfppZcWmiIXXXSRO/nkkwvdw8WDSwCBP7i2Z+QQ6DSBuNAcDrPKZ1KJLGXDyQrDMWEvj72+yEaUjy9XpRPQng3Nv6SijdoPPfSQt/Nt7NixbunSpYWmCY6LQri42DmHwGcaQAACnSQQzZojD7NCc8jikmxOLYokrPQ9q4invPUS9jDNosX/ixLQnFq1alXibXp9S9T6tKjUUzJtpC0SQqg9LuJAgUBRAgj8osS4HgIQaJyAQkVmzJixVj/YWJtsFoXhyGsqz32eosPBxNj3MIk8LLimGgJxh9JFW9L8kyffh6JFtU7YzgqFC4/1sssuc8cff7wPw2cMDRBA4DcAnSYhAIHeCcRl4th2220Dr5hP3r7eCf3vzrxpLsPtiKMWAsTZ90uf+/MQyArVUR3yYCuzTpdf23nGGeZ19NFHu3POOcdtvfXWeTByDQRiCSDwmRgQgECnCCiVnjK+hMvs2bODUBKKC7z0dtpsXm+hwnEkQmDIDKqbQNzrOdqHrop8OR10cFWRkBylyzzllFPqNgPteUgAge+hURkSBHwl8Ktf/codccQRaw0P7/3/cBSJrzeAEvZsoPX11dKNcWkRKgH/8MMPp3ZYCwGl0OyCJ7/IJvbwoG+44YYh72/dsCK9bCMBBH4brUKfIACBWAIHHnigW7RoEd77EIGi8fV265QpU4I4+y4IJl4OfhMoIvLbfBBWr8JeC22dP8GhcX7P87pHh8CvmzjtQQACPRGYOnWqmzt37lr3rrvuuu6tt97qqb4u3yQhMWfOnCDNZd4wnLCwVzgOmXG6PAP867vmtARuWmYdjbqNp90qBMfC4opaRgfHSdzzeixKjuuzCCDwswjxfwhAoHECCxYscJMnTx7Sj1/+8pfu8MMPb7x/dXVAYTjy2OfJXx/tkzLjSNjjJazLWrRTlEDWIVhW33777efuuOOOotWXfr36q2xeWac/JzXMU7TSTUKFIQIIfKYDBCDQagIrV650O+2005A+zp8/3+nYdt+LPPR22mzeNJdhJgh732eIX+OTN1yL0KSTbm20EtY//OEPGxm8XpNqv5eFtjrMqdCNmG3gGkXgD5zJGTAEukVAB8NED2babbfd3JIlS9zw4cO7NZgCvZXQURiOvINFw3DUDCkvC8Dm0lYRyCvytcDXPpKRI0fW0n8tsE888cTg/ejNN9/sqc1DDz006DMhOT3h46YCBBD4BWBxKQQgUC8BpZiLesm22GILd91113kZaiIhrxSgGnOe02bjrIGwr3eO0lo1BIqIfAn9Kp/maZGtp2i9huLYgluva0Lkqpkv1DqUAAKfWQEBCLSSwNKlS93YsWOH9E1x5Dq11qdi3vpeH/njsfdpNjAWI6BF7v777+/+/e9/Z0Ip+31Br0kT9b2ExlmHFSKng+M4PC7ThFxQMgEEfslAqQ4CECiHgLJS6EM7XOT9uvvuu8tpoOFa+o2tt+4rC4dy2SMgGjYozVdC4LnnnnN77bVXZnYda1zvEUr9KmG91VZbuSeffNJtuumm7iMf+Uhm/yTktajQVz+iXg2x9yUTNxdUTACBXzFgqocABHoj8MEPftA988wza9386KOP5vqg7q3Feu6yEJx+HvcjIOqxFa20g8BLL73kpk2b5pRNq+0FYd92Cw1O/xD4g2NrRgqBzhCIS4upGFtlzuliscf9veStj45XqfXksd911127iII+Q6BnAkqV21aRj7Dv2azcWBEBBH5FYKkWAhDonYAP4TkKwbEsOBL4/RRtnLU4XrJv9EOSe7tOIO69ockxrb/++u7HP/4xIXJNGoG2Ywkg8JkYEIBA6wgkfYi/8847retruEOWBUdp8PoV9aqX+PpWm5vONURg2bJl7lvf+pZbvHhxIz1QHnsdsKevgw46qJE+0CgEsggg8LMI8X8IQKB2Atrkpvz30dJWga9sG+pzrznrw+OUeJg4cSJhOLXPOhrsGoGpU6e6uXPn1tZt5bDXa5MN7bUhp6E+CCDw+4DHrRCAQDUE5JnTcfRtFvgS9LZhtpeDqKJjk7dewkHx9RQIQCAfAb0O77nnnmBxXcZTs7jFtjLzSNgrOw8FAl0hgMDviqXoJwQGiMAVV1zhjjvuuCEj1qN5nWLbVCkrN7b1X7H15q0ntr4pq9KuTwSeeOIJ9/TTT7sXX3zRLV++PPgaMWKE23777YPUl1qMS6hH02Dqb7ZxXd/1emQju08zY/DGgsAfPJszYgi0nsCYMWNivXEbbbSRmzlzpps+fXpt3jSJennqy/QQ8qi/9VOQDkIAAhDoNAEEfqfNR+ch4CeBnXfe2a1YsSJxcPKu3XjjjZV52FauXOmWLFnizj333OCgnDKKbZjV43689WUQpQ4IQAACEEgigMBnbkAAAq0jIBGsuNqsUvbx9Nqwt3DhQvf44487ifx+CyE4/RLkfghAAAIQ6IUAAr8XatwDAQhUSkAHQh177LG52pA33L50Qzi2VvG2zz//vFu9erXbeuut3SOPPBLUqQWEYnQ322yzICa3zM15lgVHG2bVDgUCEIAABCBQNwEEft3EaQ8CEMhFQNkx5KHP48nPVWHFF+mEWW2Y1RcFAhCAAAQg0CQBBH6T9GkbAhDIJCBvvoT+qlWrMq+t+wIdT295sUmhVzd92oMABCAAgSQCCHzmBgQg0HoCCqNRfngdKNV0sXz1CsFB1DdtDdqHAAQgAIE4Agh85gUEINAZAvLmS+i/9tprtfZZMf4HHnigO+WUU8iAUyt5GoMABCAAgV4IIPB7ocY9EIBAYwS0iVYhO3V48ydNmuSmTZvGZtnGrE3DEIAABCDQCwEEfi/UuAcCEGicgIS+NuIqA46+FMajv/Xj3R89erQbO3ask7CfMGFC42OkAxCAAAQgAIFeCCDwe6HGPRCAQCcI2LH0f/nLX9wmm2ySmtteKTNHjRrl3ve+93VibHQSAhCAAAQgkEQAgc/cgAAEIAABCEAAAhCAgEcEEPgeGZOhQAACEIAABCAAAQhAAIHPHIAABCAAAQhAAAIQgIBHBBD4HhmToUAAAhCAAAQgAAEIQACBzxyAAAQgAAEIQAACEICARwQQ+B4Zk6FAAAIQgAAEIAABCEAAgc8cgAAEIAABCEAAAhCAgEcEEPgeGZOhQAACEIAABCAAAQhAAIHPHIAABCAAAQhAAAIQgIBHBBD4HhmToUAAAhCAAAQgAAEIQACBzxyAAAQgAAEIQAACEICARwQQ+B4Zk6FAAAIQgAAEIAABCEAAgc8cgAAEIAABCEAAAhCAgEcEEPgeGZOhQAACEIAABCAAAQhAAIHPHIAABCAAAQhAAAIQgIBHBBD4HhmToUAAAhCAAAQgAAEIQACBzxyAAAQgAAEIQAACEICARwQQ+B4Zk6FAAAIQgAAEIAABCEAAgc8cgAAEIAABCEAAAhCAgEcEEPgeGZOhQAACEIAABCAAAQhAAIHPHIAABCAAAQhAAAIQgIBHBBD4HhmToUAAAhCAAAQgAAEIQACBzxyAAAQgAAEIQAACEICARwQQ+B4Zk6FAAAIQgAAEIAABCEAAgc8cgAAEIAABCEAAAhCAgEcEEPgeGZOhQAACEIAABCAAAQhAAIHPHIAABCAAAQhAAAIQgIBHBBD4HhmToUAAAhCAAAQgAAEIQACBzxyAAAQgAAEIQAACEICARwQQ+B4Zk6FAAAIQgAAEIAABCEAAgc8cgAAEIAABCEAAAhCAgEcEEPgeGZOhQAACEIAABCAAAQhAAIHPHIAABCAAAQhAAAIQgIBHBBD4HhmToUAAAhCAAAQgAAEIQACBzxyAAAQgAAEIQAACEICARwQQ+B4Zk6FAAAIQgAAEIAABCEAAgc8cgAAEIAABCEAAAhCAgEcEEPgeGZOhQAACEIAABCAAAQhAAIHPHIAABCAAAQhAAAIQgIBHBBD4HhmToUAAAhCAAAQgAAEIQACBzxyAAAQgAAEIQAACEICARwQQ+B4Zk6FAAAIQgAAEIAABCEAAgc8cgAAEIAABCEAAAhCAgEcEEPgeGZOhQAACEIAABCAAAQhAAIHPHIAABCAAAQhAAAIQgIBHBBD4HhmToUAAAhCAAAQgAAEIQACBzxyAAAQgAAEIQAACEICARwQQ+B4Zk6FAAAIQgAAEIAABCEAAgc8cgAAEIAABCEAAAhCAgEcEEPgeGZOhQAACEIAABCAAAQhAAIHPHIAABCAAAQhAAAIQgIBHBBD4HhmToUAAAhCAAAQgAAEIQACBzxyAAAQgAAEIQAACEICARwQQ+B4Zk6FAAAIQgAAEIAABCEAAgc8cgAAEIAABCEAAAhCAgEcEEPgeGZOhQAACEIAABCAAAQhAAIHPHIAABCAAAQhAAAIQgIBHBBD4HhmToUAAAhCAAAQgAAEIQACBzxyAAAQgAAEIQAACEICARwT+Hyny77Hp+3JwAAAAAElFTkSuQmCC',
    now(),
    1,
    now(),
    1
);

INSERT INTO mbr_contract_sign_lst (
    contract_no,
    contract_id,
    customer_id,
    signature_type,
    signature,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
    2,
    1,
    1,
    20,
    '[{"lx":74,"ly":32,"mx":74,"my":31},{"lx":74,"ly":31,"mx":74,"my":32},{"lx":73,"ly":32,"mx":74,"my":31},{"lx":71,"ly":32,"mx":73,"my":32},{"lx":69,"ly":33,"mx":71,"my":32},{"lx":66,"ly":34,"mx":69,"my":33},{"lx":63,"ly":35,"mx":66,"my":34},{"lx":61,"ly":37,"mx":63,"my":35},{"lx":59,"ly":38,"mx":61,"my":37},{"lx":59,"ly":40,"mx":59,"my":38},{"lx":58,"ly":41,"mx":59,"my":40},{"lx":58,"ly":42,"mx":58,"my":41},{"lx":59,"ly":43,"mx":58,"my":42},{"lx":60,"ly":44,"mx":59,"my":43},{"lx":61,"ly":45,"mx":60,"my":44},{"lx":62,"ly":45,"mx":61,"my":45},{"lx":63,"ly":45,"mx":62,"my":45},{"lx":64,"ly":45,"mx":63,"my":45},{"lx":65,"ly":45,"mx":64,"my":45},{"lx":66,"ly":45,"mx":65,"my":45},{"lx":67,"ly":45,"mx":66,"my":45},{"lx":69,"ly":44,"mx":67,"my":45},{"lx":71,"ly":43,"mx":69,"my":44},{"lx":72,"ly":42,"mx":71,"my":43},{"lx":73,"ly":42,"mx":72,"my":42},{"lx":73,"ly":41,"mx":73,"my":42},{"lx":74,"ly":40,"mx":73,"my":41},{"lx":75,"ly":40,"mx":74,"my":40},{"lx":75,"ly":39,"mx":75,"my":40},{"lx":76,"ly":38,"mx":75,"my":39},{"lx":77,"ly":37,"mx":76,"my":38},{"lx":77,"ly":36,"mx":77,"my":37},{"lx":76,"ly":36,"mx":77,"my":36},{"lx":75,"ly":35,"mx":76,"my":36},{"lx":73,"ly":35,"mx":75,"my":35},{"lx":71,"ly":35,"mx":73,"my":35},{"lx":70,"ly":35,"mx":71,"my":35},{"lx":69,"ly":35,"mx":70,"my":35},{"lx":68,"ly":35,"mx":69,"my":35},{"lx":66,"ly":35,"mx":68,"my":35},{"lx":65,"ly":35,"mx":66,"my":35},{"lx":35,"ly":65,"mx":35,"my":64},{"lx":35,"ly":64,"mx":35,"my":65},{"lx":37,"ly":64,"mx":35,"my":64},{"lx":41,"ly":63,"mx":37,"my":64},{"lx":52,"ly":62,"mx":41,"my":63},{"lx":71,"ly":61,"mx":52,"my":62},{"lx":90,"ly":60,"mx":71,"my":61},{"lx":118,"ly":58,"mx":90,"my":60},{"lx":137,"ly":57,"mx":118,"my":58},{"lx":151,"ly":55,"mx":137,"my":57},{"lx":157,"ly":55,"mx":151,"my":55},{"lx":159,"ly":54,"mx":157,"my":55},{"lx":160,"ly":54,"mx":159,"my":54},{"lx":159,"ly":54,"mx":160,"my":54},{"lx":89,"ly":58,"mx":89,"my":57},{"lx":89,"ly":57,"mx":89,"my":58},{"lx":89,"ly":58,"mx":89,"my":57},{"lx":88,"ly":60,"mx":89,"my":58},{"lx":86,"ly":62,"mx":88,"my":60},{"lx":83,"ly":66,"mx":86,"my":62},{"lx":81,"ly":72,"mx":83,"my":66},{"lx":79,"ly":75,"mx":81,"my":72},{"lx":77,"ly":79,"mx":79,"my":75},{"lx":76,"ly":82,"mx":77,"my":79},{"lx":75,"ly":84,"mx":76,"my":82},{"lx":74,"ly":86,"mx":75,"my":84},{"lx":74,"ly":87,"mx":74,"my":86},{"lx":78,"ly":83,"mx":74,"my":87},{"lx":86,"ly":78,"mx":78,"my":83},{"lx":114,"ly":55,"mx":114,"my":54},{"lx":113,"ly":56,"mx":114,"my":55},{"lx":111,"ly":59,"mx":113,"my":56},{"lx":108,"ly":63,"mx":111,"my":59},{"lx":106,"ly":66,"mx":108,"my":63},{"lx":102,"ly":71,"mx":106,"my":66},{"lx":100,"ly":75,"mx":102,"my":71},{"lx":97,"ly":78,"mx":100,"my":75},{"lx":96,"ly":79,"mx":97,"my":78},{"lx":95,"ly":81,"mx":96,"my":79},{"lx":94,"ly":83,"mx":95,"my":81},{"lx":93,"ly":83,"mx":94,"my":83},{"lx":97,"ly":81,"mx":93,"my":83},{"lx":104,"ly":76,"mx":97,"my":81},{"lx":158,"ly":41,"mx":158,"my":40},{"lx":158,"ly":40,"mx":158,"my":41},{"lx":156,"ly":42,"mx":158,"my":40},{"lx":152,"ly":46,"mx":156,"my":42},{"lx":147,"ly":50,"mx":152,"my":46},{"lx":144,"ly":53,"mx":147,"my":50},{"lx":140,"ly":57,"mx":144,"my":53},{"lx":136,"ly":60,"mx":140,"my":57},{"lx":133,"ly":62,"mx":136,"my":60},{"lx":132,"ly":63,"mx":133,"my":62},{"lx":131,"ly":63,"mx":132,"my":63},{"lx":131,"ly":64,"mx":131,"my":63},{"lx":132,"ly":62,"mx":131,"my":64},{"lx":138,"ly":58,"mx":132,"my":62},{"lx":142,"ly":55,"mx":138,"my":58},{"lx":150,"ly":49,"mx":150,"my":48},{"lx":150,"ly":47,"mx":150,"my":49},{"lx":151,"ly":47,"mx":150,"my":47},{"lx":152,"ly":47,"mx":151,"my":47},{"lx":154,"ly":48,"mx":152,"my":47},{"lx":158,"ly":48,"mx":154,"my":48},{"lx":163,"ly":48,"mx":158,"my":48},{"lx":167,"ly":48,"mx":163,"my":48},{"lx":170,"ly":48,"mx":167,"my":48},{"lx":173,"ly":48,"mx":170,"my":48},{"lx":175,"ly":48,"mx":173,"my":48},{"lx":176,"ly":48,"mx":175,"my":48},{"lx":178,"ly":48,"mx":176,"my":48},{"lx":179,"ly":48,"mx":178,"my":48},{"lx":180,"ly":48,"mx":179,"my":48},{"lx":127,"ly":74,"mx":127,"my":73},{"lx":127,"ly":73,"mx":127,"my":74},{"lx":128,"ly":73,"mx":127,"my":73},{"lx":129,"ly":73,"mx":128,"my":73},{"lx":133,"ly":72,"mx":129,"my":73},{"lx":141,"ly":72,"mx":133,"my":72},{"lx":149,"ly":72,"mx":141,"my":72},{"lx":159,"ly":71,"mx":149,"my":72},{"lx":165,"ly":71,"mx":159,"my":71},{"lx":169,"ly":71,"mx":165,"my":71},{"lx":170,"ly":71,"mx":169,"my":71},{"lx":171,"ly":70,"mx":170,"my":71},{"lx":172,"ly":70,"mx":171,"my":70},{"lx":173,"ly":70,"mx":172,"my":70},{"lx":168,"ly":71,"mx":168,"my":70},{"lx":167,"ly":72,"mx":168,"my":71},{"lx":165,"ly":73,"mx":167,"my":72},{"lx":163,"ly":75,"mx":165,"my":73},{"lx":161,"ly":77,"mx":163,"my":75},{"lx":160,"ly":79,"mx":161,"my":77},{"lx":158,"ly":81,"mx":160,"my":79},{"lx":156,"ly":83,"mx":158,"my":81},{"lx":155,"ly":84,"mx":156,"my":83},{"lx":154,"ly":85,"mx":155,"my":84},{"lx":153,"ly":86,"mx":154,"my":85},{"lx":152,"ly":86,"mx":153,"my":86},{"lx":153,"ly":86,"mx":152,"my":86},{"lx":219,"ly":62,"mx":219,"my":61},{"lx":218,"ly":61,"mx":219,"my":62},{"lx":216,"ly":62,"mx":218,"my":61},{"lx":213,"ly":63,"mx":216,"my":62},{"lx":208,"ly":65,"mx":213,"my":63},{"lx":202,"ly":68,"mx":208,"my":65},{"lx":197,"ly":71,"mx":202,"my":68},{"lx":194,"ly":73,"mx":197,"my":71},{"lx":191,"ly":75,"mx":194,"my":73},{"lx":189,"ly":77,"mx":191,"my":75},{"lx":189,"ly":78,"mx":189,"my":77},{"lx":188,"ly":79,"mx":189,"my":78},{"lx":189,"ly":79,"mx":188,"my":79},{"lx":190,"ly":79,"mx":189,"my":79},{"lx":192,"ly":79,"mx":190,"my":79},{"lx":196,"ly":79,"mx":192,"my":79},{"lx":199,"ly":78,"mx":196,"my":79},{"lx":204,"ly":75,"mx":199,"my":78},{"lx":211,"ly":72,"mx":204,"my":75},{"lx":219,"ly":68,"mx":211,"my":72},{"lx":222,"ly":66,"mx":219,"my":68},{"lx":226,"ly":64,"mx":222,"my":66},{"lx":228,"ly":62,"mx":226,"my":64},{"lx":229,"ly":61,"mx":228,"my":62},{"lx":229,"ly":60,"mx":229,"my":61},{"lx":229,"ly":59,"mx":229,"my":60},{"lx":228,"ly":59,"mx":229,"my":59},{"lx":227,"ly":58,"mx":228,"my":59},{"lx":226,"ly":58,"mx":227,"my":58},{"lx":224,"ly":58,"mx":226,"my":58},{"lx":223,"ly":58,"mx":224,"my":58},{"lx":224,"ly":58,"mx":223,"my":58},{"lx":226,"ly":57,"mx":224,"my":58},{"lx":228,"ly":57,"mx":226,"my":57},{"lx":231,"ly":56,"mx":228,"my":57},{"lx":234,"ly":55,"mx":231,"my":56},{"lx":236,"ly":55,"mx":234,"my":55},{"lx":238,"ly":55,"mx":236,"my":55},{"lx":239,"ly":54,"mx":238,"my":55},{"lx":214,"ly":67,"mx":214,"my":66},{"lx":214,"ly":66,"mx":214,"my":67},{"lx":214,"ly":65,"mx":214,"my":66},{"lx":216,"ly":65,"mx":214,"my":65},{"lx":219,"ly":64,"mx":216,"my":65},{"lx":225,"ly":63,"mx":219,"my":64},{"lx":230,"ly":61,"mx":225,"my":63},{"lx":234,"ly":60,"mx":230,"my":61},{"lx":239,"ly":59,"mx":234,"my":60},{"lx":244,"ly":57,"mx":239,"my":59},{"lx":249,"ly":56,"mx":244,"my":57},{"lx":252,"ly":55,"mx":249,"my":56},{"lx":255,"ly":54,"mx":252,"my":55},{"lx":256,"ly":54,"mx":255,"my":54},{"lx":257,"ly":54,"mx":256,"my":54},{"lx":229,"ly":62,"mx":229,"my":61},{"lx":229,"ly":60,"mx":229,"my":62},{"lx":232,"ly":59,"mx":229,"my":60},{"lx":237,"ly":57,"mx":232,"my":59},{"lx":243,"ly":54,"mx":237,"my":57},{"lx":251,"ly":51,"mx":243,"my":54},{"lx":263,"ly":47,"mx":251,"my":51},{"lx":273,"ly":43,"mx":263,"my":47},{"lx":278,"ly":41,"mx":273,"my":43},{"lx":280,"ly":40,"mx":278,"my":41},{"lx":281,"ly":39,"mx":280,"my":40},{"lx":283,"ly":33,"mx":283,"my":32},{"lx":281,"ly":35,"mx":283,"my":33},{"lx":279,"ly":37,"mx":281,"my":35},{"lx":276,"ly":41,"mx":279,"my":37},{"lx":270,"ly":46,"mx":276,"my":41},{"lx":265,"ly":51,"mx":270,"my":46},{"lx":259,"ly":57,"mx":265,"my":51},{"lx":254,"ly":63,"mx":259,"my":57},{"lx":249,"ly":68,"mx":254,"my":63},{"lx":247,"ly":70,"mx":249,"my":68},{"lx":245,"ly":72,"mx":247,"my":70},{"lx":244,"ly":73,"mx":245,"my":72},{"lx":243,"ly":74,"mx":244,"my":73},{"lx":243,"ly":75,"mx":243,"my":74},{"lx":242,"ly":75,"mx":243,"my":75},{"lx":248,"ly":85,"mx":248,"my":84},{"lx":248,"ly":84,"mx":248,"my":85},{"lx":247,"ly":84,"mx":248,"my":84},{"lx":244,"ly":85,"mx":247,"my":84},{"lx":242,"ly":85,"mx":244,"my":85},{"lx":236,"ly":87,"mx":242,"my":85},{"lx":229,"ly":90,"mx":236,"my":87},{"lx":224,"ly":93,"mx":229,"my":90},{"lx":221,"ly":95,"mx":224,"my":93},{"lx":218,"ly":98,"mx":221,"my":95},{"lx":216,"ly":99,"mx":218,"my":98},{"lx":215,"ly":101,"mx":216,"my":99},{"lx":214,"ly":102,"mx":215,"my":101},{"lx":214,"ly":103,"mx":214,"my":102},{"lx":215,"ly":103,"mx":214,"my":103},{"lx":216,"ly":104,"mx":215,"my":103},{"lx":217,"ly":104,"mx":216,"my":104},{"lx":220,"ly":104,"mx":217,"my":104},{"lx":224,"ly":104,"mx":220,"my":104},{"lx":228,"ly":104,"mx":224,"my":104},{"lx":234,"ly":104,"mx":228,"my":104},{"lx":241,"ly":102,"mx":234,"my":104},{"lx":248,"ly":100,"mx":241,"my":102},{"lx":253,"ly":97,"mx":248,"my":100},{"lx":260,"ly":92,"mx":253,"my":97},{"lx":265,"ly":89,"mx":260,"my":92},{"lx":267,"ly":88,"mx":265,"my":89},{"lx":268,"ly":87,"mx":267,"my":88},{"lx":268,"ly":86,"mx":268,"my":87},{"lx":268,"ly":85,"mx":268,"my":86},{"lx":267,"ly":84,"mx":268,"my":85},{"lx":266,"ly":84,"mx":267,"my":84},{"lx":263,"ly":83,"mx":266,"my":84},{"lx":258,"ly":82,"mx":263,"my":83},{"lx":248,"ly":81,"mx":258,"my":82},{"lx":241,"ly":81,"mx":248,"my":81},{"lx":231,"ly":81,"mx":241,"my":81},{"lx":224,"ly":81,"mx":231,"my":81},{"lx":221,"ly":81,"mx":224,"my":81},{"lx":220,"ly":81,"mx":221,"my":81},{"lx":220,"ly":82,"mx":220,"my":81}]',
    now(),
    1,
    now(),
    1
);


INSERT INTO mbr_arrears_lst (

    arrears_id,
    customer_id,
    arrears_nm,
    bizco_nm,
    bizco_reg_no,
    work_start_dy,
    work_end_dy,
    office_no,
    tel_no,
    add_tel_no,
    arrears_amt,
    work_nm,
    work_loc_nm,
    arrears_conts,
    proc_st,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
    1,
    1,
    '김체무',
    '돈내놔회사',
    '1234567890',
    '2020/05/06',
    '2020/05/08',
    '0255553333',
    '01011112222',
    '01022223333',
    4000000,
    '우리집 뒷마당',
    '김포 풍무동',
    '돈을 너무너무안준다우1',
    0,
    now(),
    1,
    now(),
    1
);

INSERT INTO mbr_arrears_lst
(
    arrears_id,
    customer_id,
    arrears_nm,
    bizco_nm,
    bizco_reg_no,
    work_start_dy,
    work_end_dy,
    office_no,
    tel_no,
    add_tel_no,
    arrears_amt,
    work_nm,
    work_loc_nm,
    arrears_conts,
    proc_st,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
    2,
    1,
    '유체무',
    '돈안줌회사',
    '1234567890',
    '2020/05/06',
    '2020/05/08',
    '0255553333',
    '01011112222',
    '01022223333',
    4000000,
    '우리집 뒷마당',
    '김포 풍무동',
    '돈을 너무너무안준다우2',
    1,
    now(),
    1,
    now(),
    1
);

INSERT INTO mbr_arrears_lst (
    arrears_id,
    customer_id,
    arrears_nm,
    bizco_nm,
    bizco_reg_no,
    work_start_dy,
    work_end_dy,
    office_no,
    tel_no,
    add_tel_no,
    arrears_amt,
    work_nm,
    work_loc_nm,
    arrears_conts,
    proc_st,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) VALUES (
    3,
    1,
    '박체무',
    '돈좀회사',
    '1234567890',
    '2020/05/06',
    '2020/05/08',
    '0255553333',
    '01011112222',
    '01022223333',
    4000000,
    '우리집 뒷마당',
    '김포 풍무동',
    '돈을 너무너무안준다우3',
    2,
    now(),
    1,
    now(),
    1
);

INSERT INTO admin_mbr_mst (
    customer_id,
    admin_tp,
    reg_dt,
    reg_id,
    upd_dt,
    upd_id
) values (
    1,
    0,
    now(),
    1,
    now(),
    1
)

