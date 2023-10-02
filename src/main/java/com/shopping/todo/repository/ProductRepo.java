package com.shopping.todo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shopping.todo.entity.Product;

public interface ProductRepo extends JpaRepository<Product, Integer>{

	List<Product> findByNameContaining(String name);
	
}
