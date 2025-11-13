<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>Admin Dashboard | Feane</title>
  <link rel="shortcut icon" href="<%=request.getContextPath()%>/images/favicon.png" type="image/png">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap.css" />
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
    .admin-card {
        background: white; border-radius: 10px; padding: 25px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center;
        margin-bottom: 20px; transition: transform 0.3s;
    }
    .admin-card:hover { transform: translateY(-5px); }
    .admin-card h4 { color: #ffbe33; font-size: 2rem; margin-bottom: 10px; }
    .admin-card p { color: #666; font-size: 1.1rem; }
    footer { margin-top: 60px; background: #222; color: white; padding: 20px 0; }
    .alert { margin: 20px 0; }
  </style>
</head>

<body>  
  <header class="admin-nav text-center">
    <a href="<%=request.getContextPath()%>/Admin/DashBoard" class="active">Dashboard</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageUser">Users</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageDish">Dishes</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageOrder">Orders</a>
    <a href="<%=request.getContextPath()%>/Admin/Report">Reports</a>
    <a href="<%=request.getContextPath()%>/Logout">Logout</a>
  </header>

  <div class="container mt-5">
    <div class="heading_container heading_center">
      <h2>Admin Dashboard</h2>
      <p>Welcome, <strong>${sessionScope.author.firstName} ${sessionScope.author.lastName}</strong> 👋</p>
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
    
    <div class="row mt-4">
      <div class="col-md-3">
        <div class="admin-card">
          <h4><i class="fas fa-users"></i> ${totalUsers}</h4>
          <p>Total Users</p>
        </div>
      </div>
      <div class="col-md-3">
        <div class="admin-card">
          <h4><i class="fas fa-utensils"></i> ${totalFoods}</h4>
          <p>Total Dishes</p>
        </div>
      </div>
      <div class="col-md-3">
        <div class="admin-card">
          <h4><i class="fas fa-shopping-cart"></i> ${totalOrders}</h4>
          <p>Total Orders</p>
        </div>
      </div>
      <div class="col-md-3">
        <div class="admin-card">
          <h4><i class="fas fa-dollar-sign"></i> ${totalRevenue}₫</h4>
          <p>Total Revenue</p>
        </div>
      </div>
    </div>
  </div>

  <footer class="footer_section">
    <div class="container text-center">
      <p>© 2025 Feane Admin Panel. All rights reserved.</p>
    </div>
  </footer>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>