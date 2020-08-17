package com.min.edu.model;

import java.io.File;
import java.io.IOException;
import java.util.List;

import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.min.edu.dtos.BoardDto;
import com.min.edu.dtos.FileDto;
import com.min.edu.dtos.RowNumDto;

@Service
public class BoardServiceImpl implements IBoardService{
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private IBoardDao dao;
	
	
	private boolean saveFile(MultipartFile[] files, int board_seq) {
		log.info("-----------------------saveFile{}{}",files,board_seq);
		boolean isc = false;
		if(files!=null) {
//			SEQ, BOARD_SEQ ,ORIGIN_NAME, STORED_NAME, FILESIZE, REGDATE, FILEPATH
			for(MultipartFile file : files) {
				String saveName = file.getOriginalFilename(); // 원래 이름
				File path = new File(filepath); // 파일이 저장되는 경로
				String fileName = UUID.randomUUID()+"-"+saveName; // db에 저장되는 이름
				if(path.isDirectory()==false) {
					path.mkdirs(); //파일 폴더가 없으면 자동 생성
				}
				File f = new File(filepath, fileName);
				try {
					file.transferTo(f); //파일업로드 경로랑 파일이름을 exception으로 오류 잡아줌
					FileDto fDto = new FileDto(); // fileDto 생성
					fDto.setBoard_seq(board_seq); //게시판 seq
					fDto.setOrigin_name(file.getOriginalFilename()); //File에 담겨져있는 기존 파일명
					fDto.setStored_name(fileName); // 저장할 filename
					fDto.setFilesize((int)file.getSize()); // 저장할 크기
					fDto.setFilepath(filepath); // 저장할 경로
					dao.fileInsert(fDto); // dao에 담아줌
				}catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return isc;
	}

	@Override
	public List<BoardDto> boardGMain() {
		log.info("boardGMain");
		return dao.boardGMain();
	}
	
	@Override
	public List<BoardDto> boardJMain() {
		log.info("boardJMain");
		return dao.boardJMain();
	}
	
	@Override
	public List<BoardDto> boardRMain() {
		log.info("boardRMain");
		return dao.boardRMain();
	}

	@Override
	public List<BoardDto> boardGList() {
		log.info("boardGList");
		return dao.boardGList();
	}

	@Override
	public BoardDto boardGSelect(String seq) {
		log.info("boardGList",seq);
		return dao.boardGSelect(seq);
	}

	@Override
	public List<BoardDto> boardJList() {
		log.info("boardJList");
		return dao.boardJList();
	}

	@Override
	public BoardDto boardJSelect(String seq) {
		log.info("boardJSelect",seq);
		return dao.boardJSelect(seq);
	}

	@Override
	public List<BoardDto> boardRList() {
		log.info("boardRList");
		return dao.boardRList();
	}

	@Override
	public BoardDto boardRSelect(String seq) {
		log.info("boardRSelect",seq);
		return dao.boardRSelect(seq);
	}

	@Override
	public boolean boardGWrite(BoardDto dto) {
		log.info("boardGWrite,{},{}\t",dto);
		boolean isc1 = dao.boardGWrite(dto);
		return (isc1)?true:false;
	}

	@Override
	public boolean boardGModify(BoardDto dto) {
		log.info("boardGModify,{}\t",dto);
		return dao.boardGModify(dto);
	}

	@Transactional
	@Override
	public boolean boardJWrite(BoardDto dto, MultipartFile[] filename) {
		log.info("boardJWrite,{},{}\t",dto,filename);
		boolean isc = dao.boardJWrite(dto);
		int seq = Integer.parseInt(dao.SeqMax());
		if(filename!=null) {
		saveFile(filename, seq);
		}
		return (isc)?true:false;
	}

	@Transactional
	@Override
	public boolean boardJModify(BoardDto dto, MultipartFile[] filename,int seq) {
		log.info("boardJModify,{},{}\t",dto,filename);
		boolean isc = dao.boardJModify(dto);
		if(filename!=null) {			
			saveFile(filename, seq);
		}
		return (isc)?true:false;
	}

	@Transactional
	@Override
	public boolean boardRWrite(BoardDto dto) {
		log.info("boardRWrite,{},{}\t",dto);
		boolean isc = dao.boardRWrite(dto);
		return (isc)?true:false;
	}
	
	@Transactional
	@Override
	public boolean boardRModify(BoardDto dto) {
		log.info("boardRModify,{}\t",dto);
		boolean isc1 = dao.boardRModify(dto);
		return (isc1)?true:false;
	}

	@Override
	public boolean boardOneDel(String seq) {
		log.info("boardDelete",seq);
		return dao.boardOneDel(seq);
	}

	@Override
	public boolean boardDelete(Map<String, String[]> map) {
		log.info("boardDelete",map);
		return dao.boardDelete(map);
	}

	@Override
	public List<BoardDto> boardGPaging(RowNumDto rDto) {
		log.info("boardGPaging,{}\t",rDto);
		return dao.boardGPaging(rDto);
	}
	
	@Override
	public List<BoardDto> boardJPaging(RowNumDto rDto) {
		log.info("boardJPaging,{}\t",rDto);
		return dao.boardJPaging(rDto);
	}
	
	@Override
	public List<BoardDto> boardRPaging(RowNumDto rDto) {
		log.info("boardRPaging,{}\t",rDto);
		return dao.boardRPaging(rDto);
	}


	@Override
	public int boardMyAll(String id) {
		log.info("boardMyAll,{}\t",id);
		return dao.boardMyAll(id);
	}

	@Override
	public int boardAll() {
		log.info("boardAll,{}\t");
		return dao.boardAll();
	}

	
	@Override
	public int boardGAll() {
		log.info("boardGAll,{}\t");
		return dao.boardGAll();
	}
	
	@Override
	public int boardJAll() {
		log.info("boardJAll,{}\t");
		return dao.boardJAll();
	}
	
	@Override
	public int boardRAll() {
		log.info("boardRAll,{}\t");
		return dao.boardRAll();
	}
	
	//파일 리스트
	@Override
	public List<FileDto> fileSelect(String board_seq) {
		log.info("fileSelect{}\t",board_seq);
		return dao.fileSelect(board_seq);
	}
	
	//파일 추가
	@Override
	public boolean fileInsert(FileDto fDto) {
		log.info("fileInsert{}\t",fDto);
		return dao.fileInsert(fDto);
	}

	
	//파일 삭제
	@Override
	public boolean fileDelete(String seq) {
		log.info("fileDelete{}\t",seq);
		return dao.fileDelete(seq);
	}

	@Override
	public String SeqMax() {
		return dao.SeqMax();
	}

	@Override
	public int boardHit(String seq) {
		return dao.boardHit(seq);
	}

	@Override
	public List<BoardDto> myBoardList(RowNumDto rDto) {
		log.info("myBoardList,{}\t",rDto);
		return dao.myBoardList(rDto);
	}
	
	@Override
	public List<BoardDto> allBoardList(RowNumDto rDto) {
		log.info("allBoardList,{}\t",rDto);
		return dao.allBoardList(rDto);
	}

	@Override
	public List<BoardDto> mainList(RowNumDto rDto) {
		log.info("mainList,{}\t",rDto);
		return dao.mainList(rDto);
	}

	@Override
	public List<BoardDto> selList(String id) {
		log.info("selList,{}\t",id);
		return dao.selList(id);
	}

	@Override
	public List<BoardDto> boardSearch(RowNumDto rDto,String searchType, String keyword) {
		log.info("boardSearch,{},{},{}\t",rDto,searchType,keyword);
		return dao.boardSearch(rDto,searchType,keyword);
	}

	@Override
	public int searchCount(String searchType, String keyword) {
		log.info("searchCount,{},{},{}\t",searchType,keyword);
		return dao.searchCount(searchType, keyword);
	}




}
