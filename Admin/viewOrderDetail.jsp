<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>Order Detail #${order.orderId} | Feane</title>
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
    .info-card { 
        background: white; border-radius: 10px; padding: 25px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 20px;
    }
    .info-card h5 { 
        color: #ffbe33; border-bottom: 2px solid #ffbe33; 
        padding-bottom: 10px; margin-bottom: 20px;
    }
    .info-row { margin-bottom: 15px; }
    .info-label { font-weight: bold; color: #666; }
    .table-container { background: white; padding: 20px; border-radius: 10px; }
    table th, table td { vertical-align: middle; }
    .dish-img { width: 60px; height: 60px; object-fit: cover; border-radius: 8px; }
    .badge-pending { background: #ffc107; }
    .badge-processing { background: #17a2b8; }
    .badge-shipping { background: #007bff; }
    .badge-delivered { background: #28a745; }
    .badge-cancelled { background: #dc3545; }
    .total-section {
        background: #f8f9fa; padding: 15px; border-radius: 8px;
        margin-top: 20px; text-align: right;
    }
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
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2><i class="fas fa-file-invoice"></i> Order Detail #${order.orderId}</h2>
      <a href="<%=request.getContextPath()%>/Admin/ManageOrder" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Back to Orders
      </a>
    </div>

    <div class="row">
      <div class="col-md-6">
        <div class="info-card">
          <h5><i class="fas fa-info-circle"></i> Order Information</h5>
          <div class="info-row">
            <span class="info-label">Order ID:</span> #${order.orderId}
          </div>
          <div class="info-row">
            <span class="info-label">Order Date:</span> 
            <fmt:formatDate value="${order.date}" pattern="dd/MM/yyyy HH:mm:ss"/>
          </div>
          <div class="info-row">
            <span class="info-label">Status:</span>
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
          </div>
          <c:if test="${not empty order.note}">
            <div class="info-row">
              <span class="info-label">Note:</span><br>
              <em>${order.note}</em>
            </div>
          </c:if>
        </div>
      </div>
      
      <div class="col-md-6">
        <div class="info-card">
          <h5><i class="fas fa-user"></i> Customer Information</h5>
          <div class="info-row">
            <span class="info-label">Name:</span> ${order.name}
          </div>
          <div class="info-row">
            <span class="info-label">Phone:</span> ${order.phone}
          </div>
          <div class="info-row">
            <span class="info-label">Address:</span> ${order.address}
          </div>
          <c:if test="${user != null}">
            <div class="info-row">
              <span class="info-label">Email:</span> ${user.email}
            </div>
          </c:if>
        </div>
      </div>
    </div>
    
    <div class="table-container">
      <h5 class="mb-3"><i class="fas fa-shopping-basket"></i> Order Items</h5>
      <table class="table table-bordered table-hover">
        <thead class="thead-dark">
          <tr>
            <th>Image</th>
            <th>Product Name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
          </tr>
        </thead>
        <tbody>
          <c:set var="subtotal" value="0"/>
          <c:forEach items="${orderDetails}" var="detail">
            <tr>
              <td class="text-center">
                <img src="<%=request.getContextPath()%>/images/${detail.dish.image}" 
                     alt="${detail.dish.name}"
                     class="dish-img"
                     onerror="this.src='<%=request.getContextPath()%>/images/default.png'">
              </td>
              <td>
                <strong>${detail.dish.name}</strong><br>
                <small class="text-muted">${detail.dish.category}</small>
              </td>
              <td>${detail.priceDish} ₫</td>
              <td class="text-center">${detail.quantity}</td>
              <td><strong>${detail.priceDish * detail.quantity} ₫</strong></td>
            </tr>
            <c:set var="subtotal" value="${subtotal + (detail.priceDish * detail.quantity)}"/>
          </c:forEach>
        </tbody>
      </table>
      
      <div class="total-section">
        <div class="row">
          <div class="col-md-8"></div>
          <div class="col-md-4">
            <div class="d-flex justify-content-between mb-2">
              <strong>Subtotal:</strong>
              <span>${subtotal} ₫</span>
            </div>
            <div class="d-flex justify-content-between mb-2">
              <strong>Shipping Fee:</strong>
              <span>${order.shipPrice} ₫</span>
            </div>
            <hr>
            <div class="d-flex justify-content-between">
              <h5><strong>Total:</strong></h5>
              <h5><strong style="color: #ffbe33;">${order.totalPrice} ₫</strong></h5>
            </div>
          </div>
        </div>
      </div>      
      <div class="text-center mt-4">
        <c:if test="${order.status.statusId != 4 && order.status.statusId != 5}">
          <button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#statusModal">
            <i class="fas fa-edit"></i> Update Order Status
          </button>
        </c:if>
        <c:if test="${order.status.statusId == 4 || order.status.statusId == 5}">
          <div class="alert alert-info d-inline-block">
            <i class="fas fa-lock"></i> This order status cannot be changed
          </div>
        </c:if>
      </div>
    </div>
    
    <div class="modal fade" id="statusModal" tabindex="-1" role="dialog">
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
  </div>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>