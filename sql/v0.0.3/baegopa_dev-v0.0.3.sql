drop DATABASE if exists baegopa_store_dev;
create DATABASE baegopa_store_dev;
use baegopa_store_dev;

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
	`user_id`	BIGINT	NOT NULL,
	`user_rank_code`	char(2)	NOT NULL,
	`user_status_code`	char(2)	NOT NULL,
	`image_id`	BIGINT	NULL,
	`login_id`	VARCHAR(30)	NOT NULL UNIQUE,
	`password`	CHAR(60)	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL,
	`email`	VARCHAR(320)	NOT NULL,
	`nickname`	VARCHAR(50)	NOT NULL,
	`last_login_datetime`	DATETIME	NOT NULL,
	`tel`	CHAR(11)	NOT NULL,
	`register_datetime`	DATETIME	NOT NULL	DEFAULT now(),
	`is_delete`	BOOLEAN	NOT NULL	DEFAULT FALSE
);

DROP TABLE IF EXISTS `address`;

CREATE TABLE `address` (
	`address_id`	BIGINT	NOT NULL,
	`zone_code`	char(5)	NOT NULL,
	`address`	VARCHAR(200)	NOT NULL UNIQUE,
	`latitude`	decimal	NOT NULL,
	`longitude`	decimal	NOT NULL
);

DROP TABLE IF EXISTS `user_address`;

CREATE TABLE `user_address` (
	`user_address_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`address_id`	BIGINT	NOT NULL,
	`is_main`	BOOLEAN	NOT NULL	DEFAULT FALSE,
	`alias`	VARCHAR(50)	NOT NULL,
	`detail_address`	VARCHAR(50)	NOT NULL
);

DROP TABLE IF EXISTS `user_status`;

CREATE TABLE `user_status` (
	`user_status_code`	CHAR(2)	NOT NULL,
	`name`	VARCHAR(10)	NOT NULL
);

DROP TABLE IF EXISTS `user_rank`;

CREATE TABLE `user_rank` (
	`user_rank_code`	char(2)	NOT NULL,
	`name`	varchar(10)	NOT NULL
);

DROP TABLE IF EXISTS `oauth_login`;

CREATE TABLE `oauth_login` (
	`oauth_login_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`oauth_type_code`	CHAR(2)	NOT NULL,
	`oauth_login_no`	VARCHAR(45)	NOT NULL
);

ALTER TABLE `oauth_login` ADD UNIQUE KEY (`oauth_type_code`, `oauth_login_no`);

DROP TABLE IF EXISTS `oauth_type`;

CREATE TABLE `oauth_type` (
	`oauth_type_code`	char(2)	NOT NULL,
	`name`	VARCHAR(10)	NOT NULL
);

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
	`role_code`	CHAR(2)	NOT NULL,
	`name`	VARCHAR(10)	NOT NULL
);

DROP TABLE IF EXISTS `store`;

CREATE TABLE `store` (
	`store_id`	BIGINT	NOT NULL,
	`brand_id`	BIGINT	NULL,
	`address_id`	BIGINT	NOT NULL,
	`store_category_id`	BIGINT	NOT NULL,
	`delivery_price_id`	BIGINT	NOT NULL,
	`image_id`	BIGINT	NULL,
	`address_detail`	VARCHAR(50)	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL,
	`tel`	VARCHAR(11)	NOT NULL,
	`store_registration`	CHAR(10)	NOT NULL,
	`main_point_rate`	DECIMAL	NOT NULL	DEFAULT 0.0,
	`is_delete`	BOOLEAN	NOT NULL	DEFAULT FALSE
);

DROP TABLE IF EXISTS `user_store`;

CREATE TABLE `user_store` (
	`user_store_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`role_code`	CHAR(2)	NOT NULL,
	`store_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `brand`;

CREATE TABLE `brand` (
	`brand_id`	BIGINT	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL
);

DROP TABLE IF EXISTS `store_category`;

CREATE TABLE `store_category` (
	`store_category_id`	BIGINT	NOT NULL,
	`name`	VARCHAR(30)	NOT NULL
);

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
	`menu_id`	BIGINT	NOT NULL,
	`menu_category_id`	BIGINT	NOT NULL,
	`image_id`	BIGINT	NULL,
	`name`	VARCHAR(100)	NOT NULL,
	`description`	TEXT	NULL,
	`price`	INT UNSIGNED NOT NULL,
	`time`	TIME	NOT NULL	DEFAULT '00:00',
	`point_rate`	DECIMAL	NULL	DEFAULT 0.0,
	`order`	INT UNSIGNED	NOT NULL	DEFAULT 0,
	`is_delete`	BOOLEAN	NOT NULL	DEFAULT FALSE,
	`is_visible`	BOOLEAN	NOT NULL	DEFAULT TRUE
);

DROP TABLE IF EXISTS `close`;

CREATE TABLE `close` (
	`close_id`	BIGINT	NOT NULL,
	`store_id`	BIGINT	NOT NULL,
	`close_date`	DATE	NOT NULL
);

DROP TABLE IF EXISTS `open`;

CREATE TABLE `open` (
	`open_id`	BIGINT	NOT NULL,
	`day_code`	CHAR(2)	NOT NULL,
	`store_id`	BIGINT	NOT NULL,
	`open_time`	TIME	NOT NULL,
	`close_time`	TIME	NOT NULL
);

DROP TABLE IF EXISTS `day`;

CREATE TABLE `day` (
	`day_code`	CHAR(2)	NOT NULL,
	`name`	VARCHAR(3)	NOT NULL
);

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
	`order_id`	BIGINT	NOT NULL,
	`coupon_id`	BIGINT	NULL,
	`user_id`	BIGINT	NOT NULL,
	`user_address`	VARCHAR(200)	NOT NULL,
	`detail_address`	VARCHAR(100)	NOT NULL,
	`req_memo`	VARCHAR(255)	NULL,
	`order_datetime`	DATETIME	NOT NULL	DEFAULT now()
);

