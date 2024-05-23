<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@include file="connect.jsp"%>
<%
  String name = request.getParameter("name");
  String email = request.getParameter("email");
  String password = request.getParameter("password");
  String subject = request.getParameter("subject");
  String tid = request.getParameter("tid");
  String sub = request.getParameter("sub");
  boolean success = false;
  try{
    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO TEACHER_DB (name, email, password, subject, t_id, subject_code) VALUES (?, ?, ?, ?, ?, ?)");
    pstmt.setString(1, name);
    pstmt.setString(2, email);
    pstmt.setString(3, password);
    pstmt.setString(4, subject);
    pstmt.setString(5, tid);
    pstmt.setString(6, sub); 
    int t = pstmt.executeUpdate();
    if(t > 0){
      success = true;
    }
    pstmt.close();
    conn.close();
  } catch(Exception e) {
    out.println("Failed");
    success = false;
  }
%>

<html>
  <head>
    <title>Registration Successful</title>
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
        text-decoration: none;
        border: 1px solid #3498db;background-color: #ffffff;
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
    <h1>Registration <%= (success) ? "Successful" : "Unsuccessful" %></h1>
    <% if (success) { %>
      <p>You have successfully registered as a teacher. Please log in to access your account.</p>
      <a href="teacher_portal.jsp">Log In</a>
    <% } else { %>
      <p>There was an error with your registration. Please try again.</p>
    <% } %>
  </body>
</html>
