<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>Manage Dishes | Feane</title>
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
    .btn-add { background: #ffbe33; color: white; border: none; }
    .btn-add:hover { background: #e6a000; color: white; }
    img { width: 60px; height: 60px; object-fit: cover; border-radius: 10px; }
    .form-inline { margin-bottom: 30px; background: white; padding: 20px; border-radius: 10px; }
    .table-container { background: white; padding: 20px; border-radius: 10px; }
    table th, table td { text-align: center; vertical-align: middle; }
    
    /* Category input group styling */
    .category-input-group {
      position: relative;
      min-width: 180px;
    }
    
    .category-input-wrapper {
      display: flex;
      gap: 5px;
    }
    
    #categorySelect {
      flex: 1;
      min-width: 120px;
    }
    
    #newCategoryInput {
      flex: 1;
      min-width: 120px;
    }
    
    .toggle-input-btn {
      background: #6c757d;
      color: white;
      border: none;
      padding: 8px 12px;
      border-radius: 4px;
      cursor: pointer;
      white-space: nowrap;
      font-size: 14px;
    }
    
    .toggle-input-btn:hover {
      background: #5a6268;
    }
    
    .toggle-input-btn i {
      margin-right: 3px;
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
      .form-inline {
        flex-direction: column;
        align-items: stretch !important;
      }
      
      .form-inline input,
      .form-inline select,
      .form-inline button,
      .category-input-group {
        width: 100% !important;
        min-width: 100% !important;
        margin-right: 0 !important;
      }
      
      .category-input-wrapper {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>  
  <header class="admin-nav text-center">
    <a href="<%=request.getContextPath()%>/Admin/DashBoard">Dashboard</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageUser">Users</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageDish" class="active">Dishes</a>
    <a href="<%=request.getContextPath()%>/Admin/ManageOrder">Orders</a>
    <a href="<%=request.getContextPath()%>/Admin/Report">Reports</a>
    <a href="<%=request.getContextPath()%>/Logout">Logout</a>
  </header>

  <div class="container">
    <div class="heading_container heading_center">
      <h2>Manage Dishes</h2>
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
    
    <form class="form-inline justify-content-center" action="<%=request.getContextPath()%>/Admin/AddFood" method="post" enctype="multipart/form-data">
      <input type="text" name="name" class="form-control mr-2 mb-2" placeholder="Dish Name" required style="min-width: 180px;">
      <input type="number" name="price" step="0.01" class="form-control mr-2 mb-2" placeholder="Price" required style="min-width: 120px;">
      
      <div class="category-input-group mr-2 mb-2">
        <div class="category-input-wrapper">
          <select name="category" id="categorySelect" class="form-control">
            <option value="">-- Select Category --</option>
            <c:forEach items="${categories}" var="cat">
              <option value="${cat}">${cat}</option>
            </c:forEach>
          </select>
          <input type="text" name="newCategory" id="newCategoryInput" class="form-control" 
                 placeholder="Type new category" style="display: none;" required>
          <button type="button" class="toggle-input-btn" id="toggleCategoryBtn" title="Add new category">
            <i class="fas fa-plus"></i>New
          </button>
        </div>
      </div>
      
      <input type="text" name="description" class="form-control mr-2 mb-2" placeholder="Description" style="min-width: 180px;">
      <input type="file" name="image" class="form-control mr-2 mb-2" accept="image/*" style="min-width: 180px;" required>
      <button class="btn btn-add mb-2"><i class="fas fa-plus"></i> Add Dish</button>
    </form>
    
    <div class="table-container">
      <table class="table table-bordered table-hover">
        <thead class="thead-dark">
          <tr>
            <th>ID</th>
            <th>Image</th>
            <th>Name</th>
            <th>Category</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${foodList}" var="f">
            <tr>
              <td>${f.id}</td>
              <td>
                <img src="<%=request.getContextPath()%>/images/${f.image}"                      
                     onerror="this.src='<%=request.getContextPath()%>/images/default.png'">
              </td>
              <td>${f.name}</td>
              <td>
                <span class="badge badge-info">${f.category}</span>
              </td>
              <td>${f.price}</td>
              <td>${f.quantity}</td>
              <td>
                <a href="<%=request.getContextPath()%>/Admin/DeleteFood?id=${f.id}" 
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure you want to delete this dish?')">
                  <i class="fas fa-trash"></i> Delete
                </a>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty foodList}">
            <tr>
              <td colspan="7" class="text-center">No dishes found</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
  
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
  
  <script>
    $(document).ready(function() {
      const categorySelect = $('#categorySelect');
      const newCategoryInput = $('#newCategoryInput');
      const toggleBtn = $('#toggleCategoryBtn');
      let isNewCategory = false;
      
      // Toggle between select and input
      toggleBtn.click(function() {
        isNewCategory = !isNewCategory;
        
        if (isNewCategory) {
          categorySelect.hide();
          categorySelect.prop('required', false);
          newCategoryInput.show();
          newCategoryInput.prop('required', true);
          newCategoryInput.focus();
          toggleBtn.html('<i class="fas fa-list"></i>List');
          toggleBtn.attr('title', 'Choose from existing categories');
        } else {
          newCategoryInput.hide();
          newCategoryInput.prop('required', false);
          newCategoryInput.val('');
          categorySelect.show();
          categorySelect.prop('required', true);
          categorySelect.focus();
          toggleBtn.html('<i class="fas fa-plus"></i>New');
          toggleBtn.attr('title', 'Add new category');
        }
      });
      
      // Form validation
      $('form').submit(function(e) {
        if (isNewCategory) {
          const newCat = newCategoryInput.val().trim();
          if (!newCat) {
            e.preventDefault();
            alert('Please enter a new category name');
            newCategoryInput.focus();
            return false;
          }
          // Clear the select value
          categorySelect.val('');
        } else {
          const selectedCat = categorySelect.val();
          if (!selectedCat) {
            e.preventDefault();
            alert('Please select a category');
            categorySelect.focus();
            return false;
          }
          // Clear the input value
          newCategoryInput.val('');
        }
      });
    });
  </script>
</body>
</html>