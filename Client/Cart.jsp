<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>Cart | Feane</title>
  <link rel="shortcut icon" href="<%=request.getContextPath()%>/images/favicon.png" type="image/png">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha512-CruCP+TD3yXzlvvijET8wV5WxxEh5H8P4cmz0RFbKK6FlZ2sYl3AEsKlLPHbniXKSrDdFewhbmBK5skbdsASbQ==" crossorigin="anonymous" />
  <link href="<%=request.getContextPath()%>/css/font-awesome.min.css" rel="stylesheet" />
  <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" />
  <link href="<%=request.getContextPath()%>/css/responsive.css" rel="stylesheet" />
</head>

<body class="sub_page"> 
  <div class="hero_area">
    <div class="bg-box">
      <img src="<%=request.getContextPath()%>/images/hero-bg.jpg" alt="">
    </div>
    
    <header class="header_section">
      <div class="container">
        <nav class="navbar navbar-expand-lg custom_nav-container">
          <a class="navbar-brand" href="${pageContext.request.contextPath}/User/HomePage">
            <span>Feane</span>
          </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class=""> </span>
            </button>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mx-auto">
              <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/User/HomePage">Home</a></li>
              <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/User/Menu">Menu</a></li>
              <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/User/About">About</a></li>              
              <li class="nav-item active"><a class="nav-link" href="${pageContext.request.contextPath}/User/Cart">Cart <span class="sr-only">(current)</span></a></li>
            </ul>
            <div class="user_option">
              <c:if test="${empty author}">
              <a href="<%=request.getContextPath()%>/Login" class="user_link">
                <i class="fa fa-user" aria-hidden="true"></i>
              </a>
             </c:if>
             <c:if test="${not empty author}">
                <div class="dropdown user_dropdown">
                 <button class="btn btn-outline-light dropdown-toggle username-btn" type="button" id="userDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <c:set var="fullName" value="${author.firstName} ${author.lastName}" />
                    <i>Hi, 
                     <c:choose>
                       <c:when test="${fn:length(fullName) > 5}">${fn:substring(fullName, 0, 5)}...</c:when>
                       <c:otherwise>${fullName}</c:otherwise>
                     </c:choose></i>
                 </button>
                 <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                    <a href="<%=request.getContextPath()%>/User/UpdateProfile" class="logout_link">MyProfile</a>
                    <a href="<%=request.getContextPath()%>/Logout" class="logout_link">Logout</a>
                 </div>
                </div>
             </c:if>
              <a href="${pageContext.request.contextPath}/User/Checkout" class="order_online">Order Online</a>
            </div>
          </div>
        </nav>
      </div>
    </header>
  </div>  
  
  <section class="book_section layout_padding">
    <div class="container">
      <div class="heading_container">
        <h2>Your Cart</h2>
      </div>
      
      <div class="table-responsive">
        <table class="table table-striped table-bordered text-center">
          <thead class="thead-dark">
            <tr>
              <th>Image</th>
              <th>Dish Name</th>
              <th>Price</th>
              <th>Quantity</th>
              <th>Total</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>           
            <c:forEach items="${cart}" var="c">
                <tr>
                  <td><img src="<%=request.getContextPath()%>/images/${c.dish.image}" alt="Pizza" width="60"></td>
                  <td>${c.dish.name}</td>
                  <td>${c.dish.price} VNĐ</td>
                  <td>
                      <input type="number" value="${c.quantity}" min="1" class="form-control text-center" style="width:80px;"
                             onchange="window.location.href='${pageContext.request.contextPath}/User/UpdateCartItem?cartItemId=${c.cartItemId}&quantity=' + this.value + '&dishId=${c.dish.id}'">
                  </td>
                  <td>${c.dish.price * c.quantity}</td>
                  <td>
                    <button class="btn btn-danger btn-sm" onclick="window.location.href='${pageContext.request.contextPath}/User/DeleteCartItem?cartItemId=${c.cartItemId}'"><i class="fa fa-trash"></i></button>
                  </td>
                </tr>
            </c:forEach>            
          </tbody>
        </table>
      </div>            
            <c:if test="${sessionScope.message != null}">
                <div id="alertMessage" class="alert alert-success text-center" style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999; width: 50%;" role="alert">
                    ${sessionScope.message}
                </div>
                <script>
                    // Tự động ẩn thông báo sau 3 giây
                    setTimeout(function () {
                        document.getElementById("alertMessage").style.display = 'none';
                    }, 3000);
                </script>
                <c:remove var="message" scope="session"/>                
            </c:if>
      <div class="text-right mt-4">
        <h5>Subtotal: <span style="color:#ff6347;">${sum} VNĐ</span></h5>
        <div class="mt-3">
          <a href="${pageContext.request.contextPath}/User/Menu" class="btn btn-secondary">← Continue Shopping</a>
          <a href="${pageContext.request.contextPath}/User/Checkout" class="btn btn-success ml-2">Proceed to Checkout</a>
        </div>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="footer_section">
    <div class="container text-center">
      <p>© 2025 Feane Restaurant. All rights reserved.</p>
    </div>
  </footer>
  
  <style>
.user_dropdown {
  display: inline-block;
}

.username-btn {
  color: white;
  background: transparent;
  border: none;
  font-weight: 500;
}

.username-btn:hover, 
.username-btn:focus {
  color: #ffc107; /* màu vàng nhấn */
  background: none;
  box-shadow: none;
}

.dropdown-menu {
  text-align: center;
  border-radius: 10px;
  min-width: 115px;
}

.dropdown-menu .dropdown-item {
  color: white;
}

.dropdown-menu .dropdown-item:hover {
  background-color: #ffc107;
  color: black;
}
</style>
<!-- jQery -->
  <script src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
  <!-- popper js -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
  </script>
  <!-- bootstrap js -->
  <script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
  <!-- owl slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js">
  </script>
  <!-- isotope js -->
  <script src="https://unpkg.com/isotope-layout@3.0.4/dist/isotope.pkgd.min.js"></script>
  <!-- nice select -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
  <!-- custom js -->
  <script src="<%=request.getContextPath()%>/js/custom.js"></script>
  <!-- Google Map -->
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCh39n5U-4IoWpsVGUHWdqB6puEkhRLdmI&callback=myMap">
  </script>
  <!-- End Google Map -->
</body>
</html>