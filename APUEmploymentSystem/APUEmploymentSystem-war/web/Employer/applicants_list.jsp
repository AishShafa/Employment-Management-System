<%-- 
    Document   : applicants_list
    Author     : aisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="../header.jsp"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="model.Notifications"%>
<%@page import="model.NotificationsFacade"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.ejb.EJB"%>

<%
    NotificationsFacade notificationsFacade = null;
    String successMessage = "";
    String action = request.getParameter("action");

    try {
        Context context = new InitialContext();
        notificationsFacade = (NotificationsFacade) context.lookup("java:global/APUEmploymentSystem/APUEmploymentSystem-ejb/NotificationsFacade!model.NotificationsFacade");
    } catch (NamingException e) {
        e.printStackTrace();
    }

    if ("shortlist".equals(action) && notificationsFacade != null) {
        String email = request.getParameter("email");
        try {
            Notifications notification = new Notifications();
            notification.setMessage("You have been shortlisted. You will receive an email with further details.");
            notification.setFromwho("Employer");
            notification.setTowho(email);
            notification.setWhatdate(new Date());
            notificationsFacade.create(notification);
            successMessage = "Applicant successfully shortlisted!";
        } catch (Exception e) {
            e.printStackTrace();
            successMessage = "Failed to shortlist applicant.";
        }
    } else if ("confirm".equals(action) && notificationsFacade != null) {
        String email = request.getParameter("email");
        try {
            Notifications notification = new Notifications();
            notification.setMessage("Congratulations! You have been offered the job. You will receive an email with further details.");
            notification.setFromwho("Employer");
            notification.setTowho(email);
            notification.setWhatdate(new Date());
            notificationsFacade.create(notification);
            successMessage = "Job offer confirmed!";
        } catch (Exception e) {
            e.printStackTrace();
            successMessage = "Failed to confirm job offer.";
        }
    }

    // Retrieve the applicants list
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
        String sql = "SELECT * FROM APPLICANTS";
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Applicants List</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/style.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2>Applicants List</h2>
    <!-- Display success or error message -->
        <%
            String errorMessage = request.getParameter("error");

            if (successMessage != null) {
        %>
            <div class="alert alert-success" role="alert">
                <%= successMessage %>
            </div>
        <%
            } else if (errorMessage != null) {
        %>
            <div class="alert alert-danger" role="alert">
                <%= errorMessage %>
            </div>
        <%
            }
        %>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>Applicant Name</th>
                <th>Birthdate</th>
                <th>Gender</th>
                <th>Email</th>
                <th>Job ID</th>
                <th>Applied Date</th>
                <th>Actions</th>
            </tr>
                </thead>
                <tbody>
                <% while (rs.next()) { %>
                    <tr>
                        <td><%= rs.getInt("ID") %></td>
                        <td><%= rs.getString("NAME") %></td>
                        <td><%= rs.getDate("BIRTHDATE") %></td>
                        <td><%= rs.getString("GENDER") %></td>
                        <td><%= rs.getString("EMAIL") %></td>
                        <td><%= rs.getInt("JOBID") %></td>
                        <td><%= rs.getDate("APPLIED_DATE") %></td>
                        <td>
                            <form method="POST" action="applicants_list.jsp" style="display:inline;">
                                <input type="hidden" name="applicantId" value="<%= rs.getInt("ID") %>">
                                <input type="hidden" name="email" value="<%= rs.getString("EMAIL") %>">
                                <input type="hidden" name="action" value="shortlist">
                                <button type="submit" class="btn btn-warning">Shortlist</button>
                            </form>
                            <form method="POST" action="applicants_list.jsp" style="display:inline;">
                                <input type="hidden" name="applicantId" value="<%= rs.getInt("ID") %>">
                                <input type="hidden" name="email" value="<%= rs.getString("EMAIL") %>">
                                <input type="hidden" name="action" value="confirm">
                                <button type="submit" class="btn btn-success">Confirm Job</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </body>
</html>

<%
    // Clean up resources
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (conn != null) conn.close();
%>
        </tbody>
    </table>
</div>
</body>
</html>