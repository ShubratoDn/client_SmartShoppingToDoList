package com.shopping.todo.payload;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ListOverview {

	private int id;
	private String title;
	private String date;
	private Double totalAmount;
	private Long totalItem;
	private boolean isExpired;
	
}
