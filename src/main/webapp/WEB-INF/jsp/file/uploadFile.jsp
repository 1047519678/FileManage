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
    <style>
        .centerTo {
            /*width: 100%;
            max-width: 320px;
            padding: 0;*/
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
    </style>
</head>
<body>
<div style="flex: 1;padding: 10px">
    <%-- 文件上传 form --%>
    <form class="layui-form layui-form-pane" lay-filter="form1" method="post"
          name="form1" id="form1" enctype="multipart/form-data" style="width: 580px;">
        <div class="layui-form-item" style="display: none">
            <label class="layui-form-label">賬號</label>
            <div class="layui-input-block">
                <input type="text" name="account" required lay-verify="required"
                       readonly="readonly" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" style="display: none">
            <label class="layui-form-label">廠商</label>
            <div class="layui-input-block">
                <input type="text" name="vendor" required lay-verify="required"
                       readonly="readonly" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">料號</label>
            <div class="layui-input-block">
                <select name="partNo" id="partNo" lay-verify="required" lay-search>
                    <option value=""></option>
                    <c:forEach items="${partList}" var="part">
                        <option value="${part.partNo}">${part.partNo}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">類別</label>
            <div class="layui-input-block">
                <select name="species" lay-verify="required">
                    <c:forEach items="${typeList}" var="type">
                        <option value="${type.typeNo}">${type.typeName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">客戶</label>
            <div class="layui-input-block">
                <select name="factory" lay-verify="required">
                    <option value=""></option>
                    <option value="phc">銀湖飛宏厂</option>
                    <option value="phcj">鉄松飛宏厂</option>
                    <option value="php">達宏厂</option>
                    <option value="phv">越南厂</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">出貨日期</label>
            <div class="layui-input-block">
                <input type="text" name="shipTime" id="shipTime" lay-verify="date" placeholder="yyyy-MM-dd"
                       autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item" pane>
            <label class="layui-form-label">上傳次數</label>
            <div class="layui-input-block">
                <input type="radio" name="times" lay-filter="times" value="01" title="第一次上傳" checked>
                <input type="radio" name="times" lay-filter="times" value="02" title="第二次上傳">
                <input type="radio" name="times" lay-filter="times" value="03" title="第三次上傳">
            </div>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">備注</label>
            <div class="layui-input-block">
                <textarea name="description" id="description" placeholder="第二、三次上傳時需備注"
                          class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">文件</label>
            <div class="layui-input-block">
                <input type="file" name="file" id="file" required lay-verify="required" placeholder="請選擇文件"
                       class="layui-input" accept="application/pdf" onchange="fileChange(this);">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" id="sub" lay-submit lay-filter="formDemo">提交</button>
            </div>
        </div>
    </form>
</div>
<div id="loading" class="centerTo" style="display:none">
    <%--<img src="<%=basePath%>img/loading.gif"/>--%>
    <h2>loading</h2>
    <svg xmlns="http://www.w3.org/2000/svg" width="60px" height="60px" viewBox="0 0 50 50"
         style="enable-background:new 0 0 50 50" xml:space="preserve">
        <path fill="#FF6700"
              d="M43.935,25.145c0-10.318-8.364-18.683-18.683-18.683c-10.318,0-18.683,8.365-18.683,18.683h4.068c0-8.071,6.543-14.615,14.615-14.615c8.072,0,14.615,6.543,14.615,14.615H43.935z"
              transform="rotate(275.098 25 25)">
            <animateTransform attributeType="xml" attributeName="transform" type="rotate" from="0 25 25" to="360 25 25"
                              dur="0.6s" repeatCount="indefinite"></animateTransform>
        </path>
    </svg>
</div>
<%-- 隐藏区域 start --%>
<input type="hidden" name="path" id="path">
<input type="hidden" name="fileName" id="fileName">
<%-- 隐藏区域 end --%>
<script src="<%=basePath%>layui/layui.all.js"></script>
<script src="<%=basePath%>js/jquery.min.js"></script>
<script>
    layui.use(['form', 'laydate'], function () {
        var laydate = layui.laydate;
        var $ = layui.jquery;
        var form = layui.form;

        form.val("form1", {
            "account": "${user.userId}",
            "vendor": "${user.factory}",
            "species": "${typeNo}"
        });

        laydate.render({
            elem: '#shipTime',
            type: 'date',
            value: new Date()
        });

        form.on('radio(times)', function (data) {
            var times = data.value;
            if (times === "02" || times === "03") {
                $('#description').attr('lay-verify', 'required');
            } else {
                $('#description').removeAttr('lay-verify');
            }
        });

    });

    //监听form提交
    $('#form1').submit(function (e) {
        debugger
        loadStart();
        e.preventDefault();//阻止按钮默认提交
        var formData = new FormData($('#form1')[0]);
        $.ajax({
            url: "<%=basePath%>file/upload",
            type: 'POST',
            cache: false,
            data: formData,
            processData: false,
            contentType: false,
            dataType: "json",
            success: function (result) {
                e.preventDefault();//阻止按钮默认提交
                loadStop();
                alert(result.msg);
                debugger;
                if (result.msg == "上传成功！") {
                    window.location.reload();
                    // $('#description').val("");
                    // $('#file').val("");
                }
            }
        });
    });

    function loadStart() {
        var load = document.getElementById("loading");
        if (load.style.display === 'none') {
            load.setAttribute("style", "display: block");
        }
    }

    function loadStop() {
        var load = document.getElementById("loading");
        if (load.style.display === 'block') {
            load.setAttribute("style", "display: none");
        }
    }

    var isIE = /msie/i.test(navigator.userAgent) && !window.opera;

    function fileChange(target) {
        var fileSize = 0;
        var fileTypes = [".pdf"];
        var filePath = target.value;
        var fileMaxSize = 1024 * 5;
        if (filePath) {
            var isNext = false;
            var fileEnd = filePath.substring(filePath.lastIndexOf("."));
            if (fileTypes && fileTypes.length > 0) {
                for (var i = 0; i < fileTypes.length; i++) {
                    if (fileTypes[i] === fileEnd) {
                        isNext = true;
                        break;
                    }
                }
            }
            if (!isNext) {
                alert("只允許上傳PDF文件！");
                target.value = "";
                return false;
            }
        } else {
            return false;
        }
        if (isIE && !target.files) {
            var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
            if (!fileSystem.FileExists(filePath)) {
                alert("文件不存在，請重新選擇！");
                return false;
            }
            var file = fileSystem.GetFile(filePath);
            fileSize = file.Size;
        } else {
            fileSize = target.files[0].size;
        }
        var size = fileSize / 1024;
        if (size > fileMaxSize) {
            alert("文件大小不能大於" + fileMaxSize / 1024 + "M！");
            target.value = "";
            return false;
        }
        if (size <= 0) {
            alert("文件大小不能為0M！");
            target.value = "";
            return false;
        }
    }
</script>

</body>
</html>
