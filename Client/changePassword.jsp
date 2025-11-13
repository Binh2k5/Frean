<%-- 
    Document   : changePassword
    Created on : Nov 9, 2025, 11:31:34 PM
    Author     : BINH
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/images/favicon.png" type="image/png">

    <title>Change Password - Feane</title>

    <!-- bootstrap core css -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap.css" />
    <!-- font awesome style -->
    <link href="<%=request.getContextPath()%>/css/font-awesome.min.css" rel="stylesheet" />
    <!-- Custom styles -->
    <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" />
    <!-- responsive style -->
    <link href="<%=request.getContextPath()%>/css/responsive.css" rel="stylesheet" />

    <style>
        .change_password_section {
            padding: 90px 0;
            background-color: #ffffff;
            min-height: calc(100vh - 200px);
        }
        .password_container {
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 50px;
            max-width: 600px;
            margin: 30px auto;
        }
        .heading_container {
            text-align: center;
            margin-bottom: 40px;
        }
        .heading_container h2 {
            font-family: 'Dancing Script', cursive;
            font-size: 2.5rem;
            font-weight: bold;
            color: #222831;
            margin-bottom: 10px;
        }
        .heading_container h2 span {
            color: #ffbe33;
        }
        .heading_container p {
            color: #666;
            margin: 0;
        }
        .form_group {
            margin-bottom: 25px;
            position: relative;
        }
        .form_group label {
            font-weight: 600;
            color: #222831;
            margin-bottom: 8px;
            display: block;
            font-size: 15px;
        }
        .form_group label i {
            margin-right: 5px;
            color: #ffbe33;
        }
        .form_group input {
            width: 100%;
            padding: 12px 45px 12px 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
            transition: all 0.3s;
            outline: none;
        }
        .form_group input:focus {
            border-color: #ffbe33;
            box-shadow: 0 0 5px rgba(255, 190, 51, 0.3);
        }
        .toggle_password {
            position: absolute;
            right: 15px;
            top: 43px;
            cursor: pointer;
            color: #666;
        }
        .toggle_password:hover {
            color: #ffbe33;
        }
        .password_requirements {
            font-size: 13px;
            color: #666;
            margin-top: 5px;
            padding-left: 20px;
        }
        .password_requirements li {
            margin: 3px 0;
        }
        .btn_group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
        }
        .btn_submit,
        .btn_cancel {
            padding: 10px 45px;
            border-radius: 45px;
            font-weight: 600;
            text-transform: uppercase;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 15px;
            text-decoration: none;
            display: inline-block;
        }
        .btn_submit {
            background: #ffbe33;
            color: #ffffff;
        }
        .btn_submit:hover {
            background: #e69c00;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 190, 51, 0.3);
        }
        .btn_cancel {
            background: #6c757d;
            color: white;
        }
        .btn_cancel:hover {
            background: #5a6268;
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
        }
        @media (max-width: 768px) {
            .password_container {
                padding: 30px 20px;
            }

            .btn_group {
                flex-direction: column;
            }

            .btn_submit,
            .btn_cancel {
                width: 100%;
            }
        }
    </style>
</head>

