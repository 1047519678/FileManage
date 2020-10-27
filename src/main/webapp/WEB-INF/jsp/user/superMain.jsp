<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <title>用户菜单</title>
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/controls.css">
    <style>
        .top {
            background-color: #436884 !important;;
        }

        .nav {
            background-color: #527692;
        }

        .bg-black {
            background-color: #456073 !important;
        }

    </style>
</head>
<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin ">
    <div class="layui-header top">
        <div class="layui-logo"><img src="<%=basePath%>img/bg/logo.png" style="padding-left: 30px;">
        </div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <%--<ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>--%>
        <div style="padding-top: 12px;padding-left: 300px;"><label
                style="color: white; font-size: 30px; font-family: KaiTi; font-weight: bolder;">飞宏物料质量检验资料上传系统</label>
        </div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    ${user.userName}
                </a>
                <dl class="layui-nav-child">
                  <dd><a href="#" onclick="changePwd()">修改密码</a></dd>

                </dl>
            </li>
            <li class="layui-nav-item"><a href="<%=basePath%>user/userOutLogin">注销</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree nav" lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;"> <i class="layui-icon" style="margin-right: 10px;">&#xe672;</i>审核管理</a>
                    <dl class="layui-nav-child " style="padding-left: 10px">
                        <dd><a href="#" data-id="1" data-title="待审核列表" class="site-demo-active"
                               data-url="<%=basePath%>file/jumpFileInfo?status=0&userId=${user.userId}" data-type="tabAdd"> <i
                                class="layui-icon">&#xe623;</i>待审核列表</a></dd>
                        <dd><a href="#" data-id="2" data-title="已审核列表" class="site-demo-active"
                               data-url="<%=basePath%>file/jumpFileInfo?status=1&userId=${user.userId}" data-type="tabAdd"> <i
                                class="layui-icon">&#xe623;</i>已审核列表</a></dd>
                    </dl>
                </li>
                <c:if test="${sessionScope.permissions.get('SuperAdmin')!=null || sessionScope.permissions.get('u1')!=null }">
                    <li class="layui-nav-item layui-nav-itemed">
                        <a href="javascript:;"> <i class="layui-icon" style="margin-right: 10px;">&#xe716;</i>系统管理</a>
                        <dl class="layui-nav-child child" style="padding-left: 10px">
                            <c:if test="${sessionScope.permissions.get('SuperAdmin')!=null || sessionScope.permissions.get('u3')!=null }">
                                <dd><a href="#" data-id="5" data-title="账号管理" class="site-demo-active"
                                       data-url="<%=basePath%>user/userInfo" data-type="tabAdd"> <i class="layui-icon">&#xe623;</i>账号管理</a>
                                </dd>
                            </c:if>
                            <c:if test="${sessionScope.permissions.get('SuperAdmin')!=null || sessionScope.permissions.get('u5')!=null }">
                                <dd><a href="#" data-id="6" data-title="账号类别管理" class="site-demo-active"
                                       data-url="<%=basePath%>user/userShowType" data-type="tabAdd"> <i
                                        class="layui-icon">&#xe623;</i>账号类别管理</a></dd>
                            </c:if>
                            <c:if test="${sessionScope.permissions.get('SuperAdmin')!=null || sessionScope.permissions.get('u2')!=null }">
                                <dd><a href="#" data-id="7" data-title="权限管理" class="site-demo-active"
                                       data-url="<%=basePath%>user/userPermission" data-type="tabAdd"> <i
                                        class="layui-icon">&#xe623;</i>权限管理</a></dd>
                            </c:if>
                        </dl>
                    </li>
                </c:if>
                <%--<li class="layui-nav-item">
                    <a href="javascript:;">用户列表</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">列表一</a></dd>
                        <dd><a href="javascript:;">列表二</a></dd>
                    </dl>
                </li>--%>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div class="layui-tab tab layui-tab-brief" lay-filter="demo" lay-allowclose="true">
            <ul class="layui-tab-title">
            </ul>
            <div class="layui-tab-content">
            </div>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © IQC2020 Copyright.
    </div>
