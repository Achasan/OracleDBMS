/*
    숫자 관련 함수
    1. ABS() : 절댓값을 구하는 함수
    
    2. SIGN() : 양수, 음수, 0을 반환해주는 함수
    
    3. ROUND(실수, 자릿수) : 반올림 해 주는 함수
                            자릿수의 경우에는 음수는 정수자리, 실수는 소수점 자리 기준이다.
                            
    4. TRUNC(숫자, 자릿수) : 소수점 이하 자리를 잘라내는 함수
    
    5. CEIL() : 올림을 해 주는 함수
    
    6. FLOOR() : 내림을 해 주는 함수
    
    7. POWER() : 제곱을 구해주는 함수
    
    8. MOD() : 나머지를 구해주는 함수
*/

SELECT ROUND(123.567, -2) FROM DUAL;
SELECT MOD(123, 2) FROM DUAL;

/*
    VIEW : 물리적인 테이블에 근거한 논리적인 가상의 테이블을 말함
    VIEW는 실질적으로 데이터를 저장하고 있지 않고, 
    VIEW를 만들면 데이터 베이스에 질의 시 실제 테이블에 접근하여 데이터를 불러오게 된다.
    VIEW는 필요한 내용들만 추출해서 사용하는 테이블이다.
    VIEW는 주로 데이터를 조회할 때 가장 많이 사용되고, 테이블처럼 사용이 가능하다.
    VIEW는 테이블에 저장하기 위한 물리적인 공간이 필요가 없다.
    테이블과 마찬가지로 INSERT, UPDATE, DELETE, SELECT 명령이 가능하다.
    
    VIEW를 사용하는 이유
    1. 보안관리를 위해 사용한다 : 보안 등급에 맞추어 컬럼의 범위를 정해서 조회가 가능하도록 할 수 있다.
    2. 사용자의 편의성을 제공한다.
    
    CREATE VIEW 뷰이름 AS 쿼리문;
*/

-- 인사부 view : 컬럼에 SAL, COMM컬럼을 제외하고 볼 수 있게
CREATE VIEW EMP_HR AS SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO FROM EMP;

-- 영업부 view : 컬럼에 급여 제외
CREATE VIEW EMP_SALES AS SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, COMM, DEPTNO FROM EMP;

-- 회계부 view : 모든 컬럼 표시
CREATE VIEW EMP_ACCOUNT AS SELECT * FROM EMP;

-- EMP 테이블을 복사해서 EMP_VIEW 생성
CREATE VIEW EMP_VIEW AS SELECT * FROM EMP;

-- EMP_VIEW에 데이터를 추가
INSERT INTO EMP_VIEW VALUES(9000, 'ANGEL', 'SALESMAN', 7698, SYSDATE, 1500, 200, 30);

-- EMP_VIEW 테이블에 데이터를 추가했지만 EMP 테이블에 데이터가 생성된 것을 볼 수 있음
-- UPDATE, DELETE도 마찬가지이다. 따라서 VIEW는 조회의 목적으로 사용하는 것이 좋다.
SELECT * FROM EMP;

-- 읽기 전용 VIEW를 만들면 실제 테이블에 INSERT, UPDATE, DELETE가 되지 않는다. 조회만 가능
-- 읽기 전용 VIEW를 만드는 방법 : VIEW 생성 시 맨 마지막에 WITH READ ONLY 문구를 추가
CREATE VIEW EMP_VIEW1 AS SELECT * FROM EMP WITH READ ONLY;

INSERT INTO EMP_VIEW1 VALUES(9006, 'ANG6', 'SALESMAN', 7698, SYSDATE, 1500, 200, 30); -- 에러 발생

-- CREATE OR REPLACE VIEW : 같은 이름의 VIEW가 있는 경우에는 다시 삭제하고 다시 VIEW를 만들라는 의미
--                          수정되는게 아니고 VIEW가 삭제되고 다시 생성되는 것이 특징
CREATE OR REPLACE VIEW EMP_ACCOUNT AS SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO
FROM EMP;


