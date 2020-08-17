package com.min.edu.model;

import java.util.List;

import com.min.edu.dtos.CommentsDto;

public interface CommentsIDao {
	
	//댓글 리스트 (board 상세보기)
	public List<CommentsDto> commentsList(String board_seq);
	
	//댓글 입력
	public boolean commentsInsert(CommentsDto dto);
	
	//삭제
	public boolean commentsDelete(String seq);
	
	//입력 form
	public CommentsDto commentsSelect(CommentsDto dto);


}
