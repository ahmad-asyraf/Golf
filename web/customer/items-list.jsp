<%@page import="java.util.Map"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@page import="java.util.HashMap"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("../login.html");
    }

    ResultSet rs = null;
    ResultSet rs1 = null;
    PreparedStatement ps = null;
    PreparedStatement ps1 = null;
    java.sql.Connection conn = null;

    String query = "SELECT * FROM item";
    String query1 = "SELECT custid FROM customer WHERE email = ?"; // Modified query

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/golfshopmanagementsystem", "root", "");
        ps = conn.prepareStatement(query);
        ps1 = conn.prepareStatement(query1);
        ps1.setString(1, email); // Set the email parameter in the prepared statement
        rs = ps.executeQuery();
        rs1 = ps1.executeQuery();

        rs1.next();
        int custid = rs1.getInt("custid");
        // Use the custid value as needed

        // Create a HashMap to store the item details
        HashMap<Integer, HashMap<String, String>> itemList = new HashMap<>();

        // Iterate through the result set and populate the item list
        while (rs.next()) {
            int itemID = rs.getInt("itemID");
            String itemName = rs.getString("itemName");
            String itemDesc = rs.getString("itemDesc");
            int itemQuantity = rs.getInt("itemQuantity");
            String itemPrice = rs.getString("itemPrice");

            // Create a HashMap to store the item properties
            HashMap<String, String> itemDetails = new HashMap<>();
            itemDetails.put("itemName", itemName);
            itemDetails.put("itemDesc", itemDesc);
            itemDetails.put("itemQuantity", String.valueOf(itemQuantity));
            itemDetails.put("itemPrice", itemPrice);

            // Add the item details to the itemList HashMap using itemID as the key
            itemList.put(itemID, itemDetails);
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Items List - Customer</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/Register1.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
        <style>
            body{
                background-image: url("../images/golf3.jpg");
                background-size: cover;
                background-repeat: no-repeat;
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
                            <a class="nav-link active" aria-current="page" href="items-list.jsp">Items List</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="services-list.jsp">Services List</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="carts-list.jsp">Carts List</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="../controllers/logout.jsp">Logout</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="profile shadow">
            <div class="profile-sidebar">
                <div class="profile-usertitle">
                    <i class="fas fa-user-alt" style="font-size:48px;"></i>
                    <div class="profile-usertitle-name">
                        <div class="bg-dark text-white shadow p-4 text-center mt-3">
                            <h2 class="text-capitalize">Welcome, <%= session.getAttribute("name")%></h2>
                            <!--<h2 class="text-capitalize">Welcome, <%= custid%></h2>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="m-3">
            <div class="row">
                <%
                    int cardCount = 0;
                    for (Map.Entry<Integer, HashMap<String, String>> entry : itemList.entrySet()) {
                        int itemID = entry.getKey();
                        HashMap<String, String> itemDetails = entry.getValue();
                        String itemName = itemDetails.get("itemName");
                        String itemDesc = itemDetails.get("itemDesc");
                        int itemQuantity = Integer.parseInt(itemDetails.get("itemQuantity"));
                        String itemPrice = itemDetails.get("itemPrice");

                        if (cardCount % 4 == 0) {
                %>
                <div class="row">
                    <% }
                        cardCount++;
                    %>
                    <div class="col-md-3 mb-4">
                        <div class="card">
                            <div class="card-header text-capitalize fw-bolder">
                                <%= itemName%>
                            </div>
                            <div class="card-body text-capitalize">
                                <p><b>Item Description: </b><%= itemDesc%></p>
                                <p><b>Item Quantity: </b><%= itemQuantity%></p>
                                <p><b>Item Price: </b><%= itemPrice%></p>
                                <% if (itemQuantity > 0) {%>
                                <form action="../controllers/add-item-to-cart.jsp" method="POST" onsubmit="return confirm('Add item to cart?');">
                                    <input type="number" id="orderquantity" name="orderquantity" min="1" max="<%= itemQuantity%>" class="form-control" onkeypress="return event.charCode >= 48 && event.charCode <= 57" placeholder="Enter quantity" required>
                                    <input type="hidden" name="itemID" value="<%= itemID%>">
                                    <input type="hidden" name="custID" value="<%= custid%>">
                                    <input type="hidden" name="itemPrice" value="<%= itemPrice%>">

                                    <div class="mt-3">
                                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                                    </div>
                                </form>
                            </div>
                            <% } else { %>
                            <button>Out Of Stock</button>
                            <% } %>
                        </div>
                    </div>
                    <% if (cardCount % 4 == 0) { %>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>

        <%
            } catch (Exception e) {
                e.printStackTrace();
                // Handle any exceptions or redirect to an error page
                String errorMessage = "An error occurred while processing your request.";
                out.print("<script> "
                        + "alert('" + errorMessage + "'); "
                        + "window.location.href = 'Item-Customer.jsp'; "
                        + "</script>");
            } finally {
                // Close connections and statements
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (rs1 != null) {
                        rs1.close();
                    }
                    if (ps != null) {
                        ps.close();
                    }
                    if (ps1 != null) {
                        ps1.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </body>
</html>
