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
    String query = "SELECT * FROM service ";
    String query1 = "SELECT custid FROM customer WHERE email = ?"; // Modified query

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

%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Services List - Customer</title>
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
                            <a class="nav-link" aria-current="page" href="items-list.jsp">Items List</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="services-list.jsp">Services List</a>
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
        <!-- End Welcome Banner-->

        <div class="container-fluid mt-2">
            <% int cardCount = 0;
                while (rs.next()) {
                    if (cardCount % 4 == 0) { %>
            <div class="row">
                <% }
                    cardCount++;
                %>
                <div class="col col-md-3 mt-3">
                    <div class="card p-3 text-capitalize">
                        <form>
                            <p><b>Service ID: </b><%=rs.getString("serviceid")%></p>
                            <p><b>Service Name: </b><%=rs.getString("servicename")%></p>
                            <p><b>Service Price: </b>RM<%=rs.getBigDecimal("serviceprice")%></p>
                        </form>
                    </div>
                </div>
                <% if (cardCount % 4 == 0) { %>
            </div>
            <% }
                }
                if (cardCount % 4 != 0) { %>
        </div>
        <% }
        %>
    </div>
</body>
</html>