-- 사용자의 편의성을 제공하는 이유
CREATE OR REPLACE VIEW EMP_SAL(EMPNO, ENAME, ANNUL_SAL)
AS
SELECT EMPNO, ENAME, TO_CHAR((SAL+NVL(COMM, 0))*12, '999,999') FROM EMP WITH READ ONLY;

SELECT * FROM EMP_SAL;

-- VIEW를 만들 때 컬럼이름만 만들고 싶은 경우, 실제 데이터는 없는 경우
-- 조건을 줄 때 말이 안되는 조건을 작성하면 된다.
CREATE OR REPLACE VIEW EMP_VIEW2 AS SELECT * FROM EMP WHERE DEPTNO = 3;

SELECT * FROM EMP_VIEW2; -- 컬럼만 만들어지고 데이터는 없음, 부서번호 3은 없는 번호이기 때문

-- 1. EMP 테이블을 이용하여 EMP_DEPT20이라는 VIEW를 만들어보자, 단 , 부서번호가 20번 부서에 속한 사원들의 사번, 이름, 담당업무, 관리자, 부서번호만 만들어진 VIEW를 출력
CREATE OR REPLACE VIEW EMP_DEPT20 AS SELECT EMPNO, ENAME, JOB, MGR, DEPTNO FROM EMP WHERE DEPTNO = 20 WITH READ ONLY;
SELECT * FROM EMP_DEPT20 ORDER BY EMPNO;

-- 2. 담당업무가 'SALESMAN'인 사원의 사번, 이름, 담당업무, 입사일, 부서번호를 컬럼으로하는 VIEW를 만들되, EMP_SALE이라는 VIEW를 만들어 화면에 출력
CREATE OR REPLACE VIEW EMP_SALE AS SELECT EMPNO, ENAME, JOB, HIREDATE, DEPTNO FROM EMP WHERE JOB = 'SALESMAN' WITH READ ONLY;
SELECT * FROM EMP_SALE ORDER BY EMPNO;

/*
    제약 조건
    NOT NULL : NULL 값이 입력되지 못하게 하는 제약조건, 특정 열에 데이터의 중복 여부와는 관계 없이
                NULL값을 허용하지 않는 제약 조건을 말한다.
                
    UNIQUE : 열에 저장할 데이터의 중복을 허용하지 않고자 할 때 사용하는 조건 NULL값은 허용된다.
    
    PRIMARY KEY : NOT NULL + UNIQUE 제약조건
                  테이블에 하나만 존재해야하는 제약 조건
                  보통은 주민번호나 EMP 테이블의 EMPNO(사원번호) 등이 PRIMARY KEY의 조건이 된다.
                  
    FOREIGN KEY : 다른 테이블의 필드(컬럼)를 참조해서 무결성을 검사하는 조건이다.
                  참조키 : 부모 테이블의 컬럼을 이야기함
                  외래키 : 자식 테이블의 컬럼을 이야기함
                  자식 테이블의 컬럼의 값(데이터값)이 부모테이블에 없는 경우에는 무결성의 규칙이 깨져버린다.
                  외래키가 존재하기 위해서는 우선적으로 부모테이블이 먼저 만들어져야 한다.
                  
    CHECK : 열에 저장할 수 있는 값의 범위 또는 패턴을 정의할 때 사용한다.
            주어진 값만 허용하는 조건이다.
*/

CREATE TABLE NULL_TEST(
    COL1 VARCHAR2(10) NOT NULL,
    COL2 VARCHAR2(10) NOT NULL,
    COL3 VARCHAR2(10)
);

INSERT INTO NULL_TEST VALUES('AA', 'AAL', 'AA2');
INSERT INTO NULL_TEST(COL1, COL2) VALUES('BB', 'BB1');
INSERT INTO NULL_TEST(COL1, COL2) VALUES('CC', ''); -- NOT NULL 제약조건 때문에 에러 발생

