-- SELECT 실습
-- 사용할 DB 선택
USE  test_db;

-- 테이블 구조 확인(컬럼 정보)
DESC USERTBL;

-- USERTBL 테이블의 모든 데이터 조회
SELECT * FROM usertbl;

-- BUYTBL 테이블의 모든 데이터 조회
SELECT * FROM test_db.buytbl;

-- employee 테이블의 모든 데이터 조회
SELECT * FROM employee;

-- 필요한 열의 데이터만 조회
SELECT USERID, NAME, ADDR FROM usertbl;

-- 별칭
SELECT USERID AS '아이디', NAME '이름', ADDR FROM usertbl;

-- DISTINCT 실습
SELECT DISTINCT ADDR FROM usertbl;
SELECT DISTINCT ADDR, MOBILE1 FROM usertbl;

-- LIMIT 실습 5명 조회
SELECT * FROM usertbl LIMIT 5;

-- 열의 산술 연산 실습
-- employee 테이블에서 직원명, 급여, 직원의 연봉(급여 * 12) 조회
SELECT EMP_NAME, SALARY, SALARY*12 FROM employee;

-- employee 테이블에서 직원명, 급여, 보너스가 포함된 연봉((급여 + (급여 * 보너스))* 12) 조회
SELECT EMP_NAME AS '직원명', SALARY AS '급여', SALARY*12 AS '연봉'
	, (SALARY + (SALARY * IFNULL(BONUS,0))) * 12 AS '보너스가 포함된 연봉' FROM employee;
	
-- WHERE
-- 비교 OR 관계 연산자 사용
-- usertbl 테이블에 아이디가 'KBS' 인 회원만 조회
SELECT USERID, NAME, HEIGHT FROM usertbl WHERE USERID = 'KBS';

-- usertbl 테이블에 키가 174 이상인 회원의 모든 데이터 조회
SELECT * FROM usertbl WHERE HEIGHT >= 174; 

-- usertbl 테이블에 이름이 김경호가 아닌 회원의 아이디, 이름 조회
SELECT USERID, NAME FROM usertbl WHERE NAME != '김경호';

-- usertbl 테이블에 휴대폰이 없는 회원의 모든 데이터 조회
SELECT * FROM usertbl WHERE MOBILE1 IS NULL;

-- usertbl 테이블에 휴대폰이 있는 회원의 모든 데이터 조회
SELECT * FROM usertbl WHERE MOBILE1 IS NOT NULL;

-- usertbl 테이블에 가입일이 2010년 10월 10일 이전인 회원의 데이터 조회
SELECT * FROM usertbl WHERE MDATE <= '2010-10-10';

-- employee 테이블에서 연봉이 5000만원 이상인 사원의 직원명, 급여, 직원의 연봉(급여 * 12) 조회
SELECT EMP_NAME, SALARY, SALARY * 12 FROM employee WHERE SALARY * 12 >=50000000;

-- usertbl 테이블에 키가 170 이상 182이 이하인 사원의 모든 데이터 조회
SELECT * FROM usertbl WHERE HEIGHT >= 170 AND HEIGHT <= 182 ORDER BY HEIGHT;

-- usertbl 테이블에 2008-01-01 에서 2010-12-31 인 회원의 모든 데이터 조회
SELECT * FROM usertbl WHERE MDATE >= '2008-01-01' AND MDATE <= '2010-12-31';

-- usertbl 테이블에 1970년도 이후의 출생자 이거나 키가 182 이상인 회원의 아이디와 이름  조회
SELECT USERID, NAME FROM usertbl WHERE BIRTHYEAR >=1970 OR HEIGHT >= 182;

-- employee 테이블에 부서 코드가 D5 이거나 급여가 500만원 이상인 직원들의 직원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY FROM employee WHERE DEPT_CODE = 'D5' OR SALARY >= 5000000;

-- usertbl 테이블에 키가 170 이상 182이 이하인 사원의 모든 데이터 조회
SELECT * FROM usertbl WHERE HEIGHT BETWEEN 170 AND 182 ORDER BY HEIGHT;
SELECT * FROM usertbl WHERE HEIGHT NOT BETWEEN 170 AND 182 ORDER BY HEIGHT;

-- usertbl 테이블에 2008-01-01 에서 2010-12-31 인 회원의 모든 데이터 조회
SELECT * FROM usertbl WHERE MDATE BETWEEN '2008-01-01' AND '2010-12-31';
SELECT * FROM usertbl WHERE MDATE NOT BETWEEN '2008-01-01' AND '2010-12-31';

