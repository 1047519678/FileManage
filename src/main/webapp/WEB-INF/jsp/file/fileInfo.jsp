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

    <script type="text/html" id="formTest">
        <form class="layui-form layui-form-pane" action="">
            <div class="layui-form-item">
                <div class="layui-inline"><label class="layui-form-label">類別：</label>
                    <div class="layui-input-block"  style="width: 200px;">
                        <select class="form-control" name="species" id="sel4" lay-verify="required" lay-filter="species">
                            <option value="">ALL</option>
                            <c:forEach items="${typeList}" var="type">
                                <option value="${type.typeNo}">${type.typeName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="layui-inline"><label class="layui-form-label">起始时间：</label>
                    <div class="layui-input-block">
                        <input type="text" name="startTime1" id="startTime1" lay-verify="date" placeholder="yyyy-MM-dd"
                               autocomplete="off" class="layui-input" style="width: 200px;float: left">
                    </div>
                </div>
                <div class="layui-inline"><label class="layui-form-label">结束时间：</label>
                    <div class="layui-input-block">
                        <input type="text" name="endTime1" id="endTime1" lay-verify="date" placeholder="yyyy-MM-dd"
                               autocomplete="off" class="layui-input" style="width: 200px;float: left">
                    </div>
                </div>
            </div>
        </form>
    </script>


    <form class="layui-form" action="">
        <div class="layui-form-item">
            <div class="layui-inline"><label class="layui-form-label">類別：</label>
                <div class="layui-input-block"  style="width: 200px;">
                    <select class="form-control" name="species" id="sel2" lay-verify="required" lay-filter="species">
                        <option value="">ALL</option>
                        <c:forEach items="${typeList}" var="type">
                            <option value="${type.typeNo}">${type.typeName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-inline"><label class="layui-form-label">廠商：</label>
                <div class="layui-input-block" style="width: 200px;">
                    <div class="layui-form" lay-filter="vendor">
                    <select name="vendor" id="sel1" lay-verify="required" lay-search lay-filter="vendor1">
                        <option value="">ALL</option>
                        <c:forEach items="${vendorList}" var="vendor">
                            <option value="${vendor.account}">${vendor.vendor}</option>
                        </c:forEach>
                    </select>
                    </div>
                </div>
            </div>
            <div class="layui-inline"><label class="layui-form-label">料號：</label>
                <div class="layui-input-block">
                    <div class="layui-form" lay-filter="partNo" style="width: 200px;">
                        <select name="partNo" id="sel3" lay-verify="required" lay-search>
                            <option value="">ALL</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline"><label class="layui-form-label">起始时间：</label>
                <div class="layui-input-block">
                    <input type="text" name="startTime" id="startTime" lay-verify="date" placeholder="yyyy-MM-dd"
                           autocomplete="off" class="layui-input" style="width: 200px;float: left">
                </div>
            </div>
            <div class="layui-inline"><label class="layui-form-label">结束时间：</label>
                <div class="layui-input-block">
                    <input type="text" name="endTime" id="endTime" lay-verify="date" placeholder="yyyy-MM-dd"
                           autocomplete="off" class="layui-input" style="width: 200px;float: left">
                    <button type="button" id="sel_btn" class="layui-btn layui-btn form1-btn" style="margin-left: 60px;">查 询</button>
                </div>
            </div>
        </div>
    </form>

    <table class="layui-hide" id="test" lay-filter="test"></table>

    <%--table 头部工具栏--%>
    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="formTest">内层样式测试</button>
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
        <a class="layui-btn layui-btn-sm" lay-event="pass" >通过</a>
        <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="reject">错误</a>
        <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="stop">中止</a>
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
    layui.use(['table','form','laydate'], function () {
        var table = layui.table;
        var $ = layui.jquery;
        var form = layui.form;
        var laydate = layui.laydate;
        var status = '${status}';
        var userId = '${user.userId}';
        var factory = '${user.factory}';

        laydate.render({
            elem: '#startTime'
        });
        laydate.render({
            elem: '#endTime',
            type: 'date',
            value: new Date()
        });

        if (status === '0') {
            table.render({
                elem: '#test'
                , url: '<%=basePath%>file/showTable/' + userId + '/' + status + '/' + factory
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , defaultToolbar: ['filter', 'exports', 'print']
                , title: '文件数据表'
                , cols: [[
                    //{field: 'fileDataId', title: 'ID', width: 80, fixed: 'left', unresize: true, sort: true},
                    {field: 'factory', title: '廠別', width: 60}
                    , {field: 'account', title: '客戶代码', width: 110, sort: true}
                    , {field: 'vendor', title: '廠商', width: 130}
                    , {field: 'species', title: '類別', width: 140, templet: function (res) {
                            if (res.species === 'Transformer') {
                                return '變壓器&電感類'
                            } else if (res.species === 'PCB') {
                                return '基板類'
                            } else if (res.species === 'Hardware') {
                                return '五金類'
                            }else if (res.species === 'CASE') {
                                return '蓋子類'
                            } else if (res.species === 'Packing') {
                                return '包材&標簽類'
                            }else if (res.species === 'Wires') {
                                return '線材&端子&插頭類'
                            } else if (res.species === 'Elec.Parts') {
                                return '電子類'
                            }else if (res.species === 'Insulators') {
                                return '絕緣類'
                            } else if (res.species === 'Expendable') {
                                return '耗材類'
                            }
                        }}
                    , {field: 'partNo', title: '料號', width: 160}
                    // , {field: 'fileName', title: '文件名', minWidth: 240}
                    , {field: 'shipTime', title: '出貨時間', width: 110}
                    , {field: 'description', title: '備注', minWidth: 100}
                    , {
                        field: 'uploadTime', title: '上傳時間', width: 160,
                        templet: function (row) {
                            return initTime(row.uploadTime);
                        }
                    }
                    // , {
                    //     field: 'status', title: '文件狀態', width: 90, templet: function (res) {
                    //         if (res.status === 0) {
                    //             return '<em>待審核</em>'
                    //         } else if (res.status === 1) {
                    //             return '<em>已審核</em>'
                    //         } else if (res.status === 2) {
                    //             return '<em>已駁回</em>'
                    //         } else if (res.status === 3) {
                    //             return '<em>已中止</em>'
                    //         }
                    //     }
                    // }
                    , {field: 'preview', fixed: 'right', title: '預覽', toolbar: '#preview', width: 100}
                    , {field: 'operate', fixed: 'right', title: '操作', toolbar: '#barDemo', width: 190}
                ]]
                , page: true
                , limit: 20
                , limits: [20, 40, 60, 80, 100, 500, 1000]
            });
        } else {
            table.render({
                elem: '#test'
                , url: '<%=basePath%>file/showTable/' + userId + '/' + status + '/' + factory
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , defaultToolbar: ['filter', 'exports', 'print']
                , title: '文件数据表'
                , cols: [[
                    //{field: 'fileDataId', title: 'ID', width: 80, fixed: 'left', unresize: true, sort: true},
                    {field: 'factory', title: '廠別', width: 70}
                    ,{field: 'account', title: '客戶代码', width: 120, sort: true}
                    , {field: 'vendor', title: '廠商', width: 150}
                    , {field: 'species', title: '類別', width: 140, templet: function (res) {
                            if (res.species === 'Transformer') {
                                return '變壓器&電感類'
                            } else if (res.species === 'PCB') {
                                return '基板類'
                            } else if (res.species === 'Hardware') {
                                return '五金類'
                            }else if (res.species === 'CASE') {
                                return '蓋子類'
                            } else if (res.species === 'Packing') {
                                return '包材&標簽類'
                            }else if (res.species === 'Wires') {
                                return '線材&端子&插頭類'
                            } else if (res.species === 'Elec.Parts') {
                                return '電子類'
                            }else if (res.species === 'Insulators') {
                                return '絕緣類'
                            } else if (res.species === 'Expendable') {
                                return '耗材類'
                            }
                        }}
                    , {field: 'partNo', title: '料號', width: 180}
                    // , {field: 'fileName', title: '文件名', minWidth: 240}
                    , {field: 'shipTime', title: '出貨時間', width: 110}
                    , {field: 'description', title: '備注', minWidth: 120}
                    , {
                        field: 'uploadTime', title: '上傳時間', width: 180,
                        templet: function (row) {
                            return initTime(row.uploadTime);
                        }
                    }
                    , {
                        field: 'status', title: '文件狀態', width: 90, templet: function (res) {
                            if (res.status === 0) {
                                return '<em>待審核</em>'
                            } else if (res.status === 1) {
                                return '<em>已審核</em>'
                            } else if (res.status === 2) {
                                return '<em>已駁回</em>'
                            } else if (res.status === 3) {
                                return '<em>已中止</em>'
                            }
                        }
                    }
                    , {field: 'preview', fixed: 'right', title: '預覽', toolbar: '#preview', width: 100}
                ]]
                , page: true
                , limit: 20
                , limits: [20, 40, 60, 80, 100, 500, 1000]
            });
        }

        //监听头工具事件
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'formTest':
                    layer.open({
                        title: '内层样式设置'
                        , content: $("#formTest").html()
                        , area: ['610px', '470px']
                        ,btn: '取消'
                        , success: function () {
                            form.render();
                            laydate.render({
                                elem:'#startTime1'//指定元素
                            });
                            laydate.render({
                                elem:'#endTime1'//指定元素
                            });
                        }
                        , cancel: function () {
                            //右上角关闭回调
                            //return false 开启该代码可禁止点击该按钮关闭
                        }
                    });
                    break;
                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('数据表');
                    break;
            }
        });

        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            if (obj.event === 'pass') {
                layer.confirm('确认通过文件：' + data.fileName + '的审核？', function (index) {
                    $.ajax({
                        url: "<%=basePath%>file/alterStatus",
                        type: "post",
                        data: {
                            "fileDataId": data.fileDataId,
                            "qcUser": userId,
                            "status": "1"
                        },
                        dateType: 'json',
                        success: function (result) {
                            if (result === 'success') {
                                selTable();
                            } else {
                                alert('审核出错，请刷新重试！');
                            }
                        },
                    });
                    layer.close(index);
                });
            } else if (obj.event === 'reject') {
                layer.confirm('确认驳回文件：' + data.fileName + '？', function (index) {
                    $.ajax({
                        url: "<%=basePath%>file/alterStatus",
                        type: "post",
                        data: {
                            "fileDataId": data.fileDataId,
                            "qcUser": userId,
                            "status": "2"
                        },
                        dateType: 'json',
                        success: function (result) {
                            if (result === 'success') {
                                selTable();
                            } else {
                                alert('驳回出错，请刷新重试！');
                            }
                        },
                    });
                    layer.close(index);
                });
            }else if (obj.event === 'stop') {
                layer.confirm('确认中止文件：' + data.fileName + '？', function (index) {
                    $.ajax({
                        url: "<%=basePath%>file/alterStatus",
                        type: "post",
                        data: {
                            "fileDataId": data.fileDataId,
                            "qcUser": userId,
                            "status": "3"
                        },
                        dateType: 'json',
                        success: function (result) {
                            if (result === 'success') {
                                selTable();
                            } else {
                                alert('中止任务出错，请刷新重试！');
                            }
                        },
                    });
                    layer.close(index);
                });
            } else if (obj.event === 'preview') {
                $('#account').val(data.account);
                $('#partNo').val(data.partNo);
                $('#fileName').val(data.fileName);
                $('#factory').val(data.factory);
                $('#uploadTime').val(data.uploadTime);
                document.getElementById("sub").click();
            }
        });

        document.querySelector('#sel_btn').addEventListener('click',function (evt) {
            selTable();
        });

        function selTable() {
            var vendor = $('#sel1').val();
            var species = $('#sel2').val();
            var partNo = $('#sel3').val();
            var startTime = $('#startTime').val();
            var endTime = $('#endTime').val();
            table.reload('test', {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                ,url: '<%=basePath%>file/selTable'
                ,type: 'post'
                ,where: {
                    "vendor": vendor,
                    "species": species,
                    "partNo": partNo,
                    "startTime": startTime,
                    "endTime": endTime,
                    "status": status,
                    "userId": userId,
                    "factory": factory
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

        form.on('select(species)', function(data){
            //清空原有select内的数据  只保留第一项
            $("#sel1").find("option:not(:first)").remove();
            //document.getElementById("sel1").options.length = 1;
            form.render('select', 'vendor');//渲染表单
            $.ajax({
                url:'<%=basePath%>file/getVendorList',
                method:'post',
                data: {
                    "species": data.value,
                    "userId": userId
                },
                dataType:'JSON',
                success:function(res){
                    for (var i = 0;i < res.length;i++){
                        $("#sel1").append("<option value='" + res[i].account + "'>" + res[i].vendor + "</option>");
                    }
                    form.render('select', 'vendor');//渲染表单
                },
                error:function (res) {
                }
            });
        });

        form.on('select(vendor1)', function(data){
            //清空原有select内的数据  只保留第一项
            $("#sel3").find("option:not(:first)").remove();
            form.render('select', 'partNo');//渲染表单
            $.ajax({
                url:'<%=basePath%>file/getPartNoList',
                method:'post',
                data: {
                    "userId": data.value
                },
                dataType:'JSON',
                success:function(res){
                    for (var i = 0;i < res.length;i++){
                        $("#sel3").append("<option value='" + res[i].partNo + "'>" + res[i].partNo + "</option>");
                    }
                    form.render('select', 'partNo');//渲染表单
                },
                error:function (res) {
                }
            });
        });

    });

/*    function getAccountList() {
        debugger
        $.ajax({
            url:'<%=basePath%>file/getVendorList',
            method:'post',
            data: {
                "species": $('#sel2').val()
            },
            dataType:'JSON',
            success:function(res){
            },
            error:function (res) {
            }
        });
    }*/

</script>

</body>
</html>
