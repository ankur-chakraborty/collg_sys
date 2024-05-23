<%@ page import="java.io.*, java.sql.*" %>
<%@ include file="connect.jsp" %>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");
boolean success = false;

try {
    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM STUDENT_DB WHERE email = ? AND password = ?");
    pstmt.setString(1, email);
    pstmt.setString(2, password);
    ResultSet rs = pstmt.executeQuery();
    if (rs.next()) {
        success = true;
        session.setAttribute("email", email);
    }
    pstmt.close();
    rs.close();
    conn.close();
} catch (Exception e) {
    out.println("Failed: " + e.getMessage());
    success = false;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Login <%= (success) ? "Successful" : "Unsuccessful" %></title>
    <style>
        body {
        font-family: Arial, sans-serif;
        text-align: center;
        padding: 20px;
        display: flex; 
        flex-direction: column; 
        justify-content: center; 
        align-items: center;
        height: 100vh; /* Height of the viewport */
        background-image: url("university.jpg"); /* Path to the background image */
        background-size: cover; /* Cover the entire viewport with the background image */
        background-repeat: no-repeat; /* Prevent the image from repeating */
        background-position: center; /* Center the image */
    }

        h1 {
            color: #2c3e50;
            font-size: 24px;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            margin-bottom: 20px;
        }

        a {
            display: block;
            width: 150px;
            margin: 10px auto;
            padding: 8px 16px;
            color: #3498db;
            text-decoration: none;background-color: #ffffff;
            border: 1px solid #3498db;
            border-radius: 4px;
            text-align: center;
        }

        a:hover {
            background-color: #3498db;
            color: white;
        }
    </style>
</head>
<body>
    <h1>Login <%= (success) ? "Successful" : "Unsuccessful" %></h1>
    <% if (success) { %>
        <p>You have successfully logged in as a student.</p>
        <a href="student_dashboard.jsp">Go to Dashboard</a>
    <% } else { %>
        <p>Invalid email or password. Please try again.</p>
        <a href="student_portal.jsp">Try Again</a>
    <% } %>
</body>
</html>
