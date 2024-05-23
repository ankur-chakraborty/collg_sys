<%@ page import="java.io.*, java.sql.*" %>
<%@ include file="connect.jsp"%>

<%
String teacherEmail = (String) session.getAttribute("teacherEmail"); // Assume the teacher's email is stored in the session

// Fetch the teacher's subject code from the TEACHER_DB table
String subjectCode = "";
try {
    PreparedStatement pstmtTeacher = conn.prepareStatement("SELECT SUBJECT_CODE FROM TEACHER_DB WHERE email = ?");
    pstmtTeacher.setString(1, teacherEmail);
    ResultSet rsTeacher = pstmtTeacher.executeQuery();
    if (rsTeacher.next()) {
        subjectCode = rsTeacher.getString("SUBJECT_CODE");
    }
    rsTeacher.close();
    pstmtTeacher.close();
} catch (Exception e) {
    out.println("Failed to retrieve teacher data: " + e.getMessage());
}

// Map the subject code to the column name in the STUDENT_DB table
String subjectColumnName = "";
switch (subjectCode) {
    case "ADV_JAVA":
        subjectColumnName = "ADV_JAVA";
        break;
    case "SOFTWARE_ENG":
        subjectColumnName = "SOFTWARE_ENG";
        break;
    case "AI":
        subjectColumnName = "AI";
        break;
    case "COMPILER":
        subjectColumnName = "COMPILER";
        break;
    default:
        out.println("Invalid subject code for teacher.");
}

// SQL query to fetch all student information from the STUDENT_DB table
String query = "SELECT name, email, enrollment_no, semester, course, " + subjectColumnName + " AS subject_grade, attendance, cgpa, present, total_classes " +
               "FROM STUDENT_DB";
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(query);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Teacher Dashboard</title>
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

        table {
            width: 100%;
            margin: 20px auto;
            border-collapse: collapse;background-color: #ffffff;
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

        form {
            margin-bottom: 20px;
        }

        input, select {
            padding: 5px;
            margin: 5px;
        }
		a {
            color: #3498db;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 4px;
            border: 1px solid #3498db;
            margin-top: 20px;background-color: #ffffff;
            display: inline-block;
        }

        a:hover {
            background-color: #3498db;
            color: white;
        }
        button {
            padding: 8px 12px;
            border-radius: 4px;
            border: none;
            background-color: #3498db;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <h1>Teacher Dashboard</h1>

    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Enrollment No.</th>
                <th>Semester</th>
                <th>Course</th>
                <th>Attendance</th>
                <th>CGPA</th>
                <th>Grade (<%= subjectColumnName %>)</th>
                <th>Update Attendance</th>
                <th>Update Grade</th>
            </tr>
        </thead>
        <tbody>
            <% while (rs.next()) { %>
                <tr>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("enrollment_no") %></td>
                    <td><%= rs.getString("semester") %></td>
                    <td><%= rs.getString("course") %></td>
                    <td><%= rs.getDouble("attendance") %></td>
                    <td><%= rs.getDouble("cgpa") %></td>
                    <td><%= rs.getDouble("subject_grade") %></td>
                    <td>
                        <!-- Form to mark attendance with radio buttons for absent/present -->
                        <form action="mark_attendance.jsp" method="post">
                            <input type="hidden" name="enrollment_no" value="<%= rs.getString("enrollment_no") %>">
                            <input type="radio" id="absent<%= rs.getString("enrollment_no") %>" name="attendance" value="0">
                            <label for="absent<%= rs.getString("enrollment_no") %>">Absent</label>
                            <input type="radio" id="present<%= rs.getString("enrollment_no") %>" name="attendance" value="1">
                            <label for="present<%= rs.getString("enrollment_no") %>">Present</label>
                            <button type="submit">Mark</button>
                        </form>
                    </td>
                    <td>
                        <!-- Form to update grade -->
                        <form action="update_grade.jsp" method="post">
                            <input type="hidden" name="enrollment_no" value="<%= rs.getString("enrollment_no") %>">
                            <input type="number" name="new_grade" value="<%= rs.getDouble("subject_grade") %>" max="10" min="0">
                            <input type="hidden" name="subject_column" value="<%= subjectColumnName %>">
                            <button type="submit">Update Grade</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <% rs.close();
       stmt.close();
       conn.close();
    %>
	<p><a href="logout.jsp">Logout</a></p>
</body>
</html>
