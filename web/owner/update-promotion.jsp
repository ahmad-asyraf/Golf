<%@page import="com.utils.DBConnection"%>
<%@ page import="java.sql.*" %>
<%@page errorPage="../controllers/error.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = (String) session.getAttribute("email");
    String promoID = request.getParameter("promoID");

    if (email == null) {
//    IF Login Session Expired Return back to login.html page
        response.sendRedirect("../login.html");
    }

    DBConnection conn = new DBConnection();
    String sql = "SELECT * FROM owner WHERE email=?";
    String sql1 = "SELECT * FROM promotion WHERE promoID = ?";
    PreparedStatement ps = conn.getConnection().prepareStatement(sql);
    PreparedStatement ps1 = conn.getConnection().prepareStatement(sql1);
    ps.setString(1, email);
    ps1.setString(1, promoID);
    ResultSet rs = ps.executeQuery();
    ResultSet rs1 = ps1.executeQuery();

    if (rs.next()) {
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Promotion - Admin</title>
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
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Services
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="add-service.jsp">Add Services</a></li>
                                <li><a class="dropdown-item" href="view-service.jsp">View Services</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle active" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Promotions
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="add-promotion.jsp">Add Promotions</a></li>
                                <li><a class="dropdown-item active" href="view-promotion.jsp">View Promotions</a></li>
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

        <%while (rs1.next()) {%>
        <div class="container">
            <div class="col-md-12">
                <div class="profile-content">
                    <div class="form-popup bg-light p-5 mt-5 text-capitalize">
                        <form action="../controllers/update-promotion.jsp" method="POST" onsubmit="return confirm('Confirm to update?');">
                            <input type="hidden" name="promoID" value="<%= rs1.getString("promoID")%>">
                            <div class="col-md-4 mx-auto">
                                <label class="form-label">Promotion ID:</label>
                                <input type="text" class="form-control" name="promovalue" value="<%= rs1.getString("promoID")%>" disabled="">
                            </div>
                            <div class="col-md-4 mx-auto">
                                <label class="form-label">Promotion Value:</label>
                                <input type="text" class="form-control" name="promovalue" value="<%= rs1.getString("promovalue")%>">
                            </div>
                            <div class="col-md-4 mx-auto">
                                <label class="form-label">Promotion Start Date:</label>
                                <input type="text" class="form-control" name="startDate" value="<%= rs1.getString("startDate")%>">
                            </div>
                            <div class="col-md-4 mx-auto">
                                <label class="form-label">Promotion End Date:</label>
                                <input type="text" class="form-control" name="endDate" value="<%= rs1.getString("endDate")%>">
                            </div>

                            <div class="text-center mt-3">
                                <button type="submit" class="btn btn-primary">Update</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <% }%>
    </body>
</html>
<%}%>