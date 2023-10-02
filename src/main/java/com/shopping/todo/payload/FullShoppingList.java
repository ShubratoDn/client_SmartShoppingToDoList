package com.shopping.todo.payload;

import java.util.List;

import com.shopping.todo.entity.ListDetails;
import com.shopping.todo.entity.ShoppingList;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FullShoppingList {

	private ShoppingList shoppingList;
	private List<ListDetails> items;	
	
}
