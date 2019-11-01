<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/pages/Head.jsp"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${basepath}css/font.css">
    <link rel="stylesheet" href="${basepath}css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="${basepath}lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${basepath}js/xadmin.js"></script>
    <script src="http://47.94.95.151:8080/js/jquery.form.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>



    <![endif]-->
</head>

<body>
<div class="x-body layui-anim layui-anim-up">
    <form action="${basepath}product/update" class="layui-form" method="post" enctype="multipart/form-data" >
        <div class="layui-form-item">
            <input type="hidden" name="id" value="${product.id}">
            <label  class="layui-form-label">
                <span class="x-red">*</span>商品名称
            </label>
            <div class="layui-input-inline">
                <input type="text"   name="name"
                       autocomplete="off" class="layui-input" value="${product.name}">
            </div>
           <%-- <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>将会成为您唯一的登入名
            </div>--%>
        </div>
        <div class="layui-form-item">
            <label   class="layui-form-label">
                <span class="x-red">*</span>价格
            </label>
            <div class="layui-input-inline">
                <input type="text"  name="price"
                       autocomplete="off" class="layui-input" value="${product.price}">
            </div>
        </div>
        <div class="layui-form-item">
            <label   class="layui-form-label">
                <span class="x-red">*</span>图片
            </label>
            <div class="layui-input-inline">
                <input id="file" type="file" name="image"
                        class="layui-input">
                <img alt="图片" id="img" src="${basepath}images/${product.img}" width="50" height="50">
            </div>

        </div>
        <div class="layui-form-item">
            <label for="desc" class="layui-form-label">
                描述
            </label>
            <div class="layui-input-block">
                <textarea placeholder="请输入内容" id="desc" name="detail" class="layui-textarea">${product.detail}</textarea>
            </div>
        </div>
        <div class="layui-form-item">

            <button type="button"  class="layui-btn" lay-filter="add" lay-submit="">
                修改
            </button>
        </div>
    </form>
</div>
<script>
    document.getElementById("file").onchange=function(){
        let file=this.files[0];
        let fileReader = new FileReader();
        fileReader.readAsDataURL(file);
        fileReader.onload=function(){
            document.getElementById("img").src=fileReader.result;
        }
    }
    layui.use(['form','layer'], function(){
        $ = layui.jquery;
        var form = layui.form
            ,layer = layui.layer;

        //自定义验证规则
       /* form.verify({
            nikename: function(value){
                if(value.length < 5){
                    return '昵称至少得5个字符啊';
                }
            }
            ,pass: [/(.+){6,12}$/, '密码必须6到12位']
            ,repass: function(value){
                if($('#L_pass').val()!=$('#L_repass').val()){
                    return '两次密码不一致';
                }
            }
        });*/

        //监听提交
        form.on('submit(add)', function(data){
            console.log(data);
            //发异步，把数据提交给php
            layer.alert("增加成功", {icon: 6},function () {
                // 获得frame索引
                var index = parent.layer.getFrameIndex(window.name);
                //关闭当前frame
                $(data.form).ajaxSubmit({
                    success:function(data){
                        parent.layer.close(index);
                        parent.location.reload();
                    }
                });


            });
            return false;
        });


    });
</script>
<script>var _hmt = _hmt || []; (function() {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
})();</script>
</body>

</html>