<%-- 
    Document   : manage_corporate
    Author     : aisha
--%>

<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="model.MyCustomer"%>
<%@page import="model.MyCustomerFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.NamingException"%>

<%
    MyCustomerFacade myCustomerFacade = null;
    String successMessage = "";
    String action = request.getParameter("action");  
    
    try {
        Context context = new InitialContext();
        myCustomerFacade = (MyCustomerFacade) context.lookup("java:global/APUEmploymentSystem/APUEmploymentSystem-ejb/MyCustomerFacade!model.MyCustomerFacade");
    } catch (NamingException e) {
        e.printStackTrace();
    }
    
    // Check if the request is to add, delete, or update a customer
    if ("add".equals(action) && myCustomerFacade != null) {
        String newRole = request.getParameter("role");
        String newUsername = request.getParameter("username");
        String newGender = request.getParameter("gender");
        String newEmail = request.getParameter("email");
        String newBirthdateStr = request.getParameter("birthdate"); // Get the birthdate as a string
        String newPassword = request.getParameter("password");

        // Convert the string birthdate to a Date object
        Date newBirthdate = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            newBirthdate = sdf.parse(newBirthdateStr);
        } catch (ParseException e) {
            e.printStackTrace();
            successMessage = "Invalid birthdate format!";
        }

        if (newRole != null && newUsername != null && newGender != null && newEmail != null && newBirthdate != null) {
            MyCustomer newCustomer = new MyCustomer(newEmail, newPassword, newUsername, newGender, new java.sql.Date(newBirthdate.getTime()), newRole);
            myCustomerFacade.create(newCustomer);
            successMessage = "Customer added successfully!";
        }
    } else if ("delete".equals(action) && myCustomerFacade != null) {
        String deleteEmail = request.getParameter("email");
        if (deleteEmail != null) {
            MyCustomer customerToDelete = myCustomerFacade.find(deleteEmail);
            if (customerToDelete != null) {
                myCustomerFacade.remove(customerToDelete);
                successMessage = "Customer deleted successfully!";
            }
        }
    } else if ("update".equals(action) && myCustomerFacade != null) {
        String updateEmail = request.getParameter("email");
        String updatedRole = request.getParameter("role");
        String updatedUsername = request.getParameter("username");
        String updatedGender = request.getParameter("gender");
        String updatedBirthdateStr = request.getParameter("birthdate");
        String updatedPassword = request.getParameter("password");

        MyCustomer customerToUpdate = myCustomerFacade.find(updateEmail);
        if (customerToUpdate != null) {
            customerToUpdate.setUsername(updatedUsername);
            customerToUpdate.setGender(updatedGender);

            // Convert the string birthdate to a Date object
            Date updatedBirthdate = null;
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                updatedBirthdate = sdf.parse(updatedBirthdateStr);
                customerToUpdate.setBirthdate(new java.sql.Date(updatedBirthdate.getTime()));
            } catch (ParseException e) {
                e.printStackTrace();
                successMessage = "Invalid birthdate format!";
            }

            customerToUpdate.setRole(updatedRole);
            myCustomerFacade.edit(customerToUpdate);
            successMessage = "Customer updated successfully!";
        }
    }
    
    // Retrieve the parameters from the request
    String role = request.getParameter("role");
    String username = request.getParameter("username");
    String gender = request.getParameter("gender");
    String email = request.getParameter("email");
    String birthdate = request.getParameter("birthdate");
    String password = request.getParameter("password");

    // Retrieve customer list based on search criteria
    List<MyCustomer> customerList = null;
    if (myCustomerFacade != null) {
        customerList = myCustomerFacade.searchCustomers(role, username, gender, email);
    }
%>

<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manage Customers</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/style.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        html,body {
            height: fit-content;
        }
        .container-fluid {
            padding: 15px;
            box-sizing: border-box;
        }
    </style>
