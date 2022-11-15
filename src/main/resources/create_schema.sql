## CREATE SCHEMA
CREATE TABLE mbr_info_mst (
  customer_id int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '회원ID',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원정보'
;

CREATE TABLE mbr_equip_lst (
  customer_id	int(10) not null COMMENT '회원ID',
  equip_cd	smallint(3)  not null COMMENT '보유장비코드',
  equip_model	varchar(10) not null COMMENT '보유장비모델',
  seq	tinyint	 not null COMMENT '순번',
  regist_no	varchar(20) not null COMMENT '등록번호',
  insurance_yn	varchar(1) not null COMMENT '보험가입여부',
  routine_yn	varchar(1) not null COMMENT '정기검사여부',
  reg_dt	datetime not null COMMENT '등록일시',
  reg_id	int(10)	not null COMMENT '등록자',
  upd_dt	datetime not null COMMENT '수정일시',
  upd_id	int(10) not null COMMENT '수정자',
  PRIMARY KEY (customer_id,equip_cd,seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원보유장비'
;
CREATE TABLE com_equip_mst (
  equip_cd	smallint(3)  not null COMMENT '보유장비코드',
  equip_model	varchar(10) not null COMMENT '보유장비모델',
  equip_nm	varchar(50) not null COMMENT '장비명',
  reg_dt	datetime not null COMMENT '등록일시',
  reg_id	int(10)	not null COMMENT '등록자',
  upd_dt	datetime not null COMMENT '수정일시',
  upd_id	int(10) not null COMMENT '수정자',
  PRIMARY KEY (equip_cd)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='보유장비관리'
;
CREATE TABLE mbr_login_hst (
  customer_id	int(10) not null COMMENT '회원ID',
  conn_dt	datetime not null COMMENT '접속일시',
  conn_ip	varchar(16) not null COMMENT '접속IP',
  PRIMARY KEY (customer_id,conn_dt)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='로그인이력'
;

CREATE TABLE com_contract_mst (
  contract_id	int(3)	not null COMMENT '계약서ID',
  contract_nm	varchar(50) not null COMMENT '계약서명',
  use_yn	varchar(2) not null DEFAULT 'N' COMMENT '사용여부',
  reg_dt	datetime not null COMMENT '등록일시',
  reg_id	int(10)	not null COMMENT '등록자',
  upd_dt	datetime not null COMMENT '수정일시',
  upd_id	int(10) not null COMMENT '수정자',
  PRIMARY KEY (contract_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='계약서관리'
;

CREATE TABLE mbr_contract_mst (
    contract_no	int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '계약번호',
	contract_id	int(3) not null COMMENT '계약서ID',
	customer_id	int(10) not null COMMENT '회원ID',
	equip_cd	smallint(3) not null COMMENT '보유장비코드',
              equip_model	varchar(10) not null COMMENT '보유장비모델',
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
	contract_st	int(1) not null COMMENT '계약서진행상태(1:작성,2:완료)',
	par_contract_id	int(3) not null COMMENT '상위계약서ID(불러오기)',
  reg_dt	datetime not null COMMENT '등록일시',
  reg_id	int(10)	not null COMMENT '등록자',
  upd_dt	datetime not null COMMENT '수정일시',
  upd_id	int(10) not null COMMENT '수정자',
  PRIMARY KEY (contract_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원_임대차계약서'
;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원_임대차계약서_서명내역'
;



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
  zip_no	varchar(6) COMMENT '우편번호',
  addr_office	varchar(255) COMMENT '기본주소',
  addr_office_dtl varchar(255) COMMENT '상세주소',
  reg_dt	datetime not null COMMENT '등록일시',
  reg_id	int(10)	not null COMMENT '등록자',
  upd_dt	datetime not null COMMENT '수정일시',
  upd_id	int(10) not null COMMENT '수정자',
  PRIMARY KEY (contract_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원_임차인정보'
;
CREATE TABLE mbr_contract_send_hst (
  contract_no	int(8) NOT NULL COMMENT '계약번호',
  contract_id	int(3) not null COMMENT '계약서ID',
	customer_id	int(10) not null COMMENT '회원ID',
	send_tp	varchar(1) not null COMMENT '구분(1:임대인,2:임차인,3:추가1,4:추가2,5:추가3)',
    mob_tel_no	varchar(20) not null COMMENT '핸드폰번호',
    send_dt	datetime not null COMMENT '발송일시'
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원_계약서전송이력'
;
CREATE TABLE mbr_contract_img_hst (
  contract_no	int(8) NOT NULL COMMENT '계약번호',
  contract_id	int(3) not null COMMENT '계약서ID',
	customer_id	int(10) not null COMMENT '회원ID',
	seq	tinyint	 not null COMMENT '순번',
  img_path	longtext not null COMMENT '이미지경로',
  img_nm	varchar(255)  not null COMMENT '이미지명',
  reg_dt	datetime not null COMMENT '등록일시',
  reg_id	int(10)	not null COMMENT '등록자',
  upd_dt	datetime not null COMMENT '수정일시',
  upd_id	int(10) not null COMMENT '수정자',
  PRIMARY KEY (contract_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원_계약서이미지관리'
;
CREATE TABLE admin_mbr_mst (
	customer_id	int(10) not null COMMENT '회원ID',
	admin_tp	int(1) not null COMMENT '권한등급(0:관리자,1:운영자)',
    use_yn	varchar(2) not null default 'Y' COMMENT '사용여부',
  reg_dt	datetime not null COMMENT '등록일시',
  reg_id	int(10)	not null COMMENT '등록자',
  upd_dt	datetime not null COMMENT '수정일시',
  upd_id	int(10) not null COMMENT '수정자',
  PRIMARY KEY (customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원_관리자'
;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통코드'
;

CREATE TABLE mbr_arrears_lst (
  arrears_id int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '체불신고ID',
  customer_id	int(10) not null COMMENT '회원ID',
  arrears_nm	varchar(5) not null COMMENT '체불자이름',
  bizco_nm	varchar(50) not null COMMENT '상호',
  bizco_reg_no	varchar(12) COMMENT '사업자등록번호',
  work_start_dy	varchar(14) not null COMMENT '작업시작일',
  work_end_dy	varchar(14) not null COMMENT '작업종료일',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원_체불신고내역'
;



-- 임차인 검색 인덱스 추가
create index idx1_mbr_contract_hire_lst on mbr_contract_hire_lst(customer_id asc , contract_no desc );

-- 임대인 검색 인덱스 추가
CREATE FULLTEXT INDEX idx1_mbr_info_mst on mbr_info_mst(bizco_nm,name);

-- 계약서 관리 검색 인덱스 추가
create index idx1_mbr_contract_mst on mbr_contract_mst(customer_id asc , reg_dt desc);
