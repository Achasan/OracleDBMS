-- LIKE 키워드 : 검색을 하는 키워드

-- WHERE ENAME LIKE '%S%' : 'S' 문자를 포함하는 사원의 이름을 모두 검색
-- % : 문자의 갯수, 어떤 문자가 와도 상관없다는 뜻을 가지고 있다.

-- WHERE ENAME LIKE 'S%' : 앞글자가 'S'인 이름의 사원을 모두 검색한다.
-- WHERE ENAME LIKE '%S' : 이름이 S로 끝나는 이름의 사원을 모두 검색한다.

-- WHERE ENAME LIKE '_S%' : 첫번째 글자는 아무거나, 2번 째 글자가 S인 사원의 이름을 검색

SELECT * FROM EMP
WHERE ENAME LIKE '%S';

-- EMP 테이블에서 이름이 'S'자로 끝나는 사원의 이름과 담당업무를 화면에 출력
SELECT ENAME, JOB FROM EMP WHERE ENAME LIKE '%S';

-- EMP 테이블에서 이름의 세 번째에 'R'이 들어가는 사원의 이름과 담당업무, 급여 화면 출력
SELECT ENAME, JOB, SAL FROM EMP WHERE ENAME LIKE '__R%';

-- EMP 테이블에서 이름의 두번째에 O가 들어가는 사원의 모든 정보를 화면에 출력
SELECT * FROM EMP WHERE ENAME LIKE '_O%';

-- EMP 테이블에서 입사년도가 82년도인 사원의 사번, 이름 ,입사일자를 화면에 출력
SELECT EMPNO, ENAME, HIREDATE FROM EMP WHERE HIREDATE LIKE '82%';

-- EMP 테이블에서 사원의 이름에 두 번째에 L이 들어가는 사원의 모든 정보를 화면에 출력
SELECT * FROM EMP WHERE ENAME LIKE '_L%';

-- EMP 테이블에서 사원의 이름에 AM이 포함되어있는 사원의 사번, 이름, 담당업무, 부서번호 화면 출력
SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE ENAME LIKE '%AM%';

-- MEMBER10 테이블에서 성이 김씨인 회원의 모든 정보를 화면에 출력
SELECT * FROM MEMBER10 WHERE MEMNAME LIKE '김%';

-- MEMBER10 테이블에서 주소에 경기도가 포함되어있는 회원의 이름, 주소, 직업을 화면에 출력
SELECT MEMNAME, ADDR, JOB FROM MEMBER10 WHERE ADDR LIKE '경기도%';

-- ORDER BY 절
-- 자료를 정렬하여 나타내고자 할 때 사용하는 구문이다. ORDER BY 절을 사용할 때는 SELECT 구문의 맨 마지막에 위치해야한다.
-- ASC : 오름차순 정렬, DESC : 내림차순 정렬, 기본적으로 AEC가 DEFAULT 이다.
-- 오름차순으로 정렬할 경우에는 ASC는 생략이 가능하다.

-- EMP 테이블에서 사번을 기준으로 오름차순으로 정렬하여 화면에 출력
SELECT * FROM EMP ORDER BY EMPNO ASC;

-- EMP 테이블에서 입사일을 기준으로 오름차순 정렬하여 화면에 출력
SELECT * FROM EMP ORDER BY HIREDATE ASC;

-- MEMBER10 테이블에서 이름을 기준으로 오름차순 정렬하여 화면에 출력
-- 이름이 같은 경우에는 나이를 기준으로 내림차순으로 정렬
SELECT * FROM MEMBER10 ORDER BY MEMNAME ASC, AGE DESC;

-- EMP 테이블에서 부서번호를 기준으로 오름차순으로 정렬을 하고, 부서번호가 같은 경우 급여를 기준으로 내림차순
-- 정렬을 하여 모든 정보 화면에 출력
SELECT * FROM EMP ORDER BY DEPTNO, SAL DESC;

-- PRODUCTS 테이블에서 판매가격을 기준으로 내림차순 정렬하여 모든 정보를 화면에 출력
SELECT * FROM PRODUCTS ORDER BY output_price DESC;

-- PRODUCTS 테이블에서 배송비를 기준으로 내림차순으로 정렬
-- 단, 배송비가 같은 경우 마일리지를 기준으로 내림차순 정렬하여 모든 정보 화면 출력
SELECT * FROM PRODUCTS ORDER BY TRANS_COST DESC, MILEAGE DESC;

-- EMP 테이블에서 입사일자가 오래된 사원부터 최근에 입사한 사원을 기준으로 정렬, 사원명, 입사일자 출력
SELECT ENAME, HIREDATE FROM EMP ORDER BY HIREDATE;

