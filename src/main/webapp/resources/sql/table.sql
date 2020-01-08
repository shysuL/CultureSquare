------------------------테이블 삭제--------------------------
DROP TABLE ReLIKE;
DROP TABLE REPLY;
DROP TABLE DONATION;
DROP TABLE BLIKE;
DROP TABLE UPFILE;
DROP TABLE PFLOC;
DROP TABLE PERFORM_ADD;
DROP TABLE PRTYPE;
DROP TABLE BOARD;
DROP TABLE ALRAM;
DROP TABLE DailyPR;
DROP TABLE SOCIALINFO;
DROP TABLE POSTTYPE;
DROP TABLE USER_TABLE;
DROP TABLE ADMIN;
------------------------테이블 삭제--------------------------

------------------------시퀀스 삭제--------------------------
DROP SEQUENCE relike_seq;
DROP SEQUENCE reply_seq;
DROP SEQUENCE donation_seq;
DROP SEQUENCE blike_seq;
DROP SEQUENCE upfile_seq;
DROP SEQUENCE pfloc_seq;
DROP SEQUENCE perform_add_seq;
DROP SEQUENCE prtype_seq;
DROP SEQUENCE board_seq;
DROP SEQUENCE alram_seq;
DROP SEQUENCE dailypr_seq;
DROP SEQUENCE socialinfo_seq;
DROP SEQUENCE posttype_seq;
DROP SEQUENCE user_table_seq;
DROP SEQUENCE admin_seq;
------------------------시퀀스 삭제--------------------------

-- 1. 관리자 테이블 생성
CREATE TABLE ADMIN (
    adminno NUMBER PRIMARY KEY,
    adminid VARCHAR2(100) NOT NULL,
    adminpw VARCHAR2(100) NOT NULL
);
-- 관리자 테이블 시퀀스 생성
CREATE SEQUENCE admin_seq;

INSERT INTO admin(adminno, adminid, adminpw) VALUES(admin_seq.nextval,'cs', 'cs');

-- 2. 회원 테이블 생성
CREATE TABLE USER_TABLE (
   userno NUMBER PRIMARY KEY,
   userid VARCHAR2(300) NOT NULL,
   userpw VARCHAR2(100) NOT NULL,
   username VARCHAR2(50) NOT NULL,
   usernick VARCHAR2(100) NOT NULL,
   userphone VARCHAR2(100) NOT NULL,
   usergender VARCHAR2(20) NOT NULL,
   userbirth NUMBER NOT NULL,
   interest VARCHAR2(300) NOT NULL,
   usertype NUMBER NOT NULL,
   permit NUMBER NOT NULL,
   emailcheck VARCHAR2(300) NOT NULL,
   originname VARCHAR2(500),
   storedname VARCHAR2(500),
   follow NUMBER NOT NULL,
   prwritedate VARCHAR2(100) NOT NULL,
   sociallogin NUMBER NOT NULL
);

-- 회원 테이블 시퀀스 생성
CREATE SEQUENCE user_table_seq;

--회원 테이블 DEFAULT 추가
ALTER TABLE USER_TABLE MODIFY (permit DEFAULT 0);
ALTER TABLE USER_TABLE MODIFY (emailcheck DEFAULT 0);
ALTER TABLE USER_TABLE MODIFY (follow DEFAULT 0);
ALTER TABLE USER_TABLE MODIFY (prcnt DEFAULT 0);

-- 3. 게시판 구분 테이블 생성
CREATE TABLE POSTTYPE(
    postno NUMBER PRIMARY KEY,
    boardname VARCHAR2(100) NOT NULL
);

-- 게시판 구분 시퀀스 생성
CREATE SEQUENCE posttype_seq;

