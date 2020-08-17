package com.min.edu.ctrl;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.min.edu.dtos.BoardDto;
import com.min.edu.dtos.CommentsDto;
import com.min.edu.dtos.FileDto;
import com.min.edu.dtos.MemberDto;
import com.min.edu.dtos.RowNumDto;
import com.min.edu.model.BoardServiceImpl;
import com.min.edu.model.CommentsIService;
import com.min.edu.model.IBoardService;
import com.min.edu.model.IServiceMember;
import com.min.edu.util.ImgFileUtils;

@SuppressWarnings("unused")
@Controller
public class BoardController {
	
	//게시판
	@Autowired
	private IBoardService bservice;
	
	//유저 컨트롤러
	@Autowired
	private IServiceMember mservice;
	
	//댓글 컨트롤러
	@Autowired
	private CommentsIService cservice;
	
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	//전체보기 테스트
	//메인 화면
	@RequestMapping(value = "/boardList.do", method = RequestMethod.GET)
	public String boardList(Model model,BoardDto dto,RowNumDto rDto
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		
		
		List<BoardDto> gList = bservice.boardGMain();
		List<BoardDto> jList = bservice.boardJMain();
		List<BoardDto> rList = bservice.boardRMain();
		
		log.info("Welcome 공지사항:\t{}",gList); // 공지사항
		log.info("Welcome 자유:\t{}",jList); // 자유
		log.info("Welcome 리뷰:\t{}",rList); // 리뷰
		
		int total = bservice.boardAll();
		//조회수 많은 글목록(공지사항 제외)
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "10";
		}

		rDto = new RowNumDto(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		
		model.addAttribute("paging", rDto);
		model.addAttribute("readList", bservice.mainList(rDto));
//		
		
		model.addAttribute("gList",gList);
		model.addAttribute("jList",jList);
		model.addAttribute("rList",rList);
		
		return "main";
	}
	
	//게시판 리스트
	@RequestMapping(value = "/myBoardList.do",method=RequestMethod.GET)
	public String myBoardList(RowNumDto rDto, Model model
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage, String id) {
		
		int total = bservice.boardMyAll(id);
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "10";
		}
		rDto = new RowNumDto(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		rDto.setId(id);
		model.addAttribute("selectId",id);
		model.addAttribute("paging", rDto);
		model.addAttribute("lists", bservice.myBoardList(rDto));
		
		return "user/myBoardList";
	}
	
	//자유 게시판 리스트 삭제
	@RequestMapping(value = "/myBoardDel.do",method = RequestMethod.POST)
	public String myBoardDel(String[] chkval,String id, Principal principal){
		log.info("Welcome myBoardDel:\t{}",Arrays.toString(chkval));
		id = principal.getName();
		boolean isc = false;
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seq_", chkval);
		if(chkval==null) {
	         return "redirect:/myBoardList.do?id="+id;
		}
		isc = bservice.boardDelete(map);
		return "redirect:/myBoardList.do?id="+id;
	}
	
	
	//전체 게시판
	@RequestMapping(value = "/allBoardList.do",method=RequestMethod.GET)
	public String allBoardList(RowNumDto rDto, Model model
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		
		//공지사항  맨위에 추가
		List<BoardDto> gLists= bservice.boardGMain();
		model.addAttribute("gLists",gLists);
		
		
		//자유 게시판과 리뷰게시판만 보여짐
		int total = bservice.boardAll();
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "6";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "6";
		}
		rDto = new RowNumDto(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", rDto);
		model.addAttribute("lists", bservice.allBoardList(rDto));
		
		return "board/allBoardList";
	}
	
	//전체 게시판 리스트 삭제
	@RequestMapping(value = "/allBoardDel.do",method = RequestMethod.POST)
	public String allBoardDel(String[] chkval,String id, Principal principal){
		log.info("Welcome myBoardDel:\t{}",Arrays.toString(chkval));
		id = principal.getName();
		boolean isc = false;
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seq_", chkval);
		if(chkval==null) {
			return "redirect:/allBoardList.do";
		}
		isc = bservice.boardDelete(map);
		return "redirect:/allBoardList.do";
	}
	
	
	//검색 게시판 리스트
	@RequestMapping(value = "/boardSearch.do",method=RequestMethod.GET)
	public String boardSearch(RowNumDto rDto, Model model
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage, 
			@RequestParam(value="searchType", required=false, defaultValue = "title")String searchType,
			@RequestParam(value="keyword", required=false, defaultValue = "")String keyword,
			HttpServletResponse resp) throws IOException {
		
		//검색했을때 나오는 게시글의 총개수
		int total = bservice.searchCount(searchType, keyword);
		resp.setHeader("Content-Type", "text/html;charset=utf-8");
			if (total==0) {
			PrintWriter out = resp.getWriter();
				out.println("<script>alert('검색할 내용이 없습니다.');</script>");
				out.flush();
			}
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "10";
		}
		
