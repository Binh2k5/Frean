<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>Manage Users | Feane</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    body { background-color: #fafafa; }
    .admin-nav { background: #222; padding: 10px 0; }
    .admin-nav a { 
        color: #fff; padding: 10px 20px; display: inline-block; 
        text-decoration: none; transition: all 0.3s;
    }
    .admin-nav a:hover, .admin-nav a.active { 
        background: #ffbe33; color: black; border-radius: 5px; 
    }
    .container { margin-top: 40px; margin-bottom: 60px; }
    table th, table td { text-align: center; vertical-align: middle; }
    .btn-add { background: #ffbe33; color: white; border: none; }
    .btn-add:hover { background: #e6a000; color: white; }
    .heading_container { margin-bottom: 30px; }
    .form-inline { margin-bottom: 30px; background: white; padding: 20px; border-radius: 10px; }
    .table-container { background: white; padding: 20px; border-radius: 10px; }
  </style>
</head>
<body>  
  <header class="admin-nav text-center">
    <a href="<%=request.getContextPath()%>/Admin/DashBoard">Dashboard</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageUser" class="active">Users</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageDish">Dishes</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageOrder">Orders</a>
    <a href="<%=request.getContextPath()%>/Admin/Report">Reports</a>
    <a href="<%=request.getContextPath()%>/Logout">Logout</a>
  </header>

  <div class="container">
    <div class="heading_container heading_center">
      <h2>Manage Users</h2>
    </div>
    
    <c:if test="${not empty sessionScope.success}">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        ${sessionScope.success}
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <c:remove var="success" scope="session"/>
    </c:if>
    
    <c:if test="${not empty sessionScope.error}">
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        ${sessionScope.error}
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <c:remove var="error" scope="session"/>
    </c:if>
    
    <form class="form-inline justify-content-center" action="<%=request.getContextPath()%>/Admin/CreateUser" method="post">
      <input type="text" name="username" class="form-control mr-2" placeholder="Email/Username" required style="min-width: 200px;">
      <input type="password" name="password" class="form-control mr-2" placeholder="Password" required style="min-width: 150px;">
      <select name="role" class="form-control mr-2" style="min-width: 120px;">
        <option value="User">User</option>
        <option value="Admin">Admin</option>
      </select>
      <button class="btn btn-add"><i class="fas fa-plus"></i> Add User</button>
    </form>
    
    <div class="table-container">
      <table class="table table-bordered table-hover">
        <thead class="thead-dark">
          <tr>
            <th>ID</th>
            <th>Email</th>
            <th>Name</th>
            <th>Phone</th>
            <th>Role</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${userList}" var="u">
            <tr>
              <td>${u.id}</td>
              <td>${u.email}</td>
              <td>${u.firstName} ${u.lastName}</td>
              <td>${u.phone}</td>
              <td>
                <c:choose>
                  <c:when test="${u.roleId == 1}">
                    <span class="badge badge-danger">Admin</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge badge-primary">User</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <a href="<%=request.getContextPath()%>/Admin/DeleteUser?id=${u.id}" 
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure you want to delete this user?')">
                  <i class="fas fa-trash"></i> Delete
                </a>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty userList}">
            <tr>
              <td colspan="6" class="text-center">No users found</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>