	<%@page import="com.shopping.todo.entity.User"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="/home">Smart-Shopping</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup"
            aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <%
         	User user =	(User) session.getAttribute("user");
        
        	if(user != null){        		
        	
        %>
        
        <div class="collapse navbar-collapse justify-content-end" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-item nav-link" href="/">Active List <span class="sr-only">(current)</span></a>
                <a class="nav-item nav-link" href="/add-list">Add New List</a>
                <a class="nav-item nav-link" href="/add-product">Add New Product</a>
                <a class="nav-item nav-link" href="/history">History</a>
                <a class="nav-item nav-link" href="/logout">Logout</a>
            </div>
            <div class="nav-user-info text-muted">
                <img src="resources/image/userImage/user.png" alt="user" class="nav-user-image">
                <%=user.getName() %>
            </div>
        </div>
        <%
        	}else{	
        %>
        
        <div class="collapse navbar-collapse justify-content-end" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-item nav-link font-20" href="/login">Login</a>
                <a class="nav-item nav-link font-20" href="/register">Register</a>
            </div>       
        </div>
        
        <%
       		} 
        %>
        
        
    </nav>