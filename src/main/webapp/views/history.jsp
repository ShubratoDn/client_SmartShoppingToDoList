<!DOCTYPE html>
<%@page import="java.util.ArrayList"%>
<%@page import="com.shopping.todo.payload.ListOverview"%>
<%@page import="java.util.List"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Shopping To Do List</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/style.css">
</head>

<body>
    
    <%@include file="partials/navbar.jsp"%>

    <div class="container">
        <div class="row">
            <div class="col-lg-8 border mx-auto rounded mt-4">
                <h1 class="text-center my-3">Your History</h1>

                <!-- shopping list items -->
                <div class="shopping-list">
                
                	<%
                		List<ListOverview> listOverviews = (List<ListOverview>) request.getAttribute("validShoppingList");
                		if(listOverviews == null || listOverviews.isEmpty()){
                			%>
                				<h1>No list found</h1>
                			<%
                		}else{
                			for(ListOverview overview : listOverviews){                			
                		
                	%>                
                    <div class="list-item border px-3 py-2 my-2 <%= (overview.isExpired()) ? "expired" : "valid" %>">
                        <div class="item-title font-20"><%=overview.getTitle() %> <span class="text-muted font-12 ml-2">last updated <%=overview.getDate() %></span></div> 
                        <div class="font-14">
                            <span class="mr-5">Total amount: $<%=overview.getTotalAmount() %></span>
                            <span class="mr-5">Total items selected: <%=overview.getTotalItem() %></span>
                            <a href="/list?id=<%=overview.getId() %>" class=" ml-5 btn btn-primary btn-sm">View List</a>
                        </div>
                    </div>  
                    
                    <%                    	
                			}
                		} 
                    %>                    
                </div>

            </div>
        </div>
    </div>


    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>