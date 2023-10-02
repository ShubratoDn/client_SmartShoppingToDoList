package com.shopping.todo.services;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.shopping.todo.entity.ListDetails;
import com.shopping.todo.entity.ShoppingList;
import com.shopping.todo.entity.User;
import com.shopping.todo.payload.FullShoppingList;
import com.shopping.todo.payload.ListOverview;
import com.shopping.todo.repository.ListDetailsRepo;
import com.shopping.todo.repository.ShoppingListRepo;

@Component
public class ListServices {

	@Autowired
	private ShoppingListRepo shoppingListRepo;
	
	@Autowired
	private UserServices userServices;
	
	@Autowired
	private ListDetailsRepo listDetailsRepo;
	
	public ShoppingList addShoppingList(String listName) {
				ShoppingList list = new ShoppingList();
		list.setListName(listName);
		list.setUser(userServices.loggedUserInfo());
		list.setExpired(false);
		list.setLastUpdated(new Date());
		
		ShoppingList save = shoppingListRepo.save(list);		
		return save;
	}
	
	
	
	
	public void addFullList(List<ListDetails> list, ShoppingList shoppingList) {
		for(ListDetails item : list) {
			item.setShoppingList(shoppingList);
			listDetailsRepo.save(item);
		}
	}
	
	
	
	public List<ListOverview> getMyFullList() {		
		User user = userServices.loggedUserInfo();		
		List<ShoppingList> findByUser = shoppingListRepo.findByUserOrderByIdDesc(user);
		
		List<ListOverview> listOverview = new ArrayList<>();
		
		for(ShoppingList list : findByUser) {			
			ListOverview overview = new ListOverview();
			
			Map<String, Object> result = listDetailsRepo.calculateTotalPriceAndItems(list.getId());
			Long totalItems = (Long) result.get("total_items");
			Double totalPrice = (Double) result.get("total_price");			

			// Create a SimpleDateFormat object with the desired format
	        SimpleDateFormat sdf = new SimpleDateFormat("dd - MM - yyyy; h:mm a");

	        // Format the date as a string
	        String formattedDate = sdf.format(list.getLastUpdated());

			overview.setId(list.getId());
			overview.setTitle(list.getListName());
			overview.setDate(formattedDate);
			overview.setTotalAmount(totalPrice);
			overview.setTotalItem(totalItems);
			overview.setExpired(list.isExpired());
			
			listOverview.add(overview);
		}
		
		return listOverview;
	}
	
	
	
	
	
	
	
	
	
	
	
	public FullShoppingList getShoppingListItems(int shoppingListId){
		
		Optional<ShoppingList> optionalShoppingList = shoppingListRepo.findById(shoppingListId);		
		ShoppingList shoppingList = null;
		User loggedUserInfo = userServices.loggedUserInfo();
		
		
		if (!optionalShoppingList.isPresent()) {
		    return null;
		 }else {
			  shoppingList = optionalShoppingList.get();
			  if(loggedUserInfo.getId() != shoppingList.getUser().getId()) {
				  return null;
			  }
		 }
		
		
		List<ListDetails> findByShoppingList = listDetailsRepo.findByShoppingList(shoppingList);
		
		FullShoppingList fullShoppingList = new FullShoppingList();
		
		fullShoppingList.setShoppingList(shoppingList);
		fullShoppingList.setItems(findByShoppingList);		
		
		return fullShoppingList;
	}
	
	
	
	
}