DROP TABLE IF EXISTS `menu_sub_menu`;

CREATE TABLE `menu_sub_menu` (
	`menu_sub_menu_id`	BIGINT	NOT NULL,
	`main_menu_id`	BIGINT	NOT NULL,
	`sub_menu_id`	BIGINT	NOT NULL,
	`menu_category_id`	BIGINT	NOT NULL,
	`name`	VARCHAR(100)	NULL,
	`order`	INT UNSIGNED	NOT NULL	DEFAULT 0,
	`price`	INT UNSIGNED	NULL
);

DROP TABLE IF EXISTS `menu_category`;

CREATE TABLE `menu_category` (
	`menu_category_id`	BIGINT	NOT NULL,
	`name`	VARCHAR(30)	NOT NULL,
	`order`	INT UNSIGNED	NOT NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `option`;

CREATE TABLE `option` (
	`option_id`	BIGINT	NOT NULL,
	`name`	VARCHAR(30)	NOT NULL,
	`price`	INT UNSIGNED	NOT NULL,
	`time`	TIME	NOT NULL	DEFAULT '00:00'
);

DROP TABLE IF EXISTS `menu_option`;

CREATE TABLE `menu_option` (
	`menu_option_id`	BIGINT	NOT NULL,
	`option_id`	BIGINT	NOT NULL,
	`option_category_id`	BIGINT	NOT NULL,
	`menu_id`	BIGINT	NOT NULL,
	`order`	INT	UNSIGNED NOT NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `option_category`;

CREATE TABLE `option_category` (
	`option_category_id`	BIGINT	NOT NULL,
	`name`	VARCHAR(30)	NOT NULL,
	`order`	INT UNSIGNED	NOT NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `brand_menu`;

CREATE TABLE `brand_menu` (
	`brand_menu_id`	BIGINT	NOT NULL,
	`brand_id`	BIGINT	NOT NULL,
	`menu_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `store_menu`;

CREATE TABLE `store_menu` (
	`store_menu_id`	BIGINT	NOT NULL,
	`store_id`	BIGINT	NOT NULL,
	`menu_id`	BIGINT	NOT NULL,
	`is_sold_out`	BOOLEAN	NOT NULL	DEFAULT FALSE
);

DROP TABLE IF EXISTS `coupon_policy`;

CREATE TABLE `coupon_policy` (
	`coupon_policy_id`	BIGINT	NOT NULL,
	`target_amount`	INT UNSIGNED	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL
);

DROP TABLE IF EXISTS `brand_coupon_vendor`;

CREATE TABLE `brand_coupon_vendor` (
	`brand_coupon_vendor_id`	BIGINT	NOT NULL,
	`brand_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `amount_coupon_policy`;

CREATE TABLE `amount_coupon_policy` (
	`amount_coupon_policy_id`	BIGINT	NOT NULL,
	`discount_amount`	INT	NOT NULL
);

DROP TABLE IF EXISTS `percent_coupon_policy`;

CREATE TABLE `percent_coupon_policy` (
	`percent_coupon_policy_id`	BIGINT	NOT NULL,
	`rate`	DECIMAL	NOT NULL,
	`max_discount_amount`	INT UNSIGNED	NOT NULL
);

DROP TABLE IF EXISTS `coupon`;

CREATE TABLE `coupon` (
	`coupon_id`	BIGINT	NOT NULL,
	`coupon_policy_id`	BIGINT	NOT NULL,
	`image_id`	BIGINT	NULL,
	`name`	VARCHAR(50)	NOT NULL,
	`description`	TEXT	NOT NULL,
	`begin_datetime`	DATETIME	NOT NULL,
	`expire_datetime`	DATETIME	NOT NULL
);

DROP TABLE IF EXISTS `anniversary_coupon_vendor`;

CREATE TABLE `anniversary_coupon_vendor` (
	`anniversary_coupon_vendor_id`	BIGINT	NOT NULL,
	`coupon_id`	BIGINT	NOT NULL,
	`anniversary_type_code`	CHAR(2)	NOT NULL,
	`user_rank_code`	CHAR(2)	NOT NULL
);

DROP TABLE IF EXISTS `user_rate_coupon_vendor`;

CREATE TABLE `user_rate_coupon_vendor` (
	`user_rate_coupon_vendor_id`	BIGINT	NOT NULL,
	`user_rank_code`	CHAR(2)	NOT NULL,
	`coupon_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `total_coupon`;

CREATE TABLE `total_coupon` (
	`total_coupon_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `store_category_coupon_vendor`;

CREATE TABLE `store_category_coupon_vendor` (
	`store_category_coupon_vendor_id`	BIGINT	NOT NULL,
	`store_category_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `menu_category_coupon_vendor`;

CREATE TABLE `menu_category_coupon_vendor` (
	`menu_category_coupon_vendor_id`	BIGINT	NOT NULL,
	`menu_category_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `user_coupon`;

CREATE TABLE `user_coupon` (
	`user_coupon_id`	BIGINT	NOT NULL,
	`coupon_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NULL,
	`issue_datetime`	DATETIME	NOT NULL	DEFAULT now(),
	`use_datetime`	DATETIME	NULL
);

DROP TABLE IF EXISTS `point`;

CREATE TABLE `point` (
	`point_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`order_id`	BIGINT	NULL,
	`point`	INT	NOT NULL,
	`reason`	VARCHAR(30)	NOT NULL,
	`create_datetime`	DATETIME	NOT NULL	DEFAULT now()
);

DROP TABLE IF EXISTS `order_state`;

CREATE TABLE `order_state` (
	`order_state_code`	CHAR(2)	NOT NULL,
	`name`	VARCHAR(20)	NOT NULL
);

DROP TABLE IF EXISTS `order_menu`;

CREATE TABLE `order_menu` (
	`order_menu_id`	BIGINT	NOT NULL,
	`store_menu_id`	BIGINT	NOT NULL,
	`order_id`	BIGINT	NOT NULL,
	`price`	INT	UNSIGNED NOT NULL,
	`name`	VARCHAR(50)	NOT NULL,
	`count`	INT	UNSIGNED NOT NULL	DEFAULT 1
);

DROP TABLE IF EXISTS `order_state_history`;

CREATE TABLE `order_state_history` (
	`order_state_history_id`	BIGINT	NOT NULL,
	`order_state_code`	CHAR(2)	NOT NULL,
	`order_id`	BIGINT	NOT NULL,
	`create_datetime`	DATETIME	NOT NULL	DEFAULT now()
);

DROP TABLE IF EXISTS `pay`;

CREATE TABLE `pay` (
	`pay_id`	BIGINT	NOT NULL,
	`order_id`	BIGINT	NOT NULL,
	`pay_type_code`	CHAR(2)	NOT NULL,
	`pay_status_code`	CHAR(2)	NOT NULL,
	`pay_datetime`	DATETIME	NOT NULL	DEFAULT now(),
	`result`	VARCHAR(50)	NOT NULL
);

DROP TABLE IF EXISTS `pay_type`;

CREATE TABLE `pay_type` (
	`pay_type_code`	CHAR(2)	NOT NULL,
	`name`	VARCHAR(20)	NOT NULL
);

DROP TABLE IF EXISTS `banner`;

CREATE TABLE `banner` (
	`banner_id`	BIGINT	NOT NULL,
	`image_id`	BIGINT	NOT NULL,
	`content`	TEXT	NOT NULL,
	`start_datetime`	DATETIME	NOT NULL,
	`end_datetime`	DATETIME	NOT NULL,
	`order`	INT UNSIGNED	NOT NULL	DEFAULT 0
);

DROP TABLE IF EXISTS `banner_coupon`;

CREATE TABLE `banner_coupon` (
	`banner_coupon_id`	BIGINT	NOT NULL,
	`banner_id`	BIGINT	NOT NULL,
	`coupon_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `pay_status`;

CREATE TABLE `pay_status` (
	`pay_status_code`	CHAR(2)	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL
);

DROP TABLE IF EXISTS `menu_review`;

CREATE TABLE `menu_review` (
	`menu_review_id`	BIGINT	NOT NULL,
	`image_id`	BIGINT	NOT NULL,
	`review_id`	BIGINT	NOT NULL,
	`store_menu_id`	BIGINT	NOT NULL,
	`content`	TEXT	NOT NULL,
	`grade`	INT	NOT NULL
);

ALTER TABLE `menu_review`
MODIFY COLUMN `grade` INT NOT NULL DEFAULT 1,
ADD CHECK (`grade` >= 1 AND `grade` <= 5);

DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
	`review_id`	BIGINT	NOT NULL,
	`parent_review_id`	BIGINT	NULL,
	`user_id`	BIGINT	NOT NULL,
	`store_id`	BIGINT	NOT NULL,
	`content`	TEXT	NOT NULL,
	`grade`	INT	NOT NULL,
	`write_datetime`	DATETIME	NOT NULL	DEFAULT now()
);

ALTER TABLE `review`
MODIFY COLUMN `grade` INT NOT NULL DEFAULT 1,
ADD CHECK (`grade` >= 1 AND `grade` <= 5);

DROP TABLE IF EXISTS `event_coupon_vendor`;

CREATE TABLE `event_coupon_vendor` (
	`event_coupon_vendor_id`	BIGINT	NOT NULL,
	`coupon_id`	BIGINT	NOT NULL,
	`user_rank_code`	CHAR(2)	NOT NULL,
	`event_datetime`	DATETIME	NOT NULL
);

DROP TABLE IF EXISTS `order_menu_option`;

CREATE TABLE `order_menu_option` (
	`order_menu_option_id`	BIGINT	NOT NULL,
	`order_menu_id`	BIGINT	NOT NULL,
	`menu_option_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `order_menu_sub_menu`;

CREATE TABLE `order_menu_sub_menu` (
	`order_menu_sub_menu_id`	BIGINT	NOT NULL,
	`order_menu_id`	BIGINT	NOT NULL,
	`menu_sub_menu_id`	BIGINT	NOT NULL
);

DROP TABLE IF EXISTS `anniversary_type`;

CREATE TABLE `anniversary_type` (
	`anniversary_type_code`	CHAR(2)	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL
);

DROP TABLE IF EXISTS `user_anniversary`;

CREATE TABLE `user_anniversary` (
	`user_anniversary_id`	BIGINT	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`anniversary_type_code`	CHAR(2)	NOT NULL,
	`anniversary_date`	DATE	NULL
);

DROP TABLE IF EXISTS `notification_type`;

CREATE TABLE `notification_type` (
	`notification_type_code`	CHAR(2)	NOT NULL,
	`name`	VARCHAR(50)	NOT NULL
);

DROP TABLE IF EXISTS `user_notification_type`;

CREATE TABLE `user_notification_type` (
	`user_notification_type_id`	BIGINT	NOT NULL,
	`notification_type_code`	CHAR(2)	NOT NULL,
	`user_id`	BIGINT	NOT NULL,
	`token`	VARCHAR(100)	NULL,
	`url`	VARCHAR(100)	NULL
);

DROP TABLE IF EXISTS `user_store_notification_type`;

CREATE TABLE `user_store_notification_type` (
	`user_store_notification_type_id`	BIGINT	NOT NULL,
	`user_store_id`	BIGINT	NOT NULL,
	`notification_type_code`	CHAR(2)	NOT NULL,
	`token`	VARCHAR(100)	NULL,
	`url`	VARCHAR(100)	NULL
);

DROP TABLE IF EXISTS `delivery_price`;

CREATE TABLE `delivery_price` (
	`delivery_price_id`	BIGINT	NOT NULL,
	`price`	INT UNSIGNED	NOT NULL
);

DROP TABLE IF EXISTS `reward_point_type`;

CREATE TABLE `reward_point_type` (
	`reward_point_type_code`	CHAR(2)	NOT NULL,
	`name`	VARCHAR(100)	NOT NULL,
	`reward_point`	INT UNSIGNED	NOT NULL
);

DROP TABLE IF EXISTS `image`;

CREATE TABLE `image` (
	`image_id`	BIGINT	NOT NULL,
	`path`	VARCHAR(255)	NOT NULL
);

DROP TABLE IF EXISTS `review_image`;

CREATE TABLE `review_image` (
	`review_image_id`	BIGINT	NOT NULL,
	`review_id`	BIGINT	NOT NULL,
	`image_id`	BIGINT	NOT NULL,
	`order`	INT UNSIGNED	NOT NULL
);

ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`user_id`
);

ALTER TABLE `address` ADD CONSTRAINT `PK_ADDRESS` PRIMARY KEY (
	`address_id`
);

ALTER TABLE `user_address` ADD CONSTRAINT `PK_USER_ADDRESS` PRIMARY KEY (
	`user_address_id`
);

ALTER TABLE `user_status` ADD CONSTRAINT `PK_USER_STATUS` PRIMARY KEY (
	`user_status_code`
);

ALTER TABLE `user_rank` ADD CONSTRAINT `PK_USER_RANK` PRIMARY KEY (
	`user_rank_code`
);

ALTER TABLE `oauth_login` ADD CONSTRAINT `PK_OAUTH_LOGIN` PRIMARY KEY (
	`oauth_login_id`
);

ALTER TABLE `oauth_type` ADD CONSTRAINT `PK_OAUTH_TYPE` PRIMARY KEY (
	`oauth_type_code`
);

ALTER TABLE `role` ADD CONSTRAINT `PK_ROLE` PRIMARY KEY (
	`role_code`
);

ALTER TABLE `store` ADD CONSTRAINT `PK_STORE` PRIMARY KEY (
	`store_id`
);

ALTER TABLE `user_store` ADD CONSTRAINT `PK_USER_STORE` PRIMARY KEY (
	`user_store_id`
);

ALTER TABLE `brand` ADD CONSTRAINT `PK_BRAND` PRIMARY KEY (
	`brand_id`
);

ALTER TABLE `store_category` ADD CONSTRAINT `PK_STORE_CATEGORY` PRIMARY KEY (
	`store_category_id`
);

ALTER TABLE `menu` ADD CONSTRAINT `PK_MENU` PRIMARY KEY (
	`menu_id`
);

ALTER TABLE `close` ADD CONSTRAINT `PK_CLOSE` PRIMARY KEY (
	`close_id`
);

ALTER TABLE `open` ADD CONSTRAINT `PK_OPEN` PRIMARY KEY (
	`open_id`
);

ALTER TABLE `day` ADD CONSTRAINT `PK_DAY` PRIMARY KEY (
	`day_code`
);

ALTER TABLE `order` ADD CONSTRAINT `PK_ORDER` PRIMARY KEY (
	`order_id`
);

ALTER TABLE `menu_sub_menu` ADD CONSTRAINT `PK_MENU_SUB_MENU` PRIMARY KEY (
	`menu_sub_menu_id`
);

ALTER TABLE `menu_category` ADD CONSTRAINT `PK_MENU_CATEGORY` PRIMARY KEY (
	`menu_category_id`
);

ALTER TABLE `option` ADD CONSTRAINT `PK_OPTION` PRIMARY KEY (
	`option_id`
);

ALTER TABLE `menu_option` ADD CONSTRAINT `PK_MENU_OPTION` PRIMARY KEY (
	`menu_option_id`
);

ALTER TABLE `option_category` ADD CONSTRAINT `PK_OPTION_CATEGORY` PRIMARY KEY (
	`option_category_id`
);

ALTER TABLE `brand_menu` ADD CONSTRAINT `PK_BRAND_MENU` PRIMARY KEY (
	`brand_menu_id`
);

ALTER TABLE `store_menu` ADD CONSTRAINT `PK_STORE_MENU` PRIMARY KEY (
	`store_menu_id`
);

ALTER TABLE `coupon_policy` ADD CONSTRAINT `PK_COUPON_POLICY` PRIMARY KEY (
	`coupon_policy_id`
);

ALTER TABLE `brand_coupon_vendor` ADD CONSTRAINT `PK_BRAND_COUPON_VENDOR` PRIMARY KEY (
	`brand_coupon_vendor_id`
);

ALTER TABLE `amount_coupon_policy` ADD CONSTRAINT `PK_AMOUNT_COUPON_POLICY` PRIMARY KEY (
	`amount_coupon_policy_id`
);

ALTER TABLE `percent_coupon_policy` ADD CONSTRAINT `PK_PERCENT_COUPON_POLICY` PRIMARY KEY (
	`percent_coupon_policy_id`
);

ALTER TABLE `coupon` ADD CONSTRAINT `PK_COUPON` PRIMARY KEY (
	`coupon_id`
);

ALTER TABLE `anniversary_coupon_vendor` ADD CONSTRAINT `PK_ANNIVERSARY_COUPON_VENDOR` PRIMARY KEY (
	`anniversary_coupon_vendor_id`
);

ALTER TABLE `user_rate_coupon_vendor` ADD CONSTRAINT `PK_USER_RATE_COUPON_VENDOR` PRIMARY KEY (
	`user_rate_coupon_vendor_id`
);

ALTER TABLE `total_coupon` ADD CONSTRAINT `PK_TOTAL_COUPON` PRIMARY KEY (
	`total_coupon_id`
);

ALTER TABLE `store_category_coupon_vendor` ADD CONSTRAINT `PK_STORE_CATEGORY_COUPON_VENDOR` PRIMARY KEY (
	`store_category_coupon_vendor_id`
);

ALTER TABLE `menu_category_coupon_vendor` ADD CONSTRAINT `PK_MENU_CATEGORY_COUPON_VENDOR` PRIMARY KEY (
	`menu_category_coupon_vendor_id`
);

ALTER TABLE `user_coupon` ADD CONSTRAINT `PK_USER_COUPON` PRIMARY KEY (
	`user_coupon_id`
);

ALTER TABLE `point` ADD CONSTRAINT `PK_POINT` PRIMARY KEY (
	`point_id`
);

ALTER TABLE `order_state` ADD CONSTRAINT `PK_ORDER_STATE` PRIMARY KEY (
	`order_state_code`
);

ALTER TABLE `order_menu` ADD CONSTRAINT `PK_ORDER_MENU` PRIMARY KEY (
	`order_menu_id`
);

ALTER TABLE `order_state_history` ADD CONSTRAINT `PK_ORDER_STATE_HISTORY` PRIMARY KEY (
	`order_state_history_id`
);

ALTER TABLE `pay` ADD CONSTRAINT `PK_PAY` PRIMARY KEY (
	`pay_id`
);

ALTER TABLE `pay_type` ADD CONSTRAINT `PK_PAY_TYPE` PRIMARY KEY (
	`pay_type_code`
);

ALTER TABLE `banner` ADD CONSTRAINT `PK_BANNER` PRIMARY KEY (
	`banner_id`
);

ALTER TABLE `banner_coupon` ADD CONSTRAINT `PK_BANNER_COUPON` PRIMARY KEY (
	`banner_coupon_id`
);

ALTER TABLE `pay_status` ADD CONSTRAINT `PK_PAY_STATUS` PRIMARY KEY (
	`pay_status_code`
);

ALTER TABLE `menu_review` ADD CONSTRAINT `PK_MENU_REVIEW` PRIMARY KEY (
	`menu_review_id`
);

ALTER TABLE `review` ADD CONSTRAINT `PK_REVIEW` PRIMARY KEY (
	`review_id`
);

ALTER TABLE `event_coupon_vendor` ADD CONSTRAINT `PK_EVENT_COUPON_VENDOR` PRIMARY KEY (
	`event_coupon_vendor_id`
);

ALTER TABLE `order_menu_option` ADD CONSTRAINT `PK_ORDER_MENU_OPTION` PRIMARY KEY (
	`order_menu_option_id`
);

ALTER TABLE `order_menu_sub_menu` ADD CONSTRAINT `PK_ORDER_MENU_SUB_MENU` PRIMARY KEY (
	`order_menu_sub_menu_id`
);

ALTER TABLE `anniversary_type` ADD CONSTRAINT `PK_ANNIVERSARY_TYPE` PRIMARY KEY (
	`anniversary_type_code`
);

ALTER TABLE `user_anniversary` ADD CONSTRAINT `PK_USER_ANNIVERSARY` PRIMARY KEY (
	`user_anniversary_id`
);

ALTER TABLE `notification_type` ADD CONSTRAINT `PK_NOTIFICATION_TYPE` PRIMARY KEY (
	`notification_type_code`
);

ALTER TABLE `user_notification_type` ADD CONSTRAINT `PK_USER_NOTIFICATION_TYPE` PRIMARY KEY (
	`user_notification_type_id`
);

ALTER TABLE `user_store_notification_type` ADD CONSTRAINT `PK_USER_STORE_NOTIFICATION_TYPE` PRIMARY KEY (
	`user_store_notification_type_id`
);

ALTER TABLE `delivery_price` ADD CONSTRAINT `PK_DELIVERY_PRICE` PRIMARY KEY (
	`delivery_price_id`
);

ALTER TABLE `reward_point_type` ADD CONSTRAINT `PK_REWARD_POINT_TYPE` PRIMARY KEY (
	`reward_point_type_code`
);

ALTER TABLE `image` ADD CONSTRAINT `PK_IMAGE` PRIMARY KEY (
	`image_id`
);

ALTER TABLE `review_image` ADD CONSTRAINT `PK_REVIEW_IMAGE` PRIMARY KEY (
	`review_image_id`
);

ALTER TABLE `user` MODIFY COLUMN `user_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `address` MODIFY COLUMN `address_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `user_address` MODIFY COLUMN `user_address_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `oauth_login` MODIFY COLUMN `oauth_login_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `store` MODIFY COLUMN `store_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `user_store` MODIFY COLUMN `user_store_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `brand` MODIFY COLUMN `brand_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `store_category` MODIFY COLUMN `store_category_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `menu` MODIFY COLUMN `menu_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `close` MODIFY COLUMN `close_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `open` MODIFY COLUMN `open_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `order` MODIFY COLUMN `order_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `menu_sub_menu` MODIFY COLUMN `menu_sub_menu_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `menu_category` MODIFY COLUMN `menu_category_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `option` MODIFY COLUMN `option_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `menu_option` MODIFY COLUMN `menu_option_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `option_category` MODIFY COLUMN `option_category_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `brand_menu` MODIFY COLUMN `brand_menu_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `store_menu` MODIFY COLUMN `store_menu_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `coupon_policy` MODIFY COLUMN `coupon_policy_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `coupon` MODIFY COLUMN `coupon_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `anniversary_coupon_vendor` MODIFY COLUMN `anniversary_coupon_vendor_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `user_rate_coupon_vendor` MODIFY COLUMN `user_rate_coupon_vendor_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `user_coupon` MODIFY COLUMN `user_coupon_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `point` MODIFY COLUMN `point_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `order_menu` MODIFY COLUMN `order_menu_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `order_state_history` MODIFY COLUMN `order_state_history_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `pay` MODIFY COLUMN `pay_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `banner` MODIFY COLUMN `banner_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `banner_coupon` MODIFY COLUMN `banner_coupon_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `menu_review` MODIFY COLUMN `menu_review_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `review` MODIFY COLUMN `review_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `event_coupon_vendor` MODIFY COLUMN `event_coupon_vendor_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `order_menu_option` MODIFY COLUMN `order_menu_option_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `order_menu_sub_menu` MODIFY COLUMN `order_menu_sub_menu_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `user_anniversary` MODIFY COLUMN `user_anniversary_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `user_notification_type` MODIFY COLUMN `user_notification_type_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `user_store_notification_type` MODIFY COLUMN `user_store_notification_type_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `delivery_price` MODIFY COLUMN `delivery_price_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `image` MODIFY COLUMN `image_id` BIGINT AUTO_INCREMENT;
ALTER TABLE `review_image` MODIFY COLUMN `review_image_id` BIGINT AUTO_INCREMENT;


ALTER TABLE `user` ADD CONSTRAINT `FK_user_rank_TO_user_1` FOREIGN KEY (
	`user_rank_code`
)
REFERENCES `user_rank` (
	`user_rank_code`
);

ALTER TABLE `user` ADD CONSTRAINT `FK_user_status_TO_user_1` FOREIGN KEY (
	`user_status_code`
)
REFERENCES `user_status` (
	`user_status_code`
);

ALTER TABLE `user` ADD CONSTRAINT `FK_image_TO_user_1` FOREIGN KEY (
	`image_id`
)
REFERENCES `image` (
	`image_id`
);

ALTER TABLE `user_address` ADD CONSTRAINT `FK_user_TO_user_address_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `user_address` ADD CONSTRAINT `FK_address_TO_user_address_1` FOREIGN KEY (
	`address_id`
)
REFERENCES `address` (
	`address_id`
);

ALTER TABLE `oauth_login` ADD CONSTRAINT `FK_user_TO_oauth_login_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `oauth_login` ADD CONSTRAINT `FK_oauth_type_TO_oauth_login_1` FOREIGN KEY (
	`oauth_type_code`
)
REFERENCES `oauth_type` (
	`oauth_type_code`
);

ALTER TABLE `store` ADD CONSTRAINT `FK_brand_TO_store_1` FOREIGN KEY (
	`brand_id`
)
REFERENCES `brand` (
	`brand_id`
);

ALTER TABLE `store` ADD CONSTRAINT `FK_address_TO_store_1` FOREIGN KEY (
	`address_id`
)
REFERENCES `address` (
	`address_id`
);

ALTER TABLE `store` ADD CONSTRAINT `FK_store_category_TO_store_1` FOREIGN KEY (
	`store_category_id`
)
REFERENCES `store_category` (
	`store_category_id`
);

ALTER TABLE `store` ADD CONSTRAINT `FK_delivery_price_TO_store_1` FOREIGN KEY (
	`delivery_price_id`
)
REFERENCES `delivery_price` (
	`delivery_price_id`
);

ALTER TABLE `store` ADD CONSTRAINT `FK_image_TO_store_1` FOREIGN KEY (
	`image_id`
)
REFERENCES `image` (
	`image_id`
);

ALTER TABLE `user_store` ADD CONSTRAINT `FK_user_TO_user_store_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `user_store` ADD CONSTRAINT `FK_role_TO_user_store_1` FOREIGN KEY (
	`role_code`
)
REFERENCES `role` (
	`role_code`
);

ALTER TABLE `user_store` ADD CONSTRAINT `FK_store_TO_user_store_1` FOREIGN KEY (
	`store_id`
)
REFERENCES `store` (
	`store_id`
);

ALTER TABLE `menu` ADD CONSTRAINT `FK_menu_category_TO_menu_1` FOREIGN KEY (
	`menu_category_id`
)
REFERENCES `menu_category` (
	`menu_category_id`
);

ALTER TABLE `menu` ADD CONSTRAINT `FK_image_TO_menu_1` FOREIGN KEY (
	`image_id`
)
REFERENCES `image` (
	`image_id`
);

ALTER TABLE `close` ADD CONSTRAINT `FK_store_TO_close_1` FOREIGN KEY (
	`store_id`
)
REFERENCES `store` (
	`store_id`
);

ALTER TABLE `open` ADD CONSTRAINT `FK_day_TO_open_1` FOREIGN KEY (
	`day_code`
)
REFERENCES `day` (
	`day_code`
);

ALTER TABLE `open` ADD CONSTRAINT `FK_store_TO_open_1` FOREIGN KEY (
	`store_id`
)
REFERENCES `store` (
	`store_id`
);

ALTER TABLE `order` ADD CONSTRAINT `FK_coupon_TO_order_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon` (
	`coupon_id`
);

ALTER TABLE `order` ADD CONSTRAINT `FK_user_TO_order_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `menu_sub_menu` ADD CONSTRAINT `FK_menu_TO_menu_sub_menu_1` FOREIGN KEY (
	`main_menu_id`
)
REFERENCES `menu` (
	`menu_id`
);

ALTER TABLE `menu_sub_menu` ADD CONSTRAINT `FK_menu_TO_menu_sub_menu_2` FOREIGN KEY (
	`sub_menu_id`
)
REFERENCES `menu` (
	`menu_id`
);

ALTER TABLE `menu_sub_menu` ADD CONSTRAINT `FK_menu_category_TO_menu_sub_menu_1` FOREIGN KEY (
	`menu_category_id`
)
REFERENCES `menu_category` (
	`menu_category_id`
);

ALTER TABLE `menu_option` ADD CONSTRAINT `FK_option_TO_menu_option_1` FOREIGN KEY (
	`option_id`
)
REFERENCES `option` (
	`option_id`
);

ALTER TABLE `menu_option` ADD CONSTRAINT `FK_option_category_TO_menu_option_1` FOREIGN KEY (
	`option_category_id`
)
REFERENCES `option_category` (
	`option_category_id`
);

ALTER TABLE `menu_option` ADD CONSTRAINT `FK_menu_TO_menu_option_1` FOREIGN KEY (
	`menu_id`
)
REFERENCES `menu` (
	`menu_id`
);

ALTER TABLE `brand_menu` ADD CONSTRAINT `FK_brand_TO_brand_menu_1` FOREIGN KEY (
	`brand_id`
)
REFERENCES `brand` (
	`brand_id`
);

ALTER TABLE `brand_menu` ADD CONSTRAINT `FK_menu_TO_brand_menu_1` FOREIGN KEY (
	`menu_id`
)
REFERENCES `menu` (
	`menu_id`
);

ALTER TABLE `store_menu` ADD CONSTRAINT `FK_store_TO_store_menu_1` FOREIGN KEY (
	`store_id`
)
REFERENCES `store` (
	`store_id`
);

ALTER TABLE `store_menu` ADD CONSTRAINT `FK_menu_TO_store_menu_1` FOREIGN KEY (
	`menu_id`
)
REFERENCES `menu` (
	`menu_id`
);

ALTER TABLE `brand_coupon_vendor` ADD CONSTRAINT `FK_coupon_TO_brand_coupon_vendor_1` FOREIGN KEY (
	`brand_coupon_vendor_id`
)
REFERENCES `coupon` (
	`coupon_id`
);

ALTER TABLE `brand_coupon_vendor` ADD CONSTRAINT `FK_brand_TO_brand_coupon_vendor_1` FOREIGN KEY (
	`brand_id`
)
REFERENCES `brand` (
	`brand_id`
);

ALTER TABLE `amount_coupon_policy` ADD CONSTRAINT `FK_coupon_policy_TO_amount_coupon_policy_1` FOREIGN KEY (
	`amount_coupon_policy_id`
)
REFERENCES `coupon_policy` (
	`coupon_policy_id`
);

ALTER TABLE `percent_coupon_policy` ADD CONSTRAINT `FK_coupon_policy_TO_percent_coupon_policy_1` FOREIGN KEY (
	`percent_coupon_policy_id`
)
REFERENCES `coupon_policy` (
	`coupon_policy_id`
);

ALTER TABLE `coupon` ADD CONSTRAINT `FK_coupon_policy_TO_coupon_1` FOREIGN KEY (
	`coupon_policy_id`
)
REFERENCES `coupon_policy` (
	`coupon_policy_id`
);

ALTER TABLE `coupon` ADD CONSTRAINT `FK_image_TO_coupon_1` FOREIGN KEY (
	`image_id`
)
REFERENCES `image` (
	`image_id`
);




ALTER TABLE `anniversary_coupon_vendor` ADD CONSTRAINT `FK_coupon_TO_anniversary_coupon_vendor_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon` (
	`coupon_id`
);

ALTER TABLE `anniversary_coupon_vendor` ADD CONSTRAINT `FK_anniversary_type_TO_anniversary_coupon_vendor_1` FOREIGN KEY (
	`anniversary_type_code`
)
REFERENCES `anniversary_type` (
	`anniversary_type_code`
);

ALTER TABLE `anniversary_coupon_vendor` ADD CONSTRAINT `FK_user_rank_TO_anniversary_coupon_vendor_1` FOREIGN KEY (
	`user_rank_code`
)
REFERENCES `user_rank` (
	`user_rank_code`
);

ALTER TABLE `user_rate_coupon_vendor` ADD CONSTRAINT `FK_user_rank_TO_user_rate_coupon_vendor_1` FOREIGN KEY (
	`user_rank_code`
)
REFERENCES `user_rank` (
	`user_rank_code`
);

ALTER TABLE `user_rate_coupon_vendor` ADD CONSTRAINT `FK_coupon_TO_user_rate_coupon_vendor_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon` (
	`coupon_id`
);

ALTER TABLE `total_coupon` ADD CONSTRAINT `FK_coupon_TO_total_coupon_1` FOREIGN KEY (
	`total_coupon_id`
)
REFERENCES `coupon` (
	`coupon_id`
);

ALTER TABLE `store_category_coupon_vendor` ADD CONSTRAINT `FK_coupon_TO_store_category_coupon_vendor_1` FOREIGN KEY (
	`store_category_coupon_vendor_id`
)
REFERENCES `coupon` (
	`coupon_id`
);

ALTER TABLE `store_category_coupon_vendor` ADD CONSTRAINT `FK_store_category_TO_store_category_coupon_vendor_1` FOREIGN KEY (
	`store_category_id`
)
REFERENCES `store_category` (
	`store_category_id`
);

ALTER TABLE `menu_category_coupon_vendor` ADD CONSTRAINT `FK_coupon_TO_menu_category_coupon_vendor_1` FOREIGN KEY (
	`menu_category_coupon_vendor_id`
)
REFERENCES `coupon` (
	`coupon_id`
);

ALTER TABLE `menu_category_coupon_vendor` ADD CONSTRAINT `FK_menu_category_TO_menu_category_coupon_vendor_1` FOREIGN KEY (
	`menu_category_id`
)
REFERENCES `menu_category` (
	`menu_category_id`
);

ALTER TABLE `user_coupon` ADD CONSTRAINT `FK_coupon_TO_user_coupon_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon` (
	`coupon_id`
);

ALTER TABLE `user_coupon` ADD CONSTRAINT `FK_user_TO_user_coupon_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `point` ADD CONSTRAINT `FK_user_TO_point_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `point` ADD CONSTRAINT `FK_order_TO_point_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`order_id`
);

ALTER TABLE `order_menu` ADD CONSTRAINT `FK_store_menu_TO_order_menu_1` FOREIGN KEY (
	`store_menu_id`
)
REFERENCES `store_menu` (
	`store_menu_id`
);

ALTER TABLE `order_menu` ADD CONSTRAINT `FK_order_TO_order_menu_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`order_id`
);

ALTER TABLE `order_state_history` ADD CONSTRAINT `FK_order_state_TO_order_state_history_1` FOREIGN KEY (
	`order_state_code`
)
REFERENCES `order_state` (
	`order_state_code`
);

ALTER TABLE `order_state_history` ADD CONSTRAINT `FK_order_TO_order_state_history_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`order_id`
);

ALTER TABLE `pay` ADD CONSTRAINT `FK_order_TO_pay_1` FOREIGN KEY (
	`order_id`
)
REFERENCES `order` (
	`order_id`
);

ALTER TABLE `pay` ADD CONSTRAINT `FK_pay_type_TO_pay_1` FOREIGN KEY (
	`pay_type_code`
)
REFERENCES `pay_type` (
	`pay_type_code`
);

ALTER TABLE `pay` ADD CONSTRAINT `FK_pay_status_TO_pay_1` FOREIGN KEY (
	`pay_status_code`
)
REFERENCES `pay_status` (
	`pay_status_code`
);

ALTER TABLE `banner` ADD CONSTRAINT `FK_image_TO_banner_1` FOREIGN KEY (
	`image_id`
)
REFERENCES `image` (
	`image_id`
);

ALTER TABLE `banner_coupon` ADD CONSTRAINT `FK_banner_TO_banner_coupon_1` FOREIGN KEY (
	`banner_id`
)
REFERENCES `banner` (
	`banner_id`
);

ALTER TABLE `banner_coupon` ADD CONSTRAINT `FK_coupon_TO_banner_coupon_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon` (
	`coupon_id`
);

ALTER TABLE `menu_review` ADD CONSTRAINT `FK_image_TO_menu_review_1` FOREIGN KEY (
	`image_id`
)
REFERENCES `image` (
	`image_id`
);

ALTER TABLE `menu_review` ADD CONSTRAINT `FK_review_TO_menu_review_1` FOREIGN KEY (
	`review_id`
)
REFERENCES `review` (
	`review_id`
);

ALTER TABLE `menu_review` ADD CONSTRAINT `FK_store_menu_TO_menu_review_1` FOREIGN KEY (
	`store_menu_id`
)
REFERENCES `store_menu` (
	`store_menu_id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_review_TO_review_1` FOREIGN KEY (
	`parent_review_id`
)
REFERENCES `review` (
	`review_id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_user_TO_review_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_order_TO_review_1` FOREIGN KEY (
	`store_id`
)
REFERENCES `order` (
	`order_id`
);

ALTER TABLE `event_coupon_vendor` ADD CONSTRAINT `FK_coupon_TO_event_coupon_vendor_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon` (
	`coupon_id`
);

ALTER TABLE `event_coupon_vendor` ADD CONSTRAINT `FK_user_rank_TO_event_coupon_vendor_1` FOREIGN KEY (
	`user_rank_code`
)
REFERENCES `user_rank` (
	`user_rank_code`
);

ALTER TABLE `order_menu_option` ADD CONSTRAINT `FK_order_menu_TO_order_menu_option_1` FOREIGN KEY (
	`order_menu_id`
)
REFERENCES `order_menu` (
	`order_menu_id`
);

ALTER TABLE `order_menu_option` ADD CONSTRAINT `FK_menu_option_TO_order_menu_option_1` FOREIGN KEY (
	`menu_option_id`
)
REFERENCES `menu_option` (
	`menu_option_id`
);

ALTER TABLE `order_menu_sub_menu` ADD CONSTRAINT `FK_order_menu_TO_order_menu_sub_menu_1` FOREIGN KEY (
	`order_menu_id`
)
REFERENCES `order_menu` (
	`order_menu_id`
);

ALTER TABLE `order_menu_sub_menu` ADD CONSTRAINT `FK_menu_sub_menu_TO_order_menu_sub_menu_1` FOREIGN KEY (
	`menu_sub_menu_id`
)
REFERENCES `menu_sub_menu` (
	`menu_sub_menu_id`
);

ALTER TABLE `user_anniversary` ADD CONSTRAINT `FK_user_TO_user_anniversary_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `user_anniversary` ADD CONSTRAINT `FK_anniversary_type_TO_user_anniversary_1` FOREIGN KEY (
	`anniversary_type_code`
)
REFERENCES `anniversary_type` (
	`anniversary_type_code`
);

ALTER TABLE `user_notification_type` ADD CONSTRAINT `FK_notification_type_TO_user_notification_type_1` FOREIGN KEY (
	`notification_type_code`
)
REFERENCES `notification_type` (
	`notification_type_code`
);

ALTER TABLE `user_notification_type` ADD CONSTRAINT `FK_user_TO_user_notification_type_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`user_id`
);

ALTER TABLE `user_store_notification_type` ADD CONSTRAINT `FK_user_store_TO_user_store_notification_type_1` FOREIGN KEY (
	`user_store_id`
)
REFERENCES `user_store` (
	`user_store_id`
);

ALTER TABLE `user_store_notification_type` ADD CONSTRAINT `FK_notification_type_TO_user_store_notification_type_1` FOREIGN KEY (
	`notification_type_code`
)
REFERENCES `notification_type` (
	`notification_type_code`
);

ALTER TABLE `review_image` ADD CONSTRAINT `FK_review_TO_review_image_1` FOREIGN KEY (
	`review_id`
)
REFERENCES `review` (
	`review_id`
);

ALTER TABLE `review_image` ADD CONSTRAINT `FK_image_TO_review_image_1` FOREIGN KEY (
	`image_id`
)
REFERENCES `image` (
	`image_id`
);

