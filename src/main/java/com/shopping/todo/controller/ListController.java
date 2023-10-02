package com.shopping.todo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shopping.todo.entity.ListDetails;
import com.shopping.todo.entity.ShoppingList;
import com.shopping.todo.payload.FullShoppingList;
import com.shopping.todo.payload.ListForm;
import com.shopping.todo.payload.ServerMessage;
import com.shopping.todo.services.ListServices;
import com.shopping.todo.services.UserServices;

@Controller
public class ListController {

	@Autowired
	private UserServices userServices;
	
	@Autowired
	private ListServices listServices;
	
	
	@GetMapping("/add-list")
	public String addListPage() {
		if(userServices.loggedUserInfo() == null) {
			return "redirect:/login";
		}
		return "add-list";
	}
	
	
	@GetMapping("/list")
	public String listPage(@RequestParam int id, Model model) {
		if(userServices.loggedUserInfo() == null) {
			return "redirect:/login";
		}
		
		
		FullShoppingList shoppingListItems = listServices.getShoppingListItems(id);
		if(shoppingListItems == null) {
			return "redirect:/home";
		}
		
		model.addAttribute("listInfo", shoppingListItems);
		return "list";
	}
	
	
		
	@PostMapping("/add-list")
	public String addList(@ModelAttribute ListForm listForm, Model model) {
		
		 // Remove objects with null or empty name from the list
	    listForm.getItems().removeIf(item -> item.getName() == null || item.getName().isEmpty());

	    if(listForm.getListTitle() == null || listForm.getListTitle().equals("")) {
	    	listForm.setListTitle("No title");	    	
	    }
	    
	    System.out.println(listForm.getItems().size());
	    
	    for(ListDetails details : listForm.getItems()){
	    	System.out.println(details.getName());
	    	System.out.println(details.getImage());
	    	System.out.println("");
	    }
	    
	    	    
	    ShoppingList addedShoppingList = listServices.addShoppingList(listForm.getListTitle());
	    
	    listServices.addFullList(listForm.getItems(), addedShoppingList);
	    
	    ServerMessage serverMessage = new ServerMessage("<li>Congratulation!! Your list has been added to your list</li>", "success", "alert-success");
	    
	    model.addAttribute("serverMsg", serverMessage);
		
		return "add-list";
	}
	
	
	
	
	
	
	
	
	@PostMapping("/update-list")
	public void updateList(@ModelAttribute ListForm listForm, Model model) {
		System.out.println("REQUEST FOUND");
	    List<ListDetails> updatedListDetails = listForm.getItems();
	    System.out.println(updatedListDetails.size());
	    
	    listForm.getItems().removeIf(item -> item.getId() == 0);
	    
	    for(ListDetails details: updatedListDetails) {	  
	    	if(details.getActualPrice() == null) {
	    		details.setActualPrice(0.0);
	    	}
	    	listServices.updateListDetails(details);	    	
	    }
	    
//	    return ""; // Redirect to a success page after processing
	}



	
	
	
}
