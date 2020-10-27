<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <title>Title</title>
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
</head>
<body>
<div style="flex: 1;">

    <form class="layui-form" action="">
        <div class="layui-form-item">
            <div class="layui-inline"><label class="layui-form-label">客戶：</label>
                <div class="layui-input-block" style="width: 200px;">
                    <select name="factory" id="sel1" lay-verify="required">
                        <option value=""></option>
                        <option value="phc">銀湖飛宏厂</option>
                        <option value="phcj">鉄松飛宏厂</option>
                        <option value="php">達宏厂</option>
                        <option value="phv">越南厂</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline"><label class="layui-form-label">料號：</label>
                <div class="layui-input-block">
                    <div class="layui-form" lay-filter="partNo" style="width: 200px;">
                        <select name="partNo" id="sel2" lay-verify="required" lay-search>
                            <option value="">ALL</option>
                            <c:forEach items="${partList}" var="part">
                                <option value="${part.partNo}">${part.partNo}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-inline"><label class="layui-form-label">出貨時間：</label>
                <div class="layui-input-block">
                    <input type="text" name="shipTime" id="shipTime" lay-verify="date" placeholder="yyyy-MM-dd"
                           autocomplete="off" class="layui-input" style="width: 200px;float: left">
                    <button type="button" id="sel_btn" class="layui-btn layui-btn form1-btn" style="margin-left: 60px;">查 詢</button>
                </div>
            </div>
        </div>
    </form>

    <table class="layui-hide" id="test" lay-filter="test"></table>

    <%--table 头部工具栏--%>
    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <%--            <button class="layui-btn layui-btn-sm" lay-event="addData">文件上传</button>--%>
        </div>
    </script>

    <%--table 文件预览栏--%>
    <script type="text/html" id="preview">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="preview">文件预览</button>
        </div>
    </script>

    <%-- table 编辑栏 --%>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="pass">通过</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="reject">驳回</a>
    </script>

</div>

<%-- 隐藏区域 start --%>
<form class="form-horizontal" name="form1"
      method="post"
      target="_blank"
      action="<%=basePath%>file/preview"
      enctype="multipart/form-data" style="width: 580px;display: none">
    <input type="text" name="account" id="account" required placeholder="">
    <input type="text" name="partNo" id="partNo" required placeholder="">
    <input type="text" name="fileName" id="fileName" required placeholder="">
    <input type="text" name="factory" id="factory" required placeholder="">
    <input type="text" name="uploadTime" id="uploadTime" required placeholder="">
    <button type="submit" id="sub" class="btn btn-primary">确认</button>
</form>
<%-- 隐藏区域 end --%>

<script src="<%=basePath%>layui/layui.all.js"></script>
<script src="<%=basePath%>js/jquery.min.js"></script>
<script>
    layui.use(['table', 'form', 'laydate'], function () {
        var table = layui.table;
        var $ = layui.jquery;
        var form = layui.form;
        var laydate = layui.laydate;
        var status = '${status}';
        var account = '${account}';

        laydate.render({
            elem: '#shipTime',
            type: 'date',
            value: new Date()
        });

        table.render({
            elem: '#test'
            , url: '<%=basePath%>file/showUserTable/' + account
            // , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            // , defaultToolbar: ['filter', 'exports']
            , title: '文件数据表'
            , cols: [[
                {
                    field: 'factory', title: '客戶', minWidth: 70, templet: function (res) {
                        if (res.factory === 'phc') {
                            return '銀湖飛宏厂'
                        } else if (res.factory === 'phcj') {
                            return '鉄松飛宏厂'
                        } else if (res.factory === 'php') {
                            return '達宏厂'
                        } else if (res.factory === 'phv') {
                            return '越南厂'
                        }
                    }
                }
                , {
                    field: 'species', title: '類別', minWidth: 100, templet: function (res) {
                        if (res.species === 'Transformer') {
                            return '變壓器&電感類'
                        } else if (res.species === 'PCB') {
                            return '基板類'
                        } else if (res.species === 'Hardware') {
                            return '五金類'
                        } else if (res.species === 'CASE') {
                            return '蓋子類'
                        } else if (res.species === 'Packing') {
                            return '包材&標簽類'
                        } else if (res.species === 'Wires') {
                            return '線材&端子&插頭類'
                        } else if (res.species === 'Elec.Parts') {
                            return '電子類'
                        } else if (res.species === 'Insulators') {
                            return '絕緣類'
                        } else if (res.species === 'Expendable') {
                            return '耗材類'
                        }
                    }
                }
                , {field: 'partNo', title: '料號', minWidth: 150}
                , {field: 'fileName', title: '文件名', minWidth: 240}
                , {field: 'shipTime', title: '出貨時間', minWidth: 110}
                , {field: 'description', title: '備注', minWidth: 100}
                , {
                    field: 'uploadTime', title: '上傳時間', minWidth: 160, templet: function (row) {
                        return initTime(row.uploadTime);
                    }
                }
                , {
                    field: 'status', title: '文件狀態', minWidth: 90, hide: true}
                , {field: 'preview', fixed: 'right', title: '預覽', toolbar: '#preview', minWidth: 100}
            ]]
            , done:function (res, curr, count) {
                //判断某一列是图片的话，给下划线
                var re = res.data;
                if(re.length>0){
                    $.each(re,function (ii,dd) {
                        if(dd.status===2 || dd.status===3){
                            $($(".layui-table-body.layui-table-main tr")[ii]).css("background-color", "rgba(247, 139, 139, 1)");
                            $($(".layui-table-body.layui-table-main tr")[ii]).css("color", "#333");
                            //$($("div .layui-table-fixed.layui-table-fixed-l .layui-table-body tr")[ii]).css("background-color", "#ff0000");
                        }

                    })
                }

            }
            , page: true
            , limit: 20
            , limits: [20, 40, 60, 80, 100, 500, 1000]
        });

        //监听头工具事件
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('数据表');
                    break;
            }
        });

        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            if (obj.event === 'preview') {
                $('#account').val(data.account);
                $('#partNo').val(data.partNo);
                $('#fileName').val(data.fileName);
                $('#factory').val(data.factory);
                $('#uploadTime').val(data.uploadTime);
                document.getElementById("sub").click();
            }
        });

        document.querySelector('#sel_btn').addEventListener('click', function (evt) {
            selTable();
        });

        function selTable() {
            var factory = $('#sel1').val();
            var partNo = $('#sel2').val();
            var shipTime = $('#shipTime').val();
            table.reload('test', {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                , url: '<%=basePath%>file/selUserTable'
                , type: 'post'
                , where: {
                    "factory": factory,
                    "partNo": partNo,
                    "shipTime": shipTime,
                    "account": account
                }
            });
        }

        function initTime(v) {
            var date = new Date(v);
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            m = m < 10 ? '0' + m : m;
            var d = date.getDate();
            d = d < 10 ? ("0" + d) : d;
            var h = date.getHours();
            h = h < 10 ? ("0" + h) : h;
            var M = date.getMinutes();
            M = M < 10 ? ("0" + M) : M;
            var s = date.getSeconds();
            s = s < 10 ? ("0" + s) : s;
            var str = y + "-" + m + "-" + d + " " + h + ":" + M + ":" + s;
            return str;
        }

    });
</script>

</body>
</html>
