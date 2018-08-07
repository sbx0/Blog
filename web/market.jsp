<%--
  Created by IntelliJ IDEA.
  User: winmj
  Date: 2017/9/9
  Time: 17:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<c:if test="${session.WW_TRANS_I18N_LOCALE eq null}">
    <fmt:setBundle basename="i18N_zh_CN"/>
</c:if>
<c:if test="${session.WW_TRANS_I18N_LOCALE eq 'zh_CN'}">
    <fmt:setBundle basename="i18N_zh_CN"/>
</c:if>
<c:if test="${session.WW_TRANS_I18N_LOCALE eq 'zh_TW'}">
    <fmt:setBundle basename="i18N_zh_TW"/>
</c:if>
<c:if test="${session.WW_TRANS_I18N_LOCALE eq 'en_US'}">
    <fmt:setBundle basename="i18N_en_US"/>
</c:if>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="description" content="<fmt:message key="website.name"/>">
    <meta name="author" content="<fmt:message key="bloger"/>">
    <link rel="icon" href="img/favicon.png">

    <title>积分市场 - <fmt:message key="website.name"/></title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <link href="css/messenger.css" rel="stylesheet">
    <link href="css/messenger-theme-flat.css" rel="stylesheet">
    <link href="css/blog.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
<s:include value="head.jsp"></s:include>
<div class="container">
    <div class="col-sm-12 margin-top-20 margin-bottom-10" role="alert">

        <ol class="breadcrumb">
            <li><a href="tools.jsp">工具</a></li>
            <li class="active">积分市场</li>
        </ol>

        <div class="row">
            <div class="col-sm-12">
                <c:choose>
                    <c:when test="${sessionScope.user.user_is_admin eq 1}">
                        <button id="sellerBtn" class="btn btn-danger" data-toggle="modal" data-target="#sellerModal">
                            我要卖
                        </button>
                    </c:when>
                </c:choose>
                <div class="text-right">
                    <p>
                        当前积分:<strong><span id="integral">加载中</span></strong>
                    </p>
                </div>
            </div>
            <div class="col-sm-12">
                <div class="row">
                    <div class="list-group" id="products">
                        <div class="spinner">
                            <p class="text-center">加载中</p>
                            <div class="bounce1"></div>
                            <div class="bounce2"></div>
                            <div class="bounce3"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="sellerModal" class="modal bs-example-modal-md" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        &times;
                    </span>
                </button>
                <h4 class="modal-title">
                    我要卖
                </h4>
            </div>
            <div class="modal-body">
                <form id="productForm" class="form-signin" action="product!add" method="post">
                    <p class="help-block">
                        点此查看<a href="a?id=141">“售卖指南”</a>
                    </p>
                    <input type="text" id="p-id" name="product.id" class="form-control hidden">
                    <label for="p-name">商品名</label>
                    <input type="text" id="p-name" name="product.name" class="form-control">
                    <label for="p-desc">描述</label>
                    <textarea id="p-desc" name="product.description" rows="3" class="form-control"></textarea>
                    <label for="p-number">存货</label>
                    <input id="p-number" type="number" name="product.number" class="form-control">
                    <label for="p-define">限制购买数</label>
                    <input id="p-define" type="number" name="product.define" class="form-control">
                    <label for="p-price">价格</label>
                    <input id="p-price" type="number" name="product.price" class="form-control">
                    <label for="p-begin">开售日期</label>
                    <input id="p-begin" type="date" name="product.begin" class="form-control">
                    <label for="p-end">截至日期</label>
                    <input id="p-end" type="date" name="product.end" class="form-control">
                    <label for="p-discount">折扣</label>
                    <input id="p-discount" type="number" name="product.discount" min="1" max="9" class="form-control">
                    <label for="d-begin">折扣开始</label>
                    <input id="d-begin" type="date" name="product.d_begin" class="form-control">
                    <label for="d-end">折扣结束</label>
                    <input id="d-end" type="date" name="product.d_end" class="form-control">
                    <label for="p-function">功能</label>
                    <input id="p-function" type="text" name="product.function" class="form-control">
                    <button id="sellerButton" class="btn btn-primary btn-block">
                        卖！
                    </button>
                </form>
                <div id="sellerLoad"></div>
            </div>
        </div>
    </div>
</div>

