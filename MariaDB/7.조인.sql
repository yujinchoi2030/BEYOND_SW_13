-- INNER JOIN 실습
-- 각 사원들의 사번, 직원명, 부서 코드, 부서명 조회
SELECT emp_id, 
		 emp_name, 
		 dept_id, 
		 dept_title
FROM employee
INNER JOIN department ON dept_code = dept_id;

-- 각 사원들의 사번, 직원명, 직급 코드, 직급명 조회
-- 연결할 테이블의 열 이름이 같은 경우
-- 방법 1) 테이블명을 이용하는 방법
SELECT employee.emp_id,
		 employee.emp_name,
		 employee.job_code,
		 job.job_name
FROM employee
INNER JOIN job ON employee.job_code = job.job_code;

-- 방법 2) 테이블 별칭을 이용하는 방법
SELECT e.emp_id,
		 e.emp_name,
		 j.*
FROM employee e
INNER JOIN job j ON e.job_code = j.job_code;

-- 방법 3) NATURAL JOIN을 이용하는 방법(참고)
SELECT emp_id,
		 emp_name,
		 job_code,
		 job_name
FROM employee
NATURAL JOIN job;

-- 실습 문제
-- usertbl 테이블과 buytbl 테이블을 조인하여
-- JYP라는 아이디를 가진 회원의 이름, 주소, 연락처, 주문 상품 이름을 조회
SELECT u.name,
       u.addr,
       CONCAT_WS('-',u.mobile1, u.mobile2) AS '연락처',
       b.prodName
FROM usertbl u
INNER JOIN buytbl b ON u.userID = b.userID
WHERE u.userID = 'JYP';

-- employee 테이블과 department 테이블을 조인하여 보너스를 받는 사원들의 사번, 직원명, 보너스, 부서명을 조회
SELECT e.emp_id AS '사번',
       e.emp_name AS '직원명',
       e.bonus AS '보너스',
       d.dept_title AS '부서명'
FROM employee e
INNER JOIN department d ON e.dept_code = d.dept_id
WHERE e.bonus IS NOT NULL;

-- employee 테이블과 department 테이블을 조인하여 인사관리부가 아닌 사원들의 직원명, 부서명, 급여를 조회
SELECT e.emp_name, 
		 d.dept_title, 
		 e.salary 
FROM employee e 
INNER JOIN department d 
ON e.dept_code = d.dept_id 
WHERE d.dept_title != '인사관리부';

-- employee 테이블과 department 테이블, job 테이블을 조인하여 사번, 직원명, 부서명, 직급명 조회
SELECT e.emp_id, 
		 e.emp_name, 
		 d.dept_title, 
		 j.job_name
FROM employee e
INNER JOIN department d ON e.dept_code = d.dept_id
INNER JOIN job j ON e.job_code = j.job_code;

-- OUTER JOIN 실습
-- 1) LEFT OUTER JOIN
-- 부서 코드가 없던 사원들의 정보가 출력된다.
SELECT e.emp_name,
		 d.dept_id,
		 d.dept_title,
		 e.salary
FROM employee e 
LEFT /* OUTER */ JOIN department d ON e.dept_code = d.dept_id
ORDER BY e.dept_code;

-- 2) RIGHT OUTER JOIN
-- 부서에 속해있는 사원이 없어도 부서에 대한 정보가 출력된다.
SELECT e.emp_name,
		 d.dept_id,
		 d.dept_title,
		 e.salary
FROM employee e 
RIGHT /* OUTER */ JOIN department d ON e.dept_code = d.dept_id
ORDER BY e.dept_code;

-- CROSS JOIN 실습
SELECT emp_name,
		 dept_title
FROM employee
CROSS JOIN department;

-- SELF JOIN 실습
-- employee 테이블을 SELF JOIN하여 사번, 직원명, 부서 코드, 사수 사번, 사수명 조회
SELECT e.emp_id AS '사번',
		 e.emp_name AS '직원명',
		 e.dept_code AS '부서 코드',
		 -- e.manager_id,
		 m.emp_id AS '사수 사번',
		 m.emp_name AS '사수명'
FROM employee e 
LEFT OUTER JOIN employee m ON e.manager_id = m.emp_id;

-- NON EQUAL JOIN 실습
-- 조인 조건에 등호(=)를 사용하지 않는 조인문을 비등가 조인이라고 한다.
-- employee 테이블과 sal_grade 테이블을 비등가 조인하여 직원명, 급여, 급여 등급 조회
SELECT e.emp_name,
		 e.salary,
		 s.sal_level
FROM employee e
-- INNER JOIN sal_grade s ON e.salary >= s.min_sal AND e.salary <= s.max_sal;
-- INNER JOIN sal_grade s ON e.salary BETWEEN s.min_sal AND s.max_sal;
LEFT OUTER JOIN sal_grade s ON e.salary BETWEEN s.min_sal AND s.max_sal;

-- 실습 문제
-- 이름에 '형'자가 들어있는 직원들의 사번, 직원명, 직급명을 조회

-- 70년대생 이면서 여자이고, 성이 전 씨인 직원들의 직원명, 주민번호, 부서명, 직급명을 조회하세요.

-- 각 부서별 평균 급여를 조회하여 부서명, 평균 급여를 조회
-- 단, 부서 배치가 안된 사원들의 평균도 같이 나오게끔 조회해 주세요.

-- 각 부서별 총 급여의 합이 1000만원 이상인 부서명, 급여의 합을 조회

-- 해외영업팀에 근무하는 직원들의 직원명, 직급명, 부서 코드, 부서명을 조회

-- 테이블을 다중 JOIN 하여 사번, 직원명, 부서명, 지역명, 국가명 조회

-- 테이블을 다중 JOIN 하여 사번, 직원명, 부서명, 지역명, 국가명, 급여 등급 조회

-- 부서가 있는 직원들의 직원명, 직급명, 부서명, 지역명을 조회하시오.

-- 한국과 일본에서 근무하는 직원들의 직원명, 부서명, 지역명, 근무 국가를 조회하세요.

-- UNION / UNION ALL 연산자 실습
-- employee 테이블에서 부서 코드가 D5인 사원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT emp_id, 
		 emp_name, 
		 dept_code, 
		 salary
FROM employee
WHERE dept_code = 'D5';

-- employee 테이블에서 급여가 300만원 초과인 사원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT emp_id, 
		 emp_name, 
		 dept_code, 
		 salary
FROM employee
WHERE salary > 3000000;

-- 1) UNION 연산자
SELECT emp_id, 
		 emp_name, 
		 dept_code, 
		 salary
FROM employee
WHERE dept_code = 'D5'

UNION

SELECT emp_id, 
		 emp_name, 
		 dept_code,
		 salary
FROM employee
WHERE salary > 3000000;

-- 위 쿼리문 대신에 WHERE 절에 OR 연산자를 사용해서 처리가 가능하다.
SELECT emp_id, 
		 emp_name, 
		 dept_code,
		 salary
FROM employee
WHERE dept_code = 'D5' OR salary > 3000000;

-- 2) UNION ALL 연산자
SELECT emp_id, 
		 emp_name, 
		 dept_code, 
		 salary
FROM employee
WHERE dept_code = 'D5'

UNION ALL

SELECT emp_id, 
		 emp_name, 
		 dept_code,
		 salary
FROM employee
WHERE salary > 3000000;