CREATE TABLE UNIQUE_TEST(
    COL1 VARCHAR2(10) UNIQUE,
    COL2 VARCHAR2(10) UNIQUE,
    COL3 VARCHAR2(10) NOT NULL,
    COLR VARCHAR2(10) NOT NULL
);

INSERT INTO UNIQUE_TEST VALUES('AA', 'BB', 'CC', 'DD');
INSERT INTO UNIQUE_TEST VALUES('AA1', 'BB1', 'CC1', 'DD1');

UPDATE UNIQUE_TEST SET COL2 = 'BB' WHERE COL = 'AA1'; 
-- UNIQUE 제약 조건 때문에 에러발생, 이미 'BB' 데이터가 UNIQUE 제약조건 데이터에 존재하기 때문에 불가능하다.



-- 외래키 예제
CREATE TABLE FOREIGN_TEST(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(20) NOT NULL,
    JOB VARCHAR2(20) NOT NULL,
    DEPTNO NUMBER(2) REFERENCES DEPT (DEPTNO)
);

INSERT INTO FOREIGN_TEST VALUES(7908, '홍길동' , 'SALESMAN', 10); -- 부서번호 10번의 정보를 저장

INSERT INTO FOREIGN_TEST VALUES(7909, '유관순', '회계부', 20); -- 부서번호 20번의 정보를 저장

-- CHECK 제약조건 예제
CREATE TABLE CHECK_TEST2(
    GENDER VARCHAR2(10) CHECK(GENDER IN ('남자', '여자'))
);

INSERT INTO CHECK_TEST VALUES('남자');
INSERT INTO CHECK_TEST VALUES('여자');
INSERT INTO CHECK_TEST VALUES('여성'); -- CHECK 제약조건에 남자, 여자만 들어갈 수 있도록 설정하였음

/* 
    시퀀스 (SEQUENCE)
    연속적인 번호를 만들어주는 기능
    
    CREATE SEQUENCE 시퀀스이름
    START WITH N (N : 시작번호를 설정, DEFAULT 1)
    INCREMENT BY N (N : 증가번호를 설정, DEFAULT 1)
    MAXVALUE N (N : 시퀀스의 최대 번호를 설정)
    MINVALUE N (N : 시퀀스의 최소 번호를 설정)
    CACHE / NOCACHE (시퀀스의 값을 빠르게 설정하기 위해 캐시메모리의 사용여부를 설정)
    
    1. CACHE : 시퀀스를 빨리 제공하기 위해서 미리 캐시메모리에 시퀀스를 넣어두고 준비하고 있다가
                시퀀스 작업이 필요할 때 사용한다. DAFAULT로는 20으로 설정되어있음.
                시스템이 비정상적으로 종료되거나 전원이 차단되면 캐시메모리에 남아있던 남은 시퀀스 번호는 
                사라지게 되어 문제가 발생할 수 있다.
    2. NOCACHE : CACHE 기능을 사용하지 않겠다는 의미이다.(권장)
*/

-- 시퀀스의 다음 시퀀스번호를 알고 싶은 경우
SELECT MEMO_SEQ.NEXTVAL FROM DUAL;




/* 
    서브쿼리(중요)
    쿼리문 안에 또 다른 쿼리문이 존재하는 쿼리문을 말한다.
    서브쿼리는 메인쿼리가 서브쿼리를 포함하는 종속적인 관계이다.
    여러 번 쿼리를 실행해서 얻을 수 있는 결과를 하나의 중첩된 쿼리문장으로 결과를 얻을 수 있게 해 준다.
    
    주의사항 : 
    서브쿼리는 괄호로 묶어서 사용해야한다.
    서브쿼리 안에서는 ORDER BY 절은 사용할 수 없다.
    연산자의 오른쪽에 있어야 한다.
    
    사용방법 : 
    안쪽에 있는 쿼리문을 실행한 후 그 결과값을 가지고 바깥쪽 쿼리문을 실행한다.
*/

