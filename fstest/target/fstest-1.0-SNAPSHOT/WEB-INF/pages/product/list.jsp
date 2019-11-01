<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/pages/Head.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body class="layui-anim layui-anim-up">
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">演示</a>
        <a>
          <cite>导航元素</cite></a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">
        <form action="${basepath}product/list" class="layui-form layui-col-md12 x-so" method="post">
            <select id="shipping" name="active" >
                <option value="">全部</option>
                <option value="1">有效</option>
                <option value="0">失效</option>
            </select>
            <input type="text" name="name"  placeholder="请输入商品名" autocomplete="off" class="layui-input">
            <button type="submit" class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <xblock>
        <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>
        <button class="layui-btn" onclick="x_admin_show('添加商品','${basepath}product/add',600,400)"><i class="layui-icon"></i>添加</button>
        <span class="x-right" style="line-height:40px">共有数据：88 条</span>
    </xblock>
    <table class="layui-table">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>
            <th>ID</th>
            <th>商品名</th>
            <th>价格</th>
            <th>图片</th>
            <th>详细信息</th>
            <th>是否有效</th>
            <th>操作</th></tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${list}">
            <tr>
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='${product.id}'><i class="layui-icon">&#xe605;</i></div>
                </td>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.price}</td>
                <td><img width="50" height="50" src="${basepath}images/${product.img}" /></td>
                <td>${product.detail}</td>
                <td class="td-status">
                        <span class="layui-btn layui-btn-normal layui-btn-mini">
                            <c:if test="${product.active==1}">有效</c:if>
                            <c:if test="${product.active==0}">失效</c:if>
                        </span></td>
                <td class="td-manage">
                    <c:if test="${product.active==0}">
                        <a onclick="member_del(this,'${product.id}',1)" href="javascript:;"  title="启用">
                            <i class="layui-icon">&#xe601;</i>
                        </a>
                    </c:if>
                    <a title="编辑"  onclick="x_admin_show('修改商品','${basepath}product/update?id=${product.id}',600,400)" href="javascript:;">
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <c:if test="${product.active==1}">
                        <a title="删除" onclick="member_del(this,'${product.id}',0)" href="javascript:;">
                            <i class="layui-icon">&#xe640;</i>
                        </a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="page">
        <div>
            <a class="prev" href="">&lt;&lt;</a>
            <a class="num" href="">1</a>
            <span class="current">2</span>
            <a class="num" href="">3</a>
            <a class="num" href="">489</a>
            <a class="next" href="">&gt;&gt;</a>
        </div>
    </div>

</div>
<script>
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });
    });

    /*用户-停用*/
    function member_stop(obj,id){
        layer.confirm('确认要停用吗？',function(index){

            if($(obj).attr('title')=='启用'){

                //发异步把用户状态进行更改
                $(obj).attr('title','停用')
                $(obj).find('i').html('&#xe62f;');

                $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                layer.msg('已停用!',{icon: 5,time:1000});

            }else{
                $(obj).attr('title','启用')
                $(obj).find('i').html('&#xe601;');

                $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-disabled').html('已启用');
                layer.msg('已启用!',{icon: 5,time:1000});
            }

        });
    }

    /*用户-删除*/
    function member_del(obj,id,active){
        let txt= active==0?"确认要删除吗？":"确实要重新启用吗"
        layer.confirm(txt,function(index){
            //发异步删除数据
            /* $(obj).parents("tr").remove();
             layer.msg('已删除!',{icon:1,time:1000});*/
            window.location.href="${basepath}product/del?id="+id+"&active="+active;
        });
    }



    function delAll (argument) {

        var data = tableCheck.getData();

        layer.confirm('确认要删除吗？'+data,function(index){
            //捉到所有被选中的，发异步进行删除
            window.location.href="${basepath}product/batchdel?ids="+data;
            /*  layer.msg('删除成功', {icon: 1});
              $(".layui-form-checked").not('.header').parents('tr').remove();*/
        });
    }
</script>
<script>var _hmt = _hmt || []; (function() {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
})();</script>
</body>

</html>