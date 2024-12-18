-- 순위 관련 함수
-- usertbl 테이블에서 키가 큰 순으로 순위를 매겨서 순위, 이름, 주소, 키를 조회
-- ORDER BY height DESC 키로 내림차순 정렬한 후에
-- ROW_NUMBER()로 순번을 매긴다.
SELECT ROW_NUMBER() OVER(ORDER BY height DESC) AS 'num',
		 NAME,
		 addr,
		 height
FROM usertbl;

-- 지역별로 순위를 매겨서 주소, 순위, 이름, 키를 조회
SELECT addr,
		 ROW_NUMBER() OVER(PARTITION BY addr ORDER BY height DESC) AS 'num',
		 NAME,
		 height
FROM usertbl;

-- 키가 큰 순으로 순위를 매겨서 순위, 이름, 키를 조회
-- 단, 동일한 순위 이후의 등수를 동일한 인원수만큼 건너뛰고 증가
SELECT RANK() OVER(ORDER BY height DESC) AS 'rank',
		 NAME,
		 height
FROM usertbl;

-- 키가 큰 순으로 순위를 매겨서 순위, 이름, 키를 조회
-- 단, 동일한 순위 이후 등수를 1증가
SELECT DENSE_RANK() OVER(ORDER BY height DESC) AS 'rank',
		 NAME,
		 height
FROM usertbl;

-- 전체 인원을 키 순서로 세운 후에 4개의 그룹으로 분할
SELECT NTILE(4) OVER(ORDER BY height DESC) AS 'num',
		 NAME,
		 height
FROM usertbl;

-- employee 테이블에서 급여가 높은 상위 10명의 순위, 직원명, 급여 조회
SELECT RANK() OVER(ORDER BY salary DESC) AS 'rank',
		 emp_name,
		 salary
FROM employee
LIMIT 10;

-- 분석 윈도우 함수
-- usertbl 테이블에서 키 순서대로 정렬 후 다음 사람과 키 차이를 조회
SELECT NAME,
		 addr,
		 height,
		 -- 현재 행의 height 열을 다음 1번째 행의 height와 비교한다.
		 height - (LEAD(height, 1) OVER(ORDER BY height DESC))
FROM usertbl;

-- usertbl 테이블에서 키 순서대로 정렬 후 이전 사람과 키 차이를 조회
SELECT NAME
		 addr,
		 height,
		 -- 현재 행의 height 열을 이전 1번째 행의 height와 비교한다.
		 height - LAG(height, 1) OVER(ORDER BY height DESC)
FROM usertbl;

-- usertbl 지역별로 가장 키가 큰 사람과 키 차이를 조회
SELECT addr,
		 NAME,
	  	 height,
	  	 height - FIRST_VALUE(height) OVER(PARTITION BY addr ORDER BY height DESC)
FROM usertbl;
