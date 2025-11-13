<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>

<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="<%=request.getContextPath()%>/images/favicon.png" type="image/png">

  <title> Feane </title>

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap.css" />

  <!--owl slider stylesheet -->
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <!-- nice select  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha512-CruCP+TD3yXzlvvijET8wV5WxxEh5H8P4cmz0RFbKK6FlZ2sYl3AEsKlLPHbniXKSrDdFewhbmBK5skbdsASbQ==" crossorigin="anonymous" />
  <!-- font awesome style -->
  <link href="<%=request.getContextPath()%>/css/font-awesome.min.css" rel="stylesheet" />

  <!-- Custom styles for this template -->
  <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="<%=request.getContextPath()%>/css/responsive.css" rel="stylesheet" />

</head>

<body class="sub_page">

  <div class="hero_area">
    <div class="bg-box">
      <img src="<%=request.getContextPath()%>/images/hero-bg.jpg" alt="">
    </div>
    <!-- header section strats -->
    <header class="header_section">
      <div class="container">
        <nav class="navbar navbar-expand-lg custom_nav-container ">
          <a class="navbar-brand" href="<%=request.getContextPath()%>/User/HomePage">
            <span>
              Feane
            </span>
          </a>

          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class=""> </span>
          </button>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav  mx-auto ">
              <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/User/HomePage">Home </a>
              </li>
              <li class="nav-item active">
                <a class="nav-link" href="<%=request.getContextPath()%>/User/Menu">Menu <span class="sr-only">(current)</span> </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/User/About">About</a>
              </li>              
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
              <a class="cart_link" href="<%=request.getContextPath()%>/User/Cart">
                <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background:new 0 0 456.029 456.029;" xml:space="preserve">
                  <g>
                    <g>
                      <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                   c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                    </g>
                  </g>
                  <g>
                    <g>
                      <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                   C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                   c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                   C457.728,97.71,450.56,86.958,439.296,84.91z" />
                    </g>
                  </g>
                  <g>
                    <g>
                      <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                   c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                    </g>
                  </g>                  
                </svg>
              </a>
              <div class="dropdown">
                <button class="btn my-2 my-sm-0 nav_search-btn dropdown-toggle" type="button" 
                        id="searchDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <i class="fa fa-search" aria-hidden="true"></i>
                </button>
                <div class="dropdown-menu dropdown-menu-right p-3" aria-labelledby="searchDropdown" style="min-width: 300px;">
                  <form class="form-inline" action="${pageContext.request.contextPath}/User/Search" method="post">
                    <div class="input-group w-100">
                      <input type="hidden" name="currentPage" value="menu">
                      <input type="text" class="form-control" name="txtSearch" placeholder="Search food..." 
                             aria-label="Search" aria-describedby="button-search">
                      <div class="input-group-append">
                        <button class="btn btn-outline-primary" type="submit" id="button-search">
                          <i class="fa fa-search" aria-hidden="true"></i>
                        </button>
                      </div>
                    </div>                    
                  </form>
                    <div class="search-results mt-2" style="max-height: 300px; overflow-y: auto;">
                        <c:if test="${not empty searchResults}">
                            <div class="search-results-header">
                                <small class="text-muted">Found ${fn:length(searchResults)} results</small>
                            </div>
                          <c:forEach items="${searchResults}" var="food">
                            <a href="javascript:void(0);" data-dish-id="${food.id}"
                               class="search-result-item d-block text-decoration-none">
                                <div class="d-flex align-items-center p-2 border-bottom">
                                    <div class="search-result-img mr-2">
                                        <img src="<%=request.getContextPath()%>/images/${food.image}" 
                                             style="width: 40px; height: 40px; object-fit: cover; border-radius: 5px;">
                                    </div>
                                  <div class="search-result-info flex-grow-1">
                                        <div class="search-result-name font-weight-bold" style="font-size: 12px; color: #333;">
                                            ${food.name}
                                        </div>
                                       <div class="search-result-price" style="font-size: 11px; color: #ffbe33;">
                                            ${food.price} VNĐ
                                        </div>
                                    </div>
                                </div>
                            </a>
                          </c:forEach>
                        </c:if>
                            
                        <c:if test="${not empty err}">
                            <div class="error-message text-center mt-2">
                                <small class="text-danger">${err}</small>
                            </div>
                        </c:if>
                    </div>                 
                </div>
              </div>
              <a href="<%=request.getContextPath()%>/User/Checkout" class="order_online">
                Order Online
              </a>
            </div>
          </div>
        </nav>
      </div>
    </header>
  </div>


  <section class="food_section layout_padding">
    <div class="container">
      <div class="heading_container heading_center">
        <h2>
          Our Menu
        </h2>
      </div>

      <ul class="filters_menu">
        <li class="${filter == 'all' ? 'active' : ''}">
            <a href="<%=request.getContextPath()%>/User/Menu?filter=all">All</a>
        </li>
        <c:forEach items="${cate}" var="c">
            <li class="${filter == c ? 'active' : ''}">
                <a href="<%=request.getContextPath()%>/User/Menu?filter=${c}"><c:set var="firstChar" value="${fn:toUpperCase(fn:substring(c, 0, 1))}" />
                                                                                        <c:set var="restChars" value="${fn:substring(c, 1, fn:length(c))}" />
                                                                                        ${firstChar}${restChars}</a>
            </li>
        </c:forEach>        
      </ul>


      <div class="filters-content">
        <div class="row grid">         
         <c:forEach items="${DB}" var="d" begin="${tool.start}" end="${tool.end}">
          <div class="col-sm-6 col-lg-4 all ${d.category}">
            <div class="box">
              <div>
                <div class="img-box">
                  <img src="<%=request.getContextPath()%>/images/${d.image}" alt="">
                </div>
                <div class="detail-box">
                  <h5>
                    ${d.name}
                  </h5>
                  <p>
                    ${d.description}
                  </p>
                  <div class="options">
                    <h6>
                      ${d.price} VNĐ
                    </h6>                  
                     <a href="<%=request.getContextPath()%>/User/Cart?dishId=${d.id}">                    
                      <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background:new 0 0 456.029 456.029;" xml:space="preserve">
                        <g>
                          <g>
                            <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                         c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                          </g>
                        </g>
                        <g>
                          <g>
                            <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                         C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                         c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                         C457.728,97.71,450.56,86.958,439.296,84.91z" />
                          </g>
                        </g>
                        <g>
                          <g>
                            <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                         c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                          </g>
                        </g>                        
                      </svg>
                    </a>                   
                 </div>
                </div>
              </div>
            </div>
          </div>
         </c:forEach>         
        </div>
      </div>
      <div class="btn-page">
          <c:if test="${tool.index > 0}">
              <a href="${pageContext.request.contextPath}/User/Menu?filter=${filter}&index=0">Home</a>
              <a href="${pageContext.request.contextPath}/User/Menu?filter=${filter}&index=${tool.index - 1}">Pre</a>
          </c:if>

          <c:forEach var="index" begin="${tool.pageStart}" end="${tool.pageEnd}">
              <a class="page-link <c:if test='${index == tool.index}'>active</c:if>"
                 href="${pageContext.request.contextPath}/User/Menu?filter=${filter}&index=${index}">
                 ${index + 1}
              </a>
          </c:forEach>

          <c:if test="${tool.index < tool.totalPage - 1}">
              <a href="${pageContext.request.contextPath}/User/Menu?filter=${filter}&index=${tool.index + 1}">Next</a>
              <a href="${pageContext.request.contextPath}/User/Menu?filter=${filter}&index=${tool.totalPage - 1}">End</a>
          </c:if>
      </div>
    </div>
  </section>

  <!-- end food section -->

  <!-- footer section -->
  <footer class="footer_section">
    <div class="container">
      <div class="row">
        <div class="col-md-4 footer-col">
          <div class="footer_contact">
            <h4>
              Contact Us
            </h4>
            <div class="contact_link_box">
                <a href="https://www.google.com/maps?q=FPT+University+Hanoi" target="_blank">
                <i class="fa fa-map-marker" aria-hidden="true"></i>
                <span>
                  FPT University Hanoi
                </span>
              </a>
              <a href="tel:+846790998">
                <i class="fa fa-phone" aria-hidden="true"></i>
                <span>
                  Call +84 6790998
                </span>
              </a>
              <a href="mailto:support@foodstore.com">
                <i class="fa fa-envelope" aria-hidden="true"></i>
                <span>
                  support@foodstore.com
                </span>
              </a>
            </div>
          </div>
        </div>
        <div class="col-md-4 footer-col">
          <div class="footer_detail">
            <a href="" class="footer-logo">
              Feane
            </a>
            <p>
              Necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with
            </p>
            <div class="footer_social">
                <a href="https://www.facebook.com/tiengtrungFPT" rel="noopener noreferrer" target="_blank">
                <i class="fa fa-facebook" aria-hidden="true"></i>
              </a>
              <a href="">
                <i class="fa fa-twitter" aria-hidden="true"></i>
              </a>
              <a href="">
                <i class="fa fa-linkedin" aria-hidden="true"></i>
              </a>
              <a href="">
                <i class="fa fa-instagram" aria-hidden="true"></i>
              </a>
              <a href="">
                <i class="fa fa-pinterest" aria-hidden="true"></i>
              </a>
            </div>
          </div>
        </div>
        <div class="col-md-4 footer-col">
          <h4>
            Opening Hours
          </h4>
          <p>
            Everyday
          </p>
          <p>
            10.00 Am -10.00 Pm
          </p>
        </div>
      </div>
      <div class="footer-info">
        <p>
          &copy; <span id="displayYear"></span> All Rights Reserved By
          <a href="https://html.design/">Free Html Templates</a><br><br>
          &copy; <span id="displayYear"></span> Distributed By
          <a href="https://themewagon.com/" target="_blank">ThemeWagon</a>
        </p>
      </div>
    </div>
  </footer>
  <!-- footer section -->

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
  
 <script>
