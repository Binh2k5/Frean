<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>Manage Orders | Feane</title>
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
    .table-container { background: white; padding: 20px; border-radius: 10px; margin-top: 20px; }
    .status-filter { background: white; padding: 20px; border-radius: 10px; margin-bottom: 20px; }
    .status-card {
        background: white; border-radius: 10px; padding: 15px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1); text-align: center;
        cursor: pointer; transition: all 0.3s; margin-bottom: 15px;
    }
    .status-card:hover { transform: translateY(-3px); box-shadow: 0 4px 10px rgba(0,0,0,0.15); }
    .status-card.active { border: 2px solid #ffbe33; }
    .status-card h4 { color: #ffbe33; margin-bottom: 5px; }
    .badge-pending { background: #ffc107; }
    .badge-processing { background: #17a2b8; }
    .badge-shipping { background: #007bff; }
    .badge-delivered { background: #28a745; }
    .badge-cancelled { background: #dc3545; }
    .status-select { width: 150px; }
  </style>
</head>
<body>
  <header class="admin-nav text-center">
    <a href="<%=request.getContextPath()%>/Admin/DashBoard">Dashboard</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageUser">Users</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageDish">Dishes</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageOrder" class="active">Orders</a>
    <a href="<%=request.getContextPath()%>/Admin/Report">Reports</a>
    <a href="<%=request.getContextPath()%>/Logout">Logout</a>
  </header>

  <div class="container">
    <div class="heading_container heading_center">
      <h2><i class="fas fa-shopping-cart"></i> Manage Orders</h2>
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

    <div class="row">
      <div class="col-md-2">
        <a href="<%=request.getContextPath()%>/Admin/ManageOrder" style="text-decoration: none;">
          <div class="status-card ${empty statusFilter ? 'active' : ''}">
            <h4>${pendingCount + processingCount + shippingCount + deliveredCount + cancelledCount}</h4>
            <p class="mb-0">All Orders</p>
          </div>
        </a>
      </div>
      <div class="col-md-2">
        <a href="<%=request.getContextPath()%>/Admin/ManageOrder?status=1" style="text-decoration: none;">
          <div class="status-card ${statusFilter == '1' ? 'active' : ''}">
            <h4>${pendingCount}</h4>
            <p class="mb-0"><span class="badge badge-pending">Pending</span></p>
          </div>
        </a>
      </div>
      <div class="col-md-2">
        <a href="<%=request.getContextPath()%>/Admin/ManageOrder?status=2" style="text-decoration: none;">
          <div class="status-card ${statusFilter == '2' ? 'active' : ''}">
            <h4>${processingCount}</h4>
            <p class="mb-0"><span class="badge badge-processing">Processing</span></p>
          </div>
        </a>
      </div>
      <div class="col-md-2">
        <a href="<%=request.getContextPath()%>/Admin/ManageOrder?status=3" style="text-decoration: none;">
          <div class="status-card ${statusFilter == '3' ? 'active' : ''}">
            <h4>${shippingCount}</h4>
            <p class="mb-0"><span class="badge badge-shipping">Shipping</span></p>
          </div>
        </a>
      </div>
      <div class="col-md-2">
        <a href="<%=request.getContextPath()%>/Admin/ManageOrder?status=4" style="text-decoration: none;">
          <div class="status-card ${statusFilter == '4' ? 'active' : ''}">
            <h4>${deliveredCount}</h4>
            <p class="mb-0"><span class="badge badge-delivered">Delivered</span></p>
          </div>
        </a>
      </div>
      <div class="col-md-2">
        <a href="<%=request.getContextPath()%>/Admin/ManageOrder?status=5" style="text-decoration: none;">
          <div class="status-card ${statusFilter == '5' ? 'active' : ''}">
            <h4>${cancelledCount}</h4>
            <p class="mb-0"><span class="badge badge-cancelled">Cancelled</span></p>
          </div>
        </a>
      </div>
    </div>

    <div class="table-container">
      <table class="table table-bordered table-hover">
        <thead class="thead-dark">
          <tr>
            <th>Order ID</th>
            <th>Customer</th>
            <th>Date</th>
            <th>Total Price</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${orderList}" var="order">
            <tr>
              <td>#${order.orderId}</td>
              <td>
                <strong>${order.name}</strong><br>
                <small>${order.phone}</small>
              </td>
              <td>
                <fmt:formatDate value="${order.date}" pattern="dd/MM/yyyy HH:mm"/>
              </td>
              <td><strong>${order.totalPrice} ₫</strong></td>
              <td>
                <c:choose>
                  <c:when test="${order.status.statusId == 1}">
                    <span class="badge badge-pending">Pending</span>
                  </c:when>
                  <c:when test="${order.status.statusId == 2}">
                    <span class="badge badge-processing">Processing</span>
                  </c:when>
                  <c:when test="${order.status.statusId == 3}">
                    <span class="badge badge-shipping">Shipping</span>
                  </c:when>
                  <c:when test="${order.status.statusId == 4}">
                    <span class="badge badge-delivered">Delivered</span>
                  </c:when>
                  <c:when test="${order.status.statusId == 5}">
                    <span class="badge badge-cancelled">Cancelled</span>
                  </c:when>
                </c:choose>
              </td>
              <td>                
                <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#statusModal${order.orderId}">
                  <i class="fas fa-edit"></i> Update
                </button>                                
                <a href="<%=request.getContextPath()%>/Admin/ViewOrderDetail?id=${order.orderId}" 
                   class="btn btn-info btn-sm">
                  <i class="fas fa-eye"></i> View
                </a>
                                
                <div class="modal fade" id="statusModal${order.orderId}" tabindex="-1" role="dialog">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title">Update Order Status - #${order.orderId}</h5>
                        <button type="button" class="close" data-dismiss="modal">
                          <span>&times;</span>
                        </button>
                      </div>
                      <form action="<%=request.getContextPath()%>/Admin/UpdateOrderStatus" method="post">
                        <div class="modal-body">
                          <input type="hidden" name="orderId" value="${order.orderId}">
                          <div class="form-group">
                            <label><strong>Customer:</strong> ${order.name}</label>
                          </div>
                          <div class="form-group">
                            <label><strong>Current Status:</strong></label>
                            <p>
                              <c:choose>
                                <c:when test="${order.status.statusId == 1}">
                                  <span class="badge badge-pending">Pending</span>
                                </c:when>
                                <c:when test="${order.status.statusId == 2}">
                                  <span class="badge badge-processing">Processing</span>
                                </c:when>
                                <c:when test="${order.status.statusId == 3}">
                                  <span class="badge badge-shipping">Shipping</span>
                                </c:when>
                                <c:when test="${order.status.statusId == 4}">
                                  <span class="badge badge-delivered">Delivered</span>
                                </c:when>
                                <c:when test="${order.status.statusId == 5}">
                                  <span class="badge badge-cancelled">Cancelled</span>
                                </c:when>
                              </c:choose>
                            </p>
                          </div>
                         <c:if test="${order.status.statusId != 4 && order.status.statusId != 5}">
                          <div class="form-group">
                            <label for="statusId"><strong>New Status:</strong></label>
                            <select name="statusId" class="form-control" required>                              
                              <c:if test="${order.status.statusId == 1}">
                                <option value="2">Processing</option>
                                <option value="5">Cancelled</option>
                              </c:if>                                                            
                              <c:if test="${order.status.statusId == 2}">
                                <option value="3">Shipping</option>
                                <option value="5">Cancelled</option>
                              </c:if>                                                            
                              <c:if test="${order.status.statusId == 3}">
                                <option value="4">Delivered</option>
                                <option value="5">Cancelled</option>
                              </c:if>
                            </select>                            
                          </div>
                         </c:if>
                         <c:if test="${order.status.statusId == 4 || order.status.statusId == 5}">
                           <div class="alert alert-info">
                             <i class="fas fa-lock"></i> This order status cannot be changed.
                           </div>
                         </c:if>
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                          <c:if test="${order.status.statusId != 4 && order.status.statusId != 5}">
                            <button type="submit" class="btn btn-primary">Update Status</button>
                          </c:if>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty orderList}">
            <tr>
              <td colspan="6" class="text-center">No orders found</td>
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