		rDto = new RowNumDto(total,Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		rDto.searchPaging(searchType,keyword);
		rDto.setKeyword(keyword);
		
		log.info("searchType :\t{}",searchType);
		log.info("keyword :\t{}",keyword);
		log.info("총 결과 :\t{}",rDto);
		
		model.addAttribute("paging", rDto);
		model.addAttribute("lists", bservice.boardSearch(rDto, searchType, keyword));
		
		return "board/boardSearch";
	}
	
	
	
	//검색 게시판 리스트 삭제
	@RequestMapping(value = "/boardSearchDel.do",method = RequestMethod.POST)
	public String boardSearchDel(String[] chkval,String id, Principal principal, String keyword,String searchType, RowNumDto rDto){
		log.info("Welcome boardSearchDel:\t{}",Arrays.toString(chkval));
		id = principal.getName();
		boolean isc = false;
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seq_", chkval);
		if(chkval==null) {
			return "redirect:/boardSearch.do?keyword="+keyword;
		}
		isc = bservice.boardDelete(map);
		return "redirect:/boardSearch.do?keyword="+keyword;
	}
	
	
	//게시판 리스트
	@RequestMapping(value = "/boardGList.do",method=RequestMethod.GET)
	public String boardGList(RowNumDto rDto, Model model
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		List<BoardDto> lists = bservice.boardGList();
		log.info("Welcome boardGList:\t{}",lists);
//		model.addAttribute("lists",lists);
		
		int total = bservice.boardGAll();
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "10";
		}
		
		rDto = new RowNumDto(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", rDto);
		model.addAttribute("lists", bservice.boardGPaging(rDto));
		
		return "board/boardGList";
	}
	
	
	//게시판 상세보기 & 댓글 리스트
	@RequestMapping(value = "/boardGSelect.do",method=RequestMethod.GET)
	public String boardGSelect(String seq,Model model,Principal principal,HttpServletRequest req,
														HttpServletResponse resp) {
		//게시판 영역
		log.info("Welcome boardGSelect:\t{}",seq);
		BoardDto dto = bservice.boardGSelect(seq);
		model.addAttribute("bDto",dto);
		
		//파일 영역
		List<FileDto> fDto =  bservice.fileSelect(seq);
		log.info("유환{}",fDto);
		model.addAttribute("fDto",fDto);
		
		//댓글 영역
		log.info("Welcome boardGSelectComments:\t{}",seq);
		List<CommentsDto> lists = cservice.commentsList(seq);
		//seq는 board의 seq 
		
		model.addAttribute("lists",lists);
		
		//게시판 조회수 새로고침 방지
		Cookie[] cookies = req.getCookies();
		//비교를 위한 쿠키
		Cookie boardCookie = null;
		
		//쿠기가 있을 경우
		if(cookies != null && cookies.length>0) {
			for (int i = 0; i < cookies.length; i++) {
				//cookie가 cookie + seq의 값을 비교하여 일치하는 쿠키를 boardCookie에 넣어줌
				if(cookies[i].getName().equals("cookie"+seq)) {
					boardCookie = cookies[i];
				}
			}
		}
		if(seq != null) {
			model.addAttribute("seq",seq);
	            if (boardCookie == null) {    
	                // 쿠키 생성(이름, 값)
	                Cookie newCookie = new Cookie("cookie"+seq, "|" + seq + "|");
	                // 쿠키 추가
	                resp.addCookie(newCookie);
	                // 쿠키를 추가 시키고 조회수 증가시킴
	                int result = bservice.boardHit(seq);
	                
	                if(result>0) {
	                    System.out.println("조회수 증가");
	                }else {
	                    System.out.println("조회수 증가 에러");
	                }
	            }
	            // viewCookie가 null이 아닐경우 쿠키가 있으므로 조회수 증가 로직을 처리하지 않음.
	            else {
	                System.out.println("cookie 있음");
	                // 쿠키 값 받아옴.
	                String value = boardCookie.getValue();
	            }
	        }
		return "board/boardGSelect";
	}
	
	
	//댓글 입력 form
	//공지사항 게시판 댓글 입력
	@RequestMapping(value = "/boardGCommentsIn.do",method = RequestMethod.POST)
	public String boardGCommentsIn(CommentsDto cDto,int board_seq,BoardDto bDto) {
		cDto.setBoard_seq(board_seq);
		log.info("Welcome boardGCommentsIn:\t{}",board_seq);
		log.info("Welcome boardGCommentsIn:\t{}",cDto);
		boolean isc = cservice.commentsInsert(cDto);
		return isc?"redirect:/boardGSelect.do?seq="+board_seq:"redirect:/boardGList.do";
	}


