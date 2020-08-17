package com.min.edu.model;

import java.util.List;
import java.util.Map;

import com.min.edu.dtos.MemberDto;

public interface IDaoMember {
	
	//로그인
	public MemberDto login(String id);
	
	//회원 가입
	public boolean signUp(MemberDto dto);
	
	//마이페이지
	public MemberDto myInfo(String id);
	
	//회원 정보수정
	public boolean userModify(MemberDto dto);
	
	//비밀번호 수정
	public boolean pwChange(MemberDto dto);
	
	//회원 탈퇴
	public boolean signDown(String id);
	
	//아이디 찾기
	public MemberDto idSearch(Map<String, String> map);	
	
	//비밀번호 찾기
	public MemberDto pwSearch(Map<String, String> map);
	
	//아이디 중복체크
	public boolean idChk(String id);
	
	//회원리스트
	public List<MemberDto> userList();
	
	//관리자 회원탈퇴
	public boolean userDelete(String id);
	

}
