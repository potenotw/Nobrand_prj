package com.min.edu.ctrl;

import java.util.ArrayList;


import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import com.min.edu.dtos.MemberDto;
import com.min.edu.model.IServiceMember;

public class SecurityController implements UserDetailsService{
	
	@Autowired
	private IServiceMember service;
	
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberDto dto = service.login(username);
		
		Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
		
		roles.add(new SimpleGrantedAuthority(dto.getAuth()));
		
		UserDetails user = new User(username,dto.getPw(),roles);
		
		return user;
	}

	
}









