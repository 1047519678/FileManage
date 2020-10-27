<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title>修改密码</title>
    <script src="<%=basePath%>js/jquery-3.0.0.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/controls.css">
</head>
<body>
<p><label>原密码：</label></p>
<p><label>新密码：</label></p>
</body>
</html>
