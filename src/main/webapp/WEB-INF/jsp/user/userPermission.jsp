<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title>权限管理</title>
    <link rel="stylesheet" href="<%=basePath%>css/table.css">
    <link rel="stylesheet" href="<%=basePath%>css/controls.css">
    <link rel="stylesheet" href="<%=basePath%>css/shade.css">
    <script src="<%=basePath%>js/jquery-3.0.0.js"></script>
    <script src="<%=basePath%>js/paging.js"></script>
    <style type="text/css">
        .pop {
            width: 360px;
            height: 300px;
            min-height: 210px;
            max-height: 280px;
            padding: 5px;
        }

        .pop-content-right {
            width: 350px;
            font-size: 16px;
            line-height: 35px;
            padding-left: 0px;
            padding-top: 10px;
           font-weight: bolder;
        }

        .pop-content {
            height: 210px;
            text-align: center;
        }

        .pop-top {
            height: 25px;
            width: 100%;
            border-bottom: 1px #E5E5E5 solid;
        }

        .pop-cancel, .pop-ok {
            margin: 0px;
        }

        .pop-content-right input{
            width: 150px;
            height: 35px;
            font-weight: bolder;
            font-size: 15px;
        }

    </style>
</head>
<body>
<!--遮罩层-->
<div class="bgPop"></div>
<!--弹出框-->
<div class="pop">
    <div class="pop-top">
        <label style="float: left;font-size: 20px;font-weight: bolder;font-family: KaiTi;">添加或修改</label>
        <span class="pop-close">Ｘ</span>
    </div>
    <div class="pop-content">
        <div class="pop-content-left">
            <img src="" alt="" class="teathumb">
        </div>
        <div class="pop-content-right">
            <input type="hidden" id="id">
            <p><label>权限编号：</label><input type="text" id="no" class="inputText" ></p>
            <p style="margin-top: 5px;"><label>权限名称：</label><input type="text" id="name" class="inputText" ></p>
            <p style="padding-right: 150px;"><label>权限描述：</label></p>
            <p><textarea class="textarea" id="remark" style="width: 300px;height: 80px;margin-left: 50px;font-weight: bolder;
    font-size: 15px;"></textarea></p>
        </div>
    </div>
    <div class="pop-foot">
        <input type="button" value="关闭" class="pop-cancel pop-close">
        <input type="button" id="edit" value="更新" class="pop-ok" onclick="upPermission()">
        <input type="button" id="inst" value="添加" class="pop-ok" onclick="inPermission()">
    </div>
</div>

<div id="main">

    <p style="text-align: left;padding-left: 20px;padding-bottom: 5px;">
        <input type="button" onclick="inst();" class="button blue" value="新增" style="width: 80px;">
    </p>
    <table id="tables" class="tableHue1" id="tableExcel" border="1" bordercolor="#a4d5e3" cellspacing="0"
           cellpadding="0" style="width: 800px;text-align: center;font-size: 15px;">
        <thead>
        <tr>
            <td width="10%"><strong>序号</strong></td>
            <td width="15%"><strong>权限编号</strong></td>
            <td width="20%"><strong>权限名称</strong></td>
            <td width="40%"><strong>权限描述</strong></td>
            <td width="15%"><strong>操作</strong></td>
        </tr>
        </thead>
        <tbody id="tbody">
        </tbody>
    </table>
    <div style="text-align: left;padding-left: 200px;">
        <a id="btn0"></a>
        <input id="pageSize" type="text" size="1" maxlength="4" value="getDefaultValue()" class="inputText"
               style="height: 20px;"/><a> 条 </a> <a href="#" id="pageSizeSet">设置</a>&nbsp;
        <a id="sjzl"></a>&nbsp;
        <a href="#" id="btn1">首页</a>
        <a href="#" id="btn2">上一页</a>
        <a href="#" id="btn3">下一页</a>
        <a href="#" id="btn4">尾页</a>&nbsp;
        <a>转到&nbsp;</a>
        <input id="changePage" type="text" size="1" maxlength="4" class="inputText" style="height: 20px;"/>
        <a>页&nbsp;</a>
        <a href="#" id="btn5">跳转</a>

    </div>
</div>

<script>
    var datas;
    $(document).ready(function () {
        $('.pop-close').click(function () {
            $('.bgPop,.pop').hide();
        });
        // $('.click_pop').click(function () {
        //     $('.bgPop,.pop').show();
        // });

        getPermissionList();
    })

    function getPermissionList() {
        var tr="";
        var table=document.getElementById("tbody");
        $.ajax({
            type: "post",
            url: "<%=basePath%>user/getPermissionList",
            dataType: "json",
            success: function (data) {
                datas=data;
                for (var i = 0; i < data.length; i++) {
                    tr+="<tr><td>"+data[i].id+"</td><td>"+data[i].no+"</td>";
                    tr+="<td>"+data[i].name+"</td><td>"+data[i].remark+"</td>";
                    tr+="<td><input type='button' class='pop-ok' value='编辑'  onclick='edit(\""+data[i].id+"\")'></td>";
                    tr+="</tr>";
                }
                table.innerHTML=tr;
                display()
            }
        })
    }

    function inst() {
        $('.bgPop,.pop').show();
        $('#edit').hide();
        $('#inst').show();
        $('#no').val("");
        $('#name').val("");
        $('#remark').val("");
        $("#no").attr("readOnly",false);
    }
    function edit(id){
        $('.bgPop,.pop').show();
        $('#edit').show();
        $('#inst').hide();
        $("#no").attr("readOnly","true");
        for(var i=0;i<datas.length; i++ ){
            if(datas[i].id==id)
            {
                $('#no').val(datas[i].no);
                $('#name').val(datas[i].name);
                $('#remark').val(datas[i].remark);

            }
        }
    }

    function inPermission(){
        upData(1);
    }
    function upPermission(){
        upData(2);
    }
    function upData(id){
        var no= $('#no').val();
        var name= $('#name').val();
        var remark= $('#remark').val();
        var urlStr="";
        if(id==1){
            urlStr="<%=basePath%>user/inPermission";
        }else{
            urlStr="<%=basePath%>user/upPermission";
        }
        $.ajax({
            type: "post",
            url: urlStr,
            data:{"no":no,"name":name,"remark":remark},
            dataType: "json",
            success: function (data) {
                alert(data.result);
                $('.bgPop,.pop').hide();
                getPermissionList();
            }
        })
    }
</script>
</body>
</html>
