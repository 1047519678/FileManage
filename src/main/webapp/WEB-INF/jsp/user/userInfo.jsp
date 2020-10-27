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
    <title>用户管理</title>
    <script src="<%=basePath%>js/jquery-3.0.0.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/controls.css">
    <link rel="stylesheet" href="<%=basePath%>css/shade.css">
    <link rel="stylesheet" href="<%=basePath%>css/table.css">
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <script src="<%=basePath%>js/paging.js"></script>
    <script src="<%=basePath%>layui/layui.js"></script>
    <style type="text/css">
        .pop {
            width: 560px;
            height: 500px;
            min-height: 400px;
            max-height: 470px;
            padding: 5px;
        }

        .pop-content-right {
            width: 550px;
            font-size: 16px;
            line-height: 35px;
            padding-left: 0px;
            padding-top: 10px;
        }

        .pop-content {
            height: 400px;
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


        .table2 input {
            height: 35px;
            width: 250px;
            font-size: 16px;
            text-align: left;
            margin: 5px 0px;
        }

        .title1 {
            text-align: right;
        }

        .layui-transfer-box {
            text-align: left;
        }
        .s_input{
            width: 100px;
            height: 30px;
           margin-right: 20px;
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
            <div id="user">
                <input type="hidden" id="id">
                <table class="tableHue1 table2" width="500px" border="1" bordercolor="#dddddd" cellspacing="0"
                       cellpadding="0" style="margin-left: 20px;font-size: 18px;
            border: 1px #e2e2e2 solid; padding: 7px;">
                    <tbody>
                    <tr>
                        <td width="30%" class="title1">厂别：</td>
                        <td class="left">
                            <%-- <input type="text" id="dorm_fact" class="inputText" readonly="readonly">--%>
                            <select class="select" id="factory"
                                    style="width: 250px;height: 30px;font-size: 16px;text-align-last: left;">
                                <option value="phc">银湖飞宏</option>
                                <option value="phcj">铁松飞宏</option>
                                <option value="php">达宏厂</option>
                                <option value="phv">越南厂</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="30%" class="title1">工号：</td>
                        <td class="left">
                            <input name="tower" id="userId" type="text" class="inputText"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="30%" class="title1">姓名：</td>
                        <td class="left">
                            <input type="text" id="userName" class="inputText">
                        </td>
                    </tr>
                    <tr id="tr-pwd">
                        <td width="30%" class="title1"> 密码：</td>
                        <td class="left">
                            <input type="password" id="pwd" name="live_sum" class="inputText">
                        </td>
                    </tr>
                    <tr>
                        <td width="30%" class="title1">部门：</td>
                        <td class="left"><input id="department" type="text" class="inputText"/></td>
                    </tr>
                    <tr>
                        <td width="30%" class="title1">电话：</td>
                        <td class="left"><input id="phone" type="text" class="inputText"/></td>
                    </tr>
                    <tr>
                        <td width="30%" class="title1">邮箱地址：</td>
                        <td class="left"><input id="email" type="text" class="inputText"/></td>
                    </tr>
                    <tr id="tr-state">
                        <td width="30%" class="title1">状态：</td>
                        <td class="left">
                            <label class="l-radio"> <input type="radio" name="state" id="state1" value="1"
                                                           checked="checked"> <span class="b-radio"></span>启用
                            </label>
                            <label class="l-radio"> <input type="radio" name="state" id="state2" value="0"> <span
                                    class="b-radio"></span>停用
                            </label>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div id="permission">
                <div id="test1" class="demo-transfer"></div>
            </div>
        </div>
    </div>
    <div class="pop-foot">
        <input type="button" value="关闭" class="pop-cancel pop-close">
        <input type="button" id="edit" value="更新" class="pop-ok" onclick="upUserInfo()">
        <input type="button" id="inst" value="添加" class="pop-ok" onclick="instUserInfo()">
    </div>
</div>

<div id="main">
    <form action="<%=basePath%>user/getUserExcel" method="post">
    <p>
        <input type="hidden" id="factorys" name="factory" value="${sessionScope.user.factory}">
       <label>工号：</label> <input type="text" id="s_userId" name="userId" class="inputText s_input">
        <label>姓名：</label><input type="text" id="s_userName" name="userName" class="inputText s_input">
        <input type="button" onclick="sel();" class="button blue" value="查询" style="width: 80px;">
    </p>
    <p style="text-align: left;padding-left: 20px;padding-bottom: 5px;padding-top: 20px;width: 1300px;">
        <input type="button" onclick="inst();" class="button blue" value="新增" style="width: 80px;">

        <input type="submit"  class="button blue" value="导出" style="width: 80px;float: right;margin-right: 50px;">
    </p>
    </form>
    <c:if test="${sessionScope.permissions.get('SuperAdmin')!=null || sessionScope.permissions.get('u6')!=null }">
        <input type="hidden" id="permissions" value="1">
    </c:if>
    <c:if test="${sessionScope.permissions.get('u6')==null }">
        <input type="hidden" id="permissions" value="0">
    </c:if>

    <table id="tables" class="tableHue1" id="tableExcel" border="1" bordercolor="#a4d5e3" cellspacing="0"
           cellpadding="0" style="width: 1300px;text-align: center;font-size: 15px;">
        <thead>
        <tr>
            <td width="10%"><strong>厂别</strong></td>
            <td width="10%"><strong>工号</strong></td>
            <td width="15%"><strong>姓名</strong></td>
            <td width="15%"><strong>部门</strong></td>
            <td width="10%"><strong>手机号码</strong></td>
            <td width="10%"><strong>电子邮箱</strong></td>
            <td width="10%"><strong>状态</strong></td>
            <td width="20%"><strong>操作</strong></td>
        </tr>
        </thead>
        <tbody id="tbody">
        </tbody>
    </table>
    <div style="text-align: left;padding-left: 700px;">
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

        getUserList();
    })
    function sel() {
        getUserList();
    }
    function getUserList() {
        var permissions = $('#permissions').val();
        var tr = "";
        var table = document.getElementById("tbody");
        var factory =$('#factorys').val();
        var userId=$('#s_userId').val();
        var userName=$('#s_userName').val();
        $.ajax({
            type: "post",
            url: "<%=basePath%>user/getUserList",
            data: {"factory": factory,"userId":userId,"userName":userName},
            dataType: "json",
            success: function (data) {
                datas = data;
                for (var i = 0; i < data.length; i++) {
                    var state = "";
                    if (data[i].state == 0) {
                        state = "停用";
                    } else {
                        state = "启用";
                    }
                    tr += "<tr><td>" + data[i].factory + "</td><td>" + data[i].userId + "</td>";
                    tr += "<td>" + data[i].userName + "</td><td>" + data[i].department + "</td>";
                    tr += "<td>" + data[i].phone + "</td><td>" + data[i].email + "</td><td>" + state + "</td>";
                    /*tr+="<td><a href='javascript:void(0)' class='pop-ok' onclick='edit(\""+data[i].userId+"\")'>编辑</a>&nbsp;&nbsp;&nbsp;<a href='javascript:void(0)' class='pop-ok' onclick='editPermission(\""+data[i].userId+"\")'>权限</a></td>";*/
                    tr += "<td><input type='button' class='pop-ok' value='编辑'  onclick='edit(\"" + data[i].userId + "\")'>";
                    if (permissions == 1) {
                        tr += "&nbsp;&nbsp;&nbsp;<input type='button' class='pop-ok' value='权限'  onclick='editPermission(\"" + data[i].userId + "\")'>";
                    }
                    tr += "&nbsp;&nbsp;&nbsp;<input type='button' class='pop-ok' value='删除'  onclick='delUser(\"" + data[i].userId + "\")'>";
                    tr += "</td>";
                    tr += "</tr>";
                }
                table.innerHTML = tr;
                display()
            }
        })
    }

    function inst() {
        $('.bgPop,.pop').show();
        $('#tr-state').hide();
        $('#tr-pwd').show();
        $('#userId').val("");
        $('#userName').val("");
        $('#department').val("");
        $('#phone').val("");
        $('#email').val("");
        $('#pwd').val("");
        $("#factory").removeAttr("disabled");
        $("#edit").hide();
        $('#inst').show();
        $("#userId").attr("readOnly", false);

        $('#user').show();
        $('#permission').hide();
    }

    function edit(userId) {
        $('.bgPop,.pop').show();
        $('#user').show();
        $('#permission').hide();
        $('#tr-pwd').hide();
        $('#tr-state').show();
        $("#edit").show();
        $('#inst').hide();
        $("#userId").attr("readOnly", "true");
        for (var i = 0; i < datas.length; i++) {
            if (datas[i].userId == userId) {
                $('#factory').val(datas[i].factory);
                $("#factory").attr("disabled", "disabled");
                $('#userId').val(datas[i].userId);
                $('#userName').val(datas[i].userName);
                $('#department').val(datas[i].department);
                $('#phone').val(datas[i].phone);
                $('#email').val(datas[i].email);
                if (datas[i].state == 1) {
                    document.getElementById("state1").checked = true;
                    document.getElementById("state2").checked = false;
                } else {
                    document.getElementById("state1").checked = false;
                    document.getElementById("state2").checked = true;
                }
            }
        }

    }

    function instUserInfo() {
        upData(1);

    }

    function upUserInfo() {
        upData(2);
    }

    function upData(id) {
        debugger;
        var userId = $('#userId').val();
        var userName = $('#userName').val();
        var department = $('#department').val();
        var phone = $('#phone').val();
        var email = $('#email').val();
        var factory = $("#factory").val();
        var password = $('#pwd').val();
        var state = 1
        var urlStr = "";
        if (id == 1) {
            urlStr = "<%=basePath%>user/instUserInfo";
        } else {
            urlStr = "<%=basePath%>user/upUserInfo";
            state = $('input:radio[name="state"]:checked').val();
        }
        $.ajax({
            type: "post",
            url: urlStr,
            data: {
                "userId": userId,
                "userName": userName,
                "department": department,
                "phone": phone,
                "email": email,
                "factory": factory,
                "state": state,
                "password": password
            },
            dataType: "json",
            success: function (data) {
                alert(data.result);
                $('.bgPop,.pop').hide();
                getUserList();
            }
        })


    }


    layui.use(['transfer', 'layer', 'util'], function () {
        var $ = layui.$
            , transfer = layui.transfer
            , layer = layui.layer
            , util = layui.util;

        window.editPermission = function (userId) {
            //alert(uid);
            //userId="BK03999";
            $('.bgPop,.pop').show();
            $('#user').hide()
            $('#permission').show();
            $("#edit").hide();
            $('#inst').hide();
            $.ajax({
                type: "post",
                url: "<%=basePath%>user/showListPermission",
                data: {"userId": userId},
                dataType: "json",
                success: function (data) {
                    transfer.render({
                        elem: '#test1'
                        , id: 'test'
                        , title: ['<b>未添加权限</b>', '<b>已添加权限</b>']
                        , showSearch: true   //开启搜索框
                        , data: data.result
                        , value: data.values
                        , parseData: function (res) {
                            return {
                                "value": res.no //数据值
                                , "title": res.name //数据标题
                                , "disabled": res.disabled  //是否禁用
                                , "checked": res.checked //是否选中
                            }
                        }
                        , onchange: function (obj, index) {
                            console.log(obj);
                            console.log(index);
                            var urlStr = null;
                            if (index == 0)//添加
                            {
                                urlStr = "<%=basePath%>user/addUserPermission"
                            } else if (index == 1) {//移除
                                urlStr = "<%=basePath%>user/delUserPermission"
                            }
                            $.ajax({
                                type: "post",
                                url: urlStr,
                                data: {"data": JSON.stringify(obj), "userId": userId},
                                dataType: "json",
                                success: function (date) {

                                }
                            })
                        }
                    });

                }
            })
        }
    });

    function delUser(userId) {
        if (confirm("确认是否删除，删除后将无法恢复！")) {
            $.ajax({
                type: "post",
                url: "<%=basePath%>user/delUserInfo",
                data: {
                    "userId": userId
                },
                dataType: "json",
                success: function (data) {
                    alert(data.result);
                    getUserList();
                }
            })
        }
    }


    //导出Excel
    function Excel(){
        var factory =$('#factorys').val();
        var userId=$('#s_userId').val();
        var userName=$('#s_userName').val();
        $.ajax({
            type: "post",
            url: "<%=basePath%>user/getUserExcel",
            data: {"factory": factory,"userId":userId,"userName":userName},
            dataType: "json",
            success: function (data) {

            }
        })
    }
</script>
</body>
</html>
