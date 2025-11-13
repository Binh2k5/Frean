<%-- 
    Document   : report
    Created on : Nov 9, 2025, 10:02:46 PM
    Author     : BINH
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>Sales Report | Feane</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
    .stats-card {
        background: white; border-radius: 10px; padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center;
        margin-bottom: 20px;
    }
    .stats-card h5 { color: #333; margin-bottom: 10px; }
    .stats-card .value { color: #ffbe33; font-size: 2rem; font-weight: bold; }
    .chart-container { 
        background: white; border-radius: 10px; padding: 30px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
    }
  </style>
</head>
<body>  
  <header class="admin-nav text-center">
    <a href="<%=request.getContextPath()%>/Admin/DashBoard">Dashboard</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageUser">Users</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageDish">Dishes</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageOrder">Orders</a>
    <a href="<%=request.getContextPath()%>/Admin/Report" class="active">Reports</a>
    <a href="<%=request.getContextPath()%>/Logout">Logout</a>
  </header>

  <div class="container">
    <div class="heading_container heading_center">
      <h2><i class="fas fa-chart-line"></i> Sales Report</h2>
    </div>
    
    <div class="row mb-4">
      <div class="col-md-6">
        <div class="stats-card">
          <h5><i class="fas fa-shopping-cart"></i> Total Orders (Delivered)</h5>
          <div class="value">${totalOrders}</div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="stats-card">
          <h5><i class="fas fa-dollar-sign"></i> Total Revenue</h5>
          <div class="value">${totalRevenue} ₫</div>
        </div>
      </div>
    </div>
    
    <div class="chart-container">
      <h4 class="text-center mb-4">Monthly Revenue Chart</h4>
      <canvas id="revenueChart"></canvas>
    </div>
  </div>

  <script>
    const ctx = document.getElementById('revenueChart');
    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ${monthLabels},
        datasets: [{
          label: 'Monthly Revenue (₫)',
          data: ${monthRevenue},
          backgroundColor: '#ffbe33',
          borderColor: '#e6a000',
          borderWidth: 2,
          borderRadius: 5
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: true,
        scales: { 
          y: { 
            beginAtZero: true,
            ticks: {
              callback: function(value) {
                return value.toLocaleString() + ' ₫';
              }
            }
          }
        },
        plugins: {
          legend: {
            display: true,
            position: 'top'
          },
          tooltip: {
            callbacks: {
              label: function(context) {
                return 'Revenue: ' + context.parsed.y.toLocaleString() + ' ₫';
              }
            }
          }
        }
      }
    });
  </script>

  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>