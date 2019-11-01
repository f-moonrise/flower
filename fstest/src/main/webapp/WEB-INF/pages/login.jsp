<%--
  Created by IntelliJ IDEA.
  User: 13326
  Date: 2019/10/29
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/pages/Head.jsp" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>娇娇花圃</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="./css/font.css">
    <link rel="stylesheet" href="./css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>

</head>
<body class="login-bg">

<div class="login layui-anim layui-anim-up">
    <div class="message">娇娇花圃</div>
    <div id="darkbannerwrap"></div>

    <form method="post" action="${basepath}login" class="layui-form" >
        <input name="id" placeholder="用户名"  type="text" class="layui-input" >
        <hr class="hr15">
        <input name="pwd"  placeholder="密码"  type="password" class="layui-input">
        <hr class="hr15">
        <input name="code" autocomplete="off"   placeholder="验证码"  type="text" class="layui-input">
        <img id="image" src="${basepath}img" style="cursor:pointer">
        <span style="color:#ff0000">${msg}</span>
        <hr class="hr15">
        <input  value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
        <hr class="hr20" >
    </form>
</div>

<script>
    $(function  () {
        $("#image").click(function(){
            $(this).attr("src","${basepath}img?"+new Date());
        });
        /*layui.use('form', function(){
            var form = layui.form;
            // layer.msg('玩命卖萌中', function(){
            //   //关闭后的操作
            //   });
            //监听提交
            form.on('submit(login)', function(data){
                // alert(888)
                layer.msg(JSON.stringify(data.field),function(){
                    location.href='index.html'
                });
                return false;
            });
        });*/
    })


</script>


<!-- 底部结束 -->
<script>
    //百度统计可去掉
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
</body>
</html>