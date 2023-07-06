drop DATABASE if exists baegopa_coupon_prod;
create DATABASE baegopa_coupon_prod;
use baegopa_coupon_prod;

DROP TABLE IF EXISTS `coupon_price_policy`;
CREATE TABLE `coupon_price_policy`
(

    `coupon_price_policy_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '쿠폰가격 정책 식별번호',
    `target_amount`          INT UNSIGNED NOT NULL COMMENT '대상금액',
    `name`                   VARCHAR(50)  NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `brand_coupon_vendor`;
CREATE TABLE `brand_coupon_vendor`
(

    `coupon_policy_id` BIGINT NOT NULL PRIMARY KEY COMMENT '쿠폰 정책 식별번호',
    `brand_id`         BIGINT NOT NULL COMMENT '가맹본사 식별번호'
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

    `coupon_price_policy_id` BIGINT       NOT NULL PRIMARY KEY COMMENT '쿠폰 가격 정책 식별번호',
    `rate`                   DECIMAL      NOT NULL COMMENT '할인율',
    `max_discount_amount`    INT UNSIGNED NOT NULL COMMENT '최대 할인 금액'
);
DROP TABLE IF EXISTS `coupon_policy`;
CREATE TABLE `coupon_policy`
(

    `coupon_policy_id`       BIGINT      NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '쿠폰 정책 식별번호',
    `coupon_price_policy_id` BIGINT      NOT NULL COMMENT '쿠폰 정책 식별번호',
    `image_id`               BIGINT      NULL COMMENT '이미지 식별번호',
    `name`                   VARCHAR(50) NOT NULL COMMENT '이름',
    `description`            TEXT        NOT NULL COMMENT '설명',
    `begin_datetime`         DATETIME    NOT NULL COMMENT '시작일시',
    `expire_datetime`        DATETIME    NOT NULL COMMENT '종료일시'
);
DROP TABLE IF EXISTS `anniversary_coupon_vendor`;
CREATE TABLE `anniversary_coupon_vendor`
(

    `anniversary_coupon_vendor_id` BIGINT  NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '회원의 기념일 쿠폰 지급 식별번호',
    `coupon_policy_id`             BIGINT  NOT NULL COMMENT '쿠폰 식별번호',
    `anniversary_type_code`        CHAR(2) NOT NULL COMMENT '기념일 코드',
    `user_rank_code`               CHAR(2) NOT NULL COMMENT '회원등급 코드'
);
DROP TABLE IF EXISTS `user_rate_coupon_vendor`;
CREATE TABLE `user_rate_coupon_vendor`
(

    `user_rate_coupon_vendor_id` BIGINT  NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '회원등급 쿠폰 지급 식별번호',
    `user_rank_code`             CHAR(2) NOT NULL COMMENT '회원등급 코드',
    `coupon_policy_id`           BIGINT  NOT NULL COMMENT '쿠폰 식별번호'
);
DROP TABLE IF EXISTS `total_coupon`;
CREATE TABLE `total_coupon`
(

    `coupon_policy_id` BIGINT NOT NULL PRIMARY KEY COMMENT '전체쿠폰 식별번호'
);
DROP TABLE IF EXISTS `store_category_coupon_vendor`;
CREATE TABLE `store_category_coupon_vendor`
(

    `coupon_policy_id`  BIGINT NOT NULL PRIMARY KEY COMMENT '쿠폰 정책 식별번호',
    `store_category_id` BIGINT NOT NULL COMMENT '매장 카테고리 식별번호'
);
DROP TABLE IF EXISTS `menu_category_coupon_vendor`;
CREATE TABLE `menu_category_coupon_vendor`
(

    `coupon_policy_id` BIGINT NOT NULL PRIMARY KEY COMMENT '쿠폰 정책 식별번호',
    `menu_category_id` BIGINT NOT NULL COMMENT '메뉴 카테고리 식별번호'
);
DROP TABLE IF EXISTS `issue_coupon`;
CREATE TABLE `issue_coupon`
(

    `issue_coupon_id`  BIGINT   NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '발급쿠폰 식별번호',
    `coupon_policy_id` BIGINT   NOT NULL COMMENT '쿠폰 정책 식별번호',
    `issue_datetime`   DATETIME NOT NULL DEFAULT now() COMMENT '발급일시',
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
DROP TABLE IF EXISTS `event_coupon_vendor`;
CREATE TABLE `event_coupon_vendor`
(

    `event_coupon_vendor_id` BIGINT   NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '이벤트 쿠폰 지급 식별번호',
    `coupon_policy_id`       BIGINT   NOT NULL COMMENT '쿠폰 식별번호',
    `user_rank_code`         CHAR(2)  NOT NULL COMMENT '회원등급 코드',
    `event_datetime`         DATETIME NOT NULL COMMENT '이벤트 일시'
);



ALTER TABLE `brand_coupon_vendor`
    ADD CONSTRAINT FOREIGN KEY (coupon_policy_id) REFERENCES `coupon_policy` (`coupon_policy_id`);



ALTER TABLE `amount_coupon_policy`
    ADD CONSTRAINT FOREIGN KEY (coupon_price_policy_id) REFERENCES `coupon_price_policy` (`coupon_price_policy_id`);



ALTER TABLE `percent_coupon_policy`
    ADD CONSTRAINT FOREIGN KEY (coupon_price_policy_id) REFERENCES `coupon_price_policy` (`coupon_price_policy_id`);



ALTER TABLE `coupon_policy`
    ADD CONSTRAINT FOREIGN KEY (coupon_price_policy_id) REFERENCES `coupon_price_policy` (`coupon_price_policy_id`);



ALTER TABLE `anniversary_coupon_vendor`
    ADD CONSTRAINT FOREIGN KEY (coupon_policy_id) REFERENCES `coupon_policy` (`coupon_policy_id`);



ALTER TABLE `user_rate_coupon_vendor`
    ADD CONSTRAINT FOREIGN KEY (coupon_policy_id) REFERENCES `coupon_policy` (`coupon_policy_id`);



ALTER TABLE `total_coupon`
    ADD CONSTRAINT FOREIGN KEY (coupon_policy_id) REFERENCES `coupon_policy` (`coupon_policy_id`);



ALTER TABLE `store_category_coupon_vendor`
    ADD CONSTRAINT FOREIGN KEY (coupon_policy_id) REFERENCES `coupon_policy` (`coupon_policy_id`);



ALTER TABLE `menu_category_coupon_vendor`
    ADD CONSTRAINT FOREIGN KEY (coupon_policy_id) REFERENCES `coupon_policy` (`coupon_policy_id`);



ALTER TABLE `issue_coupon`
    ADD CONSTRAINT FOREIGN KEY (coupon_policy_id) REFERENCES `coupon_policy` (`coupon_policy_id`);



ALTER TABLE `banner_coupon`
    ADD CONSTRAINT FOREIGN KEY (banner_id) REFERENCES `banner` (`banner_id`);
ALTER TABLE `banner_coupon`
    ADD CONSTRAINT FOREIGN KEY (coupon_policy_id) REFERENCES `coupon_policy` (`coupon_policy_id`);



ALTER TABLE `event_coupon_vendor`
    ADD CONSTRAINT FOREIGN KEY (coupon_policy_id) REFERENCES `coupon_policy` (`coupon_policy_id`);


