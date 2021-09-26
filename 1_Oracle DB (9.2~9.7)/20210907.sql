/*
    PL/SQL(Procedual Language / Structured Query Language)
    
    SQL만으로는 구현이 어렵거나 구현 불가능한 작업을 수행하기 위해
    오라클에서 제공하는 프로그래밍 언어를 말한다.
    일반 프로그래밍 언어적인 요소들을 다 가지고있으며, 데이터베이스 업무를 처리하기위한
    최적화된 언어이다.
    변수, 조건 처리, 반복 처리 등 다양한 기능을 사용할 수 있다.
    
    기본 구조 
    
    1. 선언부(Declare) : 모든 변수나 상수를 선언하는 부분
    
    2. 실행부(Excutable - begin) : 실제 로직이 실행되는 부분, 제어문(조건문), 반복문 등의 로직을 기술하는 부분
    
    3. 예외처리부(Exception) : 실행 도중 예외가 발생 시 해결하기 위한 명령들을 기술하는 부분
    
    위의 기본 구조 중에서 선언부와 예외처리부는 생략이 가능하지만 실행부는 반드시 기술해야한다.
    
   *  PL/SQL 사용시 주의사항
    
    1. 기본구조(Declare, begin, Exception) 키워드 뒤에는 세미콜론을 붙이지 않는다.
    
    2. 블럭의 각 부분에서 실행해야 하는 문장 끝에는 세미콜론을 붙인다.

    3. begin ~ end(실행부) 밑에는 반드시 "/"을 붙여 주어야 한다.
*/

-- PL/SQL을 이용하여 "Hello, PL/SQL" 내용을 화면에 출력

-- PL/SQL은 기본적으로 문장의 결과를 화면에 출력시키지 않는다. 화면에 출력할 수 있도록 해주어야함
-- 실행결과를 화면에 출력하는 문장 : SET SERVEROUTPUT ON
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO, PL/SQL');
END;
/


-- 선언부(DECLARE) 영역에 변수를 선언하는 방법
--  1. 스칼라 자료형 : 형식) 변수명 자료형(크기)
 

DECLARE
    NUM NUMBER(10);
    NAME VARCHAR2(20);

BEGIN
    SELECT EMPNO, ENAME INTO NUM, NAME 
    FROM EMP
    WHERE ENAME = 'ADAMS';
    
    DBMS_OUTPUT.PUT_LINE(NUM||'        '||NAME);
END;
/

/*
    2. 레퍼런스 자료형 : 형식) 변수명 테이블명.컬럼명%TYPE;
        테이블에 정의된 컬럼의 자료형과 크기를 모두 파악하고 있다면 별 문제가 없겠지만,
        대부분은 그렇지 못하기 때문에 오라클에서는 레퍼런스(REFERENCE) 변수를 제공해주고 있음
*/

-- := 선언한 변수 값에 데이터를 저장하는 연산자이다.

DECLARE
    V_EMPNO EMP.EMPNO%TYPE; -- V_EMPNO 변수는 EMP 테이블의 EMPNO 컬럼의 자료형으로 하겠다.
    V_ENAME EMP.ENAME%TYPE;
    
