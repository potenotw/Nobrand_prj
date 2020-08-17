package com.min.edu.model;

import java.util.HashMap;
import java.util.List;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.min.edu.dtos.BoardDto;
import com.min.edu.dtos.FileDto;
import com.min.edu.dtos.RowNumDto;

@Repository
public class BoardDaoImpl implements IBoardDao{
	
	@Autowired
	private SqlSessionTemplate session;
	
	private final String NS="com.min.edu.board.";

	@Override
	public List<BoardDto> boardGMain() {
		return session.selectList(NS+"boardGMain");
	}
	
	@Override
	public List<BoardDto> boardJMain() {
		return session.selectList(NS+"boardJMain");
	}
	
	@Override
	public List<BoardDto> boardRMain() {
		return session.selectList(NS+"boardRMain");
	}

	@Override
	public List<BoardDto> boardGList() {
		return session.selectList(NS+"boardGList");
	}

	@Override
	public BoardDto boardGSelect(String seq) {
		return session.selectOne(NS+"boardGSelect",seq);
	}

	@Override
	public List<BoardDto> boardJList() {
		return session.selectList(NS+"boardJList");
	}

	@Override
	public BoardDto boardJSelect(String seq) {
		return session.selectOne(NS+"boardJSelect",seq);
	}

	@Override
	public List<BoardDto> boardRList() {
		return session.selectList(NS+"boardRList");
	}

	@Override
	public BoardDto boardRSelect(String seq) {
		return session.selectOne(NS+"boardRSelect",seq);
	}

	@Override
	public boolean boardGWrite(BoardDto dto) {
		int n = session.insert(NS+"boardGWrite",dto);
		return (n>0)?true:false;
	}

	@Override
	public boolean boardGModify(BoardDto dto) {
		int n = session.update(NS+"boardGModify",dto);
		return (n>0)?true:false;
	}

	@Override
	public boolean boardJWrite(BoardDto dto) {
		int n = session.insert(NS+"boardJWrite",dto);
		return (n>0)?true:false;
	}

	@Override
	public boolean boardJModify(BoardDto dto) {
		int n = session.update(NS+"boardJModify",dto);
		return (n>0)?true:false;
	}

	@Override
	public boolean boardRWrite(BoardDto dto) {
		int n = session.insert(NS+"boardRWrite",dto);
		return (n>0)?true:false;
	}

	@Override
	public boolean boardRModify(BoardDto dto) {
		int n = session.update(NS+"boardRModify",dto);
		return (n>0)?true:false;
	}

	@Override
	public boolean boardOneDel(String seq) {
		int n = session.update(NS+"boardOneDel",seq);
		return (n>0)?true:false;
	}

	@Override
	public boolean boardDelete(Map<String, String[]> map) {
		int n = session.update(NS+"boardDelete",map);
		return (n>0)?true:false;
	}

	@Override
	public List<BoardDto> boardGPaging(RowNumDto rDto) {
		return session.selectList(NS+"boardGPaging",rDto);
	}
	
	@Override
	public List<BoardDto> boardJPaging(RowNumDto rDto) {
		return session.selectList(NS+"boardJPaging",rDto);
	}
	
	@Override
	public List<BoardDto> boardRPaging(RowNumDto rDto) {
		return session.selectList(NS+"boardRPaging",rDto);
	}
	

	@Override
	public int boardMyAll(String id) {
		return session.selectOne(NS+"boardMyAll",id);
	}

	@Override
	public int boardAll() {
		return session.selectOne(NS+"boardAll");
	}

	@Override
	public int boardGAll() {
		return session.selectOne(NS+"boardGAll");
	}
	@Override
	public int boardJAll() {
		return session.selectOne(NS+"boardJAll");
	}
	@Override
	public int boardRAll() {
		return session.selectOne(NS+"boardRAll");
	}

	@Override
	public List<FileDto> fileSelect(String board_seq) {
		return session.selectList(NS+"fileSelect",board_seq);
	}

	@Override
	public boolean fileInsert(FileDto fDto) {
		int n = session.insert(NS+"fileInsert",fDto);
		return (n>0)?true:false;
	}

	@Override
	public boolean fileDelete(String seq) {
		int n = session.delete(NS+"fileDelete",seq);
		return (n>0)?true:false;
	}

	@Override
	public String SeqMax() {
		return session.selectOne(NS+"SeqMax");
	}

	@Override
	public int boardHit(String seq) {
		return session.update("boardHit",seq);
	}

	@Override
	public List<BoardDto> myBoardList(RowNumDto rDto){
		return session.selectList(NS+"myBoardList",rDto);
	}
	
	@Override
	public List<BoardDto> allBoardList(RowNumDto rDto){
		return session.selectList(NS+"allBoardList",rDto);
	}

	@Override
	public List<BoardDto> mainList(RowNumDto rDto) {
		return session.selectList(NS+"mainList",rDto);
	}

	@Override
	public List<BoardDto> selList(String id) {
		return session.selectList(NS+"selList",id);
	}

	@Override
	public List<BoardDto> boardSearch(RowNumDto rDto,String searchType,String keyword) {
		
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("start", rDto.getStart());
		map.put("end", rDto.getEnd());
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		return session.selectList(NS+"boardSearch",map);
	}

	@Override
	public int searchCount(String searchType, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		
		return session.selectOne(NS+"searchCount",map);
	}



}
