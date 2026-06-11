# 그룹 함수
# - 그룹의 통계를 반환하는 함수
# - sum(), avg(), count(), MAX(), MIN()

# sum(컬럼)
# - null(빈칸 상태)이 아닌 컬럼의 합
SELECT
    sum(menu_price)
FROM
    tbl_menu;

# avg(컬럼)
# - null(빈칸 상태)이 아닌 컬럼의 평균
SELECT
    avg(menu_price)
FROM
    tbl_menu;

# 카테고리 코드가 10인 메뉴의 평균 가격
SELECT
    avg(menu_price)
FROM
    tbl_menu
WHERE
    category_code = 10;


# 메뉴 가격 최대값, 최소값
SELECT
    max(menu_price) `최대값`,
    min(menu_price) `최소값`
FROM
    tbl_menu;

# null과 연산을 수행하면 모든 결과가 null
SELECT 1 + null;


# 합계, 평균 -> 숫자 데이터 컬럼에만 적용 가능
# 최대, 최소 -> 숫자, 문자, 날짜 모두 사용 가능
SELECT
    max(menu_name),
    min(menu_name)
FROM
    tbl_menu;

# count(* | 컬럼명) : 행의 개수를 조회
# count(*) : 모든 행(null 포함) 개수
# count(컬럼명) : 지정된 컬럼 값 중 null인 컬럼을 제외한 행의 개수

SELECT
    count(*), # 전체 행 개수 (12)
    count(ref_category_code) # null 3개를 제외한 행 개수 (9)
FROM
    tbl_category;


# ==================================================
# GROUP BY 절
# - 지정된 컬럼 값이 일치하는 행을 그룹화(grouping) 시키는 구문

SELECT
    category_code,
    count(*), # 각 그룹의 모든 행의 개수
    sum(menu_price), # 각 그룹의 가격 합계
    avg(menu_price), # 각 그룹의 가격 평균
    MAX(menu_price), # 각 그룹의 메뉴 최대값
    MIN(menu_price) # 각 그룹의 메뉴 최소값
FROM
    tbl_menu
GROUP BY
    category_code; # category_code 컬럼 값이 같은 행을 그룹화


### GROUP BY 사용 시 주의사항
# 1. null도 별도 그룹으로 묶임
# 2. SELECT 절에는 GROUP BY 기준이 된 컬럼 + 그룹 함수만 작성 가능

SELECT
    ref_category_code
    #, category_name # 그룹화되지 않은 컬럼으로 인해 오류 발생
FROM
    tbl_category
GROUP BY
    ref_category_code;


### 그룹 내 하위 그룹 구성 가능
# category_code로 1차 그룹화 후
# 각 그룹에서 orderable_status가 같은 행 끼리 2차 그룹화
SELECT
    category_code,
    orderable_status,
    count(*) # 2차 그룹화된 orderable_status에 대한 카운트
FROM
    tbl_menu
GROUP BY
    category_code,
    orderable_status
ORDER BY
    category_code ASC;


### WHERE + GROUP BY : 필터링된 행 중 컬럼값이 같은 행 그룹화
# - WHERE : 지정된 테이블에서 행을 필터링
# - GROUP BY : 컬럼 값이 같은 행을 그룹화

# 메뉴 테이블에서 카테고리별 개수, 합계를 구하기
# 단, 메뉴 가격이 10,000원 이상인 메뉴만
SELECT
    category_code,
    count(*),
    sum(menu_price)
FROM
    tbl_menu
WHERE
    menu_price >= 10000
GROUP BY
    category_code;


# 메뉴 테이블에서
# 주문이 가능한 메뉴 중 카테고리 코드가 4, 10인 메뉴의
# 카테고리별 개수 조회
SELECT
    # m.category_code,
    c.category_name,
    count(*)
FROM
    tbl_menu m
JOIN
    tbl_category c ON m.category_code = c.category_code
WHERE
    m.orderable_status = 'Y'
    AND
    m.category_code IN (4, 10)
GROUP BY
    # m.category_code;
    c.category_name;


# ==================================================
# HAVING 절
# - GROUP BY를 통해 만들어진 그룹에 대한 조건을 작성하는 구문
# - HAVING 절 작성 시 항상 그룹함수가 포함된다

# 메뉴 테이블에서
# 카테고리 별 메뉴 개수가 2개 이상인 카테고리의
# 카테고리 번호, 개수 출력
SELECT
    category_code,
    count(*)
FROM
    tbl_menu
GROUP BY
    category_code
HAVING
    count(*) >= 2;


# 카테고리 테이블에서
# 부모 카테고리(ref_category_code) 별로 개수 3개 이상인
# 부모 카테고리 번호, 개수 조회
# 부모 카테고리 오름차순으로 조회
SELECT
    ref_category_code,
    count(*)
FROM
    tbl_category
GROUP BY
    ref_category_code
HAVING
    count(*) >= 3
ORDER BY
    ref_category_code ASC;


# 위 쿼리 결과에서 null 제외
SELECT
    ref_category_code,
    count(*)
FROM
    tbl_category
WHERE
    ref_category_code IS NOT NULL
GROUP BY
    ref_category_code
HAVING
    /* WHERE절 필터링이 더 효과적이며 권장됨
    ref_category_code IS NOT NULL
    AND
    */
    count(*) >= 3
ORDER BY
    ref_category_code ASC;


# SELECT구문에 작성 가능한 모든 절 사용
SELECT
    ref_category_code,
    count(*)
FROM
    tbl_category
WHERE
    ref_category_code IS NOT NULL
GROUP BY
    ref_category_code
HAVING
    /* WHERE절 필터링이 더 효과적이며 권장됨
    ref_category_code IS NOT NULL
    AND
    */
    count(*) >= 3
ORDER BY
    ref_category_code ASC
LIMIT
    1;