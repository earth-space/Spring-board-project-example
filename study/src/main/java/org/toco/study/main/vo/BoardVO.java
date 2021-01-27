package org.toco.study.main.vo;

public class BoardVO {
	private String boardNo;
	private String boardTitle;
	private String boardContent;
	private String userId;
	private int boardCount;
	private String boardDate;

	public BoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BoardVO(String boardNo, String boardTitle, String boardContent, String userId, int boardCount,
			String boardDate) {
		super();
		this.boardNo = boardNo;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.userId = userId;
		this.boardCount = boardCount;
		this.boardDate = boardDate;
	}

	public String getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(String boardNo) {
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

	public String getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}

	@Override
	public String toString() {
		return "BoardVO [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardContent=" + boardContent
				+ ", userId=" + userId + ", boardCount=" + boardCount + ", boardDate=" + boardDate + "]";
	}

}