</div>
<div id="changePwd"  style="display:none;text-align: center;font-size: 18px;font-weight: bolder">
    <p style="padding-top: 20px;"><label>原来密码：</label><input type="password" class="inputText" id="oldPwd" style="width: 150px;height: 35px;"></p>
    <p style="padding-top: 20px;"><label>新的密码：</label><input type="password" class="inputText" id="newPwd" style="width: 150px;height: 35px;"></p>
    <p style="padding-top: 20px;"><label>重复密码：</label><input type="password" class="inputText" id="newPwd2" style="width: 150px;height: 35px;"></p>
</div>
<script src="<%=basePath%>layui/layui.all.js"></script>
<script src="<%=basePath%>js/jquery.min.js"></script>
<script>

    layui.use('element', function () {
        var $ = layui.jquery;
        var element = layui.element;
        var active = {
            tabAdd: function (url, id, name) {
                element.tabAdd('demo', {
                    title: name,
                    content: '<iframe data-frameid="' + id + '" scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:99%;"></iframe>',
                    id: id
                });
                FrameWH();
            },
            tabChange: function (id) {
                //切换到指定Tab项
                element.tabChange('demo', id);
            },
            tabDelete: function (id) {
                element.tabDelete("demo", id);
            }
            , tabDeleteAll: function (ids) {
                $.each(ids, function (i, item) {
                    element.tabDelete("demo", item);
                })
            }
        };
        //当点击有site-demo-active属性的标签时，触发点击事件
        $('.site-demo-active').on('click', function () {
            var dataid = $(this);
            if ($(".layui-tab-title li[lay-id]").length <= 0) {
                active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
            } else {
                var isData = false;
                $.each($(".layui-tab-title li[lay-id]"), function () {
                    if ($(this).attr("lay-id") === dataid.attr("data-id")) {
                        active.tabDelete($(this).attr("lay-id"));
                        //isData = true;
                    }
                });
                if (isData === false) {
                    active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
                }
            }
            active.tabChange(dataid.attr("data-id"));
        });

        function FrameWH() {
            var h = $(window).height() - 41 - 10 - 60 - 10 - 44 - 10;
            $("iframe").css("height", h + "px");
        };

        $(window).resize(function () {
            FrameWH();
        })

        window.changePwd=function () {
            layer.open({
                type:1,
                area:['400px','300px'],
                title: '修改密码'
                ,content: $("#changePwd"),
                shade: 0,
                btn: ['更新', '重置']
                ,btn1: function(index, layero){
                    var oldPwd=$('#oldPwd').val().trim();
                    var newPwd=$('#newPwd').val().trim();
                    var newPwd2=$('#newPwd2').val().trim();
                    if(oldPwd==""){
                        alert("请输入原来密码！");
                    }else {
                        if(newPwd=="" ||newPwd2==""){
                            alert("请输入新密码！");
                        }else if(newPwd!=newPwd2){
                            alert("输入新密码不一样");
                        }else{
                            $.ajax({
                                type: "post",
                                url: "<%=basePath%>user/changePwd",
                                data: {"oldPwd": oldPwd,"newPwd":newPwd},
                                dataType: "json",
                                success: function (data) {
                                    alert(data.msg);
                                    if(data.msg=="修改成功"){
                                        $('#oldPwd').val("");
                                        $('#newPwd').val("");
                                        $('#newPwd2').val("");
                                        layer.closeAll();
                                        $('#changePwd').hide();
                                    }
                                }
                            })
                        }
                    }
                },
                btn2: function(index, layero){
                   $('#oldPwd').val("");
                   $('#newPwd').val("");
                   $('#newPwd2').val("");
                    return false;
                },
                cancel: function(layero,index){
                    layer.closeAll();
                    $('#changePwd').hide();
                }

            });

        }
    });
</script>
</body>
</html>