-- EMP 테이블에서 급여가 1100 이상인 사원의 모든 정보를 출력, 입사일자가 빠른 순으로 정렬하여 모든 정보를 화면에 출력
SELECT * FROM EMP WHERE SAL >= 1100 ORDER BY HIREDATE ASC;

-- EMP 테이블에서 부서번호를 기준으로 오름차순 정렬하여 나타내고, 부서번호가 같은 경우 담당업무를 오름차순으로 정렬
-- 만약 담당업무가 같다고 한다면 급여가 많은 데서 적은 순으로 정렬하여 모든 정보를 화면에 출력
SELECT * FROM EMP ORDER BY EMPNO, JOB, SAL DESC;


/*
NOT 키워드 : 부정의 의미를 가진 키워드
쿼리문을 작성 시 부정이 아닌 긍정의 쿼리문을 작성한 후에 부정의 의미인 NOT을 붙여주면 된다.
*/

-- EMP 테이블에서 담당업무가 'MANAGER', 'CLERK', 'ANALYST',가 아닌 사원의 사번, 이름, 담당업무, 급여를 출력
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB NOT IN('MANAGER', 'CLERK', 'ANALYST');

-- EMP 테이블에서 이름에 'S'자가 들어가지 않는 사원의 몯느 정보를 화면에 출력
SELECT * FROM EMP WHERE ENAME NOT LIKE '%S%';

-- EMP 테이블에서 부서 번호가 10번 부서가 아닌 사원의 이름, 담당업무, 부서번호를 화면에 출력
SELECT ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO != 10;

-- MEMBER10 테이블에서 주소가 '경기도'가 아닌 회원의 모든 정보를 화면에 출력
SELECT * FROM MEMBER10 WHERE ADDR NOT LIKE '경기도%';

-- PRODUCTS 테이블에서 출고가가 100만원 미만이 아닌 제품의 상품명, 입고가, 출고가를 화면에 출력
SELECT PRODUCTS_NAME, INPUT_PRICE, OUTPUT_PRICE FROM PRODUCTS WHERE NOT OUTPUT_PRICE < 1000000;


/*
 그룹 함수 : 여러 행 또는 테이블 전체에 대하여 함수가 적용되어 하나의 결과값을 가져오는 함수
 
 AVG() : 평균값을 구해주는 함수
 COUNT() : 행의 갯수를 구해주는 함수, NULL값은 COUNT 되지않음.
 MAX() : 최댓값을 구해주는 함수
 MIN() : 최솟값을 구해주는 함수
 SUM() : 총합을 구해주는 함수
  
*/

-- EMP 테이블에서 사번을 가지고 있는 모든 사원의 수를 화면에 출력
SELECT COUNT(COMM) "COUNT" FROM EMP;

-- EMP 테이블에서 보너스를 받는 사원의 수를 화면에 출력
SELECT COUNT(COMM) FROM EMP;

-- EMP 테이블에서 관리자의 수를 화면에 보여주세요
SELECT COUNT(DISTINCT MGR) "MANAGER" FROM EMP;

-- EMP 테이블에서 보너스를 가진 사원의 수를 화면에 보여주세요
SELECT COUNT(COMM) "SAL COMM" FROM EMP;

-- EMP 테이블에서 모든 SALESMAN의 급여 평균과, 급여 최고액, 급여 최소액, 급여 합계액을 화면에 출력
SELECT AVG(SAL) "SALAVG", MAX(SAL) "SALMAX", MIN(SAL) "SALMIN", SUM(SAL) "SALSUM" FROM EMP WHERE JOB = 'SALESMAN';

-- EMP 테이블에서 등록되어있는 사원의 총 수, 보너스가 NULL이 아닌 인원 수, 보너스의 평균, 등록되어있는 부서의 수를 화면에 출력
SELECT COUNT(EMPNO) "사원 수", COUNT(COMM) "보너스 인원 수", AVG(COMM) "보너스 평균", COUNT(DISTINCT DEPTNO) "부서 수" FROM EMP;

/*
시퀀스(SEQUENCE)
순번을 부여할 때 사용하는 문법
CREATE SEQUENCE 시퀀스이름 START WITH 1 INCREMENT BY 1;
*/

CREATE TABLE MEMO(
    NO NUMBER(5) PRIMARY KEY,
    TITLE VARCHAR2(100) NOT NULL,
    WRITER VARCHAR2(50) NOT NULL,
    CONTENT VARCHAR2(500) NOT NULL,
    REGDATE DATE
);

CREATE SEQUENCE MEMO_SEQ START WITH 1 INCREMENT BY 1;

