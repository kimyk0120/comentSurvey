SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS answer;
DROP TABLE IF EXISTS multi_question;
DROP TABLE IF EXISTS survey_question;
DROP TABLE IF EXISTS survey_target;
DROP TABLE IF EXISTS survey;
DROP TABLE IF EXISTS user;




/* Create Tables */

CREATE TABLE answer
(
	survey_key int NOT NULL,
	question_seq int NOT NULL,
	user_id varchar(50) NOT NULL,
	answer varchar(1000),
	PRIMARY KEY (survey_key, question_seq, user_id)
);


CREATE TABLE multi_question
(
	survey_key int NOT NULL,
	question_seq int NOT NULL,
	multi_seq int NOT NULL,
	multi_question varchar(200),
	PRIMARY KEY (survey_key, question_seq, multi_seq)
);


CREATE TABLE survey
(
	survey_key int NOT NULL AUTO_INCREMENT,
	-- A:전체
	-- B:지자체
	-- C:해설사
	survey_target varchar(1) COMMENT 'A:전체
B:지자체
C:해설사',
	survey_title varchar(50) NOT NULL,
	-- 'Y' 일 경우 임시저장 상태
	-- 'N' 일 경우 설문대상자들에 발송 완료
	temp_yn varchar(1) COMMENT '''Y'' 일 경우 임시저장 상태
''N'' 일 경우 설문대상자들에 발송 완료',
	reg_dt datetime,
	reg_id varchar(20),
	PRIMARY KEY (survey_key),
	UNIQUE (survey_key)
);


CREATE TABLE survey_question
(
	survey_key int NOT NULL,
	question_seq int NOT NULL,
	-- 'Y'일 경우 객관식
	-- 'N'일 경우 주관식
	multi_yn varchar(1) COMMENT '''Y''일 경우 객관식
''N''일 경우 주관식',
	question varchar(200),
	PRIMARY KEY (survey_key, question_seq)
);


CREATE TABLE survey_target
(
	survey_key int NOT NULL,
	user_id varchar(50) NOT NULL,
	send_dt datetime,
	email_yn varchar(1),
	sms_yn varchar(1),
	-- 발송고유값
	unique_no varchar(20) COMMENT '발송고유값',
	confirm_yn varchar(1),
	confirm_dt datetime,
	temp_yn varchar(1),
	PRIMARY KEY (survey_key, user_id)
);


CREATE TABLE user
(
	user_id varchar(50) NOT NULL,
	sido_cd varchar(5),
	gugun_cd varchar(5),
	auth_no varchar(1),
	email varchar(50),
	phone varchar(20),
	cmntor_no varchar(10),
	PRIMARY KEY (user_id),
	UNIQUE (user_id)
);



/* Create Foreign Keys */

ALTER TABLE survey_question
	ADD FOREIGN KEY (survey_key)
	REFERENCES survey (survey_key)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE survey_target
	ADD FOREIGN KEY (survey_key)
	REFERENCES survey (survey_key)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE answer
	ADD FOREIGN KEY (survey_key, question_seq)
	REFERENCES survey_question (survey_key, question_seq)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE multi_question
	ADD FOREIGN KEY (survey_key, question_seq)
	REFERENCES survey_question (survey_key, question_seq)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE answer
	ADD FOREIGN KEY (user_id)
	REFERENCES user (user_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE survey_target
	ADD FOREIGN KEY (user_id)
	REFERENCES user (user_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