-- IN 
-- 주소가 경남, 경북, 전남인 회원의 이름, 주소 조회
SELECT NAME, ADDR FROM usertbl WHERE ADDR IN ('경남','경북','전남');
SELECT NAME, ADDR FROM usertbl WHERE ADDR NOT IN ('경남','경북','전남');

-- LIKE
-- 성이 김씨인 회원의 모든 데이터 조회
SELECT * FROM usertbl WHERE NAME LIKE '김%';
SELECT * FROM usertbl WHERE NAME NOT LIKE '김%';

-- usertbl 테이블에 USERID 가 S 가 있는 모든 회원의 데이터 조회
SELECT * FROM usertbl WHERE USERID LIKE '%S%';


-- 실습 문제
-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 
-- 직원의 사번, 직원명, 부서 코드, 급여 조회 (BETWEEN AND)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM employee WHERE SALARY BETWEEN 3500000 AND 6000000;

-- EMPLOYEE 테이블에서 입사일이 '1990-01-01' ~ '2001-01-01'인 사원의 모든 컬럼 조회
SELECT * FROM employee WHERE HIRE_DATE BETWEEN '1990-01-01' AND '2001-01-01';

-- EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE FROM employee WHERE PHONE NOT LIKE '010%';

-- EMPLOYEE 테이블에서 이름 중에 '하'가 포함된 사원의 직원명, 주민번호, 부서 코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE FROM employee WHERE EMP_NAME LIKE '%하%';

-- employee 테이블에서 이메일 중 _ 앞 글자가 3자리인 주소를 가진 사원의 사번, 직원명, 이메일 조회 
SELECT EMP_ID, EMP_NAME, EMAIL FROM employee WHERE EMAIL LIKE '___\_%'; -- WHERE email LIKE '___$_%' ESCAPE '$';

-- ORDER BY 실습
-- usertbl 테이블에서 mDate으로 오름차순 / 내림차순 정렬
SELECT userid, NAME, mDate FROM usertbl ORDER BY mDate DESC; -- ORDER BY mDate; -- ORDER BY mDate ASC;

-- 가입일이 가장 늦은 회원 3명의 모든 데이터를 출력
SELECT * FROM usertbl ORDER BY mDate DESC LIMIT 3;

-- usertbl 테이블에서 addr으로 오름차순 정렬
-- 단, addr 일치할 경우 mDate를 가지고 내림차순 정렬
SELECT userid, NAME, addr, mDate FROM usertbl ORDER BY addr ASC, mDate DESC; -- ORDER BY addr, mDate DESC;

-- usertbl 테이블에서 아이디, 이름, 가입일 조회(별칭 포함)
-- 단, 이름으로 내림차순 정렬
SELECT userid AS '아이디', NAME AS '이름', mDate AS '가입일' FROM usertbl ORDER BY `이름` DESC; -- ORDER BY NAME DESC; -- ORDER BY 2 DESC; 

-- GROUP BY 실습
-- 중복 제거와 그룹으로 묶는 것은 다르다.
SELECT DISTINCT addr, COUNT(*) FROM usertbl ORDER BY addr;

SELECT addr, COUNT(*) FROM usertbl GROUP BY addr ORDER BY addr;

-- employee 테이블에서 전체 사원의 급여의 합계 조회
SELECT SUM(salary) FROM employee;

-- employee 테이블에서 부서별 급여의 합계 조회 (부서별 오름차순으로 정렬)
SELECT dept_code, SUM(salary) FROM employee GROUP BY dept_code ORDER BY dept_code;

-- buytbl 테이블에서 사용자 별로 구매한 개수의 합계 조회
SELECT userid, SUM(amount), SUM(price * amount)	FROM buytbl GROUP BY userid ORDER BY SUM(amount);

-- 전체 구매자가 구매한 물품 개수의 평균
SELECT AVG(amount) FROM buytbl;

-- 사용자별 평균 구매 개수
SELECT userid, AVG(amount) FROM buytbl GROUP BY userid;

-- usertbl 테이블에서 가장 작은 키와 큰 키 조회
SELECT MIN(height), MAX(height) FROM usertbl;

