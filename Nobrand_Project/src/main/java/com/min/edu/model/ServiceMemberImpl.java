package com.min.edu.model;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.min.edu.dtos.MemberDto;

@Service
public class ServiceMemberImpl implements IServiceMember{

	@Autowired
	private IDaoMember dao;
	
	@Override
	public MemberDto login(String id) {
		return dao.login(id);
	}

	@Override
	public boolean signUp(MemberDto dto) {
		return dao.signUp(dto);
	}

	@Override
	public boolean userModify(MemberDto dto) {
		return dao.userModify(dto);
	}

	@Override
	public boolean pwChange(MemberDto dto) {
		return dao.pwChange(dto);
	}

	@Override
	public boolean signDown(String id) {
		return dao.signDown(id);
	}

	@Override
	public MemberDto idSearch(Map<String, String> map) {
		return dao.idSearch(map);
	}

	@Override
	public MemberDto pwSearch(Map<String, String> map) {
		return dao.pwSearch(map);
	}

	@Override
	public boolean idChk(String id) {
		return dao.idChk(id);
	}

	@Override
	public List<MemberDto> userList() {
		return dao.userList();
	}

	@Override
	public boolean userDelete(String id) {
		return dao.userDelete(id);
	}

	@Override
	public MemberDto myInfo(String id) {
		return dao.myInfo(id);
	}

	
	
}
