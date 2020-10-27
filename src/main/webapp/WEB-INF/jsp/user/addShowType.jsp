<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>css/shade.css">
    <link rel="stylesheet" href="<%=basePath%>css/table.css">
    <link rel="stylesheet" href="<%=basePath%>css/controls.css">
    <script src="<%=basePath%>js/paging.js"></script>
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
        <label style="float: left;font-size: 20px;font-weight: bolder;font-family: KaiTi;">添加或移除</label>
        <span class="pop-close">Ｘ</span>
    </div>
    <div class="pop-content">
        <div class="pop-content-left">
            <img src="" alt="" class="teathumb">
        </div>
        <div class="pop-content-right">
            <div id="test7" class="demo-transfer"></div>
        </div>
    </div>
    <div class="pop-foot">
        <input type="button" value="关闭" class="pop-cancel pop-close">
    </div>
</div>
<div id="main">
    <p style="margin-bottom: 20px;">
        <label>工号：</label> <input type="text" id="s_userId" class="inputText s_input">
        <label>姓名：</label><input type="text" id="s_userName" class="inputText s_input">
        <input type="button" onclick="sel();" class="button blue" value="查询" style="width: 80px;">
    </p>
    <input type="hidden" id="factorys" value="${sessionScope.user.factory}">
    <table id="tables" class="tableHue1" id="tableExcel" border="1" bordercolor="#a4d5e3" cellspacing="0"
           cellpadding="0" style="width: 1000px;text-align: center;font-size: 15px;">
        <thead>
        <tr>
            <td width="10%"><strong>厂别</strong></td>
            <td width="10%"><strong>工号</strong></td>
            <td width="15%"><strong>姓名</strong></td>
            <td width="10%"><strong>部门</strong></td>
            <td width="20%"><strong>操作</strong></td>
        </tr>
        </thead>
        <tbody id="tbody">
        </tbody>
    </table>
    <div style="text-align: left;padding-left: 400px;">
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
<%--<input type="button"  value="确定"  onclick="edit('test101')">--%>
<%--<a href="javascript:void(0)"  onclick="edit('test102')">点击</a>--%>
<script src="<%=basePath%>js/jquery-3.0.0.js"></script>
<script src="<%=basePath%>layui/layui.js"></script>

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
        var tr="";
        var table=document.getElementById("tbody");
        var factory=$('#factorys').val();
        var userId=$('#s_userId').val();
        var userName=$('#s_userName').val();
        $.ajax({
            type: "post",
            url: "<%=basePath%>user/getUserList",
            data: {"factory": factory,"userId":userId,"userName":userName},
            dataType: "json",
            success: function (data) {
                datas=data;
                //debugger;
                for (var i = 0; i < data.length; i++) {
                    tr+="<tr><td>"+data[i].factory+"</td><td>"+data[i].userId+"</td>";
                    tr+="<td>"+data[i].userName+"</td><td>"+data[i].department+"</td>";
                    tr+="<td><input type='button' class='pop-ok' value='编辑类别'  onclick='edit(\""+data[i].userId+"\")'></td>";
                    tr+="</tr>";
                }
                table.innerHTML=tr;
                display()
            }
        })

    }


    layui.use(['transfer', 'layer', 'util'], function () {
        var $ = layui.$
            , transfer = layui.transfer
            , layer = layui.layer
            , util = layui.util;

         window.edit=function(userId) {
             //alert(uid);
              //userId="BK03999";
             $('.bgPop,.pop').show();
             $.ajax({
                 type: "post",
                 url: "<%=basePath%>user/showListType",
                 data:{"userId":userId},
                 dataType: "json",
                 success: function (data) {
                     transfer.render({
                         elem: '#test7'
                         , id: 'test'
                         , title: ['<b>未添加类别</b>', '<b>已添加类别</b>']
                         , showSearch: true   //开启搜索框
                         , data: data.result
                         , value: data.values
                         , parseData: function (res) {
                             return {
                                 "value": res.typeNo //数据值
                                 , "title": res.typeName //数据标题
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
                                 urlStr = "<%=basePath%>user/addShowType"
                             } else if (index == 1) {//移除
                                 urlStr = "<%=basePath%>user/delShowType"
                             }
                             $.ajax({
                                 type: "post",
                                 url: urlStr,
                                 data: {"data":JSON.stringify(obj),"userId":userId},
                                 dataType: "json",
                                 success: function (result) {

                                 }
                             })
                         }
                     });

                 }
             })
         }



       /* var _tools = {
            doExamine: function() {
                var userId="BK03999";
                $('.bgPop,.pop').show();
                $.ajax({
                    type: "post",
                    url: "<%=basePath%>user/showListType",
                    data:{"userId":userId},
                    dataType: "json",
                    success: function (data) {
                        transfer.render({
                            elem: '#test7'
                            , id: 'test'
                            , title: ['<b>未添加类别</b>', '<b>已添加类别</b>']
                            , showSearch: true   //开启搜索框
                            , data: data.result
                            , value: data.values
                            , parseData: function (res) {
                                return {
                                    "value": res.employeeId //数据值
                                    , "title": res.username //数据标题
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
                                    urlStr = "<%=basePath%>user/addShowType"
                                } else if (index == 1) {//移除
                                    urlStr = "<%=basePath%>user/delShowType"
                                }
                                $.ajax({
                                    type: "post",
                                    url: urlStr,
                                    contentType: "application/json;charset=UTF-8",
                                    data: JSON.stringify(obj),
                                    dataType: "json",
                                    success: function (result) {

                                    }
                                })
                            }
                        });

                    }
                })
            }
        }
        window.tools = _tools;*/
    });
</script>
</body>
</html>