--추가, 소셜 로그인 여부 테이블 생성
CREATE TABLE SOCIALINFO(
    socialinfono NUMBER PRIMARY KEY,
    socialnick VARCHAR2(100) NOT NULL,
    userno NUMBER NOT NULL,
    
    CONSTRAINT socialinfo_userno_fk FOREIGN KEY(userno) REFERENCES USER_TABLE(userno)
);

-- 소셜 로그인 여부 시퀀스 생성
CREATE SEQUENCE socialinfo_seq;


-- 추가. 하루 PR 작성 수 테이블 생성
CREATE TABLE DailyPR(
    dailyPrNo NUMBER PRIMARY KEY,
    recentUpTime VARCHAR2(100) NOT NULL,
    userno NUMBER NOT NULL,
    
    CONSTRAINT dailypr_userno_fk FOREIGN KEY(userno) REFERENCES USER_TABLE(userno)
);

-- 하루 PR 작성 수 시퀀스 생성
CREATE SEQUENCE dailypr_seq;


-- 4.알림 테이블 생성
CREATE TABLE ALRAM(
    alramno NUMBER PRIMARY KEY,
    alramcontents VARCHAR2(100) NOT NULL,
    alramtime VARCHAR2(100) NOT NULL,
    alramcheck NUMBER NOT NULL,
    alramtype NUMBER NOT NULL,
    alramsender VARCHAR2(100) NOT NULL,
    userno NUMBER NOT NULL,
    
    CONSTRAINT alram_userno_fk FOREIGN KEY(userno) REFERENCES USER_TABLE(userno)
);

-- 알림 테이블 시퀀스 생성
CREATE SEQUENCE alram_seq;

--알림 테이블 DEFAULT 추가
ALTER TABLE ALRAM MODIFY (alramcheck DEFAULT 0);

-- 5.게시판 테이블 생성
CREATE TABLE BOARD(
    boardno NUMBER PRIMARY KEY,
    title VARCHAR2(200) NOT NULL,
    writtendate VARCHAR2(100) NOT NULL,
    contents VARCHAR2(3000) NOT NULL,
    views NUMBER NOT NULL,
    userno NUMBER NOT NULL,
    postno NUMBER NOT NULL,
   
    CONSTRAINT board_userno_fk FOREIGN KEY(userno) REFERENCES USER_TABLE(userno),
    CONSTRAINT board_postno_fk FOREIGN KEY(postno) REFERENCES POSTTYPE(postno)
);

-- 게시판 테이블 시퀀스 생성
CREATE SEQUENCE board_seq;

-- 6.PR유형 테이블 생성
CREATE TABLE PRTYPE(
    prno NUMBER PRIMARY KEY,
    prname VARCHAR2(100) NOT NULL,
    boardno NUMBER NOT NULL,
   
    CONSTRAINT prtype_boardno_fk FOREIGN KEY(boardno) REFERENCES BOARD(boardno)
);

-- PR유형 시퀀스 생성
CREATE SEQUENCE prtype_seq;

-- 7.공연정보게시판 추가정보 테이블 생성
CREATE TABLE PERFORM_ADD(
    performno NUMBER PRIMARY KEY,
    performname VARCHAR2(100) NOT NULL,
    performdate VARCHAR2(100) NOT NULL,
    writepermit NUMBER NOT NULL,
    updatepermit NUMBER NOT NULL,
    deletepermit NUMBER NOT NULL,
    boardno NUMBER NOT NULL,
   
    CONSTRAINT perform_add_boardno_fk FOREIGN KEY(boardno) REFERENCES BOARD(boardno)
);

-- 공연정보게시판 추가정보 시퀀스 생성
CREATE SEQUENCE perform_add_seq;

--공연정보게시판 추가정보 DEFAULT 추가
ALTER TABLE PERFORM_ADD MODIFY (writepermit DEFAULT 0);
ALTER TABLE PERFORM_ADD MODIFY (updatepermit DEFAULT 0);
ALTER TABLE PERFORM_ADD MODIFY (deletepermit DEFAULT 0);

