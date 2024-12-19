-- 테이블 생성 실습
-- 회원에 대한 데이터를 담을 수 있는 tb_member 테이블 생성
DROP TABLE `tb_member`;

CREATE TABLE `tb_member` (
	`mem_no` INT NOT NULL,
	`mem_id` VARCHAR(20) NOT NULL,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` VARCHAR(15) NOT NULL,
	`enroll_date` DATE DEFAULT CURDATE()
);

-- 테이블에 샘플 데이터 추가
INSERT INTO tb_member VALUES (1, 'USER1', '1234', '홍길동', '2024-12-08');
INSERT INTO tb_member VALUES (2, 'USER2', '1234', '이몽룡', CURDATE());
INSERT INTO tb_member VALUES (3, 'USER3', '1234', '성춘향', DEFAULT);

-- NOT NULL로 인해 NULL 값으로 데이터 삽입/갱신이 불가능하다.
INSERT INTO tb_member(mem_no, mem_id)VALUES (4, 'USER4');
INSERT INTO tb_member VALUES (NULL, NULL, NULL, NULL, NULL);

UPDATE tb_member
SET mem_id = NULL
WHERE mem_name = '홍길동';

SELECT * FROM tb_member;

-- 제약 조건 실습
-- 기본 키(PRIMARY KEY), UNIQUE 제약 조건 실습
DROP TABLE `tb_member`;

CREATE TABLE `tb_member` (
	`mem_no` INT PRIMARY KEY,
	`mem_id` VARCHAR(20) NOT NULL UNIQUE,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` VARCHAR(15) NOT NULL,
	`enroll_date` DATE DEFAULT CURDATE()
);

INSERT INTO tb_member VALUES (1, 'USER1', '1234', '홍길동', '2024-12-08');
INSERT INTO tb_member VALUES (2, 'USER2', '1234', '이몽룡', CURDATE());
-- 기본 키 중복으로 에러 발생
INSERT INTO tb_member VALUES (1, 'USER3', '1234', '성춘향', DEFAULT);
-- 기본 키가 NULL이므로 에러 발생
INSERT INTO tb_member VALUES (NULL, 'USER3', '1234', '성춘향', DEFAULT);
-- mem_id의 중복으로 에러 발생
INSERT INTO tb_member VALUES (3, 'USER1', '1234', '성춘향', DEFAULT);

-- 시스템에서 자동으로 기본 키를 생성할 수 있도록 수정
DROP TABLE `tb_member`;

CREATE TABLE `tb_member` (
	`mem_no` INT AUTO_INCREMENT PRIMARY KEY,
	`mem_id` VARCHAR(20) NOT NULL UNIQUE,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` VARCHAR(15) NOT NULL,
	`enroll_date` DATE DEFAULT CURDATE()
);

INSERT INTO tb_member(mem_id, mem_pass, mem_name)
VALUES ('USER1', '1234', '홍길동');

INSERT INTO tb_member(mem_id, mem_pass, mem_name)
VALUES ('USER2', '1234', '이몽룡');

-- 열 정의 후 제약 조건을 별도로 지정하는 방법
DROP TABLE `tb_member`;

CREATE TABLE `tb_member` (
	`mem_no` INT AUTO_INCREMENT,
	`mem_id` VARCHAR(20) NOT NULL,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` VARCHAR(15) NOT NULL,
	`enroll_date` DATE DEFAULT CURDATE(),
	/* CONSTRAINT */ PRIMARY KEY(mem_no),
	-- PRIMARY KEY 제약 조건의 경우 여러 개의 열을 묶어서 하나의 기본 키를 생성할 수 있다.
	-- PRIMARY KEY(mem_no, mem_id),
	CONSTRAINT uq_tb_member_mem_id UNIQUE(mem_id)
   --	UNIQUE 제약 조건도 여러 개의 열을 묶어서 하나의 제약 조건으로 생성할 수 있다. 
	-- UNIQUE(mem_id, mem_id)
);

INSERT INTO tb_member(mem_id, mem_pass, mem_name)
VALUES ('USER1', '1234', '홍길동');

INSERT INTO tb_member(mem_id, mem_pass, mem_name)
VALUES ('USER2', '1234', '이몽룡');

-- FOREIGN KEY 제약 조건
-- 부모 테이블 생성
CREATE TABLE `tb_member_grade`(
	grade_code VARCHAR(10) PRIMARY KEY,
	grade_name VARCHAR(10) NOT NULL
);

INSERT INTO tb_member_grade VALUES ('vip', 'VIP 회원');
INSERT INTO tb_member_grade VALUES ('gold', 'GOLD 회원');
INSERT INTO tb_member_grade VALUES ('silver', 'SILVER 회원');

-- 자식 테이블 생성
DROP TABLE tb_member;

CREATE TABLE `tb_member` (
	`mem_no` INT AUTO_INCREMENT PRIMARY KEY,
	`mem_id` VARCHAR(20) NOT NULL UNIQUE,
	`mem_pass` VARCHAR(20) NOT NULL,
	`mem_name` VARCHAR(15) NOT NULL,
	-- `grade_code` VARCHAR(10) REFERENCES tb_member_grade,
	`grade_code` VARCHAR(10) REFERENCES tb_member_grade(grade_code),
	`enroll_date` DATE DEFAULT CURDATE()
);

INSERT INTO tb_member(mem_id, mem_pass, mem_name, grade_code)
VALUES ('USER1', '1234', '홍길동', 'vip');

-- tb_member_grade 테이블의 grade_code 열에 
-- bronze라는 값이 없어서 외래 키 제약 조건에 위배되어 에러가 발생하다.
INSERT INTO tb_member(mem_id, mem_pass, mem_name, grade_code)
VALUES ('USER2', '1234', '이몽룡', 'bronze');

-- grade_code 열에 NULL 값은 삽입 가능
INSERT INTO tb_member(mem_id, mem_pass, mem_name, grade_code)
VALUES ('USER2', '1234', '이몽룡', NULL);

-- 두 테이블을 조인하여 데이터 조회
SELECT m.mem_no,
		 m.mem_id,
		 m.mem_name,
		 mg.grade_name
FROM tb_member m
-- INNER JOIN tb_member_grade mg ON m.grade_code = mg.grade_code;
LEFT OUTER JOIN tb_member_grade mg ON m.grade_code = mg.grade_code;

-- tb_member_grade 테이블에서 grade_code가 vip인 데이터 삭제
-- SELECT *
DELETE
FROM tb_member_grade
WHERE grade_code = 'vip';

-- tb_member_grade 테이블에서 grade_code가 vip인 데이터 수정
UPDATE tb_member_grade
SET grade_code = 'VVIP'
-- SET grade_name = 'VIP Member'
WHERE grade_code = 'vip';

INSERT INTO tb_member_grade VALUES ('vip', 'VIP 회원');
INSERT INTO tb_member(mem_id, mem_pass, mem_name, grade_code)
VALUES ('USER1', '1234', '홍길동', 'vip');

SELECT * FROM tb_member_grade;
SELECT * FROM tb_member;