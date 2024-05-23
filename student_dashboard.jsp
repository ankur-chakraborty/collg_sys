<%@ page import="java.io.*, java.sql.*" %>
<%@ include file="connect.jsp"%>

<%
String email = (String) session.getAttribute("email"); // Assume email is stored in the session
String name = "";
String semester = "";
String course = "";
String enrollmentNo = "";
double cgpa = 0.0;
int attendance = 0;

double advJavaGrade = 0.0;
double softwareEngGrade = 0.0;
double aiGrade = 0.0;
double compilerGrade = 0.0;

boolean success = false;

try {
    // SQL query to fetch student details, grades, and CGPA from the database
    PreparedStatement pstmt = conn.prepareStatement(
        "SELECT name, semester, course, enrollment_no, cgpa, attendance, ADV_JAVA, SOFTWARE_ENG, AI, COMPILER " +
        "FROM student_db WHERE email = ?"
    );
    pstmt.setString(1, email);
    
    ResultSet rs = pstmt.executeQuery();
    if (rs.next()) {
        // Retrieve student details
        name = rs.getString("name");
        semester = rs.getString("semester");
        course = rs.getString("course");
        enrollmentNo = rs.getString("enrollment_no");
        cgpa = rs.getDouble("cgpa");
        attendance = rs.getInt("attendance");
        
        // Retrieve grades
        advJavaGrade = rs.getDouble("ADV_JAVA");
        softwareEngGrade = rs.getDouble("SOFTWARE_ENG");
        aiGrade = rs.getDouble("AI");
        compilerGrade = rs.getDouble("COMPILER");
        
        success = true;
    }
    
    pstmt.close();
    rs.close();
} catch (Exception e) {
    out.println("Failed to retrieve data: " + e.getMessage());
    success = false;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>
        <% if (success) { %>
            Student Dashboard
        <% } else { %>
            Login Unsuccessful
        <% } %></title>
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

        .student-details {
            border: 1px solid #ccc;
            padding: 20px;background-color: #ffffff;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: left;
            width: 50%;
            margin: 0 auto;
        }

        table {
            width: 80%;
            margin: 20px auto;background-color: #ffffff;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        a {
            color: #3498db;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 4px;
            border: 1px solid #3498db;background-color: #ffffff;
            margin-top: 20px;
            display: inline-block;
        }

        a:hover {
            background-color: #3498db;
            color: white;
        }
        
        
    </style>
</head>
<body>
    <h1>Student Dashboard</h1>
    <% if (success) { %>

        <div class="student-details">
            <h2>Student Details</h2>
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Semester:</strong> <%= semester %></p>
            <p><strong>Course:</strong> <%= course %></p>
            <p><strong>Enrollment No.:</strong> <%= enrollmentNo %></p>
            <p><strong>CGPA:</strong> <%= cgpa %></p>
            <p><strong>Attendance:</strong> <%= attendance %></p>
        </div>

        <p>Grades:</p>
        <table>
            <thead>
                <tr>
                    <th>Subject</th>
                    <th>Grade</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Advanced Java</td>
                    <td><%= advJavaGrade %></td>
                </tr>
                <tr>
                    <td>Software Engineering</td>
                    <td><%= softwareEngGrade %></td>
                </tr>
                <tr>
                    <td>Artificial Intelligence</td>
                    <td><%= aiGrade %></td>
                </tr>
                <tr>
                    <td>Compiler</td>
                    <td><%= compilerGrade %></td>
                </tr>
            </tbody>
        </table>

        <p><a href="logout.jsp">Logout</a></p>
    <% } else { %>
        <p>Failed to retrieve your data. Please try again.</p>
    <% } %>
</body>
</html>
