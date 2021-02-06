package org.toco.study.main.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private String userId;
	private int boardCount;
	private Date boardDate;
	private String boardFile1;
	private String boardFile2;
	private MultipartFile uploadFile;
	private int replyCount;
	
	public BoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public BoardVO(int boardNo, String boardTitle, String boardContent, String userId, int boardCount,
			Date boardDate, int replyCount) {
		super();
		this.boardNo = boardNo;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.userId = userId;
		this.boardCount = boardCount;
		this.boardDate = boardDate;
		this.replyCount = replyCount;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getBoardCount() {
		return boardCount;
	}

	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}

	public Date getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}

	@Override
	public String toString() {
		return "BoardVO [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardContent=" + boardContent
				+ ", userId=" + userId + ", boardCount=" + boardCount + ", boardDate=" + boardDate + "]";
	}

	public String getBoardFile1() {
		return boardFile1;
	}

	public void setBoardFile1(String boardFile1) {
		this.boardFile1 = boardFile1;
	}

	public String getBoardFile2() {
		return boardFile2;
	}

	public void setBoardFile2(String boardFile2) {
		this.boardFile2 = boardFile2;
	}

	public MultipartFile getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

}