</head>
<body>
    <br>

    <div class="container">
        <a href="${pageContext.request.contextPath}/Admin/admin_dashboard.jsp" class="btn btn-secondary mb-4">Go to Home</a>
        <h2>Search & Manage Accounts</h2>

        <%-- Display success message if customer was added or deleted--%>
        <% if (!successMessage.isEmpty()) { %>
            <div class="alert alert-success" role="alert">
                <%= successMessage %>
            </div>
        <% } %>

        <!-- Combined Form to search customers or add a new customer -->
        <form method="POST" action="manage_corporate.jsp">
            <div class="form-group">
                <label for="role">Role:</label>
                <select class="form-control" name="role" id="role">
                    <option value="">Select Role</option>
                    <option value="Admin">Admin</option>
                    <option value="Staff">Staff</option>
                    <option value="Employee">Employee</option>
                    <option value="Employer">Employer</option>
                </select>
            </div>

            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" class="form-control" name="username" id="username" placeholder="Enter name">
            </div>

            <div class="form-group">
                <label for="gender">Gender:</label>
                <select class="form-control" name="gender" id="gender">
                    <option value="">Select Gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" class="form-control" name="email" id="email" placeholder="Enter email">
            </div>
            
            <div class="form-group">
                <label for="birthdate">Birthdate:</label>
                <input type="date" class="form-control" name="birthdate" id="birthdate">
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="text" class="form-control" name="password" id="password" placeholder="Enter password">
            </div>

            <div>
                <button type="submit" class="btn btn-primary" name="action" value="search">Search</button>
                <button type="submit" class="btn btn-success" name="action" value="add">Add New Customer</button>
            </div>
        </form>

        <hr>

        <!-- Display the result in a table with edit and update buttons -->
        <% if (customerList != null && !customerList.isEmpty()) { %>
        <h4>Results</h4>
        <% for (MyCustomer customer : customerList) { 
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String birthdateStr = customer.getBirthdate() != null ? sdf.format(customer.getBirthdate()) : "";
        %>
        <form method="post" action="manage_corporate.jsp">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Email</th>
                        <th>Username</th>
                        <th>Gender</th>
                        <th>Birthdate</th>
                        <th>Role</th>
                        <th>Password</th> <!-- Added Password Column -->
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><input type="text" class="form-control" name="email" value="<%= customer.getEmail() %>" readonly></td>
                        <td><input type="text" class="form-control editable-field" name="username" value="<%= customer.getUsername() %>" disabled></td>
                        <td>
                            <select class="form-control editable-field" name="gender" disabled>
                                <option value="Male" <%= "Male".equals(customer.getGender()) ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= "Female".equals(customer.getGender()) ? "selected" : "" %>>Female</option>
                                <option value="Other" <%= "Other".equals(customer.getGender()) ? "selected" : "" %>>Other</option>
                            </select>
                        </td>
                        <td><input type="date" class="form-control editable-field" name="birthdate" value="<%= birthdateStr %>" disabled></td>
                        <td>
                            <select class="form-control editable-field" name="role" disabled>
                                <option value="Admin" <%= "Admin".equals(customer.getRole()) ? "selected" : "" %>>Admin</option>
                                <option value="Staff" <%= "Staff".equals(customer.getRole()) ? "selected" : "" %>>Staff</option>
                                <option value="Employee" <%= "Employee".equals(customer.getRole()) ? "selected" : "" %>>Employee</option>
                                <option value="Employer" <%= "Employer".equals(customer.getRole()) ? "selected" : "" %>>Employer</option>
                            </select>
                        </td>
                        <td><input type="text" class="form-control editable-field" name="password" value="<%= customer.getPassword() %>" disabled></td>
                        <td>
                            <button type="button" class="btn btn-info edit-btn">Edit</button>
                            <button type="submit" class="btn btn-warning update-btn" name="action" value="update" style="display: none;">Update</button>
                            <button type="submit" class="btn btn-danger" name="action" value="delete">Delete</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <% } %>
    <% } else if (customerList != null) { %>
        <p>No customers found.</p>
    <% } %>

    </div>

    <script>
        $(document).ready(function() {
            $(".edit-btn").click(function() {
                // Enable the fields in the current row
                $(this).closest("tr").find(".editable-field").prop("disabled", false);

                // Show the Update button and hide the Edit button
                $(this).closest("tr").find(".update-btn").show();
                $(this).hide();
            });
        });
    </script>
    <footer class="text-center mt-5">
        <p>&copy; 2024 Asia Pacific University of Technology & Innovation (APU). All rights reserved.</p>
    </footer>
</body>
</html>