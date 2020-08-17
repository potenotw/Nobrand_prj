package com.min.edu.ctrl;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.min.edu.dtos.BoardDto;
import com.min.edu.dtos.MemberDto;
import com.min.edu.model.IServiceMember;

@Controller
public class MemberController {

	@Autowired
	private IServiceMember service;
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private PasswordEncoder pwEncoder;

	// 로그인 페이지로 가는 매핑
	@RequestMapping(value = "/loginPage.do", method = RequestMethod.GET)
	public String login(@RequestParam(value = "error", required = false) String error,
	@RequestParam(value = "logout", required = false) String logout, Model model,
													HttpServletResponse resp, Authentication user ) throws IOException {
	log.info("Welcome login:\t{}",new Date());
	//로그인 성공시
	if(user != null) {
		UserDetails userD = (UserDetails) user.getPrincipal();
		model.addAttribute("user",userD.toString());		
	}
	//로그인 실패
	//print로 출력하는 script 코드를 utf-8로 출력
	resp.setHeader("Content-Type", "text/html;charset=utf-8");
	if (error != null) {
		PrintWriter out = resp.getWriter();
			out.println("<script>alert('아이디 또는 비밀번호를 확인해주세요'); location.href='./loginPage.do'</script>");
			out.flush();
			return null;
		}
	return "login";
	}
	

	//로그인 완료 후 메인 페이지로 가는 매핑
	@RequestMapping(value = "/loginChk.do", method = RequestMethod.GET)
	public String loginMain(Principal principal, Model model) {
		String id = principal.getName();
		log.info("Welcome loginMain:\t{}",id);
		MemberDto dto = service.login(id);
		model.addAttribute("mdto",dto);
		return "redirect:/boardList.do";
	}
	
	//회원가입으로 가는 매핑 views
	@RequestMapping(value = "/signUpPage.do", method = RequestMethod.GET)
	public String signUp() {
		log.info("Welcome signUp:\t{}");
		return "signUp";
	}
	// 회원가입 성공 매핑
	@RequestMapping(value = "/signUp.do", method = RequestMethod.POST)
	public String sign(MemberDto dto) {
		log.info("Welcome sign:\t{}",dto);
		service.signUp(dto);
		return "redirect:/loginPage.do";
	}
	
	///errorPage.do
	//에러
	@RequestMapping(value = "/errorPage.do", method = RequestMethod.GET)
	public String AuthError(MemberDto dto, Model model) {
		log.info("Welcome AuthError:\t{}",dto);
		return "errorPage";
	}
	
	//회원 리스트 page
	@RequestMapping(value = "/userList.do", method = RequestMethod.GET)
	public String userList(Model model) {
		List<MemberDto> lists = service.userList();
		log.info("Welcome userList:\t{}",lists);
		model.addAttribute("lists",lists);
		return "admin/userList";
	}
	
	//마이페이지
	@RequestMapping(value = "/myInfo.do", method = RequestMethod.GET)
	public String myInfo(Model model,Principal principal) {
		String id = principal.getName();
		log.info("Welcome myInfo:\t{}",id);
		MemberDto dto = service.myInfo(id);
		model.addAttribute("mdto",dto);
		return "user/myInfo";
	}
	
	//유저 정보 수정
	@RequestMapping(value = "/userModify.do", method = RequestMethod.GET)
	public String userModify(Model model,Principal principal) {
		String id = principal.getName();
//		NAME,NICKNAME,AUTH,PHONE,BIRTHDAY ,ADDRESS,REGDATE
		MemberDto dto = service.myInfo(id);
		String name = dto.getName();
		String nickname = dto.getNickname();
		String auth = dto.getAuth();
		String phone = dto.getPhone();
		String birthday = dto.getBirthday();
		String address = dto.getAddress();
		String regdate = dto.getRegdate();
		model.addAttribute("name",name);
		model.addAttribute("nickname",nickname);
		model.addAttribute("auth",auth);
		model.addAttribute("phone",phone);
		model.addAttribute("birthday",birthday);
		model.addAttribute("address",address);
		model.addAttribute("regdate",regdate);
		return "user/userModify";
	}
	
	//유저 수정 form
	@RequestMapping(value = "/modifyForm.do",method = RequestMethod.POST)
	public String modifyForm(Principal principal, MemberDto dto) {
		String id = principal.getName();
		dto.setId(id);
		service.userModify(dto);
		log.info("Welcome modifyForm:\t{}",dto,id);
		return "redirect:/myInfo.do";
	}
	
