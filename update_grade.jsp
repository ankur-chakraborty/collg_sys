<%@ page import="java.sql.*, java.io.*" %>
<%@ include file="connect.jsp"%>

<%
String enrollmentNo = request.getParameter("enrollment_no");
String subjectColumn = request.getParameter("subject_column");
double newGrade = Double.parseDouble(request.getParameter("new_grade"));

boolean isUpdated = false;
String message = "";

try {
    // Start a transaction
    conn.setAutoCommit(false);
    
    // Update the specified subject grade
    PreparedStatement updateGradeStmt = conn.prepareStatement(
        "UPDATE STUDENT_DB SET " + subjectColumn + " = ? WHERE ENROLLMENT_NO = ?"
    );
    updateGradeStmt.setDouble(1, newGrade);
    updateGradeStmt.setString(2, enrollmentNo);
    updateGradeStmt.executeUpdate();
    updateGradeStmt.close();
    
    // Calculate new CGPA
    PreparedStatement selectGradesStmt = conn.prepareStatement(
        "SELECT ADV_JAVA, SOFTWARE_ENG, AI, COMPILER FROM STUDENT_DB WHERE ENROLLMENT_NO = ?"
    );
    selectGradesStmt.setString(1, enrollmentNo);
    ResultSet rs = selectGradesStmt.executeQuery();
    
    if (rs.next()) {
        double advJavaGrade = rs.getDouble("ADV_JAVA");
        double softwareEngGrade = rs.getDouble("SOFTWARE_ENG");
        double aiGrade = rs.getDouble("AI");
        double compilerGrade = rs.getDouble("COMPILER");
        
        double newCgpa = (advJavaGrade + softwareEngGrade + aiGrade + compilerGrade) / 4;
        
        // Update the CGPA
        PreparedStatement updateCgpaStmt = conn.prepareStatement(
            "UPDATE STUDENT_DB SET CGPA = ? WHERE ENROLLMENT_NO = ?"
        );
        updateCgpaStmt.setDouble(1, newCgpa);
        updateCgpaStmt.setString(2, enrollmentNo);
        updateCgpaStmt.executeUpdate();
        updateCgpaStmt.close();
    }
    
    rs.close();
    selectGradesStmt.close();
    
    // Commit the transaction
    conn.commit();
    
    // If everything is successful, set isUpdated to true
    isUpdated = true;
    message = "Grade successfully updated.";
} catch (Exception e) {
    message = "Failed to update grade: " + e.getMessage();
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
    <title>Update Grade</title>
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
    <h1>Update Grade</h1>

    <% if (isUpdated) { %>
        <p><%= message %></p>
    <% } else { %>
        <p>Something went wrong. Please try again later.</p>
    <% } %>

    <p><a href="teacher_dashboard.jsp">Go back to the teacher dashboard</a></p>
</body>
</html>