INSERT INTO MEMO VALUES(MEMO_SEQ.NEXTVAL, '메모1', '홍길동', '홍길동님의 글', SYSDATE);
INSERT INTO MEMO VALUES(MEMO_SEQ.NEXTVAL, '메모2', '이순신', '장군님의 글', SYSDATE);
INSERT INTO MEMO VALUES(MEMO_SEQ.NEXTVAL, '메모3', '유관순', '유관순님의 글', SYSDATE);
INSERT INTO MEMO VALUES(MEMO_SEQ.NEXTVAL, '메모4', '김유신', '유신님의 글', SYSDATE);
INSERT INTO MEMO VALUES(MEMO_SEQ.NEXTVAL, '메모5', '김연아', '연아님의 글', SYSDATE);
INSERT INTO MEMO VALUES(MEMO_SEQ.NEXTVAL, '메모6', '앙기모', '뛰뛰빵빵님의 글', SYSDATE);

SELECT * FROM MEMO;

/*
    JOIN ~ ON 키워드
    테이블과 테이블을 연결하여 특정한 데이터를 얻고자 할 때 사용하는 키워드
    2개 이상의 테이블에 정보가 나뉘어져 있을 때 사용한다.
    중복해서 데이터가 저장되는 것을 막기 위해 테이블을 나누어서 쓰게 된다.
    EMP 테이블에서 부서의 상세정보까지 저장을 한다면 10번 부서에 소속된 사원이 3명이므로 부서명과 근무지가 3번 중복되어 나타난다.
    이렇게 중복되어 저장된 데이터는 추후 삽입, 수정, 삭제 시 이상 현상이 발생할 수 있게 된다.
    따라서 데이터가 중복이 되지 않게 하려면 2개 이상의 테이블에 정보를 나누어 저장을 해두어야한다.
    
    테이블을 2개로 나누면 여러면 질의를 해야하므로 테이블을 결합시켜주는 JOIN ON 키워드를 사용한다.3
    
    
    JOIN의 종류
    1. CROSS JOIN
    - 두 개 이상의 테이블이 조인될 때 조건 없이 테이블에 결합이 이루어진다.
        따라서 테이블의 전체 행과 컬럼이 조인되기 때문에 
        EMP 사원 수(14) * DEPT 부서 수(4)가 곱해진 56개의 정보가 나타나게 된다.
    
    2. EQUI JOIN
    - 가장 많이 사용되는 조인 방법으로, 조인의 대상이 되는 두 테이블에서 공통적으로 존재하는
        컬럼의 값이 일치되는 행을 연결하여 결과를 생성하는 방법
      두 테이블이 조인하려면 일치되는 공통 컬럼을 사용하면 된다.
        컬럼의 이름이 같으면 혼동이 올 수 있기 댸문에 컬럼 이름 앞에 테이블의 이름을 기술하는 것이 좋다.
    
    3. SELF JOIN
    - 하나의 테이블 내에서 조인을 해야 얻을 수 있는 조인 방법
        자기 자신 테이블을 조인하는 것을 뜻한다.
        FROM 절 다음에 테이블 이름을 나란히 두 번 기술을 할 수 없다.
        따라서 같은 테이블이 하나 더 존재하는 것처럼 사용할 수 있도록 테이블에 별칭을 붙여서 사용한다.
    
    4. OUTER JOIN
    - 2개 이상의 테이블이 조인이 될 때 어느 한 쪽 테이블에는 해당하는 데이터가
        다른쪽 테이블에 데이터가 존재하지 않는 경우 그 데이터가 출력디 되지 않는 문제점을 해결하기위해 사용되는
        조인기법. 정보가 부족한 테이블의 컬럼 뒤에 '(+)' 기호를 붙여서 사용이 가능하다.
*/

SELECT * FROM EMP, DEPT; -- CROSS JOIN 방법, 조건이 없기 때문에 단순히 EMP행과 DEPT행을 곱한 결과가 출력된다.


-- EQUI JOIN : EMP 테이블에서 사원의 사번, 이름 ,담당업무, 부서번호, 부서명, 근무 위치를 출력
-- EMP 테이블에는 부서명, 근무위치는 없음, DEPT 테이블에서 가져와야함
SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC FROM EMP "E" JOIN DEPT "D" ON E.DEPTNO = D.DEPTNO;

-- EMP 테이블에서 사원명이 SCOTT인 사원의 부서명을 화면에 출력
SELECT E.ENAME, E.DEPTNO, D.DNAME FROM EMP "E" JOIN DEPT "D" ON E.DEPTNO = D.DEPTNO WHERE E.ENAME = 'SCOTT';

