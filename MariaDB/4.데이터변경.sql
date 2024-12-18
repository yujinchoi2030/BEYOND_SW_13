-- INSERT 실습
-- usertbl 테이블에 한 개의 행 삽입
INSERT INTO usertbl(userid, name, birthYear, addr) 
VALUES ('hong123', '홍길동', 2015, '서울');

-- 열의 순서와 데이터 타입이 맞지 않아서 에러가 발생한다.
INSERT INTO usertbl(userid, name, birthYear, addr) 
VALUES ('lee123', 2015, '이몽룡', '강원');

-- 기본 키 열에 NULL 값이 입력될 수 없어서 에러가 발생한다.
INSERT INTO usertbl(name, birthYear, addr) 
VALUES ('이몽룡', 2015, '강원');

-- NULL을 허용하지 않는 열에 NULL 값이 입력될 수 없어서 에러가 발생한다. 
INSERT INTO usertbl(userid, birthYear, addr) 
VALUES ('lee123', 2015, '강원');

-- 모든 열에 저장될 값을 지정하지 않아서 에러가 발생한다.
INSERT INTO usertbl
VALUES ('lee123', '이몽룡', 2015, '강원');

-- usertbl 테이블에 한 개의 행 삽입(열 이름 생략)
INSERT INTO usertbl
VALUES ('lee123', '이몽룡', 2015, '강원', '010', '12345678', 160, NULL);

-- 현재 날짜를 조회하는 함수
SELECT CURDATE();

INSERT INTO usertbl
VALUES ('sung123', '성춘향', 2015, '강원', '010', '45678901', 160, CURDATE());

-- usertbl 테이블에 여러 개의 행 삽입
INSERT INTO usertbl(userid, name, birthYear, addr)
VALUES ('lim123', '임꺽정', 1977, '경기'), 
       ('moon123', '문인수', 2000, '서울');

SELECT * 
FROM usertbl;

-- 테이블 복사
-- 테이블의 데이터 또는 구조만 복사한다.
CREATE TABLE usertbl_copy(
	SELECT *
	FROM usertbl
	WHERE 1 = 0
);

-- SELECT 결과를 usertbl_copy 테이블에 삽입
INSERT INTO usertbl_copy (
	SELECT *
	FROM usertbl
	WHERE addr = '서울'
);

-- 서브 쿼리로 조회한 열의 개수가 테이블의 열의 개수보다 적어서 에러가 발생한다.
INSERT INTO usertbl_copy (
	SELECT userid, name
	FROM usertbl
	WHERE addr = '강원'
);

-- 서브 쿼리 조회 결과와 테이블의 열의 순서와 데이터 유형이 맞지 않아서 에러가 발생한다.
INSERT INTO usertbl_copy (
	SELECT userid,
			 birthYear,
			 mDate,
			 height,
			 mobile1,
			 mobile2,
			 addr,
			 name
	FROM usertbl
	WHERE addr = '강원'
);

-- 열의 순서와 데이터 유형이 맞아야 행이 삽입된다.
INSERT INTO usertbl_copy(userid, name, birthYear, addr) (
	SELECT userid, 
			 name, 
			 birthYear, 
			 addr
	FROM usertbl
	WHERE addr = '강원'
);

DROP TABLE usertbl_copy;

-- UPDATE 실습
-- usertbl 테이블에서 userid가 hong123인 회원의 이름을 고길동으로 변경
UPDATE usertbl
SET NAME = '고길동'
WHERE userid = 'hong123';

-- 테스트 테이블 생성
CREATE TABLE emp_salary(
	SELECT emp_id, 
			 emp_name, 
			 salary, 
			 bonus
	FROM employee
);

-- WHERE 절을 작성하지 않으면 모든 행이 변경된다.
UPDATE emp_salary
SET emp_name = '홍길동';

-- 모든 사원의 급여를 기존 급여에서 10프로 인상한 금액(기존 급여 * 1.1)으로 변경
UPDATE emp_salary
SET salary = salary * 1.1;

SELECT * FROM emp_salary;

-- DELETE 실습
-- usertbl 테이블에서 userid가 hong123인 회원을 삭제
-- SELECT *
DELETE 
FROM usertbl
WHERE userid = 'hong123';

-- usertbl 테이블에서 mobile1이 NULL인 회원들 중 상위 2명 삭제
-- SELECT *
DELETE
FROM usertbl
WHERE mobile1 IS NULL LIMIT 2;

SELECT *
FROM usertbl
WHERE mobile1 IS NULL;

-- WHERE 절을 작성하지 않으면 모든 행이 삭제된다.
DELETE FROM emp_salary;

-- 조건부 데이터 입력, 변경 실습
-- usertbl 테이블에 userid가 BBK인 한 개의 행 삽입
-- 기본 키 중복으로 에러가 발생한다.
INSERT INTO usertbl(userid, NAME, birthYear, addr)
VALUES ('BBK', '바보킴', 1999, '인천');

-- 기본 키 중복으로 인한 에러가 발생하지 않고 경고만 출력하고 넘어간다.
INSERT IGNORE INTO usertbl(userid, NAME, birthYear, addr)
VALUES ('BBK', '바보킴', 1999, '인천');

-- usertbl 테이블에 userid가 BBK인 회원이 없으면 INSERT를 수행하고
-- userid가 BBK인 회원이 있으면 UPDATE를 수행한다.
INSERT INTO usertbl(userid, NAME, birthYear, addr)
VALUES ('BBK', '바보킴', 1999, '인천')
ON DUPLICATE KEY UPDATE NAME = '바보킴', addr = '인천';

-- usertbl 테이블에 userid가 HONG인 회원이 없으면 INSERT를 수행하고 
-- userid가 HONG인 회원이 있으면 UPDATE를 수행한다.
INSERT INTO usertbl(userid, NAME, birthYear, addr)
VALUES ('HONG', '홍길동', 1880, '서울')
ON DUPLICATE KEY UPDATE NAME = '고길동', birthYear = 1900, addr = '강원';

-- 참고
-- AUTOCOMMIT은 사용자가 COMMIT 명령을 실행하지 않아도 
-- 자동으로 모든 명령이 COMMIT 되어 즉시 반영되는 것을 말한다.
SELECT @@AUTOCOMMIT;

SET autocommit = 1; -- 활성화
SET autocommit = 0; -- 비활성화

-- autocommit이 활성화된 경우 ROLLBACK으로 실행이 취소되지 않는다.
DELETE FROM usertbl WHERE userid = 'HONG';

SELECT * FROM usertbl;

ROLLBACK;

-- autocommit이 비활성화된 경우 ROLLBACK으로 실행이 취소된다.
DELETE FROM usertbl WHERE userid = 'sung123';

SELECT * FROM usertbl;

ROLLBACK;

-- autocommit이 비활성화된 경우에 변경 사항을 확정하려면 COMMIT을 실행해야 한다.
DELETE FROM usertbl WHERE userid = 'sung123';

SELECT * FROM usertbl;

COMMIT;
ROLLBACK;
