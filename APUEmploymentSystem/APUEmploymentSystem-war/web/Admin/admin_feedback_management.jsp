<%-- 
    Document   : admin_feedback_management
    Author     : aisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="../header.jsp"%>
<%@include file="../includes.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - Feedback Management</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container">
            <h2>Admin - Feedback Management</h2>
            
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    // Load the JDBC driver (Adjust for your DB)
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

                    // Query the FEEDBACK table
                    String sql = "SELECT * FROM FEEDBACK";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();

                    // Check if there are any feedback records
                    if (!rs.next()) {
            %>
                        <div class="alert alert-warning">No feedback or complaints available.</div>
            <%
                    } else {
            %>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Employer</th>
                                    <th>Employee</th>
                                    <th>Feedback Type</th>
                                    <th>Message</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
            <%
                        // Loop through the results and display each feedback
                        do {
            %>
                                <tr>
                                    <td><%= rs.getString("FROMEMPLOYER") %></td>
                                    <td><%= rs.getString("ABOUTEMPLOYEE") %></td>
                                    <td><%= rs.getString("FEEDBACKTYPE") %></td>
                                    <td><%= rs.getString("MESSAGE") %></td>
                                    <td><%= rs.getString("STATUS") %></td>
                                    <td><%= rs.getDate("FEEDBACKDATE") %></td>
                                <td>
                                <form action="<%=request.getContextPath()%>/SendWarningServlet" method="POST">
                                    <input type="hidden" name="employeeEmail" value="<%= rs.getString("ABOUTEMPLOYEE") %>">
                                    <input type="hidden" name="feedbackMessage" value="<%= rs.getString("MESSAGE") %>">
                                    <button type="submit" class="btn btn-warning">Send Warning</button>
                                </form>


                                    </td>
                                </tr>
            <%
                        } while (rs.next());
            %>
                            </tbody>
                        </table>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                }
            %>

            

            <h3>Sent Warnings</h3>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>To</th>
                        <th>Message</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try {
                        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
                        String warningSql = "SELECT * FROM NOTIFICATIONS WHERE MESSAGE LIKE 'Warning:%'";
                        ps = conn.prepareStatement(warningSql);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                %>
                            <tr>
                                <td><%= rs.getString("TOWHO") %></td>
                                <td><%= rs.getString("MESSAGE") %></td>
                                <td><%= rs.getDate("WHATDATE") %></td>
                            </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    }
                %>
                </tbody>
            </table>
        </div>
    </body>
</html>