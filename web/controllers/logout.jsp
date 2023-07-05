<%
    HttpSession httpsession = request.getSession();
    httpsession.invalidate();
    response.sendRedirect("../index.html");
%>
