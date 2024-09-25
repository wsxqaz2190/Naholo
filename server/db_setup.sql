-- 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS Naholo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 사용
USE Naholo_db;

-- 1. 사용자 테이블 생성 (모든 다른 테이블의 외래 키 참조 대상)
CREATE TABLE `Users` (
    `USER_ID` VARCHAR(255) NOT NULL,
    `USER_PW` VARCHAR(255) NOT NULL,
    `NAME` VARCHAR(255) NOT NULL,
    `PHONE` CHAR(255) NOT NULL,
    `BIRTH` CHAR(255) NOT NULL,
    `GENDER` BOOLEAN NOT NULL,
    `NICKNAME` VARCHAR(255) NOT NULL,
    `USER_CHARACTER` CHAR(255) NOT NULL,
    `LV` BIGINT NOT NULL DEFAULT 0,
    `INTRODUCE` VARCHAR(255) NOT NULL,
    `IMAGE` longtext NULL, -- 이미지 경로 저장
    `EXP` BIGINT NOT NULL DEFAULT 0, -- 경험치 필드 추가
    PRIMARY KEY (`USER_ID`)
);

-- 2. 장소 정보 테이블 생성 (WHERE_REVIEW, LIKES, Journal_post, WHERE_IMAGE 테이블이 참조)
CREATE TABLE `Where` (
    `WHERE_ID` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `WHERE_NAME` VARCHAR(255) NOT NULL,
    `WHERE_LOCATE` VARCHAR(255) NOT NULL,
    `WHERE_RATE` FLOAT(53) NOT NULL,
    `WHERE_TYPE` VARCHAR(255) NOT NULL,
    `LATITUDE` FLOAT(53) NULL,
    `LONGITUDE` FLOAT(53) NULL
);

-- 3. 사용자 이미지 테이블 생성 (Users 테이블 참조)
CREATE TABLE `Users_Image` (
    `USER_ID` VARCHAR(255) NOT NULL,
    `IMAGE` longtext NULL,
    PRIMARY KEY (`USER_ID`),
    FOREIGN KEY (`USER_ID`) REFERENCES `Users`(`USER_ID`) ON DELETE CASCADE
);

-- 4. 팔로우 테이블 생성 (Users 테이블 참조)
CREATE TABLE `Follow` (
    `USER_ID` VARCHAR(255) NOT NULL,
    `FOLLOWER` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`USER_ID`, `FOLLOWER`),
    FOREIGN KEY (`USER_ID`) REFERENCES `Users`(`USER_ID`) ON DELETE CASCADE,
    FOREIGN KEY (`FOLLOWER`) REFERENCES `Users`(`USER_ID`) ON DELETE CASCADE
);

-- 5. 좋아요 테이블 생성 (Users와 Where 테이블 참조)
CREATE TABLE `LIKES` (
    `LIKES_ID` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `USER_ID` VARCHAR(255) NOT NULL,
    `WHERE_ID` BIGINT NOT NULL,
    FOREIGN KEY (`USER_ID`) REFERENCES `Users`(`USER_ID`) ON DELETE CASCADE,
    FOREIGN KEY (`WHERE_ID`) REFERENCES `Where`(`WHERE_ID`) ON DELETE CASCADE
);

-- 6. 장소 리뷰 테이블 생성 (Users와 Where 테이블 참조)
CREATE TABLE `WHERE_REVIEW` (
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
    `REASON_WATCH` BOOLEAN NOT NULL,
    FOREIGN KEY (`USER_ID`) REFERENCES `Users`(`USER_ID`) ON DELETE CASCADE,
    FOREIGN KEY (`WHERE_ID`) REFERENCES `Where`(`WHERE_ID`) ON DELETE CASCADE
);

-- 7. 리뷰 이미지 테이블 생성 (WHERE_REVIEW 테이블 참조)
CREATE TABLE `REVIEW_IMAGE` (
    `IMAGE_ID` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `REVIEW_ID` BIGINT NOT NULL,
    `IMAGE` longtext NULL,
    FOREIGN KEY (`REVIEW_ID`) REFERENCES `WHERE_REVIEW`(`REVIEW_ID`) ON DELETE CASCADE
);

-- 8. 장소 이미지 테이블 생성 (Where 테이블 참조)
CREATE TABLE `WHERE_IMAGE` (
    `IMAGE_ID` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `WHERE_ID` BIGINT NOT NULL,
    `IMAGE` longtext NOT NULL,
    FOREIGN KEY (`WHERE_ID`) REFERENCES `Where`(`WHERE_ID`) ON DELETE CASCADE
);

-- 9. 일지 포스트 테이블 생성 (Users와 Where 테이블 참조)
CREATE TABLE `Journal_post` (
    `POST_ID` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `USER_ID` VARCHAR(255) NOT NULL,
    `WHERE_ID` BIGINT NOT NULL,
    `POST_NAME` VARCHAR(255) NOT NULL,
    `POST_CONTENT` VARCHAR(255) NOT NULL,
    `POST_CREATE` CHAR(255) NOT NULL,
    `POST_UPDATE` CHAR(255) NOT NULL,
    `POST_LIKE` BIGINT NOT NULL,
    FOREIGN KEY (`USER_ID`) REFERENCES `Users`(`USER_ID`) ON DELETE CASCADE,
    FOREIGN KEY (`WHERE_ID`) REFERENCES `Where`(`WHERE_ID`) ON DELETE CASCADE
);

-- 10. 일지 댓글 테이블 생성 (Journal_post 테이블 참조)
CREATE TABLE `Journal_comment` (
    `COMMENT_ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `POST_ID` BIGINT NOT NULL,
    `COMMENT_CONTENT` VARCHAR(255) NOT NULL,
    `USER_ID` VARCHAR(255) NOT NULL,
    FOREIGN KEY (`POST_ID`) REFERENCES `Journal_post`(`POST_ID`) ON DELETE CASCADE,
    FOREIGN KEY (`USER_ID`) REFERENCES `Users`(`USER_ID`) ON DELETE CASCADE
);

