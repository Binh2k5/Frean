<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>Checkout | Feane</title>
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
              <li class="nav-item active"><a class="nav-link" href="${pageContext.request.contextPath}/User/Checkout">Checkout <span class="sr-only">(current)</span></a></li>
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
              <a class="cart_link" href="${pageContext.request.contextPath}/User/Cart">
                <i class="fa fa-shopping-cart" aria-hidden="true"></i>
              </a>
            </div>
          </div>
        </nav>
      </div>
    </header>
  </div>

  <section class="book_section layout_padding">
    <div class="container">
      <div class="heading_container">
        <h2>Proceed to Checkout</h2>
      </div>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>        
      <div class="row">        
        <div class="col-md-6">
          <div class="form_container">
            <form action="${pageContext.request.contextPath}/User/Checkout" method="post">
              <h5 class="mb-3">Billing Information</h5>

              <div class="form-group">
                  <input type="text" name="fullName" class="form-control" placeholder="Full Name" value="${author.lastName} ${author.firstName}" required>
              </div>

              <div class="form-group">
                <input type="email" name="email" class="form-control" placeholder="Email" value="${author.email}" required>
              </div>

              <div class="form-group">
                <input type="number" name="phone" class="form-control" placeholder="Phone Number" value="${author.phone}" required>
              </div>

              <div class="form-group">
                <input type="text" name="address" class="form-control" placeholder="Shipping Address" value="${author.address}" required>
              </div>

              <div class="form-group">
                <select class="form-control nice-select wide" name="paymentMethod" required>
                  <option value="" disabled selected>Select Payment Method</option>
                  <option value="cod">Cash on Delivery</option>
                  <option value="credit">Credit/Debit Card</option>
                </select>
              </div>

              <div class="form-group">
                <textarea class="form-control" name="note" rows="3" placeholder="Additional Note (optional)"></textarea>
              </div>
              
              <div class="btn_box mt-4">
                <button type="submit">Confirm Order</button>
              </div>
            </form>
          </div>
        </div>
        
        <div class="col-md-6">
          <div class="order_summary bg-light p-4 rounded">
            <h5 class="mb-3">Order Summary</h5>
            <table class="table table-borderless">
              <tbody>
                <c:forEach items="${cart}" var="c">
                    <tr>
                      <td>${c.dish.name}</td>
                      <td class="text-right">${c.dish.price * c.quantity} VNĐ</td>
                    </tr>                    
                </c:forEach>
                <tr>
                  <th>Subtotal</th>
                  <td class="text-right">${sum}</td>
                </tr>
                <tr>
                  <th>Shipping Fee</th>
                  <td class="text-right">Free</td>
                </tr>
                <tr>
                  <th>Total</th>
                  <td class="text-right" style="color:#ff6347;">${sum}</td>
                </tr>
              </tbody>
            </table>
            <p class="text-muted mt-2"><small>* Free shipping for orders over 200,000 VNĐ</small></p>
          </div>
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
