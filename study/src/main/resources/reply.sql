CREATE TABLE reply(
    board_no NUMBER,
	reply_no NUMBER,
	reply_writer VARCHAR2(100),
	reply_content VARCHAR2(100),
	reply_date DATE DEFAULT SYSDATE,
	PRIMARY KEY(board_no, reply_no)
)

ALTER TABLE reply ADD CONSTRAINT reply_no FOREIGN KEY(board_no) REFERENCES board(board_no)

CREATE SEQUENCE reply_seq
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 100
	MINVALUE 100
	NOCACHE
	NOCYCLE