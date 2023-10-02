package com.shopping.todo.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.shopping.todo.entity.ListDetails;
import com.shopping.todo.entity.ShoppingList;

public interface ListDetailsRepo extends JpaRepository<ListDetails, Integer> {

	 @Query(value = "SELECT SUM(ld.price * ld.quantity) AS total_price, COUNT(*) AS total_items " +
             "FROM list_details AS ld " +
             "WHERE ld.shopping_list_id = ?1", nativeQuery = true)
	 Map<String, Object> calculateTotalPriceAndItems(int shoppingListId);

	
	 List<ListDetails> findByShoppingList(ShoppingList shoppingList);
	 	 
	 ListDetails findById(int id);
	 
}
