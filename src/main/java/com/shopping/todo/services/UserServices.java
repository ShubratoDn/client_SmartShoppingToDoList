package com.shopping.todo.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.shopping.todo.entity.User;
import com.shopping.todo.repository.UserRepo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Component
public class UserServices {

	@Autowired
	private UserRepo userRepo;
	
	public User loggedUserInfo() {
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = requestAttributes.getRequest();
		HttpSession session = request.getSession();
		return (User) session.getAttribute("user");		
	}
	
	public User saveuser(User user) {
		User save = userRepo.save(user);
		return save;
	}
	
	public User getUserByEmail(String email) {
		return userRepo.findByEmail(email);
	}
	
}
