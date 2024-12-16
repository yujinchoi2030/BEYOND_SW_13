-- 형 변환 함수
-- 숫자 데이터를 문자 데이터로 형변환
SELECT 123456789;
SELECT CONVERT(123456789, CHAR);
SELECT CAST(123456789 AS CHAR);

-- usertbl 테이블에서 birthyear 열의 데이터를 문자 데이터로 형 변환
SELECT NAME, CONVERT(BIRTHYEAR, CHAR) FROM usertbl;

-- 실수 데이터를 정수 데이터로 형 변환
SELECT CONVERT(AVG(AMOUNT), INT) FROM buytbl;

-- 문자데이터를 숫자 데이터로 형 변환
SELECT CONVERT('10000000', INT);
SELECT CONVERT('10,000,000', INT);
SELECT REPLACE('10,000,000',',','');
SELECT CONVERT(REPLACE('10,000,000',',',''), INT);

-- 아래의 쿼리가 정상적으로 연산되도록 쿼리문을 작성하시오
SELECT '1,000,000' - '500,000';

SELECT CONVERT(REPLACE('1,000,000',',',''), INT) -  CONVERT(REPLACE('500,000',',',''), INT);
SELECT REPLACE('1,000,000',',','') -  REPLACE('500,000',',','');

-- usertble 테이블에서 mobile1 의 데이터를 숫자 데이터로 형 변환
SELECT NAME, MOBILE1, CONVERT(MOBILE1, INT) FROM usertbl;


-- 문자, 숫자  데이터를 날짜 데이터로 형 변환
SELECT CONVERT('2024-12-16', DATE);
SELECT CONVERT('2024/12/16', DATE);
SELECT CONVERT('2024%12%16', DATE);
SELECT CONVERT('12:16:17', TIME);
SELECT CONVERT('2024-12-16 12:16:17', DATETIME);

SELECT CONVERT(20241216, DATE);
SELECT CONVERT(123517, TIME);
SELECT CONVERT(20241216123517, DATETIME);

-- MARIA DB 에서 CONVERT, CAST 함수는 매우 유용하지만 모든 데이터 타입 변환이 가능한 것은 아니다.
CONVERT (2024, YEAR);
CONVERT (2024, TINYINT);
CONVERT (2024, SMAILLINT);

-- 묵시적 형 변환
SELECT 100 + 200; -- 정수로 변환되어 연산된다.
SELECT CONCAT('100', '200'); -- 문자와 문자를 연결한다.
SELECT CONCAT(100, 200); -- 정수가 문자로 변환되어 연결된다.
SELECT 1 > '2mega'; -- 정수 2로 변환되어서 비교(거짓 = 0)
SELECT 3 > '2mega'; -- 정수 2로 변환되어서 비교(참 = 1)
SELECT 0 = 'mega'; -- 문자는 0 으로 변환된다. (참 = 1)

SELECT IF(100 < 200 ,'참', '거짓');

-- 고객 별 전체 구매 개수의 합계 조회
-- 단, 구매 개수가 10개 이상이면 VIP, 10개 미만이면 '일반 고객'
SELECT USERID AS 'ID', SUM(AMOUNT)  AS '구매 갯수', IF(SUM(AMOUNT) < 10, '일반고객', 'VIP') AS 등급 
FROM buytbl GROUP BY USERID ORDER BY SUM(AMOUNT) DESC;

-- IFNULL 함수
SELECT IFNULL(NULL , '값이 없음'), IFNULL(100 , '값이 없음');
SELECT NVL(NULL , '값이 없음'), NVL(100 , '값이 없음');

-- buytbl 테이블에서 모든 데이터를 출력
-- 단 groupName 열의 값이 NULL 인 경우 '없음' 으로 표기
SELECT NUM, USERID, PRODNAME, IFNULL(GROUPNAME, '없음'), PRICE, AMOUNT FROM buytbl;

-- NVL2 함수
SELECT NVL2(NULL,100,200), NVL2(300,100,200);

-- employee 테이블에서 보너스로 0.1 로 동결하여 직원명, 보너스율, 보너스가 포함된 연봉 조회
SELECT EMP_NAME, NVL2(BONUS,0.1,0), (SALARY + (SALARY * NVL2(BONUS,0.1,0))) * 12 FROM employee;

-- CASE 구문
SELECT CASE 10 WHEN 1 THEN '일'
					WHEN 5 THEN '오'
					WHEN 10 THEN '십'
					ELSE '모름'
		END AS '결과';
		
SELECT CASE WHEN 10 > 20  THEN '10 > 20'
				WHEN 10 <= 20 THEN '10 <= 20'
				ELSE '모름'
		END AS '결과';
		
-- employee 테이블에서 직원명, 급여, 급여 등급 (1~4등급)
-- 1등급 : 500만원 초과, 2등급: 500만원 이하~350초과, 3등급:350 이하 ~ 200만원 초과, 4등급 : 이외
SELECT EMP_NAME
		,SALARY
		,CASE WHEN SALARY > 5000000 THEN '1등급'
				WHEN SALARY > 3500000 THEN '2등급'
				WHEN SALARY > 2000000 THEN '3등급'
				ELSE '4등급' 
		 END AS GRADE
		 FROM employee ORDER BY SALARY DESC;
		 
-- 문자열 함수
-- ASCII, CHAR 함수
SELECT ASCII('A'), CHAR(97), ASCII('김');

-- BIT_LENGTH, CHAR_LENGTH, LENGTH 함수
SELECT BIT_LENGTH('ABC'), CHAR_LENGTH('ABC'), LENGTH('ABC');
SELECT BIT_LENGTH('가나다'), CHAR_LENGTH('가나다'), LENGTH('가나다');

-- CONCAT, CONCAT_WS 함수
SELECT CONCAT(2024,12,16), CONCAT_WS('/',2024,12,16);

-- usertbl 테이블에서 아이디, 이름, 전화번호 조회
SELECT USERID, NAME, MOBILE1, MOBILE2
		,CONCAT(MOBILE1,MOBILE2) AS PHONE_CONCAT
		,CONCAT_WS('-',MOBILE1,MOBILE2) AS PHONE_CONCAT_WS FROM usertbl;

-- usertbl 테이블에서 급여 조회
SELECT CONCAT(EMP_NAME, '님의 급여는 ', SALARY, ' 입니다.') FROM employee;

-- ELT, FIELD, FIND_IN_SET, INSTR, LOCATE 함수
SELECT ELT(3, '하나', '둘', '셋') AS ELT;
SELECT FIELD('둘', '하나', '둘', '셋') AS FIELD;
SELECT FIND_IN_SET('하나', '하나, 둘, 셋') AS FIND_IN_SET;
SELECT INSTR('하나 둘 셋', '둘') AS INSTR;
SELECT LOCATE('하나', '하나 둘 셋') AS LOCATE;

-- employee 테이블에서 이메일의 @ 위치값 출력
SELECT EMAIL, INSTR(EMAIL, '@') AS INSTR FROM employee;





 