-- 부서명이 'RESEARCH'인 사원의 사번, 이름, 급여, 부서명, 근무위치를 화면에 출력
SELECT E.EMPNO, E.ENAME, E.SAL, D.DNAME, D.LOC FROM EMP "E" JOIN DEPT "D" ON E.DEPTNO = D.DEPTNO WHERE D.DNAME = 'RESEARCH' ORDER BY EMPNO;

-- EMP 테이블에서 'NEW YORK'에 근무하는 사원의 이름과 급여, 부서번호 화면에 출력
SELECT E.ENAME, E.SAL, E.DEPTNO FROM EMP "E" JOIN DEPT "D" ON E.DEPTNO = D.DEPTNO WHERE D.LOC = 'NEW YORK';

-- EMP 테이블에서 'ACCOUNTING' 부서 소속 사원의 이름과 담당업무, 입사일, 부서번호, 부서명 출력
SELECT E.ENAME, E.HIREDATE, E.DEPTNO, D.DNAME FROM EMP "E" JOIN DEPT "D" ON E.DEPTNO = D.DEPTNO WHERE D.DNAME = 'ACCOUNTING';

-- EMP 테이블에서 담당업무가 'MANAGER'인 사원의 이름과 담당업무, 부서번호, 부서명을 화면에 출력
SELECT E.ENAME, E.JOB, E.DEPTNO, D.DNAME FROM EMP "E" JOIN DEPT "D" ON E.DEPTNO = D.DEPTNO WHERE E.JOB = 'MANAGER';


-- EMP 테이블에서 각 사원별 관리자의 이름을 화면에 출력 (SELF JOIN)
SELECT E1.ENAME, E1.JOB, E2.ENAME "MANAGER" FROM EMP "E1" JOIN EMP "E2" ON E1.MGR = E2.EMPNO WHERE E1.JOB = 'CLERK';

-- EMP 테이블에서 매니저가 "KING"인 사원들의 이름과 담당업무를 화면에 출력
SELECT E1.ENAME, E1.JOB, E2.ENAME FROM EMP "E1" JOIN EMP "E2" ON E1.MGR = E2.EMPNO WHERE E2.ENAME = 'KING';


-- OUTER JOIN 
SELECT E1.ENAME || '의 매니저 이름은' || E2.ENAME || ' 입니다.' FROM EMP "E1" JOIN EMP "E2" ON E1.MGR = E2.EMPNO(+);

SELECT E.ENAME, D.DEPTNO, D.DNAME FROM EMP E JOIN DEPT D ON E.DEPTNO(+) = D.DEPTNO ORDER BY E.DEPTNO;


-- DUAL TABLE : 오라클에서 자체적으로 제공해 주는 테이블로, 간단하게 함수를 이용하여 계산, 결과값을 확인할 때 사용하는 테이블이다.
--              오직 한 행, 한 컬럼만을 담고있는 테이블로, 특정 테이블을 생성할 필요 없이 함수, 또는 계산을 하고자 할 때 사용된다.

/* 오라클에서 제공해주는 함수들
    1. 날짜와 관련된 함수
        SYSDATE : 현재 시스템의 날짜를 구해오는 함수 *SELECT SYSDATE FROM DUAL;
                  SYSDATE에 +, - 연산자를 사용하여 날짜 연산이 가능하다.
    
    2. 몇 달 이후의 날짜를 구하는 함수 : ADD_MONTHS();
        형식 : ADD_MONTHS(현재날짜, MONTH) *SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;
        
    3. 다가올 날짜(요일)을 구해주는 함수 : NEXT_DAY()
        형식) NEXT_DAY(현재날짜, '요일') : 요일을 체크하여 이번주면 이번주 수요일, 수요일이 지나갔으면 다음주 출력
        ** 요일은 한글로 입력해야한다. 한국어로 설정되어서 그런듯
        *SELECT NEXT_DAY(SYSDATE, '일요일') FROM DUAL;
        
    4. 달의 마지막 날을 구해 주는 함수 : LAST_DAY()
    
    5. 두 날짜 사이의 개월 수 차이를 구하는 함수 : months_between()
    
    6. 형식에 맞게 문자열로 날짜를 출력하는 함수 : TO_CHAR()
        형식 ) TO_CHAR(날짜, '날짜형식')
*/

SELECT EMPNO, ENAME, HIREDATE, SYSDATE, MONTHS_BETWEEN(SYSDATE, HIREDATE) "개월 수 차" FROM EMP;

SELECT LAST_DAY(SYSDATE) FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YY/MM/DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MM/DD/YY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'yyyy-MM-dd') FROM DUAL;

