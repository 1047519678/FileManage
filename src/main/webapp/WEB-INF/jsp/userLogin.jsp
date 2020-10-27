<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>用户登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/style.css">

    <style>
        .btn-primary {
            background-color: #337ab7;
            color: #FFF;
            border-color: #337ab7;
        }

        .flat-blue {
            background-color: #F9F9F9;
        }

        .login-header {
            color: #FFF;
        }

        body {
            background-image: url(<%=basePath%>img/bg/login.png);
            background-size: cover;
            background-repeat: no-repeat;
        }

        input {
            box-sizing: border-box;
            border: 1px solid rgba(0, 0, 0, 1.00);
            color: #000000;
            text-decoration: none;
            width: 100%;
            font-family: "幼圆";
        }
        .row{
            margin-right: 0px;
        }
        .container {
            width: 600px;
            text-align: center;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            padding: 0px;
        }

        .left {
            float: left;
            width: 49%;
            height: 280px;
            margin-bottom: 25px;
            display: inline-block;
           /* margin-left: 15px;*/
        }

        .right {
            float: right;
            width: 49%;
            display: inline-block;
        }
        .title2{
            background-color: #1e7db9;
            width: 340px;
            font-size: 24px;
            margin-top: 40px;
            color: white;
            font-family: KaiTi;
        }
    </style>
</head>

<body class="flat-blue login-page">
<div class="container">
    <%--<div class="login-box">
        <h4 style="padding: 20px 0px;margin: 0px;font-size: 30px;font-family: KaiTi;font-weight: bolder;">飞宏品质保证书上传系统</h4>
    </div>--%>
    <div class="left">
        <div>

            <div class="login-form row">
                <div class="row">
                    <div class="col-xs-12" style="height: 280px;background-color: #337ab7;">
                        <div class="card">
                            <div class="card-header" style="background-color: #337ab7;padding-top: 60px;">
                                <img src="<%=basePath%>img/bg/logo.png">
                            </div>
                        </div>
                        <div class="card-body">
                            <label class="title2">飞宏物料质量检验资料</label><br>
                            <label  class="title2" style="margin-top: 0px;">上传系统</label>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="right">
        <div>
            <%-- <div class="div-left">
                 <h4 style="padding: 20px 0px;margin: 0px;font-size: 30px;font-family: KaiTi;font-weight: bolder;">飞宏品质保证书上传系统</h4>
             </div>--%>
            <div class="login-form row">
                <%--                <div class="col-sm-12 text-center login-header" style="padding: 0px;margin: 0px;background-color: #337ab7;">--%>
                <%--&lt;%&ndash;                    <i class="login-logo fa fa-fighter-jet fa-5x"></i>&ndash;%&gt;--%>
                <%--                    <h4 style="padding: 20px 0px;margin: 0px;font-size: 30px;font-family: KaiTi;font-weight: bolder;">飞宏品质保证书上传系统</h4>--%>
                <%--                </div>--%>
                <div class="row">
                    <div class="col-xs-12" style="height: 280px;background-color: #ffffff;">
                        <div class="card">
                            <div class="card-header">
                                <div style="padding-top:10px;font-size: 20px;">
                                    <div class="title">用户登录</div>
                                </div>
                            </div>
                            <div class="card-body">
                                <form id="loginform" name="loginform" class="form-vertical" method="post"
                                      action="<%=basePath%>user/checkLogin" onSubmit="return mycheck()">
                                    <div class="control">
                                        <input type="text" class="form-control" placeholder="账户名" name="userId"/>
                                    </div>
                                    <div class="control">
                                        <input type="password" class="form-control" placeholder="密码" name="password" value="123"/>
                                    </div>
                                    <div class="login-button text-center">
                                        <input type="submit" class="btn btn-primary" value="登陆">
                                    </div>
                                    <br/>
                                    <p align="center">
                                        <front size="2">${msg}</front>
                                    </p>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Javascript Libs -->
<script type="text/javascript" src="<%=basePath%>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
<!--登陆检查-->
<script>
    if (top !== this) {
        parent.location.reload();
    }

    function mycheck() {
        if (isNull(loginform.userId.value)) {
            alert("请输入用户名！");
            return false;
        }
        if (isNull(loginform.password.value)) {
            alert("请输入密码！");
            return false;
        }
    }

    function isNull(str) {
        if (str === "") return true;
        var regu = "^[ ]+$";
        var re = new RegExp(regu);
        return re.test(str);
    }
</script>
</body>
</html>