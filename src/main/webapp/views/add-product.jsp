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
            <div class="col-lg-8 border mx-auto rounded mt-4">
                <h1 class="text-center my-3">Add New Product</h1>

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

                <form action="/add-product" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="inp1">Product Name</label>
                        <input type="text" name="name" class="form-control" id="inp1" placeholder="Enter Product Name">
                        <!-- <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small> -->
                    </div>

                    <div class="form-group">
                        <label>Unit name</label>
                        <input type="text" name="unit" class="form-control" placeholder="Product measure unit (kg, Liter, pound)">                       
                    </div>

                    <div class="form-group">
                        <label>Product Price</label>
                        <input type="number" name="price" class="form-control" placeholder="Enter Price for 1 unit product">
                       
                    </div>
                   

                    <div class="form-group">
                        <label for="inp2">Product Image</label>
                        <input type="file" name="file" class="form-control" id="inp2" placeholder="Enter Product Name">
                    </div>

                    <input type="submit" value="Add Now" class="btn btn-success my-4 px-5">
                </form>

            </div>
        </div>
    </div>


    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>