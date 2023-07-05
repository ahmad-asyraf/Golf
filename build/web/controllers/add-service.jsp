<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Add Service</title>
    </head>
    <body>
        <%
            String serviceid = request.getParameter("serviceid");
            String servicename = request.getParameter("servicename");
            String serviceprice = request.getParameter("serviceprice");

            PreparedStatement ps1 = null;
            PreparedStatement ps2 = null;
            ResultSet rs = null;
            Connection conn = null;

            String query1 = "SELECT serviceid from service WHERE serviceid=?";
            String query2 = "INSERT INTO service(serviceid,servicename,serviceprice ) VALUES(?,?,?)";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/golfshopmanagementsystem", "root", "");
                ps1 = conn.prepareStatement(query1);
                ps1.setString(1, serviceid);
                rs = ps1.executeQuery();
                if (!rs.next()) {
                    ps2 = conn.prepareStatement(query2);;
                    ps2.setString(1, serviceid);
                    ps2.setString(2, servicename);
                    ps2.setString(3, serviceprice);

                    int i = ps2.executeUpdate();
                    response.sendRedirect("../owner/view-service.jsp");
                } else {
                    response.sendRedirect("../owner/homepage.jsp");
                }
            } catch (Exception e) {
                out.println(e);
            }
        %>
    </body>
</html>
