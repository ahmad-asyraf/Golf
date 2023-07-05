<%@page import="java.text.DecimalFormat"%>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("../login.html");
    }

    ResultSet rs = null;
    ResultSet rs1 = null;
    PreparedStatement ps = null;
    PreparedStatement ps1 = null;
    Connection conn = null;

    String query = "SELECT orders.*, item.* "
            + "FROM orders "
            + "JOIN customer ON orders.custID = customer.custid "
            + "JOIN item ON orders.itemID = item.itemID "
            + "WHERE customer.email = ?";

    String query1 = "SELECT custid FROM customer WHERE email = ?"; // Modified query

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/golfshopmanagementsystem", "root", "");
        ps = conn.prepareStatement(query);
        ps.setString(1, email);
        ps1 = conn.prepareStatement(query1);
        ps1.setString(1, email); // Set the email parameter in the prepared statement
        rs = ps.executeQuery();
        rs1 = ps1.executeQuery();
        int i = 1;

        rs1.next();
        int custid = rs1.getInt("custid");
        // Use the custid value as needed
%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Carts List - Customer</title>
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
        <nav class="navbar navbar-expand-lg bg-light shadow">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="items-list.jsp">Items List</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="services-list.jsp">Services List</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="carts-list.jsp">Carts List</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="../controllers/logout.jsp">Logout</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!--Welcome Banner-->
        <div class="profile shadow">
            <div class="profile-sidebar">
                <div class="profile-usertitle">
                    <i class="fas fa-user-alt" style="font-size:48px;"></i>
                    <div class="profile-usertitle-name">
                        <div class="bg-dark text-white shadow p-4 text-center mt-3">
                            <h2 class="text-capitalize">Welcome, <%= session.getAttribute("name")%></h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End Welcome Banner-->

        <div class="container-fluid">
            <main class="mt-3">
                <table class="table table-bordered shadow">
                    <thead class="table-primary">
                        <tr>
                            <th>No.</th>
                            <th>Order ID</th>
                            <th>Item Name</th>
                            <th>Item Price</th>
                            <th>Quantity</th>
                            <th>Total Price</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <% while (rs.next()) {%>
                    <tr>
                        <td><%= i++%></td>
                        <td><%= rs.getInt("orderid")%></td>
                        <td class="text-capitalize"><%= rs.getString("itemName")%></td>
                        <td>RM<%= rs.getBigDecimal("totalPrice")%></td>
                        <td><%= rs.getInt("quantity")%></td>
                        <td>
                            <%
                                double totalPrice = rs.getInt("quantity") * rs.getInt("totalPrice");
                                DecimalFormat decimalFormat = new DecimalFormat("#0.00");
                                String formattedTotalPrice = decimalFormat.format(totalPrice);
                            %>

                            <!-- Display the formatted total price -->
                            RM<%= formattedTotalPrice%>
                        </td>
                        <td class="text-center">
                            <a href="../controllers/delete-item-from-cart.jsp?orderID=<%= rs.getInt("orderid")%>" class="btn btn-sm btn-danger" onclick="return confirm('Delete this item?');">Delete</a>
                        </td>
                    </tr>
                    <% } %>
                </table>
                <% } catch (Exception e) {
                        out.println("error: " + e);
                    } finally {
                        try {
                            if (rs != null) {
                                rs.close();
                            }
                            if (ps != null) {
                                ps.close();
                            }
                            if (conn != null) {
                                conn.close();
                            }
                        } catch (Exception e) {
                            out.println("error: " + e);
                        }
                    }%>
            </main>
        </div>
    </body>
</html>