SELECT * FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'SCOTT');
-- WHERE 조건문에 이름이 SCOTT인 사람의 SALARY보다 높은 데이터를 출력하기 위해 SELECT 문 안에 SELECT문을 사용하는 서브쿼리를 사용하였다.

-- 1. EMP 테이블에서 평균 급여보다 더 적게 받는 사원의 사번, 이름, 담당업무, 급여, 부서번호를 화면에 출력
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP WHERE SAL < (SELECT AVG(NVL(SAL, 0)) FROM EMP);

-- 2. EMP 테이블에서 사번이 7521인 사원과 담당업무가 같고, 급여가 7934인 사원보다 더 많이 받는 사원의 사번, 이름, 담당업무, 급여를 화면에 출력
SELECT EMPNO, ENAME, JOB, SAL 
FROM EMP 
WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO = 7521) AND SAL > (SELECT SAL FROM EMP WHERE EMPNO = 7934);

-- 3. EMP 테이블에서 담당업무가 'MANAGER'인 사원의 최소급여보다 적으면서, 담당업무가 'CLERK'는 아닌 사원의 사번, 이름, 담당업무, 급여를 화면에 출력
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SAL < (SELECT MIN(SAL) FROM EMP WHERE JOB = 'MANAGER') AND NOT JOB = 'CLERK';

-- 4. 부서위치가 'DALLALS'인 사원의 사번, 이름, 부서번호, 담당업무를 화면에 출력
SELECT E.EMPNO, E.ENAME, E.DEPTNO, E.JOB FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO WHERE D.LOC = 'DALLAS';
SELECT EMPNO, ENAME, DEPTNO, JOB FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');

-- 5. MEMBER10테이블에 있는 고객의 정보 중 마일리지가 가장 높은 회원의 모든 정보를 화면에 출력
SELECT * FROM MEMBER10 WHERE MILEAGE = (SELECT MAX(MILEAGE) FROM MEMBER10);

-- 6. EMP 테이블에서 'SMITH'인 사원보다 더 많은 급여를 받는 사원의 이름과, 급여를 화면에 출력
SELECT ENAME, SAL FROM EMP WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'SMITH');

-- 7. EMP 테이블에서 10번 부서 급여의 평균 급여보다 더 적은 급여를 받는 사원들의 이름, 급여, 부서번호를 화면에 출력
SELECT ENAME, SAL, DEPTNO FROM EMP WHERE SAL < (SELECT AVG(NVL(SAL, 0)) FROM EMP WHERE DEPTNO = 10);

-- 8. EMP 테이블에서 'BLAKE'와 같은 부서에 있는 사원들의 이름과 입사일자, 부서번호를 화면에 보여주되, 'BLAKE'는 제외하고 화면에 출력
SELECT ENAME, HIREDATE, DEPTNO FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'BLAKE') AND NOT ENAME = 'BLAKE';

-- 9. EMP 테이블에서 평균급여보다 더 많은 급여를 받는 사원들의 사번, 이름, 급여를 화면에 보여주되, 급여가 높은데서 낮은 순으로 화면에 출력
SELECT EMPNO, ENAME, SAL FROM EMP WHERE SAL > (SELECT AVG(NVL(SAL, 0)) FROM EMP) ORDER BY SAL DESC;

-- 10. EMP 테이블에서 이름에 'T'를 포함하고 있는 사원들과 같은 부서에 근무하고 있는 사원의 사번과 이름, 부서번호를 화면에 출력
SELECT EMPNO, ENAME, DEPTNO FROM EMP WHERE DEPTNO IN(SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%T%'); -- 부서번호가 20, 30이 나오는데 2개를 동시에 출력하는 방법을 모르겠음 - IN 사용


-- 11. 'SALES' 부서에서 근무하고 있는 사원들의 부서번호, 이름, 담당업무를 화면에 출력
SELECT E.DEPTNO, E.ENAME, E.JOB FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO WHERE D.DNAME = 'SALES';
SELECT DEPTNO, ENAME, JOB FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME = 'SALES');

