<%@page import="com.utils.DBConnection"%>
<%@ page import="java.sql.*" %>
<%@page errorPage="../controllers/error.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
//    IF Login Session Expired Return back to login.html page
        response.sendRedirect("../login.html");
    }

    DBConnection conn = new DBConnection();
    String sql = "SELECT * FROM owner WHERE email=?";
    String sql1 = "SELECT * FROM service";
    PreparedStatement ps = conn.getConnection().prepareStatement(sql);
    PreparedStatement ps1 = conn.getConnection().prepareStatement(sql1);
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();
    ResultSet rs1 = ps1.executeQuery();

    if (rs.next()) {
%>
<!DOCTYPE html>
<html>
    <head>
        <title>View Service - Admin</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/Register1.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
        <style>
            body{
                background-image: url("../images/golf3.jpg");
                background-size: cover;
                background-attachment: fixed;
                background-repeat: no-repeat;
                background-position: center;
            }
        </style>
    </head>
    <body>
        <!--Navigation Bar-->
        <nav class="navbar navbar-expand-lg bg-light shadow">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="homepage.jsp">Homepage</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Items
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="add-item.jsp">Add Items</a></li>
                                <li><a class="dropdown-item" href="view-item.jsp">View Items</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle active" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Services
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="add-service.jsp">Add Services</a></li>
                                <li><a class="dropdown-item active" href="view-service.jsp">View Services</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Promotions
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="add-promotion.jsp">Add Promotions</a></li>
                                <li><a class="dropdown-item" href="view-promotion.jsp">View Promotions</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="orders-list.jsp">Order</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="payment.jsp">Payment</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="sales.jsp">Sales</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="../controllers/logout.jsp">Logout</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!--End Navigation Bar-->

        <!--Welcome Banner-->
        <div class="profile shadow">
            <div class="profile-sidebar">
                <div class="profile-usertitle">
                    <i class="fas fa-user-alt" style="font-size:48px;"></i>
                    <div class="profile-usertitle-name">
                        <div class="bg-dark text-white shadow p-4 text-center mt-3">
                            <h2 class="text-capitalize">Welcome, <%= rs.getString("ownername")%></h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End Welcome Banner-->

        <div class="container-fluid mt-3">
            <div class="row">
                <%while (rs1.next()) {%>
                <div class="col col-md-3 mt-3">
                    <div class="card text-capitalize">
                        <div class="card-header fw-bolder">
                            <%=rs1.getString("servicename")%>
                        </div>
                        <div class="card-body">
                            <p><b>Service ID: </b><%=rs1.getString("serviceid")%></p>
                            <p><b>Service Price : </b>RM<%=rs1.getString("serviceprice")%></p>

                            <div class="row">
                                <div class="col text-center">
                                    <a href="update-service.jsp?serviceid=<%=rs1.getString("serviceid")%>" class="btn btn-primary col-md-6">Update</a>
                                </div>
                                <div class="col text-center">
                                    <a href="../controllers/delete-service.jsp?serviceid=<%= rs1.getString("serviceid")%>" class="btn btn-danger col-md-6" onclick="return confirm('Confirm to delete this service?');">Delete</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </body>
</html>
<%}%>