<!DOCTYPE html>
<%@page import="java.util.List"%>
<%@page import="com.shopping.todo.entity.ListDetails"%>
<%@page import="com.shopping.todo.entity.ShoppingList"%>
<%@page import="com.shopping.todo.payload.FullShoppingList"%>


   <%
   	 	FullShoppingList fullShoppingList = (FullShoppingList) request.getAttribute("listInfo");
   		if(fullShoppingList == null){
   			response.sendRedirect("/home");
   		}
   		
   		ShoppingList shoppingList = fullShoppingList.getShoppingList();
   		List<ListDetails> items = fullShoppingList.getItems();
   		
   %>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Shopping To Do List</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/style.css">
</head>

<body class="<%= (shoppingList.isExpired()) ? "expired" : "valid" %>">
   
   	<%@include file="partials/navbar.jsp" %>


    <div class="container">
        <div class="row">
            <div class="col-lg-12 border mx-auto rounded mt-4">
                <h1 class="text-center my-3"><%=shoppingList.getListName() %></h1>

                <div class="shopping-list-btns">

                </div>
                <!-- shopping list items -->
                <form id="my-form">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col" colspan="2"></th>
                                <th scope="col" colspan="3" class="text-center border-success border-left border-right">Planning</th>
                                <th scope="col" colspan="3" class="text-center  border-right border-primary">Actual</th>
                            </tr>
                            <tr>
                                <th scope="col">Name</th>
                                <th scope="col">Image</th>
                                <th scope="col" class="separator-left-success">Price / unit</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Total price</th>
                                <th scope="col"class="border-success border-bottom-0 border-left">Price / unit</th>
                                <th scope="col">Quantity</th>
                                <th scope="col" class="separator-right-primary">Total price</th>
                            </tr>
                        </thead>
                        <tbody class="border-bottom">
						    <%
						    	Double myBudget = 0.0;
						    
						        for (ListDetails item : items) {
						            Double price = (item.getPrice() * item.getQuantity());
						            String actualPriceValue = (item.getActualPrice() == 0) ? ""+item.getPrice() : String.valueOf(item.getActualPrice());
						            String actualQuantityValue = (item.getActualQuantity() == 0) ? "" : String.valueOf(item.getActualQuantity());
						            
						            Double actualTotalPrice = item.getActualPrice() * item.getActualQuantity();
                                    myBudget +=price;
						    %>
						    <tr>
						        <td><%= item.getName() %></td>
						        <td><img src="resources/image/productImage/<%= item.getImage() %>"
						                alt="Item Image" class="table-item-img"></td>
						        <td class="separator-left-success">$<%= item.getPrice() %> / <%= item.getUnit() %></td>
						        <td><%= item.getQuantity() %> <%= item.getUnit() %></td>
						        <td>$<%= price %></td>
								<td class="separator-left-success">
				                    <input value="<%= actualPriceValue %>" type="number" placeholder="Price"
				                        class="form-control actual-price-input" data-row-index="<%= item.getId() %>"
				                       name="items[<%=item.getId() %>].actualPrice">
				                </td>
				                								
				                <td class="d-flex">
				                    <input value="<%= actualQuantityValue %>" type="number" placeholder="Quantity"
				                        class="form-control actual-quantity-input mr-3" data-row-index="<%= item.getId() %>"
				                        name="items[<%=item.getId() %>].actualQuantity">
				                    <%=item.getUnit() %>
				                </td>								
				                <td class="separator-right-primary" data-row-index="<%= item.getId() %>">$<%=actualTotalPrice %></td>
				                <td class="d-none">
									<input type="text" hidden class="form-control" name="items[<%=item.getId() %>].id" value="<%=item.getId()%>"/>
								</td>
						    </tr>
						    <%
						        }
						    %>
						</tbody>
                    </table>
                </form>

				<div class="d-flex justify-content-between">
					<h3> Your Budget : $<%=myBudget %></h3>
					<h3> Your Expense : $<span id="totalExpense">100</span></h3>
				</div>

				<form action="/change-validity" method="post">
					<input hidden name="shoppingListId" value="<%=shoppingList.getId()%>">
					<%= (shoppingList.isExpired()) 
					? 
							"<input type='submit' class='btn btn-success my-5' value='Start Shopping Again'>" 
							: "<input type='submit' class='btn btn-danger my-5' value='Mark as Shopping Done'>" %>
				</form>

            </div>
        </div>
    </div>


    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    
    <script>
    
    
		 // Function to calculate and update totalExpense
		    function updateTotalExpense() {
		        var totalExpense = 0;
		        
		        // Iterate through all rows
		        $(".actual-price-input").each(function() {
		            var rowIndex = $(this).data("row-index");
		            var actualPriceInput = $(".actual-price-input[data-row-index='" + rowIndex + "']");
		            var actualQuantityInput = $(".actual-quantity-input[data-row-index='" + rowIndex + "']");
		            
		            var actualPrice = parseFloat(actualPriceInput.val()) || 0;
		            var actualQuantity = parseFloat(actualQuantityInput.val()) || 0;
		            
		            // Calculate row total and add to totalExpense
		            totalExpense += actualPrice * actualQuantity;
		        });
		
		        // Update the totalExpense display
		        $("#totalExpense").text(totalExpense.toFixed(2));
		    }
 
    
    
    
    
    
	    // Wait for the document to be ready
	    $(document).ready(function () {
	        // Add event listeners to actualPrice and actualQuantity input fields
	        $(".actual-price-input, .actual-quantity-input").on("input", function () {

	            var rowIndex = $(this).data("row-index");
	            var actualPriceInput = $(".actual-price-input[data-row-index='" + rowIndex + "']");
	            var actualQuantityInput = $(".actual-quantity-input[data-row-index='" + rowIndex + "']");
	            var totalPriceCell = $("td.separator-right-primary[data-row-index='" + rowIndex + "']");
		            
	            // Get actual price and quantity values
	            var actualPrice = parseFloat(actualPriceInput.val()) || 0;
	            var actualQuantity = parseFloat(actualQuantityInput.val()) || 0;
	
	           
	            // Calculate total price
	            var totalPrice = actualPrice * actualQuantity;
	
	            // Update the total price cell
	            totalPriceCell.text("$" + totalPrice.toFixed(2)); // Format the total price
				
	         // Calculate and update totalExpense
	            updateTotalExpense();
	            
	            
	         // Get the form element.
	            const form = document.getElementById('my-form');

	            // Create a new FormData object.
	            const formData = new FormData(form);

	            // Send the AJAX request to the server
	            $.ajax({
	                url: "/update-list",
	                type: "POST",
	                processData: false,  // Don't process the data
	                contentType: false,  // Don't set content type
	                data: formData,
	                success: function (response) {
	                    // Handle the server's response if needed
// 	                    console.log("AJAX request sent successfully");
	                },
	                error: function (error) {
	                    // Handle errors if necessary
// 	                    console.error(error);
	                }
	            });
	            
	        });

	        // Initial calculation of totalExpense
	        updateTotalExpense();
	    });
	</script>
    
    
    
</body>

</html>