<div id="productModal" class="modal bs-example-modal-md" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        &times;
                    </span>
                </button>
                <h4 class="modal-title">
                    商品详情
                </h4>
            </div>
            <span class="hidden" id="p_id"></span>
            <div id="product" class="modal-body">
                <h3 class="text-warning">
                    <strong>
                        <span id="p_name"></span>
                    </strong>
                </h3>
                <h4>
                    <span id="p_price"></span>
                    积分
                </h4>
                <p>
                    <span id="p_discount"></span>
                </p>
                <h5>
                    剩
                    <span id="p_num"></span>
                    件
                </h5>
                <p>
                    <span id="p_desc"></span>
                </p>
                <div class="form-group">
                    <label for="p_num">购买数量</label>
                    <input id="b_num" type="number" class="form-control" value="1" min="1" max="100" placeholder="数量"
                           oninput="result()">
                </div>
                <div>
                    <hr>
                    <h4 class="text-right">
                        需付
                        <strong>
                            <span id="b_pay" class="text-warning"></span>
                        </strong>
                        积分
                    </h4>
                    <p class="text-right">
                        您有
                        <strong>
                            <span id="b_have"></span>
                        </strong>
                        积分
                    </p>
                    <p class="text-right">
                        剩
                        <strong>
                            <span id="b_left" class="text-success"></span>
                        </strong>
                        积分
                    </p>
                    <hr>
                </div>
                <button id="buyBtn" class="btn btn-primary float-right">
                    立即购买
                </button>
                &nbsp;
                <button id="wantBtn" class="btn btn-default">
                    加入购物车
                </button>
                &nbsp;
                <button id="updateBtn" class="btn btn-danger">
                    修改商品信息
                </button>
                <div id="buyBtnDiv"></div>
            </div>
            <div id="p_load" class="modal-footer"></div>
        </div>
    </div>
</div>

<div id="invoiceModal" class="modal bs-example-modal-sm" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        &times;
                    </span>
                </button>
                <h4 class="modal-title">
                    购买凭据
                </h4>
            </div>
            <div id="invoiceDiv" class="modal-body">
                <p>
                    凭据编号：
                    <span id="i_id"></span>
                </p>
                <p>
                    商品名称：
                    <span id="i_name"></span>
                </p>
                <p>
                    购买数量：
                    <span id="i_number"></span>
                </p>
                <p>
                    花费积分：
                    <span id="i_price"></span>
                </p>
                <p>
                    购买者：
                    <span id="i_user"></span>
                </p>
                <p>
                    成交时间：
                    <span id="i_end"></span>
                </p>
            </div>
            <div id="invoiceLoad" class="modal-footer"></div>
        </div>
    </div>
</div>

