package com.min.edu.dtos;

public class RowNumDto {
	
	private String id;
	private int nowPage   ;//현재 페이지
	private int startPage ;//시작 페이지
	private int endPage   ;//끝 페이지
	private int total     ;//게시글 총 개수
	private int cntPerPage;//페이지 당 글 개수
	private int lastPage  ;//마지막 페이지
	private int start     ;//쿼리문 시작 
	private int end       ;//쿼리문 끝
	private int cntPage = 5;
	
	public RowNumDto() {
		
	}
	
	public RowNumDto(int total, int nowPage, int cntPerPage) {
		setNowPage(nowPage);
		setCntPerPage(cntPerPage);
		setTotal(total);
		boardLastPage(getTotal(), getCntPerPage());
		boardStartEndPage(getNowPage(), cntPage);
		boardStartEnd(getNowPage(), getCntPerPage());
	}
	// 제일 마지막 페이지 계산
	public void boardLastPage(int total, int cntPerPage) {
		setLastPage((int) Math.ceil((double)total / (double)cntPerPage));
	}
	// 시작, 끝 페이지 계산
	public void boardStartEndPage(int nowPage, int cntPage) {
		setEndPage(((int)Math.ceil((double)nowPage / (double)cntPage)) * cntPage);
		if (getLastPage() < getEndPage()) {
			setEndPage(getLastPage());
		}
		setStartPage(getEndPage() - cntPage + 1);
		if (getStartPage() < 1) {
			setStartPage(1);
		}
	}
	// DB 쿼리에서 사용할 start, end값 계산
	public void boardStartEnd(int nowPage, int cntPerPage) {
		setEnd(nowPage * cntPerPage);
		setStart(getEnd() - cntPerPage + 1);
	}
	
	//페이징시 검색창에 검색어와 키워드값을 유지
	public String searchPaging(String keyword,String searchType) {
		if(searchType.equals("")||keyword.equals("")) {
			return "";
		}
		return "searchType="+searchType+"&keyword="+keyword;
	}
	
	//페이징 키워드 검색어
	private String searchType;
	private String keyword;

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "RowNumDto [id=" + id + ", nowPage=" + nowPage + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", total=" + total + ", cntPerPage=" + cntPerPage + ", lastPage=" + lastPage + ", start=" + start
				+ ", end=" + end + ", cntPage=" + cntPage + "]";
	}

	
}




