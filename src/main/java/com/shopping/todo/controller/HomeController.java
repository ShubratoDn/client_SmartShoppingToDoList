package com.shopping.todo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shopping.todo.payload.ListOverview;
import com.shopping.todo.services.ListServices;
import com.shopping.todo.services.UserServices;

@Controller
public class HomeController {

	@Autowired
	private UserServices userServices;

	@Autowired
	private ListServices listServices;

	@GetMapping(value = { "/", "/home" })
	public String home(Model model) {
		if (userServices.loggedUserInfo() == null) {
			return "redirect:/login";
		}

		List<ListOverview> myFullList = listServices.getAllActiveList();
		model.addAttribute("validShoppingList", myFullList);		
		return "index";
	}

	
	
	@GetMapping(value = { "/history" })
	public String history(Model model) {
		if (userServices.loggedUserInfo() == null) {
			return "redirect:/login";
		}

		List<ListOverview> myFullList = listServices.getMyFullList();
		model.addAttribute("validShoppingList", myFullList);		
		return "history";
	}

	
	
	
	
}
