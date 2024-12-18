-- 서브 쿼리 실습
-- 하나의 SQL 문 안에 포함된 또 다른 SQL 문을 서브 쿼리라 한다.

-- 서브 쿼리 예시
-- 1. 노옹철 사원과 같은 부서원들을 조회
SELECT EMP_NAME, DEPT_CODE
FROM 
	employee
WHERE
	EMP_NAME = '노옹철';
	
-- 2. 부서 코드가 노옹철 사원의 부서코드와 동일한 사원들을 조회
SELECT EMP_NAME, DEPT_CODE
FROM 
	employee
WHERE
	DEPT_CODE = 'D9';
	
-- 3. 위 2단계를 서브쿼리를 사용하여 하나의 쿼리문으로 작성
SELECT EMP_NAME, DEPT_CODE
FROM 
	employee
WHERE
	DEPT_CODE = (	SELECT DEPT_CODE
						FROM 
							employee
						WHERE
							EMP_NAME = '노옹철');

-- 서브 쿼리 구분
-- 서브 쿼리는 서브 쿼리를 수행한 결과값의 행과 열의 개수에 따라서 분류할 수 있다.

-- 1) 단일행 서브 쿼리
-- 서브 쿼리의 조회 결과 값의 갯수가 1개 일 때
-- 전 직원의 평균 급여보다 더 많은 급여를 받고 있는 직원들의 사번, 직원명, 직급 코드, 급여를 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM
	employee
WHERE
	SALARY >= (	SELECT AVG(SALARY) 
					FROM
						employee);
-- 노옹철 사원의 급여보다 더 많이 받는 사원의 사번, 직원명, 부서명, 급여 조회
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.SALARY
FROM
	employee AS E
INNER JOIN
	department AS D
ON
	E.DEPT_CODE = D.DEPT_ID
WHERE 
	SALARY > (	SELECT SALARY
					FROM
						employee
					WHERE
						EMP_NAME = '노옹철');
						
-- 2) 다중행 서브 쿼리
--	서브 쿼리의 조회 결과 값의 갯수가 여러행 일 때

-- 각 부서별 최고 급여를 받는 직원의 이름, 직급 코드, 부서 코드, 급여 조회
-- 부서별 최고 급여 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM
	employee
WHERE SALARY IN (
						SELECT MAX(SALARY)
						FROM
							employee
						GROUP BY
							DEPT_CODE)
ORDER BY DEPT_CODE;

-- 직원들의 사번, 직원명, 부서 코드, 구분(사원/사수) 조회
-- 사수에 해당하는 사번을 조회
SELECT EMP_ID AS '사번'
		,EMP_NAME AS '직원명'
		,DEPT_CODE AS '부서 코드'
		,CASE WHEN EMP_ID IN (SELECT DISTINCT MANAGER_ID
									 FROM
										employee
									 WHERE
										MANAGER_ID IS NOT NULL) THEN '사수'
				ELSE '사원'
		 END AS '구분'
FROM
	employee;
	
-- 대리 직급 임에도 과장 직급 들의 최소 급여보다 많이 받는 직원의 사번,이름,직급코드,급여 조회
SELECT E.EMP_ID, E.EMP_NAME,J.JOB_CODE,E.SALARY
FROM
	employee AS E
INNER JOIN
	job AS J
ON
	E.JOB_CODE = J.JOB_CODE
WHERE
	JOB_NAME = '대리'
AND SALARY >= (SELECT MIN(E.SALARY)
					FROM
						employee AS E
					INNER JOIN
						job AS J
					ON
						E.JOB_CODE = J.JOB_CODE
					WHERE
						JOB_NAME = '과장');
						
-- ANY 는 서브 쿼리의 결과 중 하나라도 조건을 만족하면 참이 된다.
SELECT E.EMP_ID, E.EMP_NAME,J.JOB_CODE,E.SALARY
FROM
	employee AS E
INNER JOIN
	job AS J
ON
	E.JOB_CODE = J.JOB_CODE
WHERE
	JOB_NAME = '대리'
AND SALARY > ANY (SELECT E.SALARY
						FROM
							employee AS E
						INNER JOIN
							job AS J
						ON
							E.JOB_CODE = J.JOB_CODE
						WHERE
							JOB_NAME = '과장');
							