	//댓글 삭제 form
	//공지사한 게시판 댓글 삭제
	@RequestMapping(value = "/commentsGDel.do",method = RequestMethod.GET)
	public String commentsGDel(String seq, Model model,String board_seq) {
		log.info("Welcome boardGCommentsIn:\t{}",seq);
		boolean isc = cservice.commentsDelete(seq);
		return isc?"redirect:/boardGSelect.do?seq="+board_seq:"redirect:/boardGList.do";
	}
	


	//게시판 리스트
	@RequestMapping(value = "/boardJList.do",method=RequestMethod.GET)
	public String boardJList(RowNumDto rDto, Model model
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
		List<BoardDto> lists = bservice.boardJList();
		log.info("Welcome boardJList:\t{}",lists);
//		model.addAttribute("lists",lists);
		
		int total = bservice.boardJAll();
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "10";
		}
		
		rDto = new RowNumDto(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", rDto);
		model.addAttribute("lists", bservice.boardJPaging(rDto));
		
		return "board/boardJList";
	}
	
	//자유 게시판 상세보기 & 댓글 리스트
	//게시판 상세보기 & 댓글 리스트
	@RequestMapping(value = "/boardJSelect.do",method=RequestMethod.GET)
	public String boardJSelect(String seq,Model model,String id, HttpServletRequest req, HttpServletResponse resp) {
		//게시판 영역
		log.info("Welcome boardJSelect:\t{}",seq);
		
		List<FileDto> fDto =  bservice.fileSelect(seq);
		log.info("유환{}",fDto);
		
		//파일 
		model.addAttribute("fDto",fDto);
		
		BoardDto dto = bservice.boardJSelect(seq);
		model.addAttribute("bDto",dto);
		
		id = dto.getId();
//		글 작성자의 조회수 가장 많은 게시물
		List<BoardDto> selLists = bservice.selList(id);
		log.info("글 작성자의 게시물:\t{}",id);
		model.addAttribute("selList",selLists);
		
		//댓글 리스트
		log.info("Welcome boardJSelectComments:\t{}",seq);
		List<CommentsDto> lists = cservice.commentsList(seq);
		//seq는 board의 seq 
		
		model.addAttribute("lists",lists);
		
		//게시판 조회수 새로고침 방지
		Cookie[] cookies = req.getCookies();
		//비교를 위한 쿠키
		Cookie boardCookie = null;
		
		//쿠기가 있을 경우
		if(cookies != null && cookies.length>0) {
			for (int i = 0; i < cookies.length; i++) {
				//cookie가 cookie + seq의 값을 비교하여 일치하는 쿠키를 boardCookie에 넣어줌
				if(cookies[i].getName().equals("cookie"+seq)) {
					boardCookie = cookies[i];
				}
			}
		}
		if(seq != null) {
			model.addAttribute("seq",seq);
	            if (boardCookie == null) {    
	                // 쿠키 생성(이름, 값)
	                Cookie newCookie = new Cookie("cookie"+seq, "|" + seq + "|");
	                // 쿠키 추가
	                resp.addCookie(newCookie);
	                // 쿠키를 추가 시키고 조회수 증가시킴
	                int result = bservice.boardHit(seq);
	                
	                if(result>0) {
	                    System.out.println("조회수 증가");
	                }else {
	                    System.out.println("조회수 증가 에러");
	                }
	            }
	            // viewCookie가 null이 아닐경우 쿠키가 있으므로 조회수 증가 로직을 처리하지 않음.
	            else {
	                System.out.println("cookie 있음");
	                // 쿠키 값 받아옴.
	                String value = boardCookie.getValue();
	            }
	        }
		
		return "board/boardJSelect";
	}
	
	
	
