drop DATABASE if exists baegopa_store_dev;
create DATABASE baegopa_store_dev;
use baegopa_store_dev;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(

    `user_id`             BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '회원 식별번호',
    `user_rank_code`      char(2)      NOT NULL COMMENT '회원등급 코드',
    `user_status_code`    char(2)      NOT NULL COMMENT '회원상태 코드',
    `image_id`            BIGINT       NULL COMMENT '프로필 이미지 식별번호',
    `login_id`            VARCHAR(255) NOT NULL UNIQUE COMMENT '로그인 아이디',
    `password`            CHAR(60)     NOT NULL COMMENT '비밀번호',
    `name`                VARCHAR(50)  NOT NULL COMMENT '이름',
    `email`               VARCHAR(320) NOT NULL COMMENT '이메일',
    `nickname`            VARCHAR(50)  NOT NULL COMMENT '닉네임',
    `last_login_datetime` DATETIME     NULL COMMENT '최근접속일시',
    `tel`                 VARCHAR(25)  NOT NULL COMMENT '전화번호',
    `register_datetime`   DATETIME     NOT NULL DEFAULT now() COMMENT '회원가입일시',
    `is_delete`           BOOLEAN      NOT NULL DEFAULT FALSE COMMENT '삭제여부'
);
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`
(

    `address_id` BIGINT          NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '주소 식별번호',
    `zone_code`  char(5)         NOT NULL COMMENT '우편번호',
    `address`    VARCHAR(200)    NOT NULL UNIQUE COMMENT '주소',
    `latitude`   decimal(16, 13) NOT NULL COMMENT '위도',
    `longitude`  decimal(16, 13) NOT NULL COMMENT '경도'
);
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address`
(

    `user_address_id` BIGINT      NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '회원 주소록 식별번호',
    `user_id`         BIGINT      NOT NULL COMMENT '회원 식별번호',
    `address_id`      BIGINT      NOT NULL COMMENT '주소 식별번호',
    `is_main`         BOOLEAN     NOT NULL DEFAULT FALSE COMMENT '대표여부',
    `alias`           VARCHAR(50) NOT NULL COMMENT '별칭',
    `detail_address`  VARCHAR(50) NOT NULL COMMENT '상세주소'
);
DROP TABLE IF EXISTS `user_status`;
CREATE TABLE `user_status`
(

    `user_status_code` CHAR(2)     NOT NULL PRIMARY KEY COMMENT '회원 상태 코드',
    `name`             VARCHAR(10) NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `oauth_login`;
CREATE TABLE `oauth_login`
(

    `oauth_login_id`  BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '소셜 로그인 식별번호',
    `user_id`         BIGINT       NOT NULL COMMENT '회원 식별번호',
    `oauth_type_code` CHAR(2)      NOT NULL COMMENT '소셜 로그인 코드',
    `oauth_login_no`  VARCHAR(255) NOT NULL COMMENT '소셜 로그인 식별번호'
);
DROP TABLE IF EXISTS `oauth_type`;
CREATE TABLE `oauth_type`
(

    `oauth_type_code` char(2)     NOT NULL PRIMARY KEY COMMENT '소셜 로그인 타입 코드',
    `name`            VARCHAR(10) NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`
(

    `role_code` CHAR(2)     NOT NULL PRIMARY KEY COMMENT '역할 코드',
    `name`      VARCHAR(10) NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store`
(

    `store_id`               BIGINT        NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '매장 식별번호',
    `brand_id`               BIGINT        NULL COMMENT '가맹본사 식별번호',
    `address_id`             BIGINT        NOT NULL COMMENT '주소 식별번호',
    `delivery_price_id`      BIGINT        NOT NULL COMMENT '배달료 식별변호',
    `image_id`               BIGINT        NULL COMMENT '매장 썸네일 이미지 식별번호',
    `logo_image_id`          BIGINT        NULL COMMENT '매장 로고 이미지 식별번호',
    `store_business_info_id` BIGINT        NOT NULL COMMENT '사업자정보 식별번호',
    `address_detail`         VARCHAR(50)   NOT NULL COMMENT '상세주소',
    `name`                   VARCHAR(50)   NOT NULL COMMENT '이름',
    `tel`                    VARCHAR(25)   NOT NULL COMMENT '전화번호',
    `main_point_rate`        DECIMAL(3, 1) NOT NULL DEFAULT 0 COMMENT '포인트 적립률',
    `is_delete`              BOOLEAN       NOT NULL DEFAULT FALSE COMMENT '삭제여부',
    `description`            TEXT          NULL COMMENT '소개문구'
);
DROP TABLE IF EXISTS `user_store`;
CREATE TABLE `user_store`
(

    `user_store_id` BIGINT  NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '회원 매장 식별번호',
    `user_id`       BIGINT  NOT NULL COMMENT '회원 식별번호',
    `role_code`     CHAR(2) NOT NULL COMMENT '역할 코드',
    `store_id`      BIGINT  NOT NULL COMMENT '매장 식별번호'
);
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand`
(

    `brand_id` BIGINT      NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '가맹본사 식별번호',
    `name`     VARCHAR(50) NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `store_category`;
CREATE TABLE `store_category`
(

    `store_category_code` char(2)     NOT NULL PRIMARY KEY COMMENT '매장 카테고리 코드',
    `name`                VARCHAR(30) NOT NULL COMMENT '매장 카테고리 이름'
);
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`
(

    `menu_id`          BIGINT        NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '메뉴 식별번호',
    `menu_category_id` BIGINT        NOT NULL COMMENT '메뉴 카테고리 식별번호',
    `image_id`         BIGINT        NULL COMMENT '이미지 식별번호',
    `name`             VARCHAR(100)  NOT NULL COMMENT '메뉴이름',
    `description`      TEXT          NULL COMMENT '메뉴설명',
    `price`            INT UNSIGNED  NOT NULL COMMENT '메뉴가격',
    `time`             TIME          NOT NULL DEFAULT '00:00' COMMENT '조리시간',
    `point_rate`       DECIMAL(3, 1) NULL     DEFAULT 0 COMMENT '포인트 적립률',
    `order`            INT UNSIGNED  NOT NULL DEFAULT 0 COMMENT '순서',
    `is_delete`        BOOLEAN       NOT NULL DEFAULT FALSE COMMENT '삭제여부',
    `is_visible`       BOOLEAN       NOT NULL DEFAULT TRUE COMMENT '보이기여부'
);
DROP TABLE IF EXISTS `close`;
CREATE TABLE `close`
(

    `close_id`   BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '휴일 식별번호',
    `store_id`   BIGINT NOT NULL COMMENT '매장 식별번호',
    `close_date` DATE   NOT NULL COMMENT '휴일'
);
DROP TABLE IF EXISTS `open`;
CREATE TABLE `open`
(

    `open_id`    BIGINT  NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '운영시간 식별번호',
    `day_code`   CHAR(2) NOT NULL COMMENT '요일 코드',
    `store_id`   BIGINT  NOT NULL COMMENT '매장 식별번호',
    `open_time`  TIME    NOT NULL COMMENT '시작시간',
    `close_time` TIME    NOT NULL COMMENT '종료시간'
);
DROP TABLE IF EXISTS `day`;
CREATE TABLE `day`
(

    `day_code` CHAR(2)    NOT NULL PRIMARY KEY COMMENT '요일 코드',
    `name`     VARCHAR(3) NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`
(

    `order_id`       BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '주문 식별번호',
    `user_id`        BIGINT       NOT NULL COMMENT '회원 식별번호',
    `user_address`   VARCHAR(200) NOT NULL COMMENT '기본 주소',
    `detail_address` VARCHAR(100) NOT NULL COMMENT '상세 주소',
    `req_memo`       VARCHAR(255) NULL COMMENT '요청메모',
    `order_datetime` DATETIME     NOT NULL DEFAULT now() COMMENT '주문일시'
);
DROP TABLE IF EXISTS `menu_sub_menu`;
CREATE TABLE `menu_sub_menu`
(

    `menu_sub_menu_id`     BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '메뉴 보조메뉴 식별번호',
    `main_menu_id`         BIGINT       NOT NULL COMMENT '주메뉴 식별번호',
    `sub_menu_id`          BIGINT       NOT NULL COMMENT '보조메뉴 식별번호',
    `sub_menu_category_id` BIGINT       NOT NULL COMMENT '보조메뉴 카테고리 식별번호',
    `name`                 VARCHAR(100) NULL COMMENT '이름',
    `order`                INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '순서',
    `price`                INT UNSIGNED NULL COMMENT '가격'
);
DROP TABLE IF EXISTS `menu_category`;
CREATE TABLE `menu_category`
(

    `menu_category_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '메뉴 카테고리 식별번호',
    `store_id`         BIGINT       NOT NULL COMMENT '매장 식별번호',
    `name`             VARCHAR(30)  NOT NULL COMMENT '이름',
    `order`            INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '순서',
    `is_delete`        boolean      NOT NULL DEFAULT FALSE COMMENT '삭제여부'
);
DROP TABLE IF EXISTS `option`;
CREATE TABLE `option`
(

    `option_id`          BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '옵션 식별번호',
    `option_category_id` BIGINT       NOT NULL COMMENT '옵션 카테고리 식별번호',
    `name`               VARCHAR(100) NOT NULL COMMENT '이름',
    `price`              INT UNSIGNED NOT NULL COMMENT '가격',
    `time`               TIME         NOT NULL DEFAULT '00:00' COMMENT '조리시간'
);
DROP TABLE IF EXISTS `menu_option`;
CREATE TABLE `menu_option`
(

    `menu_option_id`     BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '메뉴 옵션 식별번호',
    `option_category_id` BIGINT       NOT NULL COMMENT '옵션 카테고리 식별번호',
    `menu_id`            BIGINT       NOT NULL COMMENT '메뉴 식별번호',
    `order`              INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '순서'
);
DROP TABLE IF EXISTS `option_category`;
CREATE TABLE `option_category`
(

    `option_category_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '옵션 카테고리 식별번호',
    `name`               VARCHAR(30)  NOT NULL COMMENT '이름',
    `order`              INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '순서'
);
DROP TABLE IF EXISTS `brand_menu`;
CREATE TABLE `brand_menu`
(

    `brand_menu_id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '가맹본사 메뉴 식별번호',
    `brand_id`      BIGINT NOT NULL COMMENT '가맹본사 식별번호',
    `menu_id`       BIGINT NOT NULL COMMENT '메뉴 식별번호'
);
DROP TABLE IF EXISTS `store_menu`;
CREATE TABLE `store_menu`
(

    `store_menu_id` BIGINT  NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '매장 메뉴 식별번호',
    `store_id`      BIGINT  NOT NULL COMMENT '매장 식별번호',
    `menu_id`       BIGINT  NOT NULL COMMENT '메뉴 식별번호',
    `is_sold_out`   BOOLEAN NOT NULL DEFAULT FALSE COMMENT '판매 가능 여부'
);

DROP TABLE IF EXISTS `point`;
CREATE TABLE `point`
(

    `point_id`        BIGINT      NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '포인트 내역 식별번호',
    `user_id`         BIGINT      NOT NULL COMMENT '회원 식별번호',
    `order_id`        BIGINT      NULL COMMENT '주문 식별번호',
    `point`           INT         NOT NULL COMMENT '포인트',
    `reason`          VARCHAR(30) NOT NULL COMMENT '사유',
    `create_datetime` DATETIME    NOT NULL DEFAULT now() COMMENT '생성일시'
);
DROP TABLE IF EXISTS `order_state`;
CREATE TABLE `order_state`
(

    `order_state_code` CHAR(2)     NOT NULL PRIMARY KEY COMMENT '주문 상태 코드',
    `name`             VARCHAR(20) NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `order_menu`;
CREATE TABLE `order_menu`
(

    `order_menu_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '주문 상세 식별번호',
    `store_menu_id` BIGINT       NOT NULL COMMENT '매장 메뉴 식별번호',
    `order_id`      BIGINT       NOT NULL COMMENT '주문 식별번호',
    `price`         INT UNSIGNED NOT NULL COMMENT '메뉴 가격',
    `name`          VARCHAR(50)  NOT NULL COMMENT '메뉴 이름',
    `count`         INT UNSIGNED NOT NULL DEFAULT 1 COMMENT '주문 수량'
);
DROP TABLE IF EXISTS `pay`;
CREATE TABLE `pay`
(

    `pay_id`          BIGINT      NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '결제 식별번호',
    `order_id`        BIGINT      NOT NULL COMMENT '주문 식별번호',
    `pay_type_code`   CHAR(2)     NOT NULL COMMENT '결제 방법 코드',
    `pay_status_code` CHAR(2)     NOT NULL COMMENT '결제 상태 코드',
    `pay_datetime`    DATETIME    NOT NULL DEFAULT now() COMMENT '결제일시',
    `result`          VARCHAR(50) NOT NULL COMMENT '결과'
);
DROP TABLE IF EXISTS `order_state_history`;
CREATE TABLE `order_state_history`
(

    `order_state_history_id` BIGINT   NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '주문 상태 변경이력 식별번호',
    `order_state_code`       CHAR(2)  NOT NULL COMMENT '주문상태 코드',
    `order_id`               BIGINT   NOT NULL COMMENT '주문 식별번호',
    `create_datetime`        DATETIME NOT NULL DEFAULT now() COMMENT '생성일시'
);
DROP TABLE IF EXISTS `pay_type`;
CREATE TABLE `pay_type`
(

    `pay_type_code` CHAR(2)     NOT NULL PRIMARY KEY COMMENT '결제 방법 코드',
    `name`          VARCHAR(20) NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `pay_status`;
CREATE TABLE `pay_status`
(

    `pay_status_code` CHAR(2)     NOT NULL PRIMARY KEY COMMENT '결제상태 코드',
    `name`            VARCHAR(50) NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `menu_review`;
CREATE TABLE `menu_review`
(

    `menu_review_id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '메뉴 리뷰 식별번호',
    `image_id`       BIGINT NOT NULL COMMENT '이미지 식별번호',
    `review_id`      BIGINT NOT NULL COMMENT '리뷰 식별번호',
    `store_menu_id`  BIGINT NOT NULL COMMENT '매장 메뉴 식별번호',
    `content`        TEXT   NOT NULL COMMENT '내용',
    `grade`          INT    NOT NULL DEFAULT 1 COMMENT '평점'
);
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`
(

    `review_id`        BIGINT   NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '리뷰 식별번호',
    `parent_review_id` BIGINT   NULL COMMENT '부모 리뷰 식별번호',
    `user_id`          BIGINT   NOT NULL COMMENT '회원식별번호',
    `store_id`         BIGINT   NOT NULL COMMENT '주문 식별번호',
    `content`          TEXT     NOT NULL COMMENT '내용',
    `grade`            INT      NOT NULL DEFAULT 1 COMMENT '평점',
    `write_datetime`   DATETIME NOT NULL DEFAULT now() COMMENT '작성일시'
);

DROP TABLE IF EXISTS `order_menu_sub_menu`;
CREATE TABLE `order_menu_sub_menu`
(

    `order_menu_sub_menu_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '주문메뉴 보조메뉴 식별번호',
    `order_menu_id`          BIGINT       NOT NULL COMMENT '주문 메뉴 식별번호',
    `name`                   VARCHAR(100) NOT NULL COMMENT '주문 메뉴 보조메뉴',
    `price`                  INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '주문 메뉴 가격'
);
DROP TABLE IF EXISTS `anniversary_type`;
CREATE TABLE `anniversary_type`
(

    `anniversary_type_code` CHAR(2)     NOT NULL PRIMARY KEY COMMENT '기념일 타입 코드',
    `name`                  VARCHAR(50) NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `user_anniversary`;
CREATE TABLE `user_anniversary`
(

    `user_anniversary_id`   BIGINT  NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '회원 기념일 정보 식별번호',
    `user_id`               BIGINT  NOT NULL COMMENT '회원 식별번호',
    `anniversary_type_code` CHAR(2) NOT NULL COMMENT '기념일 코드',
    `anniversary_date`      DATE    NULL COMMENT '기념일'
);
DROP TABLE IF EXISTS `user_notification_type`;
CREATE TABLE `user_notification_type`
(

    `user_notification_type_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '회원 푸시 알림 식별번호',
    `notification_type_code`    CHAR(2)      NOT NULL COMMENT '푸시 알림 코드',
    `user_id`                   BIGINT       NOT NULL COMMENT '회원 식별번호',
    `token`                     VARCHAR(100) NULL COMMENT '토큰',
    `url`                       VARCHAR(100) NULL COMMENT 'url'
);
DROP TABLE IF EXISTS `notification_type`;
CREATE TABLE `notification_type`
(

    `notification_type_code` CHAR(2)     NOT NULL PRIMARY KEY COMMENT '푸시 알림 타입 코드',
    `name`                   VARCHAR(50) NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `user_store_notification_type`;
CREATE TABLE `user_store_notification_type`
(

    `user_store_notification_type_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '매장 회원 푸시 알림 식별번호',
    `user_store_id`                   BIGINT       NOT NULL COMMENT '회원 매장 식별번호',
    `notification_type_code`          CHAR(2)      NOT NULL COMMENT '푸시 알림 코드',
    `token`                           VARCHAR(100) NULL COMMENT '토큰',
    `url`                             VARCHAR(100) NULL COMMENT 'url'
);
DROP TABLE IF EXISTS `delivery_price`;
CREATE TABLE `delivery_price`
(

    `delivery_price_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '배달료 식별변호',
    `price`             INT UNSIGNED NOT NULL COMMENT '가격'
);
DROP TABLE IF EXISTS `reward_point_type`;
CREATE TABLE `reward_point_type`
(

    `reward_point_type_code` CHAR(2)      NOT NULL PRIMARY KEY COMMENT '지급 포인트 타입 코드',
    `name`                   VARCHAR(100) NOT NULL COMMENT '이름',
    `reward_point`           INT UNSIGNED NOT NULL COMMENT '지급 포인트'
);
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image`
(

    `image_id`      BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '이미지 식별번호',
    `name`          CHAR(36)     NOT NULL COMMENT '이미지 이름',
    `original_name` VARCHAR(255) NOT NULL COMMENT '이미지 실제이름',
    `ext`           VARCHAR(20)  NOT NULL COMMENT '확장자',
    `folder_name`   VARCHAR(50)  NOT NULL COMMENT '폴더이름',
    `uploader_id`   BIGINT       NOT NULL COMMENT '업로더 식별번호',
    `is_private`    boolean      NOT NULL COMMENT '공개여부'
);
DROP TABLE IF EXISTS `user_rank`;
CREATE TABLE `user_rank`
(

    `user_rank_code` char(2)     NOT NULL PRIMARY KEY COMMENT '회원 코드',
    `name`           varchar(10) NOT NULL COMMENT '이름'
);
DROP TABLE IF EXISTS `review_image`;
CREATE TABLE `review_image`
(

    `review_image_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '리뷰 이미지 식별번호',
    `review_id`       BIGINT       NOT NULL COMMENT '리뷰 식별번호',
    `image_id`        BIGINT       NOT NULL COMMENT '이미지 식별번호',
    `order`           INT UNSIGNED NOT NULL COMMENT '순서'
);
DROP TABLE IF EXISTS `order_coupon`;
CREATE TABLE `order_coupon`
(

    `order_coupon`    BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '주문 쿠폰 식별번호',
    `order_id`        BIGINT NOT NULL COMMENT '주문 식별번호',
    `issue_coupon_id` BIGINT NOT NULL COMMENT '발급쿠폰 식별번호'
);

DROP TABLE IF EXISTS `user_menu`;
CREATE TABLE `user_menu`
(

    `user_menu_id`  BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '장바구니 식별번호',
    `user_id`       BIGINT       NOT NULL COMMENT '회원 식별번호',
    `store_menu_id` BIGINT       NOT NULL COMMENT '매장 메뉴 식별번호',
    `count`         INT UNSIGNED NOT NULL DEFAULT 1 COMMENT '주문 수량'
);
DROP TABLE IF EXISTS `user_menu_option`;
CREATE TABLE `user_menu_option`
(

    `user_menu_option_id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '유저 메뉴 식별번호',
    `user_menu_id`        BIGINT NOT NULL COMMENT '장바구니 식별번호',
    `menu_option_id`      BIGINT NOT NULL COMMENT '메뉴 옵션 식별번호'
);
DROP TABLE IF EXISTS `user_menu_sub_menu`;
CREATE TABLE `user_menu_sub_menu`
(

    `user_menu_sub_menu_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '유저메뉴 보조메뉴 식별번호',
    `menu_sub_menu_id`      BIGINT       NOT NULL COMMENT '메뉴 보조메뉴 식별번호',
    `user_menu_id`          BIGINT       NOT NULL COMMENT '장바구니 식별번호',
    `count`                 INT UNSIGNED NOT NULL DEFAULT 1 COMMENT '주문 수량'
);
DROP TABLE IF EXISTS `store_store_category`;
CREATE TABLE `store_store_category`
(

    `store_store_category_id` BIGINT  NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '매장 매장 카테고리 식별번호',
    `store_category_code`     char(2) NOT NULL COMMENT '매장 카테고리 코드',
    `store_id`                BIGINT  NOT NULL COMMENT '매장 식별번호'
);
DROP TABLE IF EXISTS `sub_menu_category`;
CREATE TABLE `sub_menu_category`
(

    `sub_menu_category_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '보조메뉴 카테고리 식별번호',
    `menu_id`              BIGINT       NOT NULL COMMENT '메뉴 식별번호',
    `name`                 VARCHAR(30)  NOT NULL COMMENT '이름',
    `order`                INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '순서'
);
DROP TABLE IF EXISTS `store_business_info`;
CREATE TABLE `store_business_info`
(

    `store_business_info_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '사업자정보 식별번호',
    `image_id`               BIGINT       NOT NULL COMMENT '사업자 등록증 이미지 식별번호',
    `registration_number`    CHAR(10)     NOT NULL COMMENT '사업자 등록 번호',
    `representative`         VARCHAR(50)  NOT NULL COMMENT '사업자 등록 대표자 이름',
    `established_date`       DATE         NOT NULL COMMENT '사업자 등록 개업연월일',
    `business_name`          VARCHAR(100) NOT NULL COMMENT '상호명'

);
DROP TABLE IF EXISTS `order_menu_option`;
CREATE TABLE `order_menu_option`
(

    `order_menu_option_id` BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '주문 메뉴 식별번호',
    `order_menu_id`        BIGINT       NOT NULL COMMENT '주문 메뉴 식별번호',
    `name`                 VARCHAR(100) NOT NULL COMMENT '주문 메뉴 옵션',
    `price`                INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '주문 메뉴 옵션 가격'
);


ALTER TABLE `user`
    ADD CONSTRAINT FOREIGN KEY (user_rank_code) REFERENCES `user_rank` (`user_rank_code`);
ALTER TABLE `user`
    ADD CONSTRAINT FOREIGN KEY (user_status_code) REFERENCES `user_status` (`user_status_code`);
ALTER TABLE `user`
    ADD CONSTRAINT FOREIGN KEY (image_id) REFERENCES `image` (`image_id`);



ALTER TABLE `user_address`
    ADD CONSTRAINT FOREIGN KEY (user_id) REFERENCES `user` (`user_id`);
ALTER TABLE `user_address`
    ADD CONSTRAINT FOREIGN KEY (address_id) REFERENCES `address` (`address_id`);



ALTER TABLE `oauth_login`
    ADD CONSTRAINT FOREIGN KEY (user_id) REFERENCES `user` (`user_id`);
ALTER TABLE `oauth_login`
    ADD CONSTRAINT FOREIGN KEY (oauth_type_code) REFERENCES `oauth_type` (`oauth_type_code`);



ALTER TABLE `store`
    ADD CONSTRAINT FOREIGN KEY (brand_id) REFERENCES `brand` (`brand_id`);
ALTER TABLE `store`
    ADD CONSTRAINT FOREIGN KEY (address_id) REFERENCES `address` (`address_id`);
ALTER TABLE `store`
    ADD CONSTRAINT FOREIGN KEY (delivery_price_id) REFERENCES `delivery_price` (`delivery_price_id`);
ALTER TABLE `store`
    ADD CONSTRAINT FOREIGN KEY (image_id) REFERENCES `image` (`image_id`);
ALTER TABLE `store`
    ADD CONSTRAINT FOREIGN KEY (logo_image_id) REFERENCES `image` (`image_id`);
ALTER TABLE `store`
    ADD CONSTRAINT FOREIGN KEY (store_business_info_id) REFERENCES `store_business_info` (`store_business_info_id`);



ALTER TABLE `user_store`
    ADD CONSTRAINT FOREIGN KEY (user_id) REFERENCES `user` (`user_id`);
ALTER TABLE `user_store`
    ADD CONSTRAINT FOREIGN KEY (role_code) REFERENCES `role` (`role_code`);
ALTER TABLE `user_store`
    ADD CONSTRAINT FOREIGN KEY (store_id) REFERENCES `store` (`store_id`);



ALTER TABLE `menu`
    ADD CONSTRAINT FOREIGN KEY (menu_category_id) REFERENCES `menu_category` (`menu_category_id`);
ALTER TABLE `menu`
    ADD CONSTRAINT FOREIGN KEY (image_id) REFERENCES `image` (`image_id`);



ALTER TABLE `close`
    ADD CONSTRAINT FOREIGN KEY (store_id) REFERENCES `store` (`store_id`);



ALTER TABLE `open`
    ADD CONSTRAINT FOREIGN KEY (day_code) REFERENCES `day` (`day_code`);
ALTER TABLE `open`
    ADD CONSTRAINT FOREIGN KEY (store_id) REFERENCES `store` (`store_id`);



ALTER TABLE `order`
    ADD CONSTRAINT FOREIGN KEY (user_id) REFERENCES `user` (`user_id`);



ALTER TABLE `menu_sub_menu`
    ADD CONSTRAINT FOREIGN KEY (main_menu_id) REFERENCES `menu` (`menu_id`);
ALTER TABLE `menu_sub_menu`
    ADD CONSTRAINT FOREIGN KEY (sub_menu_id) REFERENCES `menu` (`menu_id`);
ALTER TABLE `menu_sub_menu`
    ADD CONSTRAINT FOREIGN KEY (sub_menu_category_id) REFERENCES `sub_menu_category` (`sub_menu_category_id`);



ALTER TABLE `menu_category`
    ADD CONSTRAINT FOREIGN KEY (store_id) REFERENCES `store` (`store_id`);



ALTER TABLE `option`
    ADD CONSTRAINT FOREIGN KEY (option_category_id) REFERENCES `option_category` (`option_category_id`);



ALTER TABLE `menu_option`
    ADD CONSTRAINT FOREIGN KEY (option_category_id) REFERENCES `option_category` (`option_category_id`);
ALTER TABLE `menu_option`
    ADD CONSTRAINT FOREIGN KEY (menu_id) REFERENCES `menu` (`menu_id`);



ALTER TABLE `brand_menu`
    ADD CONSTRAINT FOREIGN KEY (brand_id) REFERENCES `brand` (`brand_id`);
ALTER TABLE `brand_menu`
    ADD CONSTRAINT FOREIGN KEY (menu_id) REFERENCES `menu` (`menu_id`);



ALTER TABLE `store_menu`
    ADD CONSTRAINT FOREIGN KEY (store_id) REFERENCES `store` (`store_id`);
ALTER TABLE `store_menu`
    ADD CONSTRAINT FOREIGN KEY (menu_id) REFERENCES `menu` (`menu_id`);



ALTER TABLE `point`
    ADD CONSTRAINT FOREIGN KEY (user_id) REFERENCES `user` (`user_id`);
ALTER TABLE `point`
    ADD CONSTRAINT FOREIGN KEY (order_id) REFERENCES `order` (`order_id`);



ALTER TABLE `order_menu`
    ADD CONSTRAINT FOREIGN KEY (store_menu_id) REFERENCES `store_menu` (`store_menu_id`);
ALTER TABLE `order_menu`
    ADD CONSTRAINT FOREIGN KEY (order_id) REFERENCES `order` (`order_id`);



ALTER TABLE `pay`
    ADD CONSTRAINT FOREIGN KEY (order_id) REFERENCES `order` (`order_id`);
ALTER TABLE `pay`
    ADD CONSTRAINT FOREIGN KEY (pay_type_code) REFERENCES `pay_type` (`pay_type_code`);
ALTER TABLE `pay`
    ADD CONSTRAINT FOREIGN KEY (pay_status_code) REFERENCES `pay_status` (`pay_status_code`);



ALTER TABLE `order_state_history`
    ADD CONSTRAINT FOREIGN KEY (order_state_code) REFERENCES `order_state` (`order_state_code`);
ALTER TABLE `order_state_history`
    ADD CONSTRAINT FOREIGN KEY (order_id) REFERENCES `order` (`order_id`);


ALTER TABLE `menu_review`
    ADD CONSTRAINT FOREIGN KEY (image_id) REFERENCES `image` (`image_id`);
ALTER TABLE `menu_review`
    ADD CONSTRAINT FOREIGN KEY (review_id) REFERENCES `review` (`review_id`);
ALTER TABLE `menu_review`
    ADD CONSTRAINT FOREIGN KEY (store_menu_id) REFERENCES `store_menu` (`store_menu_id`);



ALTER TABLE `review`
    ADD CONSTRAINT FOREIGN KEY (parent_review_id) REFERENCES `review` (`review_id`);
ALTER TABLE `review`
    ADD CONSTRAINT FOREIGN KEY (user_id) REFERENCES `user` (`user_id`);
ALTER TABLE `review`
    ADD CONSTRAINT FOREIGN KEY (store_id) REFERENCES `store` (`store_id`);


ALTER TABLE `order_menu_sub_menu`
    ADD CONSTRAINT FOREIGN KEY (order_menu_id) REFERENCES `order_menu` (`order_menu_id`);



ALTER TABLE `user_anniversary`
    ADD CONSTRAINT FOREIGN KEY (user_id) REFERENCES `user` (`user_id`);
ALTER TABLE `user_anniversary`
    ADD CONSTRAINT FOREIGN KEY (anniversary_type_code) REFERENCES `anniversary_type` (`anniversary_type_code`);



ALTER TABLE `user_notification_type`
    ADD CONSTRAINT FOREIGN KEY (notification_type_code) REFERENCES `notification_type` (`notification_type_code`);
ALTER TABLE `user_notification_type`
    ADD CONSTRAINT FOREIGN KEY (user_id) REFERENCES `user` (`user_id`);



ALTER TABLE `user_store_notification_type`
    ADD CONSTRAINT FOREIGN KEY (user_store_id) REFERENCES `user_store` (`user_store_id`);
ALTER TABLE `user_store_notification_type`
    ADD CONSTRAINT FOREIGN KEY (notification_type_code) REFERENCES `notification_type` (`notification_type_code`);



ALTER TABLE `review_image`
    ADD CONSTRAINT FOREIGN KEY (review_id) REFERENCES `review` (`review_id`);
ALTER TABLE `review_image`
    ADD CONSTRAINT FOREIGN KEY (image_id) REFERENCES `image` (`image_id`);



ALTER TABLE `order_coupon`
    ADD CONSTRAINT FOREIGN KEY (order_id) REFERENCES `order` (`order_id`);





ALTER TABLE `user_menu`
    ADD CONSTRAINT FOREIGN KEY (user_id) REFERENCES `user` (`user_id`);
ALTER TABLE `user_menu`
    ADD CONSTRAINT FOREIGN KEY (store_menu_id) REFERENCES `store_menu` (`store_menu_id`);



ALTER TABLE `user_menu_option`
    ADD CONSTRAINT FOREIGN KEY (user_menu_id) REFERENCES `user_menu` (`user_menu_id`);
ALTER TABLE `user_menu_option`
    ADD CONSTRAINT FOREIGN KEY (menu_option_id) REFERENCES `menu_option` (`menu_option_id`);



ALTER TABLE `user_menu_sub_menu`
    ADD CONSTRAINT FOREIGN KEY (menu_sub_menu_id) REFERENCES `menu_sub_menu` (`menu_sub_menu_id`);
ALTER TABLE `user_menu_sub_menu`
    ADD CONSTRAINT FOREIGN KEY (user_menu_id) REFERENCES `user_menu` (`user_menu_id`);



ALTER TABLE `store_store_category`
    ADD CONSTRAINT FOREIGN KEY (store_category_code) REFERENCES `store_category` (`store_category_code`);
ALTER TABLE `store_store_category`
    ADD CONSTRAINT FOREIGN KEY (store_id) REFERENCES `store` (`store_id`);



ALTER TABLE `sub_menu_category`
    ADD CONSTRAINT FOREIGN KEY (menu_id) REFERENCES `menu` (`menu_id`);



ALTER TABLE `store_business_info`
    ADD CONSTRAINT FOREIGN KEY (image_id) REFERENCES `image` (`image_id`);



ALTER TABLE `order_menu_option`
    ADD CONSTRAINT FOREIGN KEY (order_menu_id) REFERENCES `order_menu` (`order_menu_id`);
