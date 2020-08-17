package com.min.edu.dtos;

import java.io.Serializable;

public class MemberDto implements Serializable{
	
	private static final long serialVersionUID = -182071920621556402L;
	public String id      ;
	public String pw      ;
	public String name    ;
	public String nickname;
	public String auth    ;
	public String phone   ;
	public String birthday;
	public String address ;
	public String delflag ;
	public String regdate ;
	
	public MemberDto() {
		
	}
	
	
	//전체 조회
	public MemberDto(String id, String pw, String name, String nickname, String phone, String birthday,
			String address) {
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.nickname = nickname;
		this.phone = phone;
		this.birthday = birthday;
		this.address = address;
	}
	
	//마이페이지	
	public MemberDto(String id, String nickname, String phone, String address) {
		this.id = id;
		this.nickname = nickname;
		this.phone = phone;
		this.address = address;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDelflag() {
		return delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", pw=" + pw + ", name=" + name + ", nickname=" + nickname + ", auth=" + auth
				+ ", phone=" + phone + ", birthday=" + birthday + ", address=" + address + ", delflag=" + delflag
				+ ", regdate=" + regdate + "]";
	}
	
	

}
