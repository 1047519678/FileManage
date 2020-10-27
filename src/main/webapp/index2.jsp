<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" pageEncoding="UTF-8" %>
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
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">LOGO</div>
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
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    ${user.account}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="<%=basePath%>userOutLogin">注销</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">列表</a>
                    <dl class="layui-nav-child">
                        <dd><a href="#" data-id="1" data-title="待审核列表" class="site-demo-active"
                               data-url="<%=basePath%>jumpFileInfo?status=0" data-type="tabAdd">待审核列表</a></dd>
                        <dd><a href="#" data-id="2" data-title="已审核列表" class="site-demo-active"
                               data-url="<%=basePath%>jumpFileInfo?status=1" data-type="tabAdd">已审核列表</a></dd>
                        <dd><a href="#"  data-id="3" data-title="已驳回列表" class="site-demo-active"
                               data-url="<%=basePath%>jumpFileInfo?status=2" data-type="tabAdd">已驳回列表</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">上传</a>
                    <dl class="layui-nav-child">
                        <dd><a href="#" data-id="4" data-title="文件上传" class="site-demo-active"
                               data-url="<%=basePath%>jumpUpload" data-type="tabAdd">文件上传</a></dd>
                    </dl>
                </li>
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
<script src="<%=basePath%>layui/layui.all.js"></script>
<script src="<%=basePath%>js/jquery.min.js"></script>
<script>
    layui.use('element',function () {
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
                        isData = true;
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
    });
</script>
</body>
</html>