	//회월탈퇴(유저) 페이지
	@RequestMapping(value = "/signDownPage.do",method = RequestMethod.GET)
	public String signDownPage(Principal principal) {
		String id = principal.getName();
		log.info("Welcome signDownPage:\t{}",id);
		return "user/signDownPage";
	}
	
	//회원탈퇴(유저)
	@RequestMapping(value = "/signDown.do",method = RequestMethod.GET)
	public String signDown (String id){
		log.info("signDown id = :\t{}",id);
		boolean isc = service.signDown(id);
		return isc?"user/myInfo":"user/signDownPage";
	}
	
	
	
	//아이디 중복체크 
	@RequestMapping(value = "/idChk.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> idChk(String id) {
		Map<String, String> map = new HashMap<String, String>();
		log.info("Welcome idChk:\t{}",id);
		boolean isc = service.idChk(id);
		map.put("isc", isc+"");
		return map;
	}
	
	//아이디 찾기 , 비밀번호 찾기 page
	@RequestMapping(value = "/searchPage.do",method = RequestMethod.GET)
	public String searchPage() {
		return "searchPage";
	}

	//아이디 찾기 ./idSearch.do
	@RequestMapping(value = "/idSearch.do", method = RequestMethod.GET)
	public String idSearch(MemberDto mDto,Model model, HttpServletResponse resp,
					String name, String birthday) throws IOException{
		Map<String, String> map = new HashMap<String, String>();
		log.info("Welcome idSearch:\t{},{}",name,birthday);
		map.put("name", name);
		map.put("birthday", birthday);
		resp.setHeader("Content-Type", "text/html;charset=utf-8");
		mDto = service.idSearch(map);
		if(mDto==null) {
			PrintWriter out = resp.getWriter();
				out.println("<script>alert('아이디를 찾을 수 없습니다.'); location.href='./searchPage.do'</script>");
				out.flush();
				return null;
		}else {
			PrintWriter out = resp.getWriter();
			out.println("<script>alert('아이디를 찾았습니다!')</script>");
			out.flush();
			model.addAttribute("mDto",mDto);
			return "idUse";
		}
	}
	
	@RequestMapping(value = "/idUse", method = RequestMethod.GET)
	public String idUse() {
		return "idUse";
	}
	

	
	//비밀번호 찾기
	@RequestMapping(value = "/pwSearch.do", method = RequestMethod.POST)
	public String pwSearch(MemberDto dto, Model model, String id, String phone,HttpServletResponse resp) throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		log.info("Welcome pwSearch:\t{}",id,phone);
		map.put("id", id);
		map.put("phone", phone);
		MemberDto mDto = service.pwSearch(map);
		resp.setHeader("Content-Type", "text/html;charset=utf-8");
		mDto = service.pwSearch(map);
		if(mDto==null) {
			PrintWriter out = resp.getWriter();
				out.println("<script>alert('해당 아이디의 정보가 일치하지 않습니다.'); location.href='./pwSearchPage.do'</script>");
				out.flush();
				return null;
		}else {
			PrintWriter out = resp.getWriter();
			out.println("<script>alert('새로운 비밀번호를 입력해주세요.')</script>");
			out.flush();
			return "pwUse";
		}
	}
	
	
	//비밀번호 찾기 페이지로 이동
	@RequestMapping(value = "/pwSearchPage.do", method = RequestMethod.GET)
	public String pwSearchPage() {
		return "pwSearchPage";
	}
	
	//비밀번호 변경
	@RequestMapping(value = "/pwUse.do", method = RequestMethod.POST)
	public String pwUse(String pw,String id,MemberDto dto) {
		log.info("Welcome pwUse:\t{}",id,pw,dto);
		dto.setId(id);
		dto.setPw(pw);
		boolean isc = service.pwChange(dto);
		return isc?"redirect:/loginPage.do":"redirect:/pwSearchPage.do";
	}
	
	//회원 관리 (탈퇴)
	@RequestMapping(value = "/userDelete.do", method = RequestMethod.GET)
	public String userDelete(String id) {
		log.info("Welcome userDelete:\t{}",id);
		boolean isc = service.userDelete(id);
		return "redirect:/userList.do";	
	}
}