-- 8.지도 테이블 생성
CREATE TABLE PFLOC(
    location NUMBER PRIMARY KEY,
    lat NUMBER NOT NULL,
    lon NUMBER NOT NULL,
    boardno NUMBER NOT NULL,
   
    CONSTRAINT pfloc_boardno_fk FOREIGN KEY(boardno) REFERENCES BOARD(boardno)
);

-- 지도 시퀀스 생성
CREATE SEQUENCE pfloc_seq;

-- 9.파일업로드 테이블 생성
CREATE TABLE UPFILE(
    fileno NUMBER PRIMARY KEY,
    originname VARCHAR2(100) NOT NULL,
    storedname VARCHAR2(100) NOT NULL,
    filesize NUMBER NOT NULL,
    boardno NUMBER NOT NULL,
   
    CONSTRAINT file_boardno_fk FOREIGN KEY(boardno) REFERENCES BOARD(boardno)
);

-- 파일업로드 시퀀스 생성
CREATE SEQUENCE upfile_seq;

-- 10.게시판 좋아요 테이블 생성
CREATE TABLE BLIKE(
    likeno NUMBER PRIMARY KEY,
    userno NUMBER NOT NULL,
    boardno NUMBER NOT NULL,
   
    CONSTRAINT blike_userno_fk FOREIGN KEY(userno) REFERENCES USER_TABLE(userno),
    CONSTRAINT blike_boardno_fk FOREIGN KEY(boardno) REFERENCES BOARD(boardno)
);

-- 게시판 좋아요 시퀀스 생성
CREATE SEQUENCE blike_seq;

-- 11.후원 테이블 생성
CREATE TABLE DONATION(
    donno NUMBER PRIMARY KEY,
    donprice NUMBER NOT NULL,
    userno NUMBER NOT NULL,
    boardno NUMBER NOT NULL,
   
    CONSTRAINT donation_userno_fk FOREIGN KEY(userno) REFERENCES USER_TABLE(userno),
    CONSTRAINT donation_boardno_fk FOREIGN KEY(boardno) REFERENCES BOARD(boardno)
);

-- 후원 시퀀스 생성
CREATE SEQUENCE donation_seq;

-- 12.댓글 대댓글 테이블 생성
CREATE TABLE REPLY(
    replyno NUMBER PRIMARY KEY,
    groupno NUMBER NOT NULL,
    replyorder NUMBER NOT NULL,
    replydepth NUMBER NOT NULL,
    recontents VARCHAR2(1000) NOT NULL,
    replydate VARCHAR2(100) NOT NULL,
    userno NUMBER NOT NULL,
    boardno NUMBER NOT NULL,
   
    CONSTRAINT reply_userno_fk FOREIGN KEY(userno) REFERENCES USER_TABLE(userno),
    CONSTRAINT reply_boardno_fk FOREIGN KEY(boardno) REFERENCES BOARD(boardno)
);

-- 댓글 대댓글 시퀀스 생성
CREATE SEQUENCE reply_seq;

-- 13. 댓글 좋아요 테이블 생성
CREATE TABLE ReLIKE(
    relikeno NUMBER PRIMARY KEY,
    userno NUMBER NOT NULL,
    replyno NUMBER NOT NULL,
   
    CONSTRAINT relike_userno_fk FOREIGN KEY(userno) REFERENCES USER_TABLE(userno),
    CONSTRAINT relike_replyno_fk FOREIGN KEY(replyno) REFERENCES REPLY(replyno)
);

-- 댓글 좋아요 시퀀스 생성
CREATE SEQUENCE relike_seq;


-- posttype 데이터
INSERT INTO posttype VALUES(1, '예술정보게시판');
INSERT INTO posttype VALUES(2, 'PR게시판');
INSERT INTO posttype VALUES(3, '자유게시판');
INSERT INTO posttype VALUES(4, '공지사항');
INSERT INTO posttype VALUES(5, 'FAQ');