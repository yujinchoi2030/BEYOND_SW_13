-- 테이블 수정 실습
-- 1. 열의 추가, 수정, 삭제
-- 1. 열의 추가
-- usertbl 테이블에 HOMEPAGE 열을 추가
ALTER TABLE usertbl ADD HOMEPAGE VARCHAR(30);

-- usertbl 테이블에 GENDER 열을 추가 (단, 기본값은 남자로 지정)
ALTER TABLE usertbl ADD GENDER CHAR(2) DEFAULT '남자' NOT NULL;

-- usertbl 테이블에 AGE 열을 추가 (단, 기본값은 0, BIRTHYEAR 뒤에 생성)
ALTER TABLE usertbl ADD AGE TINYINT DEFAULT 0 AFTER BIRTHYEAR;

-- 2. 열의 수정
-- usertbl 테이블에서 name 열의 데이터 유형을 CHAR(15)로 변경
ALTER TABLE usertbl MODIFY NAME CHAR(15) NULL;

-- usertbl 테이블에서 name 열의 데이터 유형을 CHAR(1)로 변경(기존 데이터로 인해 변경 불가)
ALTER TABLE usertbl MODIFY NAME CHAR(1) NULL;

-- usertbl 테이블에서 name 열의 데이터 유형을 INT로 변경(기존 데이터로 인해 변경 불가)
ALTER TABLE usertbl MODIFY NAME INT NULL;

-- 값이 없으면 문자 타입을 정수 타입으로 변경 가능
ALTER TABLE usertbl MODIFY HOMEPAGE INT;

-- NAME 열의 이름을 UNAME 으로 변경
ALTER TABLE usertbl RENAME COLUMN NAME TO UNAME;

-- NAME 열의 이름을 UNAME 으로 변경 + MODIFY 
ALTER TABLE usertbl CHANGE COLUMN NAME UNAME VARCHAR(20) DEFAULT '없음' NOT NULL;

SELECT * FROM usertbl;




































SELECT * FROM usertbl;