-- 12. EMP 테이블에서 'KING'에게 보고하는 모든 사원의 이름과 급여, 관리자를 화면에 출력
SELECT ENAME, SAL, MGR FROM EMP WHERE MGR = 7839;
SELECT ENAME, SAL, MGR FROM EMP WHERE MGR = (SELECT EMPNO FROM EMP WHERE ENAME = 'KING');

-- 13. EMP 테이블에서 자신의 급여가 평균급여보다 낮고, 이름에 'S'가 들어가는 사원과 동일한 부서에서 근무하는 모든 사원의 사번, 이름, 급여, 부서번호 출력
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP 
WHERE SAL < (SELECT AVG(NVL(SAL, 0)) FROM EMP)
AND DEPTNO IN (SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%S%');

-- 14. EMP 테이블에서 보너스를 받는 사원과 부서번호, 급여가 같은 사원들의 이름, 급여, 부서번호를 화면에 출력
SELECT ENAME, SAL, DEPTNO FROM EMP WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE COMM > 0) AND SAL IN(SELECT SAL FROM EMP WHERE COMM > 0);

-- 15. PRODUCTS 테이블에서 상품의 판매가격이 판매가격의 평균보다 큰 상품의 전체 내용을 화면에 출력
SELECT * FROM PRODUCTS WHERE OUTPUT_PRICE > (SELECT AVG(OUTPUT_PRICE) FROM PRODUCTS);

-- 16. PRODUCTS 테이블에 ㅇ씨는 판매가격에서 평균 가격 이상의 상품 목록을 구하되, 평균을 구할 때 가격이 가장 큰 금액인 상품을 제외하고 평균을 구하여 화면에 출력
SELECT * FROM PRODUCTS 
WHERE OUTPUT_PRICE >= (SELECT AVG(OUTPUT_PRICE) FROM PRODUCTS WHERE OUTPUT_PRICE != (SELECT MAX(OUTPUT_PRICE) FROM PRODUCTS)); -- 최고 판매가를 평균산출에서 제외

-- 17. PRODUCTS 테이블에서 카테고리 이름에 '에어컨' 이라는 단어가 포함된 카테고리에 속하는 상품목록의 정체정보를 화면에 출력
SELECT * FROM PRODUCTS WHERE CATEGORY_FK = '00010003';
SELECT * FROM PRODUCTS WHERE CATEGORY_FK = (SELECT CATEGORY_CODE FROM CATEGORY WHERE CATEGORY_NAME LIKE '%에어컨%');

-- 18. MEMBER10 테이블에 있는 고객 정보 중 마일리지가 가장 높은 금액을 가지는 고객에게 보너스 마일리지 5000점을 더 주어 고객명, 마일리지, 마일리지+5000점을 화면에 출력
SELECT MEMNAME, MILEAGE, MILEAGE+5000 "BONUS MILEAGE" FROM MEMBER10 WHERE MILEAGE = (SELECT MAX(MILEAGE) FROM MEMBER10);

COMMIT;


/*
    GROUP BY절 : 특정 컬럼이나 값을 기준으로 해당 레코드를 묵어서 자료를 관리할 때 사용한다.
                 보통 특정 컬럼을 기준으로 집계를 구하는데 많이 사용이 된다.
                 보통은 그룹함수와 함께 사용하면 효과적으로 활용이 가능하다.
                 
*/

SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO -- 부서번호 별로 행의 갯수를 출력한다
ORDER BY DEPTNO;

-- EMP 테이블에서 부서별로 급여의 합계액을 화면에 출력
SELECT DEPTNO, ROUND(AVG(SAL), 0)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- EMP 테이블에서 부서별로 그룹을 지어서 부서의 급여 합계와 부서별 인원수, 부서별 평균 급여, 부서별 최대 급여,
-- 부서별 최소 급여를 구하여 화면에 출력, 급여 합계를 기준으로 내림차순으로 정렬하여 화면에 출력

