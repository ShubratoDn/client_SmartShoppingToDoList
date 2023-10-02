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
    
    <main>
        <div class="container mt-5 pt-4">
            <div class="col-lg-5 mt-5 border p-3 mx-auto">
                <h2 class="text-center mb-4">Login Smart Shopping</h2>
                
                <%
                	ServerMessage sm = (ServerMessage) request.getAttribute("serverMsg");
                	if(sm != null){	
                %>
                <div class="alert <%=sm.getCss() %> alert-dismissible fade show" role="alert">                    
                    <%=sm.getMessage() %>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <%                
                	}
                %>
                
                <form action="/login" method="post">
                    <input class="form-control my-2" type="text" name="email" placeholder="Enter your email">
                    <input class="form-control my-2" type="password" name="password" placeholder="Enter your password">

                    <input class="btn btn-outline-dark w-100" type="submit" value="Login now">
                </form>
            </div>
        </div>
    </main>




    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>