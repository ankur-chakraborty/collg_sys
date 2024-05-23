<%@ page import="java.io.IOException" %>

<%
try {
    session.invalidate();
    response.sendRedirect("index.html");
} catch (IOException e) {
    out.println("An error occurred during logout: " + e.getMessage());
}
%>