$(document).ready(function() {
    <c:if test="${not empty err}">
        $('#searchDropdown').dropdown('show');
    </c:if>
});
$(document).ready(function() {
    <c:if test="${not empty searchResults or not empty err}">
        $('#searchDropdown').dropdown('show');
    </c:if>    
    
    $(document).on('click', '.search-result-item', function(e) {
        e.preventDefault();
        e.stopPropagation();
        
        var dishId = $(this).data('dish-id');
        if (dishId) {            
            console.log("Dish ID to add to cart: " + dishId);    
            $.post("<%=request.getContextPath()%>/User/Cart", { dishId: dishId }, function(response) {                
                alert("Đã thêm sản phẩm " + dishId + " vào giỏ hàng!");                
            }).fail(function() {
                alert("Lỗi khi thêm sản phẩm vào giỏ hàng.");
            });
        }
    });    
    // Prevent form submission if search is empty
    $('form.form-inline').on('submit', function(e) {
        var searchInput = $(this).find('input[name="txtSearch"]');
        if (!searchInput.val().trim()) {
            e.preventDefault();
        }
    });
});
</script>
  
 <style>
     /* Search Results Styling */
.search-results {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.search-results-header {
    padding: 8px 12px;
    border-bottom: 1px solid #eee;
    background: #f8f9fa;
}

.search-result-item {
    transition: all 0.2s ease;
    border: none !important;
}

.search-result-item:hover {
    background-color: #f8f9fa;
    transform: translateX(2px);
}

.search-result-item:last-child .border-bottom {
    border-bottom: none !important;
}

.search-result-name {
    transition: color 0.2s ease;
}

.search-result-item:hover .search-result-name {
    color: #ffbe33 !important;
}

/* Dropdown styling */
.dropdown-menu {
    max-height: 80vh;
    overflow: hidden;
}

/* Ensure dropdown stays open when interacting with results */
.dropdown-menu.show {
    display: block;
}
.food_section .filters_menu li {
    padding: 0; /* Bỏ padding của li */
    margin: 5px; /* nếu muốn khoảng cách giữa các nút */
    list-style: none;
}

.food_section .filters_menu li a {
    display: block; /* cho a chiếm toàn bộ diện tích li */
    padding: 7px 25px; /* padding trước đây của li đưa sang a */
    border-radius: 25px;
    text-decoration: none;
    color: inherit;    
}

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
.dropdown {
    margin-bottom: 1.5%;
}
.error-message {
    color: red;
}
.btn-page {
    display: flex;
    justify-content: center;
    margin-top: 40px;
    gap: 4px;
}

.btn-page a {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 6px 12px;
    border: 1px solid #ffbe33;
    border-radius: 16px;
    color: #ffbe33;
    text-decoration: none;
    transition: all 0.3s ease;
    font-weight: 500;
    font-size: 13px;
    min-width: 32px;
    height: 32px;
    background: white;
    line-height: 1;
}

.btn-page a:hover {
    background-color: #ffbe33;
    color: white;
    transform: scale(1.05);
    box-shadow: 0 2px 8px rgba(255, 190, 51, 0.3);
}

/* Trang hiện tại - giả sử có class active */
.btn-page a.active {
    background-color: #ffbe33;
    color: white;
    border-color: #ffbe33;
    transform: scale(1.08);
}

/* Nút điều hướng đặc biệt (First, Last, Prev, Next) */
.btn-page a:first-child,
.btn-page a:last-child {
    background-color: #ffbe33;
    color: white;
    font-weight: 600;
    padding: 6px 10px;
    font-size: 12px;
}

.btn-page a:first-child:hover,
.btn-page a:last-child:hover {
    background-color: #e6a400;
    transform: scale(1.05);
}

/* Nút Prev/Next */
.btn-page a:nth-child(2),
.btn-page a:nth-last-child(2) {
    background-color: #fff8e6;
    border-color: #ffd166;
    font-size: 12px;
}

/* Responsive cho mobile */
@media (max-width: 576px) {
    .btn-page {
        gap: 3px;
        margin-top: 30px;
    }
    
    .btn-page a {
        padding: 5px 8px;
        min-width: 28px;
        height: 28px;
        font-size: 12px;
        border-radius: 14px;
    }
    
    .btn-page a:first-child,
    .btn-page a:last-child {
        padding: 5px 8px;
        font-size: 11px;
    }
}
</style>
</body>
</html>