<!DOCTYPE html>
<%@page import="com.shopping.todo.entity.Product"%>
<%@page import="java.util.List"%>
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
                <h1 class="text-center my-3">All Products</h1>

					    <table class="table">
					        <thead>
					            <tr>
					                <th scope="col">Id</th>
					                <th scope="col">Product Name</th>
					                <th scope="col">Image</th>
					                <th scope="col">Unit <span class="text-muted font-12">(eg: piece / kg)</span></th>
					                <th scope="col">Price / Unit</th>
					            </tr>
					        </thead>
					        <tbody>
					        
					        <%
					    		List<Product> allProducts = (List<Product>)  request.getAttribute("allProducts");
					        	if(allProducts == null){
					        		%>
					        			<h1 class="text-center my-5">No Products Found</h1>
					        		<%
					        	}else{
					        		for(Product product: allProducts){				        	
					        %>					        
					            <tr>
					            	<td><%=product.getName() %></td>
					            	<td><img src="resources/image/productImage/<%= product.getImage()%>" alt="Item Image" class="table-item-img"></td>
					             	<td><%=product.getUnit() %></td>
					                <td><%=product.getPrice() %></td>					                
					            </tr>					            	
					        <%
					        		}
					        	}
					        %>			           				            
					        </tbody>	
					    </table>


            </div>
        </div>
    </div>


    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>


</body>

</html>
