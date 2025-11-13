<%-- 
    Document   : profile
    Created on : Nov 9, 2025, 10:02:37 PM
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
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/images/favicon.png" type="image/png">

    <title>My Profile - Feane</title>

    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap.css" />
    <link href="<%=request.getContextPath()%>/css/font-awesome.min.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/css/responsive.css" rel="stylesheet" />

    <style>
        .profile_section {
            padding: 90px 0;
            background-color: #ffffff;
        }

        .profile_container {
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 50px;
            margin-top: 30px;
        }

        .heading_container {
            text-align: center;
            margin-bottom: 50px;
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

        .avatar_section {
            text-align: center;
            margin-bottom: 40px;
        }

        .avatar_preview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #ffbe33;
            margin-bottom: 20px;
        }

        .avatar_placeholder {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: #f1f2f3;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            border: 5px solid #ffbe33;
        }

        .avatar_placeholder i {
            font-size: 60px;
            color: #6c757d;
        }

        .btn_change_avatar {
            display: inline-block;
            padding: 10px 30px;
            background-color: #ffbe33;
            color: #ffffff;
            border-radius: 45px;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .btn_change_avatar:hover {
            background-color: #e69c00;
        }

        .form_group {
            margin-bottom: 25px;
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

        .form_group input,
        .form_group textarea {
            width: 100%;
            padding: 12px 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
            transition: all 0.3s;
            outline: none;
        }

        .form_group input:focus,
        .form_group textarea:focus {
            border-color: #ffbe33;
            box-shadow: 0 0 5px rgba(255, 190, 51, 0.3);
        }

        .form_group input:disabled {
            background-color: #f8f9fa;
            cursor: not-allowed;
            opacity: 0.7;
        }

        .form_group textarea {
            resize: vertical;
            min-height: 100px;
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

        .section_divider {
            margin: 50px 0;
            border-top: 2px dashed #e9ecef;
        }

        .security_section {
            text-align: center;
            padding: 30px;
            background: #f8f9fa;
            border-radius: 10px;
        }

        .security_section h4 {
            font-family: 'Dancing Script', cursive;
            color: #222831;
            margin-bottom: 15px;
            font-size: 28px;
        }

        .security_section p {
            color: #6c757d;
            margin-bottom: 20px;
        }

        .btn_change_password {
            display: inline-block;
            padding: 10px 30px;
            background-color: #ffbe33;
            color: #ffffff;
            border-radius: 45px;
            transition: all 0.3s;
            border: none;
            text-decoration: none;
        }

        .btn_change_password:hover {
            background-color: #e69c00;
            text-decoration: none;
            color: white;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .profile_container {
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
        <!-- header section starts -->
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
                        <div class="user_option">
                            <c:if test="${not empty author}">
                                <a href="<%=request.getContextPath()%>/User/Profile" class="user_link">
                                    <i class="fa fa-user" aria-hidden="true"></i>
                                </a>
                            </c:if>                            
                        </div>
                    </div>
                </nav>
            </div>
        </header>
    </div>

    <!-- Profile Section -->
    <section class="profile_section">
        <div class="container">
            <div class="profile_container">
                <div class="profile_header">
                    <h2>My Profile</h2>
                    <p style="color: #6c757d; margin: 0;">Manage your account information</p>
                </div>

                <!-- Success/Error Messages -->
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

                <form action="${pageContext.request.contextPath}/User/UpdateProfile" method="post" 
                      enctype="multipart/form-data">
                                        
                    <div class="avatar_section">
                        <c:choose>
                            <c:when test="${not empty author.avatar}">
                                <img src="<%=request.getContextPath()%>/images/${author.avatar}" 
                                     alt="Avatar" class="avatar_preview" id="avatarPreview">
                            </c:when>
                            <c:otherwise>
                                <div class="avatar_placeholder">
                                    <i class="fa fa-user"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div>
                            <label for="avatarInput" class="btn_custom btn_update" style="cursor: pointer;">
                                <i class="fa fa-camera"></i> Change Avatar
                            </label>
                            <input type="file" id="avatarInput" name="avatar" accept="image/*" 
                                   style="display: none;" onchange="previewAvatar(this)">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form_group">
                                <label><i class="fa fa-envelope"></i> Email</label>
                                <input type="email" name="email" value="${author.email}" disabled>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form_group">
                                <label><i class="fa fa-user"></i> First Name *</label>
                                <input type="text" name="firstName" value="${author.firstName}" 
                                       required placeholder="Enter first name">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form_group">
                                <label><i class="fa fa-user"></i> Last Name *</label>
                                <input type="text" name="lastName" value="${author.lastName}" 
                                       required placeholder="Enter last name">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form_group">
                                <label><i class="fa fa-phone"></i> Phone Number</label>
                                <input type="tel" name="phone" value="${author.phone}" 
                                       placeholder="Enter phone number" pattern="[0-9]{10,11}">
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form_group">
                                <label><i class="fa fa-map-marker"></i> Address</label>
                                <textarea name="address" rows="3" placeholder="Enter your address">${author.address}</textarea>
                            </div>
                        </div>
                    </div>
                    <div class="btn_group">
                        <button type="submit" class="btn_custom btn_update">
                            <i class="fa fa-save"></i> Update Profile
                        </button>
                        <a href="${pageContext.request.contextPath}/User/HomePage" class="btn_custom btn_cancel">
                            <i class="fa fa-times"></i> Cancel
                        </a>
                    </div>
                </form>
                <div class="section_divider"></div>
                <div style="text-align: center;">
                    <h4 style="color: #222831; margin-bottom: 15px;">Security</h4>
                    <p style="color: #6c757d; margin-bottom: 20px;">
                        Keep your account secure by updating your password regularly
                    </p>
                    <a href="${pageContext.request.contextPath}/User/ChangePassword" class="btn_change_password">
                        <i class="fa fa-lock"></i> Change Password
                    </a>
                </div>
            </div>
        </div>
    </section>  

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

<script src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/js/custom.js"></script>
<script>
    // Preview avatar before upload
    function previewAvatar(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var preview = document.getElementById('avatarPreview');
                if (preview) {
                    preview.src = e.target.result;
                } else {
                    // Create new image element if placeholder was shown
                    var avatarSection = document.querySelector('.avatar_section');
                    var placeholder = document.querySelector('.avatar_placeholder');
                    if (placeholder) {
                        placeholder.remove();
                    }
                    var img = document.createElement('img');
                    img.id = 'avatarPreview';
                    img.className = 'avatar_preview';
                    img.src = e.target.result;
                    avatarSection.insertBefore(img, avatarSection.firstChild);
                }
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
    // Auto-hide alerts after 5 seconds
    setTimeout(function() {
        $('.alert').fadeOut('slow');
    }, 5000);
    // Display current year in footer
    document.getElementById('displayYear').textContent = new Date().getFullYear();
</script>
</body>
</html>