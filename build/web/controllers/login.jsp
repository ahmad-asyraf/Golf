<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Login</title>
    </head>
    <body>
        <%@ page import="java.sql.*" %>
        <%@ page import="javax.sql.*" %>
        <%@ page import="java.io.PrintWriter" %>

        <%
            String uid1 = request.getParameter("email");
//            String bname = request.getParameter("bname");
            String pass1 = request.getParameter("password");
            String u2 = request.getParameter("utype");
            int u = Integer.parseInt(u2);

            HttpSession httpSession = request.getSession();

            ResultSet rs = null;
            Connection conn = null;
            PreparedStatement ps = null;

            PrintWriter pw = response.getWriter();

            String query2 = "SELECT email,pass1,ownername FROM owner WHERE email=?";
            String query1 = "SELECT * FROM customer WHERE email=?";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/golfshopmanagementsystem", "root", "");

                if (u == 1) {
                    ps = conn.prepareStatement(query1);
                } else if (u == 2) {
                    ps = conn.prepareStatement(query2);
                }

                ps.setString(1, uid1);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String email = rs.getString("email");
                    String password = rs.getString("pass1");

                    if (pass1.equals(password)) {
                        String name = "";
                        int id;
                        if (u == 1) {
                            name = rs.getString("firstname");
                        } else if (u == 2) {
                            name = rs.getString("ownername");
                        }

                        // Store user information in session
                        httpSession.setAttribute("email", email);
                        httpSession.setAttribute("name", name);
                        httpSession.setAttribute("usertype", u);

                        // Redirect to the appropriate page after successful login
                        if (u == 1) {
                            httpSession.setAttribute("currentcust", rs.getString(3));
                            pw.println("<script type=\"text/javascript\">");
                            pw.println("alert('Successfully Login');");
                            pw.println("window.location.href = \"../customer/items-list.jsp\";");
                            pw.println("</script>");
                        } else if (u == 2) {
                            pw.println("<script type=\"text/javascript\">");
                            pw.println("alert('Successfully Login');");
                            pw.println("window.location.href = \"../owner/homepage.jsp\";");
                            pw.println("</script>");
                        }
                    } else {
                        pw.println("<script type=\"text/javascript\">");
                        pw.println("alert('Invalid Password');");
                        pw.println("window.location.href = \"../login.html\";");
                        pw.println("</script>");
                    }
                } else {
                    pw.println("<script type=\"text/javascript\">");
                    pw.println("alert('User Does Not Exist');");
                    pw.println("window.location.href = \"../login.html\";");
                    pw.println("</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close database connections and resources
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
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </body>
</html>