/*
    문자와 관련된 함수
        1. 대문자, 소문자를 바꾸어주는 함수 : UPPER(), LOWER(), INITCAP()
            * INITCAP() : 첫글자만 대문자, 나머지는 소문자로 바꾸어준다.
        
        2. 문자의 길이를 구하는 함수 : length()
            * LENGTHB() : 입력한 데이터의 바이트길이를 구한다. 한글은 한 글자 당 2바이트로 구해진다.
                            (유니코드는 3바이트로 추출된다.)
            
        3. 문자열 일부를 추출하는 함수 : SUBSTR()
            * 시작 위치가 음수인 경우에는 오른쪽부터 시작이 된다.
            형식) SUBSTR("문자열", INDEX, LENGTH)
            
        4. 문자열을 연결하는 함수 : CONCAT() = ||
            형식) CONCAT("문자열", "문자열"); ==> "문자열문자열"
            
        5. 자릿수를 늘려주는 함수 : LPAD() RPAD() 왼쪽 오른쪽
            형식) LPAD('문자열', '전체자릿수', '늘어난자릿수에 채울 문자')
            
        6. 문자를 지워주는 함수 : 왼쪽 문자를 지워주는 함수, 오른쪽 문자를 지워주는 함수
            LTRIM()
            RTRIM()
            
        7. 문자열을 교체해주는 함수 : REPLACE()
            형식) REPLACE('원본문자', '교체될문자열', '새로운문자열');
*/
select lower(ename), initcap(ename) from emp;
select length(ename) from emp where length(ename) >= 5;

SELECT LENGTH('한글입니다'), LENGTHB('한글입니다') FROM DUAL;

SELECT SUBSTR(ENAME, 1, 3) FROM EMP;

SELECT ENAME, SUBSTR(ENAME, -3, 3) FROM EMP;

SELECT ENAME, SUBSTR(ENAME, 2) FROM EMP;

SELECT CONCAT('아령', '하세요'), '아령' || '하세요' FROM DUAL;

SELECT LPAD(ENAME, 10, '12345678') FROM EMP;
SELECT RPAD(ENAME, 10, '98765432') FROM EMP;

SELECT ENAME, RTRIM(ENAME, 'N') FROM EMP;
SELECT ENAME, REPLACE(ENAME, 'RD', 'EN') FROM EMP;

-- 문제 : EMP 테이블에서 결과가 아래와 같이 나오도록 화면에 출력
--          결과) 'SCOTT의 담당업무는 ANALYST 입니다.'
--          단, CONCAT 함수 사용
SELECT CONCAT(CONCAT(ENAME, '의 담당업무는 '), CONCAT(JOB, '입니다')) "result" FROM EMP;

-- 문제2 : EMP 테이블에서 결과가 아래와 같이 나오도록 화면에 출력
--          결과) 'SCOTT의 연봉은 36000 입니다.'
--          단, CONCAT 함수 사용
SELECT CONCAT(CONCAT(ENAME, '의 연봉은 '), CONCAT(SAL*10, '입니다.')) FROM EMP;

-- 문제3 : MEMBER10 테이블에서 결과가 아래와 같이 나오도록 화면에 출력
--          결과) '홍길동 회원의 직업은 학생입니다.'
--          단, CONCAT 함수 사용
SELECT CONCAT(CONCAT(MEMNAME, ' 회원의 직업은 '), CONCAT(JOB, '입니다.')) FROM MEMBER10;

-- 문제4 : EMP 테이블에서 사번, 이름, 담당업무를 화면에 출력
--          단, 담당업무는 소문자로 변경하여 화면에 출력
SELECT EMPNO, ENAME, LOWER(JOB) FROM EMP;

-- 문제5 : 주민등록번호 중에서 생년월일을 추출하여 화면에 출력
SELECT SUBSTR('960731-1067214', 3, 4) FROM DUAL;

-- 문제6 : EMP 테이블에서 담당업무에 'A'라는 글자를 '$'로 바꾸어 화면에 출력
SELECT REPLACE(JOB, 'A', '$') FROM EMP;

-- 문제7 : MEMBER10 테이블에서 직업이 '학생'인 정보를 '대학생'으로 바꾸어 화면에 출력
SELECT MEMNAME, REPLACE(JOB, '대학생', '학생') FROM MEMBER10;

-- 문제8 : MEMBER10 테이블에서 주소에 '경기도'로 된 정보를 '서울특별시'로 바꾸어 화면에 출력
SELECT MEMNAME, REPLACE(ADDR, '경기도', '서울특별시') FROM MEMBER10;