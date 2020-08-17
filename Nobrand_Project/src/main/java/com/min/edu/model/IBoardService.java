package com.min.edu.model;


import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.min.edu.dtos.BoardDto;
import com.min.edu.dtos.FileDto;
import com.min.edu.dtos.RowNumDto;

public interface IBoardService {
	
	//MainPage
	public List<BoardDto> boardGMain();
	public List<BoardDto> boardJMain();
	public List<BoardDto> boardRMain();
	// 메인 페이지 조회수 많은 글
	public List<BoardDto> mainList(RowNumDto rDto);
	
	//나의 게시글 리스트
	public List<BoardDto> myBoardList(RowNumDto rDto);

	//게시판 전체 조회
	public List<BoardDto> allBoardList(RowNumDto rDto);
	
	//검색 구현
	public List<BoardDto> boardSearch(RowNumDto rDto,String searchType, String keyword);
	
	//검색한 글개수
	public int searchCount(String searchType, String keyword);
	
	//유저 게시글 상세보기의 해당 유저 조회수 많은 글목록
	public List<BoardDto> selList(String id);
	
	//일반 파일 업로드 경로
	public static final String filepath = "C:/nobrand/workspace_spring/Nobrand_Project/src/main/webapp/resources";
	
	//이미지 파일 업로드 경로
	public static final String imgpath = "C:/Users/nyhhy/eclipse-workspace_spring/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Nobrand_Project/";
	
	
	
	//공지 게시판 전체보기
	//공지 게시판 상세보기
	public List<BoardDto> boardGList();
	public BoardDto boardGSelect(String seq);

	
	//자유게시판 전체보기
	//자유게시판 상세보기
	public List<BoardDto> boardJList();
	public BoardDto boardJSelect(String seq);
	
	//리뷰 게시판 전체보기
	public List<BoardDto> boardRList();
	//리뷰 게시판 상세보기
	public BoardDto boardRSelect(String seq);
	

	//공지사항 게시판 글쓰기
	//공지사항 게시판 글수정
	public boolean boardGWrite(BoardDto dto);
	public boolean boardGModify(BoardDto dto);
	//자유 게시판 글쓰기
	//자유  게시판 글수정
	public boolean boardJWrite(BoardDto dto, MultipartFile[] filename);
	public boolean boardJModify(BoardDto dto, MultipartFile[] filename,int seq);
	
	//리뷰 게시판 글쓰기
	//리뷰 게시판 글수정
	public boolean boardRWrite(BoardDto dto);
	public boolean boardRModify(BoardDto dto);
	
	//글삭제(delplag)
	public boolean boardOneDel(String seq);
	//다중 글 삭제
	public boolean boardDelete(Map<String, String[]> map);
	
	//페이징 
	public List<BoardDto> boardGPaging(RowNumDto rDto);
	public List<BoardDto> boardJPaging(RowNumDto rDto);
	public List<BoardDto> boardRPaging(RowNumDto rDto);
	
	//게시글 전체 개수(유저)
	public int boardMyAll(String id);
	public int boardAll();
	public int boardGAll();
	public int boardJAll();
	public int boardRAll();
	
	//파일 보기 리스트
	public List<FileDto> fileSelect(String board_seq);
	
	//파일 저장
	public boolean fileInsert(FileDto fDto);
	
	//파일 삭제
	public boolean fileDelete(String seq);

	//파일업로드 게시물 seq최대값
	public String SeqMax();
	
	//조회수
	public int boardHit(String seq);

	
}
