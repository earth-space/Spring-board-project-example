package org.toco.study.main.vo;

public class PageVO {
	
	// 현재 페이지, 시작 페이지, 끝 페이지, 게시글 총 갯수, 페이지당 글 갯수, 마지막 페이지, SQL에 쓸 start, end
	private int nowPage, startPage, endPage, total, cntPerPage, lastPage, start, end;
	
	//페이지 목록 개수
	private int cntPage = 5;
	
	public PageVO() {
	
	}
	
	public PageVO(int total, int nowPage, int cntPerPage) {
		setNowPage(nowPage);
		setCntPerPage(cntPerPage);
		setTotal(total);
		
		//목록이 몇개 생성되어야 할지 계산
		calcLastPage(getTotal(), getCntPerPage());
		calcStartEndPage(getNowPage(), cntPage);
		calcStartEnd(getNowPage(), getCntPerPage());
	}
	
	// 제일 마지막 페이지 계산
	public void calcLastPage(int total, int cntPerPage) {
		setLastPage((int)Math.ceil((double)total / (double)cntPerPage)); //소수점 자리 올림 (ceil)
	}
	
	// 시작, 끝 페이지 계산
	public void calcStartEndPage(int nowPage, int cntPage) {
		setEndPage(((int)Math.ceil((double)nowPage / (double)cntPage)) * cntPage);
		
		if (getLastPage() < getEndPage()) {
			setEndPage(getLastPage());
		}
		
		setStartPage(getEndPage() - cntPage + 1);
		
		if (getStartPage() < 1) {
			setStartPage(1);
		}
	}
	
	// SQL에서 사용할 start, end값 계산
	public void calcStartEnd(int nowPage, int cntPerPage) {
		setEnd(nowPage * cntPerPage);
		setStart(getEnd() - cntPerPage + 1);
	}
	
	public int getNowPage() {
		return nowPage;
	}
	
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	public int getTotal() {
		return total;
	}
	
	public void setTotal(int total) {
		this.total = total;
	}
	
	public int getCntPerPage() {
		return cntPerPage;
	}
	
	public void setCntPerPage(int cntPerPage) {
		this.cntPerPage = cntPerPage;
	}
	
	public int getLastPage() {
		return lastPage;
	}
	
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	
	public int getEnd() {
		return end;
	}
	
	public void setEnd(int end) {
		this.end = end;
	}	
	
	public int setCntPage() {
		return cntPage;
	}
	
	public void getCntPage(int cntPage) {
		this.cntPage = cntPage;
	}
	
	@Override
	public String toString() {
		return "PagingVO [nowPage=" + nowPage + ", startPage=" + startPage + ", endPage=" + endPage + ", total=" + total
				+ ", cntPerPage=" + cntPerPage + ", lastPage=" + lastPage + ", start=" + start + ", end=" + end
				+ ", cntPage=" + cntPage + "]";
	}
}
