package com.shopping.todo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shopping.todo.entity.ShoppingList;
import com.shopping.todo.entity.User;

public interface ShoppingListRepo extends JpaRepository<ShoppingList, Integer> {
	 List<ShoppingList> findByUserOrderByIdDesc(User user);
}
