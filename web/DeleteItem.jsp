

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Pro Shop Golf Management System</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg bg-light">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Pro Shop Golf Management System</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="ViewItem.jsp">Back</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container-fluid mt-3">
            <div class="row">
                <%
                    Class.forName("com.mysql.jdbc.Driver");
                    String db_url = "jdbc:mysql://localhost:3306/golfshopmanagementsystem";
                    Connection con = DriverManager.getConnection(db_url, "root", "");

                    Statement stmt = con.createStatement();
                    String sql = "SELECT * FROM item";
                    ResultSet rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                %>
                <div class="col col-md-3 mt-3">
                    <div class="card p-3">
                        <form action="DeleteItem1.jsp" method="POST">
                                                        <div class="text-center">
                                <img src="images/golf3.jpg" width="200px" height="200px">
                            </div>
                            <h1 class="text-center"> <%=rs.getString("itemID")%></h1>
                            <p><b>Item ID:</b><%=rs.getString("itemID")%></p>
                            <p><b>Item Name: </b><%=rs.getString("itemName")%></p>
                            <p><b>Item Description : </b><%=rs.getString("itemDesc")%></p>
                            <p><b>Item Quantity : </b><%=rs.getInt("itemQuantity")%></p>
                            <p><b>Item Price : </b><%=rs.getDouble("itemPrice")%></p> 

                           <div class="col text-center">
                <a href="DeleteItem1.jsp?itemID=<%= rs.getString("itemID") %>" class="btn btn-primary col-md-6">Delete</a>
              </div>
                            
                        </form>
                    </div>
                    </div>
                </div>
                <%
                    }
                    con.close();
                %>
            </div>
    </body>
</html>
