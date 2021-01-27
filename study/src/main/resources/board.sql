CREATE TABLE board(
    board_no NUMBER PRIMARY KEY,
    board_title VARCHAR2(100) NOT NULL,
    board_content VARCHAR2(100) NOT NULL,
    user_id VARCHAR2(100) NOT NULL,
    board_count NUMBER DEFAULT 0,
    board_date DATE DEFAULT SYSDATE,
    board_file1 VARCHAR2(200),
    board_file2 VARCHAR2(200)
)

CREATE SEQUENCE board_seq

INSERT INTO board(board_no,board_title,board_content,user_id) VALUES(board_seq.NEXTVAL,'샘플1','샘플입니다','toco')