package com.min.edu.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.min.edu.dtos.CommentsDto;

@Repository
public class CommentsDaoImpl implements CommentsIDao{
	
	@Autowired
	private SqlSessionTemplate session;
	
	private final String NS="com.min.edu.comments.";

	@Override
	public List<CommentsDto> commentsList(String board_seq) {
		return session.selectList(NS+"commentsList",board_seq);
	}

	@Override
	public boolean commentsInsert(CommentsDto dto) {
		int n = session.insert(NS+"commentsInsert", dto);
		return (n>0)?true:false;
	}

	@Override
	public boolean commentsDelete(String seq) {
		int n = session.update(NS+"commentsDelete", seq);
		return (n>0)?true:false;
	}

	@Override
	public CommentsDto commentsSelect(CommentsDto dto) {
		return session.selectOne(NS+"commentsSelect", dto);
		
	}
}
