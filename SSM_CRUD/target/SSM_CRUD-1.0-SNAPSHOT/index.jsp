<%--
  Created by IntelliJ IDEA.
  User: wangziao
  Date: 2021/11/25
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录注册</title>
    <%
        pageContext.setAttribute ("BasePath", request.getContextPath ());
    %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- Google fonts -->
    <%--<link href="//fonts.googleapis.com/css2?family=Kumbh+Sans:wght@300;400;700&display=swap" rel="stylesheet">--%>

    <!-- CSS Stylesheet -->
    <link rel="stylesheet" href="${BasePath}/static/css/style.css" type="text/css" media="all" />
    <%--引入jquery--%>
    <script type="text/javascript" src="${BasePath}/static/js/jquery-1.12.4.min.js"></script>
</head>
<body>
<div class="signinform">
    <h1>欢迎登录博客系统</h1>
    <!-- container -->
    <div class="container">
        <!-- main content -->
        <div class="w3l-form-info">
            <div class="w3_info">
                <h2>请输入用户名和密码</h2>
                <form id="login_form">
                    <div class="input-group">
                        <span><i class="fas fa-user" aria-hidden="true"></i></span>
                        <input type="email" placeholder="用户名" id="login_name" name="uname">
                    </div>
                    <div class="input-group">
                        <span><i class="fas fa-key" aria-hidden="true"></i></span>
                        <input type="Password" placeholder="密码" id="login_password" name="password">
                    </div>
                    <div class="input-group">
                        <span><i class="fas fa-code" aira-hidden="true"></i></span>
                        <input type="text" name="code" style="width: 150px;" id="code" placeholder="验证码"/>
                        <img id="code_img" alt="" src="kaptcha.jpg" style="float: right; margin-right: 40px; width:80px; height: 30px">
                    </div>
                    <button class="btn btn-primary btn-block" type="button" id="login_btn">登录</button>
                    <span>还没有帐号？赶紧<a href="${BasePath}/regist" style="color: #1da1f2">注册</a></span>
                </form>
            </div>
        </div>
        <!-- //main content -->
    </div>
    <!-- //container -->
    <!-- footer -->
    <div class="footer">
        <p>&copy; 2021 Service login form. All Rights Reserved | Design by wanghao
            <%--<a href="https://w3layouts.com/"   target="blank">W3layouts</a>--%>
        </p>
    </div>
    <!-- footer -->
</div>

<!-- fontawesome v5-->
<script src="${BasePath}/static/js/fontawesome.js"></script>
<script type="text/javascript">
    $(function () {
        $("#login_btn").click(function () {
            $.ajax({
                url:"${BasePath}/loginVerify",
                type:"POST",
                data:$("#login_form").serialize(),
                success:function (result) {
                    console.log(result);
                    if(result.code == 200)
                    {
                        window.location.href = "${BasePath}/login_success"
                    }else if(result.code == 250){
                        alert("登录失败,"+result.extend.errmsg);
                        document.getElementById("login_form").reset();
                    }
                }
            })
        })

        //刷新验证码
        $("#code_img").click(function () {
            this.src="kaptcha.jpg";
        });

    });
</script>
</body>
</html>
