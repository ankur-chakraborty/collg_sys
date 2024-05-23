<%@ page import="java.io.*,java.util.*" %>

<html>
  <head>
    <title>Teacher Registration</title>
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
      input[type="email"],
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
    <h1>Teacher Registration</h1>
    <p>Please enter your details:</p>
    <form action="register_teacher.jsp" method="post">
      <label for="name">Name:</label>
      <input type="text" id="name" name="name">

      <label for="email">Email:</label>
      <input type="email" id="email" name="email">

      <label for="password">Password:</label>
      <input type="password" id="password" name="password">
      
      <label for="subject">Subject:</label>
      <input type="text" id="subject" name="subject">
      
      <label for="tid">Teacher ID:</label>
      <input type="text" id="tid" name="tid">
      
      <label for="sub">Subject Code:</label>
      <input type="text" id="sub" name="sub">
      
      <input type="submit" value="Register">
    </form>
  </body>
</html>