-- 과장 직급임에도 차장 직금의 최대 급여보다 더 많이 받는 직원들의 사번, 이름, 직급 코드, 급여 조회
SELECT E.EMP_ID, E.EMP_NAME,J.JOB_CODE,E.SALARY
FROM
	employee AS E
INNER JOIN
	job AS J
ON
	E.JOB_CODE = J.JOB_CODE
WHERE
	JOB_NAME = '과장'
AND SALARY > ALL (SELECT E.SALARY
						FROM
							employee AS E
						INNER JOIN
							job AS J
						ON
							E.JOB_CODE = J.JOB_CODE
						WHERE
							JOB_NAME = '차장');
							
-- 3) 다중열 서브 쿼리
-- 서브 쿼리의 조회 결과 값은 한 행이지만 열의 수가 여러개 일 때

-- 하이유 사원과 같은 부서 코드, 같으 직급 코드에 해당하는 사원들을 조회
-- 하이유 사원의 부서 코드와 직급 코드를 조회
SELECT EMP_NAME, JOB_CODE
FROM
	employee
WHERE
	EMP_NAME = '하이유';
	
-- 부서 코드가 D5 이면서 직급 코드가 J5 인 사원들을 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM
	employee
WHERE
	(DEPT_CODE,JOB_CODE) IN (('D5','J5'));
	-- (DEPT_CODE,JOB_CODE) = ('D5','J5');
	-- DEPT_CODE = 'D5' AND JOB_CODE = 'J5';
	
-- 다중열 서브 쿼리를 사용해서 작성하는 방법
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM
	employee
WHERE
	(DEPT_CODE,JOB_CODE) IN (SELECT EMP_NAME, JOB_CODE
										FROM
											employee
										WHERE
											EMP_NAME = '하이유');
											
-- 박나라 사원과 직급 코드가 일치하면서 같은 사수를 가지고 있는
-- 사원들의 사번, 직원명, 직급 코드, 사수 사번 조회

-- 박나라 사원의 직급 코드와 사수의 사번을 조회
SELECT JOB_CODE, MANAGER_ID
FROM
	employee
WHERE EMP_NAME = '박나라';
-- 다중열 서브쿼리를 사용해서 작성
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM
	employee
WHERE
	(JOB_CODE,MANAGER_ID) IN ( SELECT JOB_CODE, MANAGER_ID
										FROM
											employee
										WHERE EMP_NAME = '박나라');
	
-- 4) 다중행 다중열 서브 쿼리
--	서브 쿼리의 조회 결과값이 여러 행, 여러 열 일 때

-- 각 부서별 최고 급여를 받는 직원의 사번, 직원명, 부서 코드, 급여 조회
SELECT dept_code, MAX(salary)
FROM
	employee
GROUP BY dept_code;

-- 각 부서별 최고 급여를 받는 직원들을 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM
	employee
WHERE
--	DEPT_CODE = 'D1' AND SALARY = 3660000
-- OR DEPT_CODE = 'D2' AND SALARY = 2490000;
	(DEPT_CODE, SALARY) IN (('D1', 3660000),('D2', 2490000));

-- 다중행 다중열 서브 쿼리를 사용해서 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM
	employee
WHERE
	(DEPT_CODE, SALARY) IN (SELECT dept_code, MAX(salary)
									FROM
										employee
									GROUP BY dept_code)
ORDER BY DEPT_CODE;

-- 각 직급별로 최소 급여를 받는 사원들의 사번, 직원명, 직급코드, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM
	employee
WHERE
	(JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
									FROM
										employee
									GROUP BY JOB_CODE)
ORDER BY JOB_CODE;

--인라인 뷰
-- FROM 절에 서브 쿼리를 작성하고 서브 쿼리를 수행한 결과를 테이블 대신에 사용한다.
SELECT A.*
FROM (SELECT EMP_ID
				,EMP_NAME
				,JOB_CODE
				,SALARY
		FROM
			employee) AS A;

-- employee 테이블에서 급여로 순위를 매겨서 출력
SELECT A.NUM
		,A.EMP_NAME
		,A.SALARY
FROM (
		SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 'NUM'
				,EMP_NAME
				,SALARY
		FROM
			employee
		) AS A
WHERE A.NUM BETWEEN 6 AND 10;



















