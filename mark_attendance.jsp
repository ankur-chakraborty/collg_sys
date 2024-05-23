<%@ page import="java.sql.*, java.io.*" %>
<%@ include file="connect.jsp"%>

<%
String enrollmentNo = request.getParameter("enrollment_no");
String attendanceStr = request.getParameter("attendance");
int attendance = Integer.parseInt(attendanceStr);

boolean isMarked = false;
String message = "";

try {
    // Start a transaction
    conn.setAutoCommit(false);
    
    // Increment TOTAL_CLASSES by 1
    PreparedStatement updateTotalClasses = conn.prepareStatement(
        "UPDATE STUDENT_DB SET TOTAL_CLASSES = TOTAL_CLASSES + 1 WHERE ENROLLMENT_NO = ?"
    );
    updateTotalClasses.setString(1, enrollmentNo);
    updateTotalClasses.executeUpdate();
    
    // Check if the student is present and increment PRESENT if necessary
    if (attendance == 1) {
        PreparedStatement updatePresent = conn.prepareStatement(
            "UPDATE STUDENT_DB SET PRESENT = PRESENT + 1 WHERE ENROLLMENT_NO = ?"
        );
        updatePresent.setString(1, enrollmentNo);
        updatePresent.executeUpdate();
        updatePresent.close();
    }
    
    // Recalculate ATTENDANCE as (PRESENT / TOTAL_CLASSES) * 100
    PreparedStatement updateAttendance = conn.prepareStatement(
        "UPDATE STUDENT_DB SET ATTENDANCE = (PRESENT / TOTAL_CLASSES) * 100 WHERE ENROLLMENT_NO = ?"
    );
    updateAttendance.setString(1, enrollmentNo);
    updateAttendance.executeUpdate();
    updateAttendance.close();
    
    // Commit the transaction
    conn.commit();
    
    // Close prepared statements
    updateTotalClasses.close();
    
    // If everything is successful, set isMarked to true
    isMarked = true;
    message = "Attendance successfully marked.";
} catch (Exception e) {
    message = "Failed to update attendance: " + e.getMessage();
    try {
        // Roll back in case of an error
        conn.rollback();
    } catch (SQLException ex) {
        message = "Failed to roll back the transaction: " + ex.getMessage();
    }
} finally {
    try {
        // Reset the auto-commit mode and close the connection
        conn.setAutoCommit(true);
        conn.close();
    } catch (SQLException ex) {
        message = "Failed to reset auto-commit: " + ex.getMessage();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance</title>
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
            padding: 8px 16px;
            background-color: #3498db;
            color: white;
            border-radius: 4px;
            text-decoration: none;
        }

        a:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <h1>Mark Attendance</h1>

    <% if (isMarked) { %>
        <p><%= message %></p>
    <% } else { %>
        <p>Something went wrong. Please try again later.</p>
    <% } %>

    <p><a href="teacher_dashboard.jsp">Go back to the teacher dashboard</a></p>
</body>
</html>
