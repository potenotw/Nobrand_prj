package com.min.edu.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.min.edu.dtos.MemberDto;

@Repository
public class DaoMemberImpl implements IDaoMember{

	@Autowired
	private SqlSessionTemplate session;
	private final String NS="com.min.edu.member.";
	
	@Autowired
	private PasswordEncoder pwEncoder;
	
	@Override
	public MemberDto login(String id) {
		return session.selectOne(NS+"login",id);
	}

	@Override
	public boolean signUp(MemberDto dto) {
		String enPw = pwEncoder.encode(dto.getPw());
		dto.setPw(enPw);
		return session.insert(NS+"signUp",dto) > 0?true:false;
	}

	@Override
	public boolean userModify(MemberDto dto) {
		int n = session.update(NS+"userModify",dto);
		return (n>0)?true:false;
	}

	@Override
	public boolean pwChange(MemberDto dto) {
		String enPw = pwEncoder.encode(dto.getPw());
		dto.setPw(enPw);
		return session.update(NS+"pwChange",dto) > 0?true:false;
	}

	@Override
	public boolean signDown(String id) {
		int n = session.update(NS+"signDown",id);
		return (n>0)?true:false;
	}

	@Override
	public MemberDto idSearch(Map<String, String> map) {
		return session.selectOne(NS+"idSearch",map);
	}

	@Override
	public MemberDto pwSearch(Map<String, String> map) {
		return session.selectOne(NS+"pwSearch",map);
	}

	@Override
	public boolean idChk(String id) {
		int n = session.selectOne(NS+"idChk",id);
		return (n>0)?true:false;
	}

	@Override
	public List<MemberDto> userList() {
		return session.selectList(NS+"userList");
	}

	@Override
	public boolean userDelete(String id) {
		int n = session.update(NS+"userDelete",id);
		return (n>0)?true:false;
	}

	@Override
	public MemberDto myInfo(String id) {
		return session.selectOne(NS+"myInfo",id);
	}


}
