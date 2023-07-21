drop DATABASE if exists baegopa_coupon_dev;
create DATABASE baegopa_coupon_dev;
use baegopa_coupon_dev;

DROP TABLE IF EXISTS `coupon_price_policy`;
CREATE TABLE `coupon_price_policy`
(

    `coupon_price_policy_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '쿠폰가격 정책 식별번호',
    `target_amount`          INT UNSIGNED NOT NULL COMMENT '대상금액',
    `name`                   VARCHAR(50)  NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `amount_coupon_policy`;
CREATE TABLE `amount_coupon_policy`
(

    `coupon_price_policy_id` BIGINT       NOT NULL PRIMARY KEY COMMENT '쿠폰 가격 정책 식별번호',
    `discount_amount`        INT UNSIGNED NOT NULL COMMENT '할인금액'
);
DROP TABLE IF EXISTS `percent_coupon_policy`;
CREATE TABLE `percent_coupon_policy`
(

    `coupon_price_policy_id` BIGINT        NOT NULL PRIMARY KEY COMMENT '쿠폰 가격 정책 식별번호',
    `rate`                   DECIMAL(3, 1) NOT NULL COMMENT '할인율',
    `max_discount_amount`    INT UNSIGNED  NOT NULL COMMENT '최대 할인 금액'
);
DROP TABLE IF EXISTS `coupon_policy`;
CREATE TABLE `coupon_policy`
(

    `coupon_policy_id`       BIGINT      NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '쿠폰 정책 식별번호',
    `coupon_price_policy_id` BIGINT      NOT NULL COMMENT '쿠폰가격 정책 식별번호',
    `image_id`               BIGINT      NULL COMMENT '이미지 식별번호',
    `coupon_code`            CHAR(2)     NOT NULL COMMENT '쿠폰 타입 코드',
    `name`                   VARCHAR(50) NOT NULL COMMENT '이름',
    `description`            TEXT        NOT NULL COMMENT '설명',
    `begin_datetime`         DATETIME    NOT NULL COMMENT '시작일시',
    `expire_datetime`        DATETIME    NULL COMMENT '종료일시',
    `user_rank_code`         CHAR(2)     NOT NULL DEFAULT 'A1' COMMENT '적용 회원등급 코드'
);
DROP TABLE IF EXISTS `issue_coupon`;
CREATE TABLE `issue_coupon`
(

    `issue_coupon_id`  BIGINT   NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '발급쿠폰 식별번호',
    `coupon_policy_id` BIGINT   NOT NULL COMMENT '쿠폰 정책 식별번호',
    `issue_datetime`   DATETIME NOT NULL DEFAULT now() COMMENT '발급일시',
    `expire_datetime`  DATETIME NOT NULL COMMENT '종료일시',
    `use_datetime`     DATETIME NULL COMMENT '사용일시'
);
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`
(

    `banner_id`      BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '배너 식별번호',
    `image_id`       BIGINT       NOT NULL COMMENT '이미지 식별번호',
    `content`        TEXT         NOT NULL COMMENT '컨텐츠',
    `start_datetime` DATETIME     NOT NULL COMMENT '시작일시',
    `end_datetime`   DATETIME     NOT NULL COMMENT '종료일시',
    `order`          INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '순서'
);
DROP TABLE IF EXISTS `banner_coupon`;
CREATE TABLE `banner_coupon`
(

    `banner_coupon_id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '배너 쿠폰 식별번호',
    `banner_id`        BIGINT NOT NULL COMMENT '배너 식별번호',
    `coupon_policy_id` BIGINT NOT NULL COMMENT '쿠폰 식별번호'
);
DROP TABLE IF EXISTS `user_issue_coupon`;
CREATE TABLE `user_issue_coupon`
(

    `user_issue_coupon_id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '회원 발급 쿠폰 식별번호',
    `issue_coupon_id`      BIGINT NOT NULL COMMENT '발급쿠폰 식별번호',
    `user_id`              BIGINT NOT NULL COMMENT '회원 식별번호'
);
DROP TABLE IF EXISTS `coupon_type`;
CREATE TABLE `coupon_type`
(

    `coupon_code` CHAR(2)     NOT NULL PRIMARY KEY COMMENT '쿠폰 타입 코드',
    `name`        VARCHAR(50) NOT NULL COMMENT '쿠폰 타입 이름'
);
DROP TABLE IF EXISTS `coupon_bound_type`;
CREATE TABLE `coupon_bound_type`
(

    `coupon_bound_code` CHAR(2)     NOT NULL PRIMARY KEY COMMENT '적용범위 코드',
    `name`              VARCHAR(25) NOT NULL COMMENT '적용범위 이름'
);
DROP TABLE IF EXISTS `coupon_policy_coupon_bound`;
CREATE TABLE `coupon_policy_coupon_bound`
(

    `coupon_policy_coupon_bound_id` BIGINT  NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '쿠폰 정책 쿠폰 적용범위 식별번호',
    `coupon_policy_id`              BIGINT  NOT NULL COMMENT '쿠폰 정책 식별번호',
    `coupon_bound_code`             CHAR(2) NOT NULL COMMENT '적용범위 코드',
    `table_identity`                BIGINT  NULL COMMENT '적용 부분 식별키',
    `table_code`                    CHAR(2) NULL COMMENT '적용코드 식별키'
);


ALTER TABLE `amount_coupon_policy`
    ADD CONSTRAINT FOREIGN KEY (coupon_price_policy_id) REFERENCES `coupon_price_policy` (`coupon_price_policy_id`);


ALTER TABLE `percent_coupon_policy`
    ADD CONSTRAINT FOREIGN KEY (coupon_price_policy_id) REFERENCES `coupon_price_policy` (`coupon_price_policy_id`);


ALTER TABLE `coupon_policy`
    ADD CONSTRAINT FOREIGN KEY (coupon_price_policy_id) REFERENCES `coupon_price_policy` (`coupon_price_policy_id`);

ALTER TABLE `issue_coupon`
    ADD CONSTRAINT FOREIGN KEY (coupon_policy_id) REFERENCES `coupon_policy` (`coupon_policy_id`);


ALTER TABLE `banner_coupon`
    ADD CONSTRAINT FOREIGN KEY (banner_id) REFERENCES `banner` (`banner_id`);
ALTER TABLE `banner_coupon`
    ADD CONSTRAINT FOREIGN KEY (coupon_policy_id) REFERENCES `coupon_policy` (`coupon_policy_id`);


ALTER TABLE `user_issue_coupon`
    ADD CONSTRAINT FOREIGN KEY (issue_coupon_id) REFERENCES `issue_coupon` (`issue_coupon_id`);


ALTER TABLE `coupon_policy_coupon_bound`
    ADD CONSTRAINT FOREIGN KEY (coupon_policy_id) REFERENCES `coupon_policy` (`coupon_policy_id`);