SELECT DEPTNO, SUM(SAL) SUM, COUNT(*) COUNT, ROUND(AVG(SAL), 0) AVG, MAX(SAL) MAX, MIN(SAL) MIN
FROM EMP
GROUP BY DEPTNO -- 부서별로 SELECT한 컬럼들을 각각 출력한다.
ORDER BY SUM DESC;


/* 
    HAVING 절
        GROUP BY 절 다음에 나오는 조건절로
        GROUP BY 절의 결과에 조건을 주어서 제한할 때 사용된다.
        GROUP BY 절에는 WHERE(조건절)이 올 수 없다.
*/

-- PRODUCTS 테이블에서 카테고리 별로 상품의 갯수를 화면에 출력

SELECT CATEGORY_FK, COUNT(*) FROM PRODUCTS GROUP BY CATEGORY_FK HAVING COUNT(*) > 1 ORDER BY CATEGORY_FK;

/*
    트랜잭션(TRANSACTION)
    데이터 처리의 한 단위를 말한다.
    오라클에서 발생하는 여러 개의 SQL 명령문들을 
    하나의 논리적인 작업 단위로 처리하는 것을 말한다.
    ALL OR NOTHING 방식으로 처리함
    명령어 여러 개의 집합이 정상적으로 처리가 되면 종료를 하고, 
    여러 개의 명령어 중에서 하나의 명령어라도 잘못이 되면 전체를 취소하는 방식을 말한다.
    
    트랜잭션을 사용하는 이유 : 데이터의 일관성을 유지하면서 데이터의 안정성을 보장하기 위해서 사용한다.
    
    트랜잭션 사용 시 트랜잭션을 제어하기 위한 명령어
    
    1. commit : 모든 작업을 정상적으로 처리하겠다고 확정하는 명령어. 트랜잭션(insert, delete, update)작업의 내용을 
                실제 db에 반영하고, 이전에 있던 데이터에 update 현상을 발생시킨다.
                모든 사용자가 변경된 데이터의 결과를 확인할 수 있다.
    
    2. rollback : 작업 중에 문제가 발생했을 때 트랜잭션 처리 과정에서
                  발생한 변경 사항을 취소하여 이전 상태로 되돌리는 명령어이다.
                  트랜잭션 작업 내용을 취소한다.
                
*/

-- 1. DEPT_01 테이블을 만들 때 DEPT 테이블을 복사하여 만들어보자.
CREATE TABLE DEPT_01 AS SELECT * FROM DEPT;
-- DEPT 테이블의 내용을 DEPT_01로 복사한다 AS를 사용하여 진행가능

DELETE FROM DEPT_01;

DELETE FROM DEPT_01 WHERE DEPTNO = 20;

commit;
rollback;

/*
    savepoint : 트랜잭션을 작게 분할하는 것을 말한다.
                사용자가 트랜잭션 중간 단계에서 포인트를 지정하여
                트랜잭션 내의 특정 SAVEPOINT까지 ROLLBACK 할 수 있게 하는 것을 말한다.
                
*/

-- 1. DEPT 테이블을 복사하여 DEPT_02 테이블 복사
CREATE TABLE DEPT_02 AS SELECT * FROM DEPT;

-- 2. DEPT_02 테이블에서 40번 부서를 삭제한 후에 COMMIT
DELETE FROM DEPT_02 WHERE DEPTNO = 40;

COMMIT;

-- 3. SAVEPOINT 생성
SAVEPOINT C1;

-- 4. 부서번호 20번인 부서를 삭제
DELETE FROM DEPT_02 WHERE DEPTNO = 20;

-- 5. SAVEPOINT 생성
SAVEPOINT C2;

-- 6. 마지막으로 부서번호 10번인 부서 삭제
DELETE FROM DEPT_02 WHERE DEPTNO = 10;

ROLLBACK C2;