-- 가장 큰 키와 작은 키의 회원 이름과 키를 출력 (서브 쿼리 활용)
SELECT NAME, height FROM usertbl WHERE height = (SELECT MIN(height) FROM usertbl) OR height = (SELECT MAX(height) FROM usertbl);
   
-- 조회된 전체 행의 개수를 출력
SELECT COUNT(*) FROM usertbl;

-- 휴대폰이 있는 회원의 수
SELECT COUNT(*) FROM usertbl WHERE mobile1 IS NOT NULL;

-- mobile1 열에 값이 있는 행만 카운트한다.
-- 즉, mobile1 열에 NULL 값인 것은 제외하고 카운트한다.
SELECT COUNT(mobile1) FROM usertbl;

-- 참고
-- mobile1 열에 중복된 값은 한 번만 카운트한다.
SELECT COUNT(DISTINCT mobile1) FROM usertbl;

-- 실습 문제
-- employee 테이블에서 부서 코드가 D5인 사원들의 총 연봉의 합계를 조회
SELECT DEPT_CODE, SUM(SALARY * 12) AS '연봉의 합계' FROM employee WHERE DEPT_CODE = 'D5' GROUP BY DEPT_CODE;

-- employee 테이블의 전체 사원의 급여 평균 조회
SELECT ROUND(AVG(IFNULL(SALARY,0))) AS '급여 평균' FROM employee;

-- employee 테이블에서 퇴사한 직원의 수를 조회 (ENT_DATE가 NULL인 경우 개수를 세지않는다.)
SELECT COUNT(ENT_DATE) FROM employee WHERE ENT_DATE IS NOT NULL;

-- employee 테이블에서 직급별 급여의 합계를 조회 (직급별 내림차순 정렬)
SELECT JOB_CODE, SUM(SALARY) AS '급여의 합계' FROM employee GROUP BY JOB_CODE ORDER BY JOB_CODE DESC;

-- employee 테이블에서 부서별 사원의 수를 조회
SELECT IFNULL(DEPT_CODE, '부서 없음'), COUNT(*) FROM employee GROUP BY DEPT_CODE;

-- employee 테이블에서 부서별 사원의 수, 보너스를 받는 사원의 수, 급여의 합, 평균 급여, 최고 급여, 최저 급여를 조회 (부서별 내림차순)
SELECT ㅊ, COUNT(*), COUNT(BONUS), SUM(SALARY), FLOOR(AVG(SALARY)), MAX(SALARY), MIN(SALARY) FROM employee GROUP BY DEPT_CODE ORDER BY DEPT_CODE DESC;

-- employee 테이블에서 부서 코드와 직급 코드가 같은 사원의 사원의 수, 급여의 합을 조회
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY) FROM employee GROUP BY DEPT_CODE, JOB_CODE ORDER BY DEPT_CODE DESC;

-- having 실습
-- buytbl 테이블에서 총 구매액이 1000 이상인 회원의 아이디를 조회
SELECT USERID, SUM(PRICE * AMOUNT) FROM buytbl GROUP BY USERID HAVING SUM(PRICE * AMOUNT) >= 1000;

-- buytbl 테이블에서 사용자별 구매 평균 갯수가 3개 이상인 회원의 아이디, 평균 구매 갯수를 조회
SELECT USERID, AVG(AMOUNT) FROM buytbl GROUP BY USERID HAVING AVG(AMOUNT) >= 3;

/*
	<SELECT 문이 실행되는 순서>
		5: SELECT
		1: FROM
		2: WHERE
		3: GROUP BY
		4: HAVING
		6: ORDER BY
		7: LIMIT
*/

-- 실습 문제
-- employee 테이블에서 부서별로 급여가 300만원 이상인 직원의 평균 급여를 조회
SELECT AVG(SALARY) FROM employee WHERE SALARY >= 3000000;

-- employee 테이블에서 부서별 평균 급여가 300만원 이상인 부서의 부서 코드, 평균 급여를 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) FROM employee GROUP BY DEPT_CODE HAVING AVG(SALARY) >= 3000000 ;

-- employee 테이블에서 직급별 총 급여의 합이 10,000,000 이상인 직급만 조회
SELECT JOB_CODE FROM employee GROUP BY JOB_CODE HAVING SUM(SALARY) >= 10000000;

-- employee 테이블에서 부서별 보너스를 받는 사원이 없는 부서만 조회
SELECT DEPT_CODE FROM employee GROUP BY DEPT_CODE HAVING COUNT(BONUS) = 0;