<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {
        $("#toolsTab").addClass("active")
        list()
    })

    $('#invoiceModal').on('hidden.bs.modal', function () {
        $("#productModal").modal("show")
    })

    $("#sellerBtn").click(function () {
        buildProduct(null, 3)
    })

    // 发票加载
    function invoiceShow(id) {
        $("#productModal").modal("hide")
        $("#invoiceModal").modal("show")
        $("#invoiceDiv").hide()
        $("#invoiceLoad").show()
        $("#invoiceLoad").html(i18N.loading)
        $.ajax({
            url: "invoice!one?id=" + id,
            type: "POST",
            success: function (data) {
                var state = data.state
                if (state == 0) {
                    $("#i_id").html(data.id)
                    $("#i_name").html(data.name)
                    $("#i_number").html(data.number)
                    $("#i_price").html(data.price)
                    $("#i_user").html("<a href=\"u?id=" + data.buyer_id + "\">" + data.buyer_name + "</a>")
                    var time = Format(getDate(data.end.time.toString()), "yyyy-MM-dd HH:mm")
                    $("#i_end").html(time)
                    $("#invoiceLoad").html("")
                    $("#invoiceLoad").hide()
                    $("#invoiceDiv").show()
                } else {
                    alert(i18N.network_error)
                }
            }
        })
    }

    $(document).on("click", "button[id='buyBtn']", function () {
        var b_num = $("#b_num").val()
        if (b_num < 1 || b_num > 100) {
            alert("购买数量最多100，最少1")
            $("#b_num").val(1)
            return false
        }
        $("#buyBtn").hide()
        $("#wantBtn").hide()
        $("#buyBtnDiv").html(i18N.loading)
        var p_id = $("#p_id").val()
        $.ajax({
            url: "invoice!buy?product.id=" + p_id + "&invoice.number=" + b_num,
            type: "POST",
            success: function (data) {
                var state = data.state
                if (state == 0) {
                    alert("购买成功")
                    list()
                    one($("#p_id").val())
                    invoiceShow(data.i_id)
                } else if (state == 1) {
                    alert("未登录")
                } else if (state == -1) {
                    alert("积分不足")
                } else if (state == -2) {
                    alert("货物数量不足")
                } else if (state == -3) {
                    alert("错误的购买时间")
                } else {
                    alert(i18N.network_error)
                }
                $("#buyBtnDiv").html("")
                $("#buyBtn").show()
                $("#wantBtn").show()
            }
        })
    })

    $(document).on("click", "button[id='wantBtn']", function () {
        $("#buyBtn").hide()
        $("#wantBtn").hide()
        $("#buyBtnDiv").html(i18N.loading)
        alert("添加成功")
        $("#buyBtnDiv").html("")
        $("#buyBtn").show()
        $("#wantBtn").show()
    })

    $(document).on("click", "button[id='updateBtn']", function () {
        $("#productModal").modal("hide")
        $("#productForm").hide()
        $("#sellerModal").modal("show")
        $("#sellerLoad").html(i18N.loading)
        $.ajax({
            url: "product!one?id=" + $("#p_id").val(),
            type: "POST",
            success: function (data) {
                var product = data.product
                buildProduct(product, 3)
                buildProduct(product, 2)
                $("#sellerLoad").html("")
                $("#productForm").show()
            }
        })
    })

    $(document).on("click", "a[name='productA']", function () {
        $("#b_num").val(1)
        $("#p_id").val(this.id)
        one(this.id)
        $("#productModal").modal("show")
        return false
    })

    function result() {
        var price = $("#p_price").html()
        var number = $("#b_num").val()
        if (number < 1) number = 1
        var count = price * number
        $("#b_pay").html(count)
        var integral = $("#integral").html()
        var left = integral - count
        if (left < 0) left = 0
        if (integral == "未登录") left = "未登录"
        else left = left.toFixed(2)
        $("#b_left").html(left)
        $("#b_have").html(integral)
    }

    function one(id) {
        $("#product").hide()
        $("#p_load").show()
        $("#p_load").html(i18N.loading)
        $.ajax({
            url: "product!one?id=" + id,
            type: "POST",
            success: function (data) {
                var state = data.state
                if (state == 0) {
                    buildProduct(data.product, 1)
                    $("#product").show()
                    $("#p_load").html("")
                    $("#p_load").hide()
                } else {
                    alert(i18N.network_error)
                }
                result()
            }
        })
    }

    $("#sellerButton").click(function () {
        $.ajax({
            url: "product!add",
            type: "POST",
            data: $("#productForm").serialize(),
            success: function (data) {
                var state = data.state
                if (state == 0) {
                    $("#sellerModal").modal("hide")
                    list()
                    alert("操作成功")
                } else {
                    alert(i18N.network_error)
                }
            }
        })
        return false
    })

    function list() {
        $.ajax({
            url: "product!get",
            type: "POST",
            dataType: "json",
            success: function (data) {
                $("#products").html("")
                var state = data.state
                if (state == 0) {
                    var products = data.products
                    for (var i = 0; i < products.length; i++) {
                        $("#products").append(buildProduct(products[i], 0))
                        $("#integral").html(data.integral)
                    }
                    result()
                } else {
                    alert(i18N.network_error)
                }
            }
        })
    }

    function buildProduct(product, type) {
        var p = ""
        if (type == 0) {

            p = "<a  id='" + product.id + "' name='productA' class='list-group-item' href='javascript:void(0)'>"
                + product.name
            if (product.discount != null) p += "<span class='badge alert-success'>"
                + product.discount + "\t折" +
                "</span>"
            p += "<span class='badge'>"
                + product.price + "\t积分" +
                "</span></a>"
        } else if (type == 1) {
            $("#p_discount").html("")
            $("#p_name").html(product.name)
            $("#p_price").html(product.price)
            if (product.d_price != null) {
                $("#p_price").html(product.d_price)
                $("#p_discount").html(product.discount + "折\t原价:" + product.price + " 积分")
            }
            $("#p_num").html(product.number)
            $("#p_desc").html(product.desc)
        } else if (type == 2) {
            $("#p-id").val(product.id)
            $("#p-name").val(product.name)
            $("#p-desc").val(product.desc)
            $("#p-number").val(product.number)
            $("#p-define").val(product.define)
            $("#p-price").val(product.price)
            $("#p-discount").val(product.discount)
            $("#p-function").val(product.function)
            var time
            if (product.begin != null) {
                var begin = product.begin
                time = Format(getDate(begin.time.toString()), "yyyy-MM-dd")
                $("#p-begin").val(time)
            }
            if (product.end != null) {
                var end = product.end
                time = Format(getDate(end.time.toString()), "yyyy-MM-dd")
                $("#p-end").val(time)
            }
            if (product.d_begin != null) {
                var d_begin = product.d_begin
                time = Format(getDate(d_begin.time.toString()), "yyyy-MM-dd")
                $("#d-begin").val(time)
            }
            if (product.d_end != null) {
                var d_end = product.d_end
                time = Format(getDate(d_end.time.toString()), "yyyy-MM-dd")
                $("#d-end").val(time)
            }
        } else if (type == 3) {
            $("#p-id").val(null)
            $("#p-name").val(null)
            $("#p-desc").val(null)
            $("#p-number").val(null)
            $("#p-define").val(null)
            $("#p-price").val(null)
            $("#p-discount").val(null)
            $("#p-function").val(null)
            $("#p-begin").val(null)
            $("#p-end").val(null)
            $("#d-begin").val(null)
            $("#d-end").val(null)
        }
        return p
    }


</script>
</body>
</html>