BEGIN
    SELECT EMPNO, ENAME INTO V_EMPNO, V_ENAME
    FROM EMP
    WHERE ENAME = 'SCOTT';
    
    DBMS_OUTPUT.PUT_LINE('V_EMPNO :' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME :' || V_ENAME);

END;
/

/*
    3. ROWTYPE 자료형 : 테이블의 모든 컬럼을 한꺼번에 저장하기 위한 변수로 선언하는방법
*/

DECLARE
    EMP_ROW EMP%ROWTYPE;
BEGIN
    SELECT * INTO EMP_ROW
    FROM EMP
    WHERE ENAME IN('ADAMS');
    
    DBMS_OUTPUT.PUT_LINE(EMP_ROW.EMPNO||' '||EMP_ROW.ENAME||' '||EMP_ROW.JOB||' '||EMP_ROW.SAL);
END;
/

-- 조건 제어문
-- 특정 조건식을 통해 상황에 따라 실행할 내용을 달리하는 방식의 명령어를 말한다.

/*
    1.IF 조건문
    
    IF~THEN : 특정 조건을 만족하는 경우 작업을 수행
              IF 조건식 THEN
                조건식이 참인 경우 실행문장;
              END IF
              
    IF~THEN~ELSE : 특정 조건을 만족하는 경우, 만족하지 않는 경우 각 작업 수행
                    IF 조건식 THEN
                        조건식이 참인 경우 실행 문장;
                    ELSE
                        조건식이 거짓인 경우 실행 문장;
                    END IF
                    
    IF~THEN~ELSIF : 여러 조건에 따라 각자 지정한 작업을 수행한다.
        형식) IF 조건식1 THEN
                실행문;
            ELSIF 조건식2 THEN
                실행문;
            ELSIF 조건식3 THEN
                실행문;
            ELSE 
                실행문
            END IF
*/

-- IF~THEN
DECLARE
    V_NUMBER NUMBER(3) := 10;
    V_NUMBER2 NUMBER(5) := 37;
BEGIN
    IF V_NUMBER > 10 THEN
        DBMS_OUTPUT.PUT_LINE('10보다 큼');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('10보다 작음');
    END IF;
    
    IF MOD(V_NUMBER2, 2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('짝수');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('홀수');
    END IF;
END;
/

DECLARE
    V_AVG NUMBER(5, 2) := 89.12;
BEGIN
    IF V_AVG >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A');
    ELSIF V_AVG >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B');
    ELSIF V_AVG >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C');
    ELSIF V_AVG >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('D');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F');
    END IF;
END;
/

/*
    CASE 조건문
        1. 단순 CASE
            CASE 비교기준
                WHEN VALUE1 THEN
                    실행문
                WHEN VALUE2 THEN
                    실행문
                WHEN VALUE3 THEN
                    실행문
                WHEN VALUE4 THEN
                    실행문
                ELSE
                    실행문
                END CASE;
*/

-- 1. 단순 CASE 예제
DECLARE
    V_SCORE NUMBER(3) := 55 ;
BEGIN
    CASE TRUNC(V_SCORE/10)
        WHEN 10 THEN
            DBMS_OUTPUT.PUT_LINE('A');
        WHEN 9 THEN
            DBMS_OUTPUT.PUT_LINE('B');
        WHEN 8 THEN
            DBMS_OUTPUT.PUT_LINE('C');
        WHEN 7 THEN
            DBMS_OUTPUT.PUT_LINE('D');
        WHEN 6 THEN
            DBMS_OUTPUT.PUT_LINE('F');
        ELSE
            DBMS_OUTPUT.PUT_LINE('F');
        END CASE;
END;
/

/*
    CASE 조건문
        2. 검색 CASE
            CASE
                WHEN 조건식1 THEN
                    실행문
                WHEN 조건식2 THEN
                    실행문
                WHEN 조건식3 THEN
                    실행문
                WHEN 조건식4 THEN
                    실행문
                ELSE
                    조건식에 모두 포함되지 않을 경우 실행문
                END CASE;
*/

DECLARE
    V_SCORE NUMBER(3) := 88;
BEGIN
    CASE
        WHEN V_SCORE >= 90 THEN
            DBMS_OUTPUT.PUT_LINE('A');
        WHEN V_SCORE >= 80 THEN
            DBMS_OUTPUT.PUT_LINE('B');
        WHEN V_SCORE >= 70 THEN
            DBMS_OUTPUT.PUT_LINE('C');
        WHEN V_SCORE >= 60 THEN
            DBMS_OUTPUT.PUT_LINE('D');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('F');
    END CASE;
END;
/


/*
    반복 제어문
    특정 작업을 반복하여 수행하고자 할 때 사용하는 문장
    
    기본 LOOP : 기본 반복문
    
    WHILE LOOP : 특정 조건의 결과를 통해서 반복을 수행
    
    FOR LOOP : 반복 횟수를 정하여 반복 수행
    
    반복문의 반복 수행을 종료시키는 명령어
    1. EXIT : 수행중인 반복을 종료시키는 명령어
    2. EXIT-WHEN : 반복 종료를 위한 조건식을 지정하고 만족하면 반복 종료
    3. CONTINUE : 수행중인 반복의 현재 주기를 건너 뜀
    4. CONTINUE-WHEN : 특정 조건식을 지정하고 조건식을 만족하면 반복 주기를 건너뜀
*/

-- 기본 LOOP 예제
DECLARE
    V_NUM NUMBER(3) := 1;
    V_SUM NUMBER(5) := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('V_NUM : ' || V_NUM);
        IF V_NUM >= 100 THEN
            V_SUM := V_SUM + V_NUM;
            DBMS_OUTPUT.PUT_LINE(V_SUM);
            EXIT;
        ELSE 
            V_SUM := V_SUM + V_NUM;
            V_NUM := V_NUM + 1;
        END IF;
    END LOOP;
END;
/

DECLARE
    V_NUM NUMBER(3) := 1;
    V_SUM NUMBER(5) := 0;
BEGIN
    LOOP
        V_SUM := V_SUM + V_NUM;
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM > 100;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_SUM);
END;
/

-- EXIT WHEN 사용
DECLARE
    V_SCORE NUMBER(3) := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(V_SCORE);
        V_SCORE := V_SCORE + 1;
        EXIT WHEN V_SCORE > 100;
    END LOOP;
END;
/


-- WHILE LOOP 예제
DECLARE 
    V_NUM NUMBER(3) := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('WHILE LOOP 반복문');
    WHILE V_NUM <= 100 LOOP
        DBMS_OUTPUT.PUT_LINE(V_NUM);
        V_NUM := V_NUM + 1;
    END LOOP;
END;
/

-- FOR LOOP 예제
DECLARE
--    V_SUM NUMBER(5) := 0;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('FOR LOOP 반복문');
    
    FOR I IN 1 .. 100 LOOP
        DBMS_OUTPUT.PUT_LINE('I = ' || I);
    END LOOP;
END;
/

DECLARE
    V_SUM NUMBER(5) := 0;

BEGIN
    FOR I IN 1 .. 100 LOOP
        V_SUM := V_SUM + I;
    END LOOP;   
    DBMS_OUTPUT.PUT_LINE(V_SUM);
END;
/

-- 키보드로 데이터 입력받는 방법
DECLARE
    V_NUM1 NUMBER(5);
    V_NUM2 NUMBER(5);
BEGIN
    V_NUM1 := '&NUM1';
    V_NUM2 := '&NUM2';
    DBMS_OUTPUT.PUT_LINE(V_NUM1 + V_NUM2);
END;
/

CREATE TABLE TEST(
    NO NUMBER(3) PRIMARY KEY,
    NAME VARCHAR2(20) NOT NULL,
    ADDR VARCHAR2(100) NOT NULL
);

DECLARE
    NO TEST.NO%TYPE;
    NAME TEST.NAME%TYPE;
    ADDR TEST.ADDR%TYPE;
    ROW TEST%ROWTYPE;
BEGIN
    NO := '&NO';
    NAME := '&NAME';
    ADDR := '&ADDR';
    
    INSERT INTO TEST VALUES(NO, NAME, ADDR);
    SELECT * INTO ROW FROM TEST WHERE NO = NO;
    DBMS_OUTPUT.PUT_LINE('번호 /  이름  /  주소');
    DBMS_OUTPUT.PUT_LINE(ROW.NO ||' ' || ROW.NAME || ' ' || ROW.ADDR);
    
END;
/

CREATE TABLE TEST(
    NO, 
/*
    데이터 정의어(DDL : Data Definition Language)
    - 데이터의 관리 및 보관을 위해 다양한 객체를 제공하는데 이러한 객체를
      새로 만들거나 기존에 존재하던 객체를 변경하거나 삭제하는 등의 기능을 수행하는 명령어를 말한다.
    
    - 데이터 정의어를 사용시 주의사항
        * 데이터 정의어를 실행하면 자동으로 commit이 된다.
          따라서 ROLLBACK을 통한 취소가 불가능하다.
          
    - 데이터 정의어의 종류
        1. CREATE : 객체를 생성하는 명령어 (테이블 생성, 시퀀스 생성, VIEW 생성)
        2. ALTER : 기존의 객체를 수정하는 명령어 (테이블의 컬럼 추가, 수정, 삭제)
        3. DROP : 객체를 삭제하는 명령어 (테이블을 삭제하는 명령어)
*/

-- TEST 테이블삭제
DROP TABLE TEST; -- TEST 테이블은 휴지통으로 간 상태
DROP TABLE TEST PURGE; -- TEST 테이블을 완전히 삭제해버린다.

-- 테이블의 이름을 변경
-- RENAME : 테이블의 이름을 변경하고 싶을 때 사용하는 명령어
-- 형식) RENAME 기존테이블이름 TO 새로운 테이블이름
RENAME DEPT_10 TO DEPT_02;

-- TRUNCATE : 테이블의 데이터를 삭제하는 명령어(데이터를 자른다)
-- 형식 ) TRUNCATE TABLE 테이블이름
TRUNCATE TABLE DEPT_02;

ROLLBACK;

BEGIN
    FOR I IN 1 .. 100 LOOP
        IF I BETWEEN 50 AND 95 THEN
            CONTINUE;
        END IF;
    DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/


BEGIN
    FOR I IN 1 .. 100 LOOP
        CONTINUE WHEN I BETWEEN 51 AND 94;
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

select* from member10;

CREATE SEQUENCE MEMBER10_SEQ
START WITH 10 INCREMENT BY 1 NOCACHE;

COMMIT;