package com.min.edu.model;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.min.edu.dtos.CommentsDto;

@Service
public class CommentsServiceImpl implements CommentsIService{
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CommentsIDao dao;

	
	@Override
	public List<CommentsDto> commentsList(String board_seq) {
		log.info("commentsList",board_seq);
		return dao.commentsList(board_seq);
	}

	@Override
	public boolean commentsInsert(CommentsDto dto) {
		log.info("commentsInsert",dto);
		return dao.commentsInsert(dto);
	}

	@Override
	public boolean commentsDelete(String seq) {
		log.info("commentsDelete",seq);
		return dao.commentsDelete(seq);
	}

	@Override
	public CommentsDto commentsSelect(CommentsDto dto) {
		log.info("commentsSelect",dto);
		return dao.commentsSelect(dto);
	}


	
	

}
