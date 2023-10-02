package com.shopping.todo.payload;

import java.util.List;

import com.shopping.todo.entity.ListDetails;

public class ListForm {
    private String listTitle;
    private List<ListDetails> items;

    // Getter and Setter methods for listTitle and items

    public String getListTitle() {
        return listTitle;
    }

    public void setListTitle(String listTitle) {
        this.listTitle = listTitle;
    }

    public List<ListDetails> getItems() {
        return items;
    }

    public void setItems(List<ListDetails> items) {
        this.items = items;
    }

	@Override
	public String toString() {
		return "ListForm [listTitle=" + listTitle + ", items=" + items + "]";
	}
    
    
    
}
