create user skn_ai@'%' identified by '1234'; # 계정 생성

# database == schema
create database menudb; # 데이터베이스(데이터 저장 공간(파일) 생성)

grant all privileges on menudb.* to skn_ai@'%'; # 권한 부여