/*
 ### Q1.

 재직 중이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의 사원번호, 직원명, 전화번호, 입사일, 퇴직여부를 출력하세요.

 - 참고. 퇴사한 직원은 퇴직여부 컬럼값이 ‘Y’이고, 재직 중인 직원의 퇴직여부 컬럼값은 ‘N’
 */
SELECT * FROM employee; # 직원 데이터 조회용

SELECT
    EMP_ID `사원번호`,
    EMP_NAME `직원명`,
    PHONE `전화번호`,
    HIRE_DATE `입사일`,
    ENT_YN `퇴직여부`
FROM
    employee
WHERE
    ENT_YN = 'N'
    AND
    PHONE LIKE '%2'
ORDER BY
    HIRE_DATE DESC
LIMIT
    3;


/*
 ### Q2.

 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 사원번호, 이메일, 전화번호, 입사일을 출력하세요.

 단, 급여를 기준으로 내림차순 출력하세요.
 */
SELECT * FROM job; # 직급 데이터 조회용

SELECT
    EMP_NAME `직원명`,
    e.JOB_CODE `직급명`,
    SALARY `급여`,
    EMP_ID `사원번호`,
    EMAIL `이메일`,
    PHONE `전화번호`,
    HIRE_DATE `입사일`
FROM
    employee as e
INNER JOIN
    job j
    ON e.JOB_CODE = j.JOB_CODE
WHERE
    j.JOB_NAME = '대리'
ORDER BY
    SALARY DESC;