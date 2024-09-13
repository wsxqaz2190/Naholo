-- 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS Naholo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 사용
USE Naholo_db;

CREATE TABLE `Users`(
    `USER_ID` VARCHAR(255) NOT NULL,
    `USER_PW` VARCHAR(255) NOT NULL,
    `NAME` VARCHAR(255) NOT NULL,
    `PHONE` CHAR(255) NOT NULL,
    `BIRTH` CHAR(255) NOT NULL,
    `GENDER` BOOLEAN NOT NULL,
    `NICKNAME` VARCHAR(255) NOT NULL,
    `USER_CHARACTER` CHAR(255) NOT NULL,
    `LV` BIGINT NOT NULL DEFAULT '0',
    `INTRODUCE` VARCHAR(255) NOT NULL,
    `IMAGE` BIGINT NOT NULL,
    PRIMARY KEY(`USER_ID`)
);
CREATE TABLE `Follow`(
    `USER_ID` VARCHAR(255) NOT NULL,
    `FOLLOWER` VARCHAR(255) NOT NULL
);
CREATE TABLE `LIKES`(
    `LIKES_ID` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `USER_ID` VARCHAR(255) NOT NULL,
    `WHERE_ID` BIGINT NOT NULL
);
CREATE TABLE `Users_Image`(
    `USER_ID` VARCHAR(255) NOT NULL,
    `IMAGE` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`USER_ID`)
);
CREATE TABLE `Where`(
    `WHERE_ID` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `WHERE_NAME` VARCHAR(255) NOT NULL,
    `WHERE_LOCATE` VARCHAR(255) NOT NULL,
    `WHERE_RATE` FLOAT(53) NOT NULL,
    `WHERE_TYPE` VARCHAR(255) NOT NULL
);
CREATE TABLE `Journal_comment`(
    `COMMENT_ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `POST_ID` BIGINT NOT NULL,
    `COMMENT_CONTENT` VARCHAR(255) NOT NULL,
    `USER_ID` VARCHAR(255) NOT NULL
);
CREATE TABLE `REVIEW_IMAGE`(
    `IMAGE_ID` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `REVIEW_ID` BIGINT NOT NULL,
    `IMAGE` VARCHAR(255) NOT NULL
);
CREATE TABLE `WHERE_REVIEW`(
    `REVIEW_ID` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `USER_ID` VARCHAR(255) NOT NULL,
    `WHERE_ID` BIGINT NOT NULL,
    `REVIEW_CONTENT` VARCHAR(255) NOT NULL,
    `WHERE_LIKE` BIGINT NOT NULL,
    `WHERE_RATE` FLOAT(53) NOT NULL,
    `REASON_MENU` BOOLEAN NOT NULL,
    `REASON_MOOD` BOOLEAN NOT NULL,
    `REASON_SAFE` BOOLEAN NOT NULL,
    `REASON_SEAT` BOOLEAN NOT NULL,
    `REASON_TRANSPORT` BOOLEAN NOT NULL,
    `REASON_PARK` BOOLEAN NOT NULL,
    `REASON_LONG` BOOLEAN NOT NULL,
    `REASON_VIEW` BOOLEAN NOT NULL,
    `REASON_INTERACTION` BOOLEAN NOT NULL,
    `REASON_QUITE` BOOLEAN NOT NULL,
    `REASON_PHOTO` BOOLEAN NOT NULL,
    `REASON_WATCH` BOOLEAN NOT NULL
);
CREATE TABLE `WHERE_IMAGE`(
    `IMAGE_ID` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `WHERE_ID` BIGINT NOT NULL,
    `IMAGE` VARCHAR(255) NOT NULL
);
CREATE TABLE `Journal_post`(
    `POST_ID` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `USER_ID` VARCHAR(255) NOT NULL,
    `WHERE_ID` BIGINT NOT NULL,
    `POST_NAME` VARCHAR(255) NOT NULL,
    `POST_CONTENT` VARCHAR(255) NOT NULL,
    `POST_CREATE` CHAR(255) NOT NULL,
    `POST_UPDATE` CHAR(255) NOT NULL,
    `POST_LIKE` BIGINT NOT NULL
);
ALTER TABLE
    `WHERE_REVIEW` ADD CONSTRAINT `where_review_where_id_foreign` FOREIGN KEY(`WHERE_ID`) REFERENCES `Where`(`WHERE_ID`);
ALTER TABLE
    `LIKES` ADD CONSTRAINT `likes_where_id_foreign` FOREIGN KEY(`WHERE_ID`) REFERENCES `Where`(`WHERE_ID`);
ALTER TABLE
    `Journal_post` ADD CONSTRAINT `journal_post_user_id_foreign` FOREIGN KEY(`USER_ID`) REFERENCES `Users`(`USER_ID`);
ALTER TABLE
    `WHERE_REVIEW` ADD CONSTRAINT `where_review_user_id_foreign` FOREIGN KEY(`USER_ID`) REFERENCES `Users`(`USER_ID`);
ALTER TABLE
    `REVIEW_IMAGE` ADD CONSTRAINT `review_image_review_id_foreign` FOREIGN KEY(`REVIEW_ID`) REFERENCES `WHERE_REVIEW`(`REVIEW_ID`);
ALTER TABLE
    `LIKES` ADD CONSTRAINT `likes_user_id_foreign` FOREIGN KEY(`USER_ID`) REFERENCES `Users`(`USER_ID`);
ALTER TABLE
    `Follow` ADD CONSTRAINT `follow_user_id_foreign` FOREIGN KEY(`USER_ID`) REFERENCES `Users`(`USER_ID`);
ALTER TABLE
    `Journal_comment` ADD CONSTRAINT `journal_comment_post_id_foreign` FOREIGN KEY(`POST_ID`) REFERENCES `Journal_post`(`POST_ID`);
ALTER TABLE
    `Journal_post` ADD CONSTRAINT `journal_post_where_id_foreign` FOREIGN KEY(`WHERE_ID`) REFERENCES `Where`(`WHERE_ID`);
ALTER TABLE
    `WHERE_IMAGE` ADD CONSTRAINT `where_image_where_id_foreign` FOREIGN KEY(`WHERE_ID`) REFERENCES `Where`(`WHERE_ID`);
ALTER TABLE
    `Users_Image` ADD CONSTRAINT `users_image_user_id_foreign` FOREIGN KEY(`USER_ID`) REFERENCES `Users`(`USER_ID`);