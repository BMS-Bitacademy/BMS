/* 환율 */
CREATE TABLE `exchangerate` (
	`date` DATE NOT NULL COMMENT '날짜',
	`price_closing` VARCHAR(50) NULL DEFAULT NULL COMMENT '종가' COLLATE 'utf8_unicode_ci',
	`price_opening` VARCHAR(50) NULL DEFAULT NULL COMMENT '오픈' COLLATE 'utf8_unicode_ci',
	`price_high` VARCHAR(50) NULL DEFAULT NULL COMMENT '고가' COLLATE 'utf8_unicode_ci',
	`price_low` VARCHAR(50) NULL DEFAULT NULL COMMENT '저가' COLLATE 'utf8_unicode_ci',
	`difference` VARCHAR(50) NULL DEFAULT NULL COMMENT '변동' COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`date`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;

/* kospi */
CREATE TABLE `kospi` (
	`date` DATE NOT NULL COMMENT '날짜',
	`price_closing` VARCHAR(50) NULL DEFAULT NULL COMMENT '종가' COLLATE 'utf8_unicode_ci',
	`price_opening` VARCHAR(50) NULL DEFAULT NULL COMMENT '오픈' COLLATE 'utf8_unicode_ci',
	`price_high` VARCHAR(50) NULL DEFAULT NULL COMMENT '고가' COLLATE 'utf8_unicode_ci',
	`price_low` VARCHAR(50) NULL DEFAULT NULL COMMENT '저가' COLLATE 'utf8_unicode_ci',
	`volume` VARCHAR(50) NULL DEFAULT NULL COMMENT '거래량' COLLATE 'utf8_unicode_ci',
	`difference` VARCHAR(50) NULL DEFAULT NULL COMMENT '변동' COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`date`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;

/* 분석 대상 회사들의 주가 */
CREATE TABLE `stock_day` (
	`IDX` INT(11) NOT NULL AUTO_INCREMENT,
	`com_name` VARCHAR(50) NULL DEFAULT NULL COMMENT '회사명' COLLATE 'utf8_unicode_ci',
	`com_code` VARCHAR(50) NOT NULL COMMENT '회사코드' COLLATE 'utf8_unicode_ci',
	`date` DATE NOT NULL COMMENT '날짜',
	`price_closing` INT(50) NULL DEFAULT NULL COMMENT '종가',
	`difference` INT(50) NULL DEFAULT NULL COMMENT '전일비',
	`price_market` INT(50) NULL DEFAULT NULL COMMENT '시가',
	`price_high` INT(50) NULL DEFAULT NULL COMMENT '고가',
	`price_low` INT(50) NULL DEFAULT NULL COMMENT '저가',
	`volume` INT(50) NULL DEFAULT NULL COMMENT '거래량',
	`status` VARCHAR(50) NULL DEFAULT NULL COMMENT '등락상태' COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`IDX`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;

/* 계란가격 */
CREATE TABLE `price_egg` (
	`idx` INT(11) NOT NULL AUTO_INCREMENT,
	`date` DATE NULL DEFAULT NULL COMMENT '날짜',
	`price` VARCHAR(50) NULL DEFAULT NULL COMMENT '가격' COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`idx`),
	INDEX `IDX` (`idx`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;

/* 우유가격 */
CREATE TABLE `price_milk` (
	`idx` INT(11) NOT NULL AUTO_INCREMENT,
	`date` DATE NULL DEFAULT NULL COMMENT '날짜',
	`price` VARCHAR(50) NULL DEFAULT NULL COMMENT '가격' COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`idx`),
	INDEX `IDX` (`idx`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
ROW_FORMAT=COMPACT
;

/* 설탕가격 */
CREATE TABLE `price_sugar` (
	`idx` INT(11) NOT NULL AUTO_INCREMENT,
	`date` DATE NULL DEFAULT NULL COMMENT '거래날짜',
	`price_closing` VARCHAR(50) NULL DEFAULT NULL COMMENT '종가(USD/ton)' COLLATE 'utf8_unicode_ci',
	`difference` VARCHAR(50) NULL DEFAULT NULL COMMENT '전일대비' COLLATE 'utf8_unicode_ci',
	`rate_UpDown` VARCHAR(50) NULL DEFAULT NULL COMMENT '등락률(%)' COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`idx`),
	INDEX `IDX` (`idx`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;

/* 유가 */
CREATE TABLE `price_oil` (
	`date` DATE NOT NULL COMMENT '날짜',
	`Dubai` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`Brent` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	`WTI` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`date`)
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;



/* 분석 데이터 테이블 */
CREATE TABLE `stock_predict` (
	`com_name` VARCHAR(30) NULL DEFAULT NULL COMMENT '회사명' COLLATE 'utf8_unicode_ci',
	`com_code` INT(11) NULL DEFAULT NULL COMMENT '회사코드',
	`date` DATE NULL DEFAULT NULL COMMENT '날짜',
	`tod_price` VARCHAR(20) NULL DEFAULT NULL COMMENT '금일종가' COLLATE 'utf8_unicode_ci',
	`tod_status` VARCHAR(20) NULL DEFAULT NULL COMMENT '금일등락여부' COLLATE 'utf8_unicode_ci',
	`tom_price` VARCHAR(20) NULL DEFAULT NULL COMMENT '익일예측종가' COLLATE 'utf8_unicode_ci',
	`tom_status` VARCHAR(20) NULL DEFAULT NULL COMMENT '익일예측등락여부' COLLATE 'utf8_unicode_ci',
	`match_status` VARCHAR(20) NULL DEFAULT NULL COMMENT '등락적중여부' COLLATE 'utf8_unicode_ci',
	`price_error` VARCHAR(20) NULL DEFAULT NULL COMMENT '금일오차범위' COLLATE 'utf8_unicode_ci',
	`return` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci'
)
COLLATE='utf8_unicode_ci'
ENGINE=InnoDB
;
