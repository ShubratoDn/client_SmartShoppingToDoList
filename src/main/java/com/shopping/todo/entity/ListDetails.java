package com.shopping.todo.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class ListDetails {

	@Id
	@GeneratedValue(strategy =  GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	private Product product;
	
	@ManyToOne
	private ShoppingList shoppingList;
	
	private String name;
	private String unit;
	private Double price;
	private Double quantity;
	private String image;	
	
	
	private Double actualPrice;
	private Double actualQuantity;
	@Override
	public String toString() {
		return "ListDetails [id=" + id + ", product=" + product + ", name=" + name + ", unit=" + unit + ", price="
				+ price + ", quantity=" + quantity + ", image=" + image + ", actualPrice=" + actualPrice
				+ ", actualQuantity=" + actualQuantity + "]";
	}
	
	
	
	
}
