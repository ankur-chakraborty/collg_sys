<%@ page import="java.io.*, java.util.*" %>

<html>
  <head>
    <title>Student Portal</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        text-align: center;
        padding: 20px;
        display: flex; 
        flex-direction: column; 
        justify-content: center; 
        align-items: center;
        height: 100vh; 
        background-image: url("university.jpg"); 
        background-size: cover; 
        background-repeat: no-repeat;
        background-position: center; 
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

    form {
        display: inline-block;
        text-align: left;
        background-color: #f7f7f7;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    label {
        font-size: 14px;
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 8px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    input[type="submit"] {
        background-color: #3498db;
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-weight: bold;
    }

    input[type="submit"]:hover {
        background-color: #2980b9;
    }
</style>

  </head>
  <body>
    <h1>Welcome to the Student Portal</h1>
    <p>Please log in to access your courses, marks, and attendance.</p>
    <form action="student_login.jsp" method="post">
      <label for="username">Username:</label>
      <input type="text" id="username" name="email">
      <label for="password">Password:</label>
      <input type="password" id="password" name="password">
      <input type="submit" value="Log In">
    </form>
  </body>
</html>
