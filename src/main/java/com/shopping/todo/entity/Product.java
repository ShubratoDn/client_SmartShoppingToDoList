package com.shopping.todo.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Product {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private String unit;
	private Double price;
	private String image;
	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", unit=" + unit + ", price=" + price + ", image=" + image
				+ "]";
	}	
	
	
	
}
