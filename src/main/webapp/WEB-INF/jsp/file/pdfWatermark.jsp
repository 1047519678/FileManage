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
    <title>PDF添加水印</title>
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
    <form class="layui-form layui-form-pane" lay-filter="form1" method="post" target="_blank" action="<%=basePath%>file/pdfWatermark"
          name="form1" id="form1" enctype="multipart/form-data" style="width: 580px;">
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">水印文字</label>
            <div class="layui-input-block">
                <textarea name="watermarkName" id="watermarkName" required class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">水印大小</label>
            <div class="layui-input-block">
                <input type="text" name="fontSize" value="15" required autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">倾斜角度</label>
            <div class="layui-input-block">
                <input type="text" name="rotation" value="45" required autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">PDF文件</label>
            <div class="layui-input-block">
                <input type="file" name="uploadFile" id="uploadFile" required placeholder="請選擇文件"
                       class="layui-input" accept="application/pdf" onchange="fileChange(this);">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" id="sub" lay-submit>提交</button>
            </div>
        </div>
    </form>
</div>

<script src="<%=basePath%>layui/layui.all.js"></script>
<script src="<%=basePath%>js/jquery.min.js"></script>
<script>
    layui.use(['form', 'laydate'], function () {
        var laydate = layui.laydate;
        var $ = layui.jquery;
        var form = layui.form;

    });

    var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
    function fileChange(target) {
        var fileSize = 0;
        var fileTypes = [".pdf"];
        var filePath = target.value;
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
                layer.alert("只允許上傳PDF文件！");
                target.value = "";
                return false;
            }
        } else {
            return false;
        }
        if (isIE && !target.files) {
            var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
            if (!fileSystem.FileExists(filePath)) {
                layer.alert("文件不存在，請重新選擇！");
                return false;
            }
            var file = fileSystem.GetFile(filePath);
            fileSize = file.Size;
        } else {
            fileSize = target.files[0].size;
        }
        var size = fileSize / 1024;
        if (size <= 0) {
            layer.alert("文件大小不能為0M！");
            target.value = "";
            return false;
        }
    }
</script>

</body>
</html>
