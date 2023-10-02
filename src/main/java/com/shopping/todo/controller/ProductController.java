package com.shopping.todo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.shopping.todo.entity.Product;
import com.shopping.todo.payload.ServerMessage;
import com.shopping.todo.services.ProductServices;
import com.shopping.todo.services.UserServices;

@Controller
public class ProductController {

	@Autowired
	private UserServices userServices;
	
	@Autowired
	private ProductServices productServices;

	@GetMapping("/add-product")
	public String addProductPage() {
		if (userServices.loggedUserInfo() == null) {
			return "redirect:/login";
		}
		return "add-product";
	}

	
	
	
	@PostMapping("/add-product")
	public String addProduct(@ModelAttribute Product product, MultipartFile file, Model model) {

		String productInputValidation = productServices.productInputValidation(product, file);
		if(productInputValidation != null && !productInputValidation.equals("")) {
			ServerMessage message = new ServerMessage(productInputValidation, "error", "alert-danger");
			model.addAttribute("serverMsg", message);
			return "add-product";
		}
		
		Product addProduct = productServices.addProduct(product, file);
		if(addProduct != null) {
			ServerMessage message = new ServerMessage("<li><strong>Congratulations!</strong> Your product successfully added</li>", "success", "alert-success");
			model.addAttribute("serverMsg", message);
		}
		
		return "add-product";
	}

	
	
	@GetMapping("/product/search")
	public ResponseEntity<?> getProductByName(@RequestParam(value = "name", required = false, defaultValue = "asdsgfagas") String name){
		List<Product> findByProductName = productServices.findByProductName(name);		
		return ResponseEntity.ok(findByProductName);
	}
	
	
}