	//댓글 입력 form
	//자유 게시판 댓글 입력
	@RequestMapping(value = "/boardJCommentsIn.do",method = RequestMethod.POST)
	public String boardJCommentsIn(CommentsDto cDto,int board_seq,BoardDto bDto) {
		cDto.setBoard_seq(board_seq);
		log.info("Welcome boardJCommentsIn:\t{}",board_seq);
		log.info("Welcome boardJCommentsIn:\t{}",cDto);
		boolean isc = cservice.commentsInsert(cDto);
		return "redirect:/boardJSelect.do?seq="+board_seq;
	}
	
	
	//댓글 삭제 form
	//자유게시판 댓글 삭제
	@RequestMapping(value = "/commentsJDel.do",method = RequestMethod.GET)
	public String commentsJDel(String seq, Model model,String board_seq) {
		log.info("Welcome boardJCommentsIn:\t{}",seq);
		boolean isc = cservice.commentsDelete(seq);
		return isc?"redirect:/boardJSelect.do?seq="+board_seq:"redirect:/boardJList.do";
	}
	

	
	//리뷰 게시판 리스트
	@RequestMapping(value = "/boardRList.do",method=RequestMethod.GET)
		public String boardRList(RowNumDto rDto, Model model
				, @RequestParam(value="nowPage", required=false)String nowPage
				, @RequestParam(value="cntPerPage", required=false)String cntPerPage) {
			List<BoardDto> lists = bservice.boardRList();
			log.info("Welcome boardRList:\t{}",lists);
//			model.addAttribute("lists",lists);
			
			int total = bservice.boardRAll();
			if (nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "6";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if (cntPerPage == null) { 
				cntPerPage = "6";
			}
			
			
			
			rDto = new RowNumDto(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			model.addAttribute("paging", rDto);
			model.addAttribute("lists", bservice.boardRPaging(rDto));
			
			return "board/boardRList";
	}
	
	//리뷰 게시판 상세보기 & 댓글 보기
	@RequestMapping(value = "/boardRSelect.do",method=RequestMethod.GET)
	public String boardRSelect(String seq,Model model,
							String id, HttpServletRequest req, HttpServletResponse resp) {
		//게시판 영역
		log.info("Welcome boardRSelect:\t{}",seq);
		
		
		
		BoardDto dto = bservice.boardRSelect(seq);
		model.addAttribute("bDto",dto);
		
		id = dto.getId();
//		글 작성자의 조회수 가장 많은 게시물
		List<BoardDto> selLists = bservice.selList(id);
		log.info("글 작성자의 게시물:\t{}",id);
		model.addAttribute("selList",selLists);
		//댓글 리스트
		log.info("Welcome boardRSelectComments:\t{}",seq);
		List<CommentsDto> lists = cservice.commentsList(seq);
		//seq는 board의 seq 
		
		model.addAttribute("lists",lists);
		//게시판 조회수 새로고침 방지
		Cookie[] cookies = req.getCookies();
		//비교를 위한 쿠키
		Cookie boardCookie = null;
		
		//쿠기가 있을 경우
		if(cookies != null && cookies.length>0) {
			for (int i = 0; i < cookies.length; i++) {
				//cookie가 cookie + seq의 값을 비교하여 일치하는 쿠키를 boardCookie에 넣어줌
				if(cookies[i].getName().equals("cookie"+seq)) {
					boardCookie = cookies[i];
				}
			}
		}
		if(seq != null) {
			model.addAttribute("seq",seq);
	            if (boardCookie == null) {    
	                // 쿠키 생성(이름, 값)
	                Cookie newCookie = new Cookie("cookie"+seq, "|" + seq + "|");
	                // 쿠키 추가
	                resp.addCookie(newCookie);
	                // 쿠키를 추가 시키고 조회수 증가시킴
	                int result = bservice.boardHit(seq);
	                
	                if(result>0) {
	                    System.out.println("조회수 증가");
	                }else {
	                    System.out.println("조회수 증가 에러");
	                }
	            }
	            // viewCookie가 null이 아닐경우 쿠키가 있으므로 조회수 증가 로직을 처리하지 않음.
	            else {
	                System.out.println("cookie 있음");
	                // 쿠키 값 받아옴.
	                String value = boardCookie.getValue();
	            }
	        }
		//seq=board_seq	
		return "board/boardRSelect";
	}
	
	
	
	//댓글 입력 form
	//리뷰 게시판 댓글 입력
	@RequestMapping(value = "/boardRCommentsIn.do",method = RequestMethod.POST)
	public String boardRCommentsIn(CommentsDto cDto,int board_seq,BoardDto bDto) {
		cDto.setBoard_seq(board_seq);
		log.info("Welcome boardRCommentsIn:\t{}",board_seq);
		log.info("Welcome boardRCommentsIn:\t{}",cDto);
		boolean isc = cservice.commentsInsert(cDto);
		return isc?"redirect:/boardRSelect.do?seq="+board_seq:"redirect:/boardRList.do";
	}
	
	
	//댓글 삭제 form
	//리뷰 게시판 댓글 삭제
	@RequestMapping(value = "/commentsRDel.do",method = RequestMethod.GET)
	public String commentsRDel(String seq, Model model,String board_seq) {
		log.info("Welcome boardRCommentsIn:\t{}",seq);
		boolean isc = cservice.commentsDelete(seq);
		return isc?"redirect:/boardRSelect.do?seq="+board_seq:"redirect:/boardRList.do";
	}
	
	
	
	//./writeBoardPage 글 작성 페이지로 이동
	@RequestMapping(value = "/boardGWritePage.do",method = RequestMethod.GET)
	public String boardGWritePage(Principal principal,Model model,BoardDto bDto) {
		String id = principal.getName(); // 로그인 아이디
		log.info("Welcome boardGWritePage:\t{}",id);
		bDto.setId(id);
		model.addAttribute("bDto",bDto);
		return "board/boardGWritePage";
	}
	
//	./writeBoard 글작성 form
	@RequestMapping(value = "/boardGWrite.do",method = RequestMethod.POST)
	public String boardGWrite(BoardDto dto, Principal principal,Model model){
		log.info("Welcome boardGWrite:\t{}",dto);
		String id = principal.getName();
		dto.setId(id);
		boolean isc = bservice.boardGWrite(dto);
		return isc?"redirect:/boardGList.do":"redirect:/boardGWritePage.do";
	}
	
	
	//./writeBoardPage 글 작성 페이지로 이동
	@RequestMapping(value = "/boardJWritePage.do",method = RequestMethod.GET)
	public String boardJWritePage(Principal principal,Model model,BoardDto bDto) {
		String id = principal.getName(); // 로그인 아이디
		log.info("Welcome boardJWritePage:\t{}",id);
		bDto.setId(id);
		model.addAttribute("bDto",bDto);
		return "board/boardJWritePage";
	}
	
//	./writeBoard 글작성 form
	@RequestMapping(value = "/boardJWrite.do",method = RequestMethod.POST)
	public String boardJWrite(BoardDto dto, Principal principal, MultipartFile[] filename,Model model){
		log.info("Welcome boardJWrite:\t{}{}",dto,filename);
		String id = principal.getName();
		dto.setId(id);
		boolean isc = bservice.boardJWrite(dto,filename);
		String board_seq = bservice.SeqMax();
		
		return "redirect:/boardJList.do";
	}
	
	
	//./writeBoardPage 글 작성 페이지로 이동
	@RequestMapping(value = "/boardRWritePage.do",method = RequestMethod.GET)
	public String boardRWritePage(Principal principal,Model model,BoardDto bDto) {
		String id = principal.getName(); // 로그인 아이디
		log.info("Welcome boardRWritePage:\t{}",id);
		bDto.setId(id);
		model.addAttribute("bDto",bDto);
		return "board/boardRWritePage";
	}
	
//	글작성 form
	@RequestMapping(value = "/boardRWrite.do",method = RequestMethod.POST)
	public String boardRWrite(BoardDto dto, Principal principal,Model model,MultipartFile filename,FileDto fDto) throws IOException, Exception {
		log.info("Welcome boardRWrite:\t{}{}",dto,filename);
		String id = principal.getName();
		String board_seq = bservice.SeqMax();
		
		String imgPath = BoardServiceImpl.imgpath;
		
		String imgUploadPath = imgPath + File.separator+"imgPath";
		String ymdPath = ImgFileUtils.calcPath(imgUploadPath);
		
		
		log.info("imgUploadPath:\t{}",imgUploadPath);
		log.info("ymdPath:\t{}",ymdPath);
		
		String fileName = null;
		if(filename != null) {
			fileName =  ImgFileUtils.fileUpload(imgUploadPath, filename.getOriginalFilename(), filename.getBytes(), ymdPath); 
		}
		
		dto.setNbrimg("imgPath" + ymdPath + File.separator + fileName);
		dto.setThumbimg("imgPath" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		dto.setId(id);
		log.info("이미지dto:\t{}",dto);
		boolean isc = bservice.boardRWrite(dto);
		
		return "redirect:/boardRList.do";
	}
	
	//공지 글 수정 페이지
	@RequestMapping(value = "/boardGModifyPage.do",method = RequestMethod.GET)
	public String boardGModifyPage(Model model, String seq) {
		log.info("Welcome boardGModifyPage:\t{}",seq);
		BoardDto dto = bservice.boardGSelect(seq);
		dto.getId();
		dto.getSeq();
		dto.getTitle();
		dto.getContent();
		dto.getReadcount();
		dto.getRegdate();
		
		List<FileDto> fDto = bservice.fileSelect(seq);
		model.addAttribute("fDto",fDto);
		
		model.addAttribute("dto",dto);
		return "board/boardGModifyPage";
	}
	
	
	//공지 글수정 form 
	@RequestMapping(value = "/boardGModify.do", method = RequestMethod.POST)
	public String boardGModify(BoardDto dto, String seq) {
		dto.getSeq();
		boolean isc = bservice.boardGModify(dto);
		log.info("Welcome boardGModifyPage:\t{}",dto,seq);
		return "redirect:/boardGSelect.do?seq="+seq;
	}
	
	
	//자유 글 수정 페이지
	@RequestMapping(value = "/boardJModifyPage.do",method = RequestMethod.GET)
	public String boardJModifyPage(Model model, String seq) {
		log.info("Welcome boardJModifyPage:\t{}",seq);
		BoardDto dto = bservice.boardJSelect(seq);
		dto.getId();
		dto.getSeq();
		dto.getTitle();
		dto.getContent();
		dto.getReadcount();
		dto.getRegdate();
		
		//파일이 가지고 있는 리스트를 뿌려줌
		List<FileDto> fDto = bservice.fileSelect(seq);
		model.addAttribute("fDto",fDto);
		
		model.addAttribute("dto",dto);
		return "board/boardJModifyPage";
	}
	
	@RequestMapping(value = "/fileDelete.do",method = RequestMethod.GET)
	public String fileDelete(String seq,String board_seq) {
		log.info("Welcome boardGCommentsIn:\t{}",seq);
		boolean isc = bservice.fileDelete(seq);
		return "redirect:/boardJModifyPage.do?seq="+board_seq;
	}

	
	//공지 글수정 form 
	@RequestMapping(value = "/boardJModify.do", method = RequestMethod.POST)
	public String boardJModify(BoardDto dto, int seq,MultipartFile[] filename) {
		boolean isc = bservice.boardJModify(dto, filename,seq);
		log.info("Welcome boardJModifyPage:\t{},{}",dto,filename,seq);
		return "redirect:/boardJSelect.do?seq="+seq;
	}
	
	
	//리뷰 글 수정 페이지
	@RequestMapping(value = "/boardRModifyPage.do",method = RequestMethod.GET)
	public String boardRModifyPage(Model model, String seq){
		log.info("Welcome boardRModifyPage:\t{}",seq);
		BoardDto dto = bservice.boardRSelect(seq);
		
		model.addAttribute("dto",dto);
		return "board/boardRModifyPage";
	}
	
	
	//리뷰 글수정 form 
	@RequestMapping(value = "/boardRModify.do", method = RequestMethod.POST)
	public String boardRModify(BoardDto dto, String seq,HttpServletRequest req,MultipartFile filename) throws IOException, Exception {
		
		
		String imgPath = BoardServiceImpl.imgpath;
		
		 // 새로운 파일이 등록되었는지 확인
		if(filename.getOriginalFilename()!= null && !filename.getOriginalFilename().equals("")) {
		  // 기존 파일을 삭제
		new File(imgPath + req.getParameter("nbrimg")).delete();
		new File(imgPath + req.getParameter("thumbimg")).delete();
		  
		// 새로 첨부한 파일을 등록
		String imgUploadPath = imgPath +  File.separator + "imgPath";
		String ymdPath = ImgFileUtils.calcPath(imgUploadPath);
		String fileName = ImgFileUtils.fileUpload(imgUploadPath, filename.getOriginalFilename(), filename.getBytes(), ymdPath);
		  
		log.info("imgUploadPath:\t{}",imgUploadPath);
		log.info("ymdPath:\t{}",ymdPath);
		  
		dto.setNbrimg("imgPath" + ymdPath + File.separator + fileName);
		dto.setThumbimg("imgPath" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		  
		 } 
		 else {  
			 // 새로운 파일이 등록되지 않았다면
		  // 기존 이미지를 그대로 사용
		 dto.setNbrimg(req.getParameter("nbrimg"));
		 dto.setThumbimg(req.getParameter("thumbimg"));
		 }
		boolean isc = bservice.boardRModify(dto);
		log.info("Welcome boardRModifyPage:\t{},{}",dto);
		return "redirect:/boardRSelect.do?seq="+seq;
	}

	
	//관리자 or 회원 리스트에 뿌릴꺼
	//공지사항 게시판 리스트 삭제
	@RequestMapping(value = "/boardGDeleteMul.do",method = RequestMethod.POST)
	public String boardGDeleteMul(String[] chkval){
		log.info("Welcome boardGDeleteMul:\t{}",Arrays.toString(chkval));
		boolean isc = false;
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seq_", chkval);
		if(chkval==null) {
	         return "redirect:/boardGList.do";
		}
		isc = bservice.boardDelete(map);
		return "redirect:/boardGList.do";
	}
	
	
	//자유 게시판 리스트 삭제
	@RequestMapping(value = "/boardJDeleteMul.do",method = RequestMethod.POST)
	public String boardJDeleteMul(String[] chkval){
		log.info("Welcome boardJDeleteMul:\t{}",Arrays.toString(chkval));
		boolean isc = false;
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seq_", chkval);
		if(chkval==null) {
	         return "redirect:/boardJList.do";
		}
		isc = bservice.boardDelete(map);
		return "redirect:/boardJList.do";
	}
	
	
	//리뷰 게시판 리스트 삭제
	@RequestMapping(value = "/boardRDeleteMul.do",method = RequestMethod.POST)
	public String boardRDeleteMul(String[] chkval){
		log.info("Welcome boardRDeleteMul:\t{}",Arrays.toString(chkval));
		boolean isc = false;
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seq_", chkval);
		if(chkval==null) {
	         return "redirect:/boardRList.do";
		}
		isc = bservice.boardDelete(map);
		return isc?"redirect:/boardRList.do":"redirect:/boardRList.do";
	}
	
	
	//상세보기 전용 삭제
	//공지사항 상세보기 삭제
	@RequestMapping(value = "/boardGDelete.do", method = RequestMethod.GET)
	public String boardGDelete(String seq,HttpServletResponse resp) throws IOException {
		log.info("Welcome boardGDelete:\t{}",seq);
	    boolean isc = bservice.boardOneDel(seq);
		return "redirect:/boardGList.do";
	}
	
	//자유 상세보기 삭제
	@RequestMapping(value = "/boardJDelete.do", method = RequestMethod.GET)
	public String boardJDelete(String seq) {
		log.info("Welcome boardJDelete:\t{}",seq);
		boolean isc = bservice.boardOneDel(seq);
		return "redirect:/boardJList.do";
	}
	
	//리뷰 상세보기 삭제
	@RequestMapping(value = "/boardRDelete.do", method = RequestMethod.GET)
	public String boardRDelete(String seq) {
		log.info("Welcome boardRDelete:\t{}",seq);
		boolean isc = bservice.boardOneDel(seq);
		return "redirect:/boardRList.do";
	}
	

	@RequestMapping(value = "/fileDownLoad.do", method = RequestMethod.GET)
	public void fileDownload(HttpServletResponse resp, FileDto fDto,String origin_name) throws IOException {
	      log.info("파일 이름 \t{}",fDto);
	      String stored_name = fDto.getStored_name();
	      File file = new File(BoardServiceImpl.filepath+"/"+stored_name);
	      log.info("다운로드 될 파일 \t{}",file);
	      InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
	      String mimeType = URLConnection.guessContentTypeFromStream(inputStream);
	      
	      if (mimeType == null) {
	         mimeType = "application/octec-stream";
	      }
	      
	      String fileName = new String(origin_name.getBytes("UTF-8"), "ISO-8859-1");
	      resp.setHeader("Content-Disposition", "attachment; fileName=" +fileName+ ";");
	      resp.setContentType(mimeType);
	      resp.setContentLength((int) file.length());
	      //헤더에 해당 파일이 첨부 파일임을 명시
	      resp.setHeader("Content-Disposition", String.format("attachment; fileName=%s", fileName));
	      log.info(file.getName() + "@@@@@@@@@@@@@@@@@@@@@@@@@@");
	      //파일 자체를 웹브라우저에서 읽어들인다. 
	      FileCopyUtils.copy(inputStream, resp.getOutputStream());
	   }
	
	
	
	/*
	 * ckediltor 이미지 업로드
	 * ckUpload를 통해서 파일을 서버로 보냄
	 * ckImgSubmit에 받고 다시 가져와서 뿌려주는 형식
	 */
	@RequestMapping(value = "/ckUpload.do",method=RequestMethod.POST)
	public void ckUpload(HttpServletRequest req,
	            HttpServletResponse resp, MultipartHttpServletRequest multiFile
	            , @RequestParam MultipartFile upload) throws Exception{
	        // 랜덤 문자 생성
	        UUID uid = UUID.randomUUID();
	        
	        OutputStream out = null;
	        PrintWriter printWriter = null;
	        
	        //인코딩
	        resp.setCharacterEncoding("utf-8");
	        resp.setContentType("text/html;charset=utf-8");
	        
	        String fileDir = BoardServiceImpl.imgpath;
	        try{
	            
	            //파일 이름 가져오기
	            String fileName = upload.getOriginalFilename();
	            byte[] bytes = upload.getBytes();
	            
	            //이미지 경로 생성
	            String path = fileDir + "ckImage/";// fileDir는 전역 변수라 그냥 이미지 경로 설정해주면 된다.
	            String ckUploadPath = path + uid + "_" + fileName;
	            File folder = new File(path);
	            
	            //해당 디렉토리 확인
	            if(!folder.exists()){
	                try{
	                    folder.mkdirs(); // 폴더 생성
	                }catch(Exception e){
	                    e.getStackTrace();
	                }
	            }
	            
	            out = new FileOutputStream(new File(ckUploadPath));
	            out.write(bytes);
	            out.flush(); // outputStram에 저장된 데이터를 전송하고 초기화
	            
	            String callback = req.getParameter("CKEditorFuncNum");
	            printWriter = resp.getWriter();
	            String fileUrl = "./ckImgSubmit.do?uid=" + uid + "&fileName=" + fileName;  // 작성화면
	            
	        // 업로드시 메시지 출력
	          printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
	          printWriter.flush();
	            
	        }catch(IOException e){
	            e.printStackTrace();
	        } finally {
	          try {
	           if(out != null) { out.close(); }
	           if(printWriter != null) { printWriter.close(); }
	          } catch(IOException e) { e.printStackTrace(); }
	         }
	        
	        return ;
	    }
	    
	    /**
	     * cKeditor 서버로 전송된 이미지 뿌려주기
	     * @param uid
	     * @param fileName
	     * @param request
	     * @return
	     * @throws ServletException
	     * @throws IOException
	     */
	    //
	   @RequestMapping(value="/ckImgSubmit.do")
	    public void ckImgSubmit(@RequestParam(value="uid") String uid
	                            , @RequestParam(value="fileName") String fileName
	                            , HttpServletRequest request, HttpServletResponse response)
	                            			throws ServletException, IOException{
	        
	        //서버에 저장된 이미지 경로
		   	String fileDir = BoardServiceImpl.imgpath;
	        String path = fileDir + "ckImage/";
	    
	        String sDirPath = path + uid + "_" + fileName;
	    
	        File imgFile = new File(sDirPath);
	        
	        //사진 이미지 찾지 못하는 경우 예외처리로 빈 이미지 파일을 설정한다.
	        if(imgFile.isFile()){
	            byte[] buf = new byte[1024];
	            int readByte = 0;
	            int length = 0;
	            byte[] imgBuf = null;
	            
	            FileInputStream fileInputStream = null;
	            ByteArrayOutputStream outputStream = null;
	            ServletOutputStream out = null;
	            
	            try{
	                fileInputStream = new FileInputStream(imgFile);
	                outputStream = new ByteArrayOutputStream();
	                out = response.getOutputStream();
	                
	                while((readByte = fileInputStream.read(buf)) != -1){
	                    outputStream.write(buf, 0, readByte);
	                }
	                
	                imgBuf = outputStream.toByteArray();
	                length = imgBuf.length;
	                out.write(imgBuf, 0, length);
	                out.flush();
	                
	            }catch(IOException e){
	                log.info("에디터 에리 \t{}",e);
	            }finally {
	                outputStream.close();
	                fileInputStream.close();
	                out.close();
	            }
	        }
	    }
}



