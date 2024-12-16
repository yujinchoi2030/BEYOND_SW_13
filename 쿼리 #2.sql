-- INSERT 실습
INSERT INTO USERTBL(USERID, NAME, BIRTHYEAR, ADDR) 
VALUES ('hong123', '홍길동', 2015, '서울');

INSERT INTO USERTBL
VALUES ('lee123', '이몽룡', 2015, '강원','010','12345678', 160, NULL);

INSERT INTO USERTBL
VALUES ('sung123', '성춘향', 2015, '강원','010','45678901', 160, CURDATE());

INSERT INTO USERTBL(USERID, NAME, BIRTHYEAR, ADDR) 
VALUES ('lim123', '임꺽정', 1977, '경기'),('moon123', '문인수', 2000, '서울');

SELECT * FROM usertbl;

CREATE TABLE usertbl_copy(SELECT * FROM usertbl WHERE 1=0);

INSERT INTO usertbl_copy 
SELECT * FROM usertbl;

DROP TABLE usertbl_copy;

-- UPDATE 실습
-- USERTBL 테이블에서 USERID 가 HONG123 인 회원의 이름을 고길동으로 변경
UPDATE usertbl SET NAME = '고길동' WHERE USERID = 'HONG123';

CREATE TABLE EMP_SALARY(
	SELECT EMP_ID, EMP_NAME, SALARY, BONUS FROM employee
);

-- WHERE 절을 작성하지 않으면 모든 행이 변경된다.
UPDATE emp_salary SET EMP_NAME = '홍길동';

-- 모든 사원의 급여를 기존 급여에서 10프로 인상한 금액(기존 급여 * 1.1) 으로 변경
UPDATE emp_salary SET SALARY = SALARY * 1.1;

SELECT * FROM emp_salary;

-- DELETE 실습
-- USERTBL 테이블에서 USERID 가 HONG123 인 회원을 삭제
DELETE FROM usertbl WHERE USERID = 'HONG123';

-- usertbl 테이블에서 mobile1 이 null 인 회원들 중 상위 2명 삭제
DELETE FROM usertbl WHERE MOBILE1 IS NULL LIMIT 2;

SELECT * FROM usertbl;

SELECT * FROM employee;

SELECT * FROM emp_salary;
-- WHERE 절을 작성하지 않으면 모든 행이 삭제된다
DELETE FROM emp_salary;

-- 조건부 데이터 입력, 변경 실습
-- usertbl 테이블에 USERID 가 BBK 인 한개의 행 삽입
-- 기본키 중복으로 에러가 발생한다.
INSERT INTO usertbl (USERID, NAME, BIRTHYEAR, ADDR)
VALUES ('BBK', '바보킴', 1999, '인천');

-- 기본키 중복으로 에러가 발생하지 않고 경고만 출력하고 넘어간다.
INSERT IGNORE INTO usertbl (USERID, NAME, BIRTHYEAR, ADDR)
VALUES ('BBK', '바보킴', 1999, '인천');

-- usertbl 테이블에 USERID 가 BBK 인 회원이 없으면 INSERT 를 수행하고, 있으면  UPDATE 실행
INSERT INTO usertbl (USERID, NAME, BIRTHYEAR, ADDR)
VALUES ('BBK', '바보킴', 1999, '인천')
ON DUPLICATE KEY UPDATE NAME = '바보킴', ADDR = '인천';

-- usertbl 테이블에 USERID 가 HONG 인 회원이 없으면 INSERT 를 수행하고, 있으면  UPDATE 실행
INSERT INTO usertbl (USERID, NAME, BIRTHYEAR, ADDR)
VALUES ('HONG', '홍길동', 1880, '서울')
ON DUPLICATE KEY UPDATE NAME = '고길동', BIRTHYEAR = 1900, ADDR = '강원';

-- 사용자가 COMMIT 명령을 실행하지 않아도 자동으로 모든 명령이 COMMIT되어 즉시 반영 
SELECT @@AUTOCOMMIT;

SET AUTOCOMMIT = 1;
SET AUTOCOMMIT = 0;
 
DELETE FROM USERTBL WHERE USERID ='LEE123';

SELECT * FROM usertbl;

DELETE FROM USERTBL WHERE USERID ='SUNG123';

SELECT * FROM USERTBL;

ROLLBACK;

DELETE FROM USERTBL WHERE USERID ='SUNG123';
COMMIT;
SELECT * FROM USERTBL;










