drop DATABASE if exists baegopa ;
create DATABASE baegopa;
use baegopa;

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
	`id`	BIGINT	NOT NULL,
	`user_rank_code`	char(2)	NOT NULL	COMMENT '프렌드',
	`user_status_code`	char(2)	NOT NULL,
	`login_id`	VARCHAR(30)	NOT NULL,
	`password`	CHAR(60)	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL,
	`email`	VARCHAR(320)	NOT NULL,
	`nickname`	VARCHAR(15)	NOT NULL,
	`birth_date`	DATE	NOT NULL,
	`last_login_datetime`	DATETIME	NOT NULL,
	`register_datetime`	DATETIME	NOT NULL	DEFAULT now(),
	`image`	BLOB	NULL,
	`is_delete`	BOOLEAN	NOT NULL	DEFAULT FALSE
);

DROP TABLE IF EXISTS `address`;

CREATE TABLE `address` (
	`id`	BIGINT	NOT NULL,
	`zip_code`	char(5)	NOT NULL,
	`address`	VARCHAR(50)	NOT NULL	COMMENT '유니크',
	`latitude`	decimal	NOT NULL,
	`longitude`	decimal	NOT NULL
);

DROP TABLE IF EXISTS `user_address`;

CREATE TABLE `user_address` (
	`id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`address_id`	BIGINT	NOT NULL,
	`is_main`	BOOLEAN	NOT NULL	DEFAULT FALSE,
	`alias`	VARCHAR(50)	NOT NULL,
	`detail_address`	VARCHAR(50)	NOT NULL
);

DROP TABLE IF EXISTS `user_status`;

CREATE TABLE `user_status` (
	`code`	char(2)	NOT NULL,
	`name`	VARCHAR(10)	NOT NULL
);

DROP TABLE IF EXISTS `user_rank`;

CREATE TABLE `user_rank` (
	`code`	char(2)	NOT NULL,
	`name`	varchar(10)	NOT NULL	COMMENT '프렌드, 패밀리, 마스터, VIP'
);

DROP TABLE IF EXISTS `oauth_login`;

CREATE TABLE `oauth_login` (
	`id`	bigint	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`oauth_type_code`	char(2)	NOT NULL	COMMENT '복합 유니크',
	`oauth_login_id`	varchar(45)	NOT NULL	COMMENT '복합 유니크'
);

DROP TABLE IF EXISTS `oauth_type`;

CREATE TABLE `oauth_type` (
	`code`	char(2)	NOT NULL,
	`name`	VARCHAR(10)	NOT NULL
);

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
	`code`	char(2)	NOT NULL,
	`name`	varchar(10)	NOT NULL	COMMENT '대표, 매니저, 알바'
);

DROP TABLE IF EXISTS `store`;

CREATE TABLE `store` (
	`id`	BIGINT	NOT NULL,
	`brand_id`	BIGINT	NULL,
	`address_id`	BIGINT	NOT NULL,
	`store_category_id`	BIGINT	NOT NULL,
	`address_detail`	VARCHAR(50)	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL,
	`tel`	VARCHAR(11)	NOT NULL,
	`store_registration`	CHAR(10)	NOT NULL,
	`image`	BLOB	NOT NULL,
	`main_point_rate`	DOUBLE	NOT NULL	DEFAULT 0.0,
	`sub_point_rate`	DOUBLE	NOT NULL	DEFAULT 0.0,
	`is_delete`	BOOLEAN	NOT NULL	DEFAULT FALSE
);

DROP TABLE IF EXISTS `user_store`;

CREATE TABLE `user_store` (
	`id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`role_code`	char(2)	NOT NULL,
	`store_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `brand`;

CREATE TABLE `brand` (
	`id`	BIGINT	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL
);

DROP TABLE IF EXISTS `store_category`;

CREATE TABLE `store_category` (
	`id`	BIGINT	NOT NULL,
	`name`	varchar(30)	NOT NULL
);

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
	`id`	BIGINT	NOT NULL,
	`menu_category_id`	BIGINT	NOT NULL,
	`name`	varchar(30)	NOT NULL,
	`discription`	varchar(255)	NULL	COMMENT '설명이 존재하지 않는 음식이 있을 수 도 있음',
	`price`	BIGINT	NOT NULL,
	`time`	TIME	NOT NULL	DEFAULT '00:00',
	`image`	BLOB	NULL,
	`point_rate`	DOUBLE	NULL	DEFAULT 0.0,
	`order`	INT	NOT NULL	DEFAULT 0,
	`is_delete`	BOOLEAN	NOT NULL	DEFAULT FALSE
);

DROP TABLE IF EXISTS `closed`;

CREATE TABLE `closed` (
	`id`	BIGINT	NOT NULL,
	`store_id`	BIGINT	NOT NULL,
	`closed_date`	DATE	NOT NULL
);

DROP TABLE IF EXISTS `open`;

CREATE TABLE `open` (
	`id`	BIGINT	NOT NULL,
	`code`	char(2)	NOT NULL,
	`store_id`	BIGINT	NOT NULL,
	`open_time`	TIME	NOT NULL,
	`close_time`	TIME	NOT NULL
);

DROP TABLE IF EXISTS `day`;

CREATE TABLE `day` (
	`code`	char(2)	NOT NULL,
	`name`	varchar(3)	NOT NULL
);

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
	`id`	BIGINT	NOT NULL,
	`coupon_id`	BIGINT	NULL,
	`user_id`	BIGINT	NOT NULL,
	`user_address`	VARCHAR(100)	NOT NULL	COMMENT '주문할 때 그때의 주소',
	`req_memo`	TEXT	NULL,
	`order_datetime`	DATETIME	NOT NULL	DEFAULT now()
);

DROP TABLE IF EXISTS `sub_menu`;

CREATE TABLE `sub_menu` (
	`id`	BIGINT	NOT NULL,
	`name`	VARCHAR(30)	NOT NULL,
	`price`	BIGINT	NOT NULL,
	`time`	TIME	NOT NULL,
	`image`	BLOB	NULL,
	`point_rate`	DOUBLE	NULL
);

DROP TABLE IF EXISTS `menu_sub_menu`;

CREATE TABLE `menu_sub_menu` (
	`id`	BIGINT	NOT NULL,
	`menu_id`	BIGINT	NOT NULL,
	`sub_menu_id`	BIGINT	NOT NULL,
	`menu_category_id`	BIGINT	NOT NULL,
	`order`	INT	NOT NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `menu_category`;

CREATE TABLE `menu_category` (
	`id`	BIGINT	NOT NULL,
	`name`	VARCHAR(30)	NOT NULL,
	`order`	INT	NOT NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `option`;

CREATE TABLE `option` (
	`id`	BIGINT	NOT NULL,
	`name`	VARCHAR(30)	NOT NULL,
	`price`	BIGINT	NOT NULL,
	`time`	TIME	NOT NULL	DEFAULT '00:00'
);

DROP TABLE IF EXISTS `menu_option`;

CREATE TABLE `menu_option` (
	`id`	BIGINT	NOT NULL,
	`option_id`	BIGINT	NOT NULL,
	`option_category_id`	BIGINT	NOT NULL,
	`menu_id`	BIGINT	NOT NULL,
	`order`	INT	NOT NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `option_category`;

CREATE TABLE `option_category` (
	`id`	BIGINT	NOT NULL,
	`name`	VARCHAR(30)	NOT NULL,
	`order`	INT	NOT NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `brand_menu`;

CREATE TABLE `brand_menu` (
	`id`	BIGINT	NOT NULL,
	`brand_id`	BIGINT	NOT NULL,
	`menu_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `store_menu`;

CREATE TABLE `store_menu` (
	`id`	BIGINT	NOT NULL,
	`store_id`	BIGINT	NOT NULL,
	`menu_id`	BIGINT	NOT NULL,
	`is_sold_out`	BOOLEAN	NOT NULL	DEFAULT FALSE
);

DROP TABLE IF EXISTS `coupon_policy`;

CREATE TABLE `coupon_policy` (
	`id`	BIGINT	NOT NULL,
	`begin_datetime`	DATETIME	NOT NULL,
	`expire_datetime`	DATETIME	NOT NULL,
	`target_amount`	INT	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL
);

DROP TABLE IF EXISTS `brand_coupon_provider`;

CREATE TABLE `brand_coupon_provider` (
	`id`	BIGINT	NOT NULL,
	`brand_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `amount_coupon_policy`;

CREATE TABLE `amount_coupon_policy` (
	`id`	BIGINT	NOT NULL,
	`discount_amount`	INT	NOT NULL
);

DROP TABLE IF EXISTS `percent_coupon_policy`;

CREATE TABLE `percent_coupon_policy` (
	`id`	BIGINT	NOT NULL,
	`rate`	DOUBLE	NOT NULL,
	`max_discount_amount`	INT	NOT NULL
);

DROP TABLE IF EXISTS `coupon`;

CREATE TABLE `coupon` (
	`id`	BIGINT	NOT NULL,
	`coupon_policy_id`	BIGINT	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL,
	`description`	TEXT	NOT NULL,
	`image`	BLOB	NULL
);

DROP TABLE IF EXISTS `birth_coupon_vendor`;

CREATE TABLE `birth_coupon_vendor` (
	`id`	BIGINT	NOT NULL,
	`coupon_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `user_rate_coupon_vendor`;

CREATE TABLE `user_rate_coupon_vendor` (
	`id`	BIGINT	NOT NULL,
	`user_rank_code`	char(2)	NOT NULL,
	`coupon_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `total_coupon`;

CREATE TABLE `total_coupon` (
	`id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `store_category_coupon_provider`;

CREATE TABLE `store_category_coupon_provider` (
	`id`	BIGINT	NOT NULL,
	`store_category_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `menu_category_coupon_provider`;

CREATE TABLE `menu_category_coupon_provider` (
	`id`	BIGINT	NOT NULL,
	`menu_category_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `user_coupon`;

CREATE TABLE `user_coupon` (
	`id`	BIGINT	NOT NULL,
	`coupon_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`issue_datetime`	DATETIME	NOT NULL	DEFAULT now()
);

DROP TABLE IF EXISTS `point_save`;

CREATE TABLE `point_save` (
	`id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`point`	INT	NOT NULL,
	`reason`	VARCHAR(30)	NOT NULL,
	`save_datetime`	DATETIME	NOT NULL	DEFAULT now()
);

DROP TABLE IF EXISTS `point_use`;

CREATE TABLE `point_use` (
	`id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`order_id`	BIGINT	NOT NULL,
	`point`	INT	NOT NULL,
	`reason`	VARCHAR(30)	NOT NULL,
	`use_datetime`	DATETIME	NOT NULL	DEFAULT now()
);

DROP TABLE IF EXISTS `order_state`;

CREATE TABLE `order_state` (
	`code`	CHAR(2)	NOT NULL,
	`name`	VARCHAR(20)	NOT NULL	COMMENT '대기, 조리, 배달, 완료, 취소'
);

DROP TABLE IF EXISTS `order_menu`;

CREATE TABLE `order_menu` (
	`id`	BIGINT	NOT NULL,
	`store_menu_id`	BIGINT	NOT NULL,
	`order_id`	BIGINT	NOT NULL,
	`price`	INT	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL,
	`count`	INT	NOT NULL	DEFAULT 1	COMMENT 'check 1 >='
);

DROP TABLE IF EXISTS `order_state_history`;

CREATE TABLE `order_state_history` (
	`id`	BIGINT	NOT NULL,
	`order_state_code`	CHAR(2)	NOT NULL,
	`order_id`	BIGINT	NOT NULL,
	`create_datetime`	DATETIME	NOT NULL	DEFAULT now()
);

DROP TABLE IF EXISTS `pay`;

CREATE TABLE `pay` (
	`id`	BIGINT	NOT NULL,
	`order_id`	BIGINT	NOT NULL,
	`pay_type_code`	CHAR(2)	NOT NULL,
	`pay_status_code`	CHAR(2)	NOT NULL,
	`pay_datetime`	DATETIME	NOT NULL	DEFAULT now(),
	`result`	VARCHAR(50)	NOT NULL
);

DROP TABLE IF EXISTS `pay_type`;

CREATE TABLE `pay_type` (
	`code`	CHAR(2)	NOT NULL,
	`name`	VARCHAR(20)	NOT NULL
);

DROP TABLE IF EXISTS `banner`;

CREATE TABLE `banner` (
	`id`	BIGINT	NOT NULL,
	`image`	BLOB	NOT NULL,
	`content`	TEXT	NOT NULL,
	`start_datetime`	DATETIME	NOT NULL,
	`end_datetime`	DATETIME	NOT NULL,
	`order`	INT	NOT NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `banner_coupon`;

CREATE TABLE `banner_coupon` (
	`id`	BIGINT	NOT NULL,
	`banner_id`	BIGINT	NOT NULL,
	`coupon_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `pay_status`;

CREATE TABLE `pay_status` (
	`code`	CHAR(2)	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL	COMMENT '결제중, 결제완료, 결재실패'
);

DROP TABLE IF EXISTS `menu_review`;

CREATE TABLE `menu_review` (
	`id`	BIGINT	NOT NULL,
	`review_id`	BIGINT	NOT NULL,
	`store_menu_id`	BIGINT	NOT NULL,
	`content`	TEXT	NOT NULL,
	`grade`	INT	NOT NULL	DEFAULT 1	COMMENT 'check 1 >= && 5 <=',
	`image`	BLOB	NULL
);

DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
	`id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`store_id`	BIGINT	NOT NULL,
	`content`	TEXT	NOT NULL,
	`grade`	INT	NOT NULL	DEFAULT 1	COMMENT 'check 1 >= && 5 <=',
	`image`	BLOB	NULL
);

DROP TABLE IF EXISTS `event_coupon_vendor`;

CREATE TABLE `event_coupon_vendor` (
	`id`	BIGINT	NOT NULL,
	`event_datetime`	DATETIME	NOT NULL,
	`coupon_id`	BIGINT	NOT NULL,
	`user_rank_code`	char(2)	NOT NULL
);

ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`id`
);

ALTER TABLE `address` ADD CONSTRAINT `PK_ADDRESS` PRIMARY KEY (
	`id`
);

ALTER TABLE `user_address` ADD CONSTRAINT `PK_USER_ADDRESS` PRIMARY KEY (
	`id`
);

ALTER TABLE `user_status` ADD CONSTRAINT `PK_USER_STATUS` PRIMARY KEY (
	`code`
);

ALTER TABLE `user_rank` ADD CONSTRAINT `PK_USER_RANK` PRIMARY KEY (
	`code`
);

ALTER TABLE `oauth_login` ADD CONSTRAINT `PK_OAUTH_LOGIN` PRIMARY KEY (
	`id`
);

ALTER TABLE `oauth_type` ADD CONSTRAINT `PK_OAUTH_TYPE` PRIMARY KEY (
	`code`
);

ALTER TABLE `role` ADD CONSTRAINT `PK_ROLE` PRIMARY KEY (
	`code`
);

ALTER TABLE `store` ADD CONSTRAINT `PK_STORE` PRIMARY KEY (
	`id`
);

ALTER TABLE `user_store` ADD CONSTRAINT `PK_USER_STORE` PRIMARY KEY (
	`id`
);

ALTER TABLE `brand` ADD CONSTRAINT `PK_BRAND` PRIMARY KEY (
	`id`
);

ALTER TABLE `store_category` ADD CONSTRAINT `PK_STORE_CATEGORY` PRIMARY KEY (
	`id`
);

ALTER TABLE `menu` ADD CONSTRAINT `PK_MENU` PRIMARY KEY (
	`id`
);

ALTER TABLE `closed` ADD CONSTRAINT `PK_CLOSED` PRIMARY KEY (
	`id`
);

ALTER TABLE `open` ADD CONSTRAINT `PK_OPEN` PRIMARY KEY (
	`id`
);

ALTER TABLE `day` ADD CONSTRAINT `PK_DAY` PRIMARY KEY (
	`code`
);

ALTER TABLE `order` ADD CONSTRAINT `PK_ORDER` PRIMARY KEY (
	`id`
);

ALTER TABLE `sub_menu` ADD CONSTRAINT `PK_SUB_MENU` PRIMARY KEY (
	`id`
);

ALTER TABLE `menu_sub_menu` ADD CONSTRAINT `PK_MENU_SUB_MENU` PRIMARY KEY (
	`id`
);

ALTER TABLE `menu_category` ADD CONSTRAINT `PK_MENU_CATEGORY` PRIMARY KEY (
	`id`
);

ALTER TABLE `option` ADD CONSTRAINT `PK_OPTION` PRIMARY KEY (
	`id`
);

ALTER TABLE `menu_option` ADD CONSTRAINT `PK_MENU_OPTION` PRIMARY KEY (
	`id`
);

ALTER TABLE `option_category` ADD CONSTRAINT `PK_OPTION_CATEGORY` PRIMARY KEY (
	`id`
);

ALTER TABLE `brand_menu` ADD CONSTRAINT `PK_BRAND_MENU` PRIMARY KEY (
	`id`
);

ALTER TABLE `store_menu` ADD CONSTRAINT `PK_STORE_MENU` PRIMARY KEY (
	`id`
);

ALTER TABLE `coupon_policy` ADD CONSTRAINT `PK_COUPON_POLICY` PRIMARY KEY (
	`id`
);

ALTER TABLE `brand_coupon_provider` ADD CONSTRAINT `PK_BRAND_COUPON_PROVIDER` PRIMARY KEY (
	`id`
);

ALTER TABLE `amount_coupon_policy` ADD CONSTRAINT `PK_AMOUNT_COUPON_POLICY` PRIMARY KEY (
	`id`
);

ALTER TABLE `percent_coupon_policy` ADD CONSTRAINT `PK_PERCENT_COUPON_POLICY` PRIMARY KEY (
	`id`
);

ALTER TABLE `coupon` ADD CONSTRAINT `PK_COUPON` PRIMARY KEY (
	`id`
);

ALTER TABLE `birth_coupon_vendor` ADD CONSTRAINT `PK_BIRTH_COUPON_VENDOR` PRIMARY KEY (
	`id`
);

ALTER TABLE `user_rate_coupon_vendor` ADD CONSTRAINT `PK_USER_RATE_COUPON_VENDOR` PRIMARY KEY (
	`id`
);

ALTER TABLE `total_coupon` ADD CONSTRAINT `PK_TOTAL_COUPON` PRIMARY KEY (
	`id`
);

ALTER TABLE `store_category_coupon_provider` ADD CONSTRAINT `PK_STORE_CATEGORY_COUPON_PROVIDER` PRIMARY KEY (
	`id`
);

ALTER TABLE `menu_category_coupon_provider` ADD CONSTRAINT `PK_MENU_CATEGORY_COUPON_PROVIDER` PRIMARY KEY (
	`id`
);

ALTER TABLE `user_coupon` ADD CONSTRAINT `PK_USER_COUPON` PRIMARY KEY (
	`id`
);

ALTER TABLE `point_save` ADD CONSTRAINT `PK_POINT_SAVE` PRIMARY KEY (
	`id`
);

ALTER TABLE `point_use` ADD CONSTRAINT `PK_POINT_USE` PRIMARY KEY (
	`id`
);

ALTER TABLE `order_state` ADD CONSTRAINT `PK_ORDER_STATE` PRIMARY KEY (
	`code`
);

ALTER TABLE `order_menu` ADD CONSTRAINT `PK_ORDER_MENU` PRIMARY KEY (
	`id`
);

ALTER TABLE `order_state_history` ADD CONSTRAINT `PK_ORDER_STATE_HISTORY` PRIMARY KEY (
	`id`
);

ALTER TABLE `pay` ADD CONSTRAINT `PK_PAY` PRIMARY KEY (
	`id`
);

ALTER TABLE `pay_type` ADD CONSTRAINT `PK_PAY_TYPE` PRIMARY KEY (
	`code`
);

ALTER TABLE `banner` ADD CONSTRAINT `PK_BANNER` PRIMARY KEY (
	`id`
);

ALTER TABLE `banner_coupon` ADD CONSTRAINT `PK_BANNER_COUPON` PRIMARY KEY (
	`id`
);

ALTER TABLE `pay_status` ADD CONSTRAINT `PK_PAY_STATUS` PRIMARY KEY (
	`code`
);

ALTER TABLE `menu_review` ADD CONSTRAINT `PK_MENU_REVIEW` PRIMARY KEY (
	`id`
);

ALTER TABLE `review` ADD CONSTRAINT `PK_REVIEW` PRIMARY KEY (
	`id`
);

ALTER TABLE `event_coupon_vendor` ADD CONSTRAINT `PK_EVENT_COUPON_VENDOR` PRIMARY KEY (
	`id`
);

ALTER TABLE `user` ADD CONSTRAINT `FK_user_rank_TO_user_1` FOREIGN KEY (
	`user_rank_code`
)
REFERENCES `user_rank` (
	`code`
);

ALTER TABLE `user` ADD CONSTRAINT `FK_user_status_TO_user_1` FOREIGN KEY (
	`user_status_code`
)
REFERENCES `user_status` (
	`code`
);

ALTER TABLE `user_address` ADD CONSTRAINT `FK_user_TO_user_address_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `user_address` ADD CONSTRAINT `FK_address_TO_user_address_1` FOREIGN KEY (
	`address_id`
)
REFERENCES `address` (
	`id`
);

ALTER TABLE `oauth_login` ADD CONSTRAINT `FK_user_TO_oauth_login_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `oauth_login` ADD CONSTRAINT `FK_oauth_type_TO_oauth_login_1` FOREIGN KEY (
	`oauth_type_code`
)
REFERENCES `oauth_type` (
	`code`
);

ALTER TABLE `store` ADD CONSTRAINT `FK_brand_TO_store_1` FOREIGN KEY (
	`brand_id`
)
REFERENCES `brand` (
	`id`
);

ALTER TABLE `store` ADD CONSTRAINT `FK_address_TO_store_1` FOREIGN KEY (
	`address_id`
)
REFERENCES `address` (
	`id`
);

ALTER TABLE `store` ADD CONSTRAINT `FK_store_category_TO_store_1` FOREIGN KEY (
	`store_category_id`
)
REFERENCES `store_category` (
	`id`
);

ALTER TABLE `user_store` ADD CONSTRAINT `FK_user_TO_user_store_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `user_store` ADD CONSTRAINT `FK_role_TO_user_store_1` FOREIGN KEY (
	`role_code`
)
REFERENCES `role` (
	`code`
);

ALTER TABLE `user_store` ADD CONSTRAINT `FK_store_TO_user_store_1` FOREIGN KEY (
	`store_id`
)
REFERENCES `store` (
	`id`
);

ALTER TABLE `menu` ADD CONSTRAINT `FK_menu_category_TO_menu_1` FOREIGN KEY (
	`menu_category_id`
)
REFERENCES `menu_category` (
	`id`
);

ALTER TABLE `closed` ADD CONSTRAINT `FK_store_TO_closed_1` FOREIGN KEY (
	`store_id`
)
REFERENCES `store` (
	`id`
);

ALTER TABLE `open` ADD CONSTRAINT `FK_day_TO_open_1` FOREIGN KEY (
	`code`
)
REFERENCES `day` (
	`code`
);

ALTER TABLE `open` ADD CONSTRAINT `FK_store_TO_open_1` FOREIGN KEY (
	`store_id`
)
REFERENCES `store` (
	`id`
);

ALTER TABLE `order` ADD CONSTRAINT `FK_coupon_TO_order_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon` (
	`id`
);

ALTER TABLE `order` ADD CONSTRAINT `FK_user_TO_order_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `menu_sub_menu` ADD CONSTRAINT `FK_menu_TO_menu_sub_menu_1` FOREIGN KEY (
	`menu_id`
)
REFERENCES `menu` (
	`id`
);

ALTER TABLE `menu_sub_menu` ADD CONSTRAINT `FK_sub_menu_TO_menu_sub_menu_1` FOREIGN KEY (
	`sub_menu_id`
)
REFERENCES `sub_menu` (
	`id`
);

ALTER TABLE `menu_sub_menu` ADD CONSTRAINT `FK_menu_category_TO_menu_sub_menu_1` FOREIGN KEY (
	`menu_category_id`
)
REFERENCES `menu_category` (
	`id`
);

ALTER TABLE `menu_option` ADD CONSTRAINT `FK_option_TO_menu_option_1` FOREIGN KEY (
	`option_id`
)
REFERENCES `option` (
	`id`
);

ALTER TABLE `menu_option` ADD CONSTRAINT `FK_option_category_TO_menu_option_1` FOREIGN KEY (
	`option_category_id`
)
REFERENCES `option_category` (
	`id`
);

ALTER TABLE `menu_option` ADD CONSTRAINT `FK_menu_TO_menu_option_1` FOREIGN KEY (
	`menu_id`
)
REFERENCES `menu` (
	`id`
);

ALTER TABLE `brand_menu` ADD CONSTRAINT `FK_brand_TO_brand_menu_1` FOREIGN KEY (
	`brand_id`
)
REFERENCES `brand` (
	`id`
);

ALTER TABLE `brand_menu` ADD CONSTRAINT `FK_menu_TO_brand_menu_1` FOREIGN KEY (
	`menu_id`
)
REFERENCES `menu` (
	`id`
);

ALTER TABLE `store_menu` ADD CONSTRAINT `FK_store_TO_store_menu_1` FOREIGN KEY (
	`store_id`
)
REFERENCES `store` (
	`id`
);

ALTER TABLE `store_menu` ADD CONSTRAINT `FK_menu_TO_store_menu_1` FOREIGN KEY (
	`menu_id`
)
REFERENCES `menu` (
	`id`
);

ALTER TABLE `brand_coupon_provider` ADD CONSTRAINT `FK_coupon_TO_brand_coupon_provider_1` FOREIGN KEY (
	`id`
)
REFERENCES `coupon` (
	`id`
);

ALTER TABLE `brand_coupon_provider` ADD CONSTRAINT `FK_brand_TO_brand_coupon_provider_1` FOREIGN KEY (
	`brand_id`
)
REFERENCES `brand` (
	`id`
);

ALTER TABLE `amount_coupon_policy` ADD CONSTRAINT `FK_coupon_policy_TO_amount_coupon_policy_1` FOREIGN KEY (
	`id`
)
REFERENCES `coupon_policy` (
	`id`
);

ALTER TABLE `percent_coupon_policy` ADD CONSTRAINT `FK_coupon_policy_TO_percent_coupon_policy_1` FOREIGN KEY (
	`id`
)
REFERENCES `coupon_policy` (
	`id`
);

ALTER TABLE `coupon` ADD CONSTRAINT `FK_coupon_policy_TO_coupon_1` FOREIGN KEY (
	`coupon_policy_id`
)
REFERENCES `coupon_policy` (
	`id`
);

ALTER TABLE `birth_coupon_vendor` ADD CONSTRAINT `FK_coupon_TO_birth_coupon_vendor_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon` (
	`id`
);

ALTER TABLE `user_rate_coupon_vendor` ADD CONSTRAINT `FK_user_rank_TO_user_rate_coupon_vendor_1` FOREIGN KEY (
	`user_rank_code`
)
REFERENCES `user_rank` (
	`code`
);

ALTER TABLE `user_rate_coupon_vendor` ADD CONSTRAINT `FK_coupon_TO_user_rate_coupon_vendor_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon` (
	`id`
);

ALTER TABLE `total_coupon` ADD CONSTRAINT `FK_coupon_TO_total_coupon_1` FOREIGN KEY (
	`id`
)
REFERENCES `coupon` (
	`id`
);

ALTER TABLE `store_category_coupon_provider` ADD CONSTRAINT `FK_coupon_TO_store_category_coupon_provider_1` FOREIGN KEY (
	`id`
)
REFERENCES `coupon` (
	`id`
);

ALTER TABLE `store_category_coupon_provider` ADD CONSTRAINT `FK_store_category_TO_store_category_coupon_provider_1` FOREIGN KEY (
	`store_category_id`
)
REFERENCES `store_category` (
	`id`
);

ALTER TABLE `menu_category_coupon_provider` ADD CONSTRAINT `FK_coupon_TO_menu_category_coupon_provider_1` FOREIGN KEY (
	`id`
)
REFERENCES `coupon` (
	`id`
);

ALTER TABLE `menu_category_coupon_provider` ADD CONSTRAINT `FK_menu_category_TO_menu_category_coupon_provider_1` FOREIGN KEY (
	`menu_category_id`
)
REFERENCES `menu_category` (
	`id`
);

ALTER TABLE `user_coupon` ADD CONSTRAINT `FK_coupon_TO_user_coupon_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon` (
	`id`
);

ALTER TABLE `user_coupon` ADD CONSTRAINT `FK_user_TO_user_coupon_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `point_save` ADD CONSTRAINT `FK_user_TO_point_save_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `point_use` ADD CONSTRAINT `FK_user_TO_point_use_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `point_use` ADD CONSTRAINT `FK_order_TO_point_use_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`id`
);

ALTER TABLE `order_menu` ADD CONSTRAINT `FK_store_menu_TO_order_menu_1` FOREIGN KEY (
	`store_menu_id`
)
REFERENCES `store_menu` (
	`id`
);

ALTER TABLE `order_menu` ADD CONSTRAINT `FK_order_TO_order_menu_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`id`
);

ALTER TABLE `order_state_history` ADD CONSTRAINT `FK_order_state_TO_order_state_history_1` FOREIGN KEY (
	`order_state_code`
)
REFERENCES `order_state` (
	`code`
);

ALTER TABLE `order_state_history` ADD CONSTRAINT `FK_order_TO_order_state_history_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`id`
);

ALTER TABLE `pay` ADD CONSTRAINT `FK_order_TO_pay_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`id`
);

ALTER TABLE `pay` ADD CONSTRAINT `FK_pay_type_TO_pay_1` FOREIGN KEY (
	`pay_type_code`
)
REFERENCES `pay_type` (
	`code`
);

ALTER TABLE `pay` ADD CONSTRAINT `FK_pay_status_TO_pay_1` FOREIGN KEY (
	`pay_status_code`
)
REFERENCES `pay_status` (
	`code`
);

ALTER TABLE `banner_coupon` ADD CONSTRAINT `FK_banner_TO_banner_coupon_1` FOREIGN KEY (
	`banner_id`
)
REFERENCES `banner` (
	`id`
);

ALTER TABLE `banner_coupon` ADD CONSTRAINT `FK_coupon_TO_banner_coupon_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon` (
	`id`
);

ALTER TABLE `menu_review` ADD CONSTRAINT `FK_review_TO_menu_review_1` FOREIGN KEY (
	`review_id`
)
REFERENCES `review` (
	`id`
);

ALTER TABLE `menu_review` ADD CONSTRAINT `FK_store_menu_TO_menu_review_1` FOREIGN KEY (
	`store_menu_id`
)
REFERENCES `store_menu` (
	`id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_user_TO_review_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_order_TO_review_1` FOREIGN KEY (
	`store_id`
)
REFERENCES `order` (
	`id`
);

ALTER TABLE `event_coupon_vendor` ADD CONSTRAINT `FK_coupon_TO_event_coupon_vendor_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon` (
	`id`
);

ALTER TABLE `event_coupon_vendor` ADD CONSTRAINT `FK_user_rank_TO_event_coupon_vendor_1` FOREIGN KEY (
	`user_rank_code`
)
REFERENCES `user_rank` (
	`code`
);
