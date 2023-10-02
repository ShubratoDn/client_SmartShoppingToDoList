<!DOCTYPE html>
<%@page import="com.shopping.todo.payload.ServerMessage"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Shopping To Do List</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/style.css">
</head>

<body>
    
    <%@include file="partials/navbar.jsp" %>

    <div class="container">
        <div class="row">
            <div class="col-lg-10 border mx-auto rounded mt-4">
                <h1 class="text-center my-3">Add New List</h1>
                
                <%
                	ServerMessage sm = (ServerMessage) request.getAttribute("serverMsg");
                	if(sm != null){	
                %>
                <div class="alert <%=sm.getCss() %> alert-dismissible fade show" role="alert">                    
                   <ul>
                   	 <%=sm.getMessage() %>
                   </ul>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <%                
                	}
                %>
                
					<form action="/add-list" method="POST">
					    <input type="text" name="listTitle" placeholder="Insert List title" class="form-control mb-4">
					    
					    <table class="table">
					        <thead>
					            <tr>
					                <th scope="col">Item Name</th>
					                <th scope="col">Image</th>
					                <th scope="col">Unit name</th>
					                <th scope="col">Price / Unit</th>
					                <th scope="col">Quantity</th>
					                <th scope="col">Total Amount</th>
					            </tr>
					        </thead>
					        <tbody>
					            <!-- This row will serve as a template for new rows -->
					            <tr class="item-row-template">
					                <td class="product_suggestions_container" data-row-index="0">					                	
										<input name="items[0].name" type="text" placeholder="Item name" autocomplete="off" class="form-control item-name-input">
					                	<ul class="product_suggestions">					                	
					                	</ul>
					                </td>
					                <td><img src="resources/image/user.png" alt="Item Image" class="table-item-img"></td>
					                <td><input name="items[0].unit" type="text" placeholder="Unit" class="form-control item-unitname-input"></td>
					                <td><input name="items[0].price" type="number" placeholder="Price" class="form-control item-price-input"></td>
					                <td><input name="items[0].quantity" type="number" placeholder="Quantity" class="form-control item-quantity-input"></td>
					                <td class="item-total-price">$0</td>
					                <td colspan="0" rowspan="0"><input name="items[0].image" type="text" hidden class="form-control item-image-input"></td>
					            </tr>					           				            
					        </tbody>	
					    </table>
					
					    <div>
					        <div>Total price is: <span id="totalProductsPrice">0</span></div>		        
					        <button id="addNewRowButton" class="btn btn-primary d-block mx-auto">Add Another item</button>
					    </div>
					
					    <input type="submit" class="btn btn-success w-100 my-5" value="Add List Now">
					</form>


            </div>
        </div>
    </div>


    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
 	
 // Wait for the document to be ready
    $(document).ready(function () {
        // Counter for generating unique indices for items
        var itemIndex = 1;

     // Function to reset a row to its initial state (empty values and empty suggestions)
        function resetRow(row) {
            row.find(".item-name-input").val(""); // Clear the input value
            row.find(".table-item-img").prop("src", "");
            row.find(".item-quantity-input").val("");
            row.find(".item-price-input").val("");
            row.find(".item-unitname-input").val("");
            row.find(".item-image-input").val("");
            
            row.find(".product_suggestions").empty(); // Clear the suggestion list
        }

        // Add an event listener to the "Add Another item" button
        $("#addNewRowButton").click(function (e) {
            e.preventDefault();

            // Clone the template row and update its input field names and data-row-index
            var newRow = $(".item-row-template").clone();
            newRow.removeClass("item-row-template");

            // Reset the cloned row to its initial state
            resetRow(newRow);

            // Update input field names with the new item index
            newRow.find("input").each(function () {
                var currentName = $(this).attr("name");
                var updatedName = currentName.replace("[0]", "[" + itemIndex + "]");
                $(this).attr("name", updatedName);
            });

            // Increment the data-row-index attribute value
            newRow.find(".product_suggestions_container").attr("data-row-index", itemIndex);

            // Append the new row to the table's tbody
            $("table tbody").append(newRow);

            // Increment the item index for the next item
            itemIndex++;
        });
        
     
     
     // Event listener for input change (Item name)
     $("table tbody").on("input", ".item-name-input", function () {
         var itemNameInput = $(this);
         var rowIndex = itemNameInput.closest(".product_suggestions_container").data("row-index");
         var itemName = itemNameInput.val();
         var suggestionList = itemNameInput.closest(".product_suggestions_container").find(".product_suggestions");

         // Send an AJAX request to the controller
         $.ajax({
             url: "/product/search",
             type: "GET",
             data: { name: itemName },
             success: function (data) {
                 // Handle the response and display suggestions for the specific row
                 suggestionList.empty();
                 $.each(data, function (index, product) {
                     suggestionList.append("<li data-product-image='" + product.image +"' data-product-name='" + product.name + "' data-product-price='" + product.price + "' data-product-unit='" + product.unit + "'>" + product.name + "</li>");
                 });
             },
             error: function () {
                 // Handle errors if necessary
             }
         });
     });

     // Event listener for clicking on a suggestion
     $("table tbody").on("click", ".product_suggestions li", function () {
         var clickedSuggestion = $(this);
         var row = clickedSuggestion.closest("tr");
         var productName = clickedSuggestion.data("product-name");
         var productPrice = clickedSuggestion.data("product-price");
         var productUnit = clickedSuggestion.data("product-unit");
         var productImage = clickedSuggestion.data("product-image");

         // Assign the selected product's data to the row
         row.find(".item-name-input").val(productName);
         row.find(".item-price-input").val(productPrice);
         row.find(".item-unitname-input").val(productUnit);
         row.find(".item-image-input").val(productImage);
         row.find(".table-item-img").prop("src", "resources/image/productImage/"+productImage);
         
         // Remove the suggestion
         clickedSuggestion.remove();
     });
     
     
     // Event listener for input change (Quantity)
     $("table tbody").on("input", ".item-quantity-input", function () {
         var quantityInput = $(this);
         var row = quantityInput.closest("tr");
         var quantity = parseFloat(quantityInput.val());
         var price = parseFloat(row.find(".item-price-input").val());
         var totalAmount = quantity * price;

         // Update the total amount for this row
         row.find(".item-total-price").text("$" + totalAmount.toFixed(2));
     });
     
     
       
     $("table tbody").on("blur", ".item-name-input", function () {
    	  // Get the product suggestions list
    	  const suggestionList = $(this).closest(".product_suggestions_container").find(".product_suggestions");

    	// Delay the removal for a short time
    	    setTimeout(function () {
    	        suggestionList.empty();
    	    }, 200); // You can adjust the delay time (e.g., 200 milliseconds) as needed

    	});
        
     
     
     
  // Function to calculate the total price
     function calculateTotalPrice() {
         var total = 0;
         
         // Iterate through each row
         $("table tbody tr").each(function () {
             var row = $(this);
             var price = parseFloat(row.find(".item-price-input").val()) || 0;
             var quantity = parseFloat(row.find(".item-quantity-input").val()) || 0;
             
             // Calculate the subtotal for this row
             var subtotal = price * quantity;
             
             // Add the subtotal to the total
             total += subtotal;
         });
         
         // Update the total price element
         $("#totalProductsPrice").text(total.toFixed(2)); // Display the total with two decimal places
     }

     // Call the calculateTotalPrice function whenever quantity or price changes
     $("table tbody").on("input", ".item-price-input, .item-quantity-input", calculateTotalPrice);

     // Initialize the total price
     calculateTotalPrice();

     
     
     
     
    });//end
        
    </script>


</body>

</html>