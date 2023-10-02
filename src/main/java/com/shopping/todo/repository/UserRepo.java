package com.shopping.todo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shopping.todo.entity.User;

public interface UserRepo extends JpaRepository<User, Integer>{

	User findByEmail(String email);
	
}