<body class="sub_page">
    <div class="hero_area">        
        <header class="header_section">
            <div class="container">
                <nav class="navbar navbar-expand-lg custom_nav-container">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/User/HomePage">
                        <span>Feane</span>
                    </a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" 
                            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" 
                            aria-expanded="false" aria-label="Toggle navigation">
                        <span class=""></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav mx-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="<%=request.getContextPath()%>/User/HomePage">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/User/Menu">Menu</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<%=request.getContextPath()%>/User/About">About</a>
                            </li>
                        </ul>                        
                    </div>
                </nav>
            </div>
        </header>        
    </div>
    
    <section class="change_password_section">
        <div class="container">
            <div class="heading_container">
                <h2>
                    Change <span>Password</span>
                </h2>
                <p>Update your password to keep your account secure</p>
            </div>

            <div class="password_container">                
                <c:if test="${not empty successMsg}">
                    <div class="alert alert-success" role="alert">
                        <i class="fa fa-check-circle"></i> ${successMsg}
                    </div>
                </c:if>
                <c:if test="${not empty errorMsg}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fa fa-exclamation-circle"></i> ${errorMsg}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/User/ChangePassword" method="post" onsubmit="return validatePassword()">                                        
                    <div class="form_group">
                        <label><i class="fa fa-lock"></i> Current Password *</label>
                        <input type="password" id="currentPassword" name="currentPassword" 
                               required placeholder="Enter current password">                        
                    </div>
                    
                    <div class="form_group">
                        <label><i class="fa fa-lock"></i> New Password *</label>
                        <input type="password" id="newPassword" name="newPassword" 
                               required placeholder="Enter new password" onkeyup="checkPasswordStrength()">
                        
                        <ul class="password_requirements">
                            <li>At least 6 characters</li>
                            <li>Contains uppercase and lowercase letters</li>
                            <li>Contains at least one number</li>
                        </ul>
                    </div>
                    
                    <div class="form_group">
                        <label><i class="fa fa-lock"></i> Confirm New Password *</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" 
                               required placeholder="Confirm new password">
                        
                    </div>
                    
                    <div class="btn_group">
                        <button type="submit" class="btn_submit" name="action" value="change">
                            <i class="fa fa-key"></i> Change Password
                        </button>
                        <a href="${pageContext.request.contextPath}/User/UpdateProfile" class="btn_cancel">
                            <i class="fa fa-times"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <!-- end change password section -->

    <!-- footer section -->
    <footer class="footer_section">
        <div class="container">
            <div class="row">
                <div class="col-md-4 footer-col">
                    <div class="footer_contact">
                        <h4>Contact Us</h4>
                        <div class="contact_link_box">
                            <a href="https://www.google.com/maps?q=FPT+University+Hanoi" target="_blank">
                                <i class="fa fa-map-marker" aria-hidden="true"></i>
                                <span>FPT University Hanoi</span>
                            </a>
                            <a href="tel:+846790998">
                                <i class="fa fa-phone" aria-hidden="true"></i>
                                <span>Call +84 6790998</span>
                            </a>
                            <a href="mailto:support@foodstore.com">
                                <i class="fa fa-envelope" aria-hidden="true"></i>
                                <span>support@foodstore.com</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 footer-col">
                    <div class="footer_detail">
                        <a href="" class="footer-logo">Feane</a>
                        <p>Necessary, making this the first true generator on the Internet. 
                           It uses a dictionary of over 200 Latin words, combined with</p>
                        <div class="footer_social">
                            <a href="https://www.facebook.com/tiengtrungFPT" target="_blank">
                                <i class="fa fa-facebook" aria-hidden="true"></i>
                            </a>
                            <a href=""><i class="fa fa-twitter" aria-hidden="true"></i></a>
                            <a href=""><i class="fa fa-linkedin" aria-hidden="true"></i></a>
                            <a href=""><i class="fa fa-instagram" aria-hidden="true"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 footer-col">
                    <h4>Opening Hours</h4>
                    <p>Everyday</p>
                    <p>10.00 Am - 10.00 Pm</p>
                </div>
            </div>
            <div class="footer-info">
                <p>&copy; <span id="displayYear"></span> All Rights Reserved By
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
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
    <!-- custom js -->
    <script src="<%=request.getContextPath()%>/js/custom.js"></script>

    <script>
        

        // Check password strength
        function checkPasswordStrength() {
            const password = document.getElementById('newPassword').value;
            const requirements = document.querySelectorAll('.password_requirements li');
            
            // Check length
            if (password.length >= 6) {
                requirements[0].style.color = 'green';
            } else {
                requirements[0].style.color = '#666';
            }
            
            // Check uppercase and lowercase
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) {
                requirements[1].style.color = 'green';
            } else {
                requirements[1].style.color = '#666';
            }
            
            // Check number
            if (/\d/.test(password)) {
                requirements[2].style.color = 'green';
            } else {
                requirements[2].style.color = '#666';
            }
        }

        // Validate password before submit
        function validatePassword() {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            // Check if passwords match
            if (newPassword !== confirmPassword) {
                alert('New password and confirm password do not match!');
                return false;
            }
            
            // Check password strength
            if (newPassword.length < 6) {
                alert('Password must be at least 6 characters long!');
                return false;
            }
            
            if (!/[a-z]/.test(newPassword) || !/[A-Z]/.test(newPassword)) {
                alert('Password must contain both uppercase and lowercase letters!');
                return false;
            }
            
            if (!/\d/.test(newPassword)) {
                alert('Password must contain at least one number!');
                return false;
            }
            
            return true;
        }

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            $('.alert').fadeOut('slow');
        }, 5000);
    </script>
</body>
</html>