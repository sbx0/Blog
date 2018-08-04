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
                        <button class="btn btn-danger" data-toggle="modal" data-target="#sellerModal">
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
                    <label for="p-name">商品名</label>
                    <input type="text" id="p-name" name="product.name" class="form-control">
                    <label for="p-desc">描述</label>
                    <textarea id="p-desc" name="product.description" rows="3" class="form-control"></textarea>
                    <label for="p-number">存货</label>
                    <input id="p-number" type="number" name="product.number" class="form-control">
                    <label for="p-define">限制购买数</label>
                    <input id="p-define" type="number" name="product.define" class="form-control">
                    <label for="p-function">功能</label>
                    <input id="p-function" type="text" name="product.function" class="form-control">
                    <label for="p-price">价格</label>
                    <input id="p-price" type="number" name="product.price" class="form-control">
                    <button id="sellerButton" class="btn btn-primary btn-block">
                        卖！
                    </button>
                </form>
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
                    <input id="b_num" type="number" class="form-control" value="1" min="1" max="10" placeholder="数量">
                </div>
                <button id="buyBtn" class="btn btn-primary">
                    立即购买
                </button>
                &nbsp;
                <button id="wantBtn" class="btn btn-default">
                    加入购物车
                </button>
                <div id="buyBtnDiv"></div>
            </div>
            <div id="p_load" class="modal-footer"></div>
        </div>
    </div>
</div>
</div>

<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {
        $("#toolsTab").addClass("active")
        list()
    })

    $(document).on("click", "button[id='buyBtn']", function () {
        var b_num = $("#b_num").val()
        if (b_num < 0 || b_num > 10) {
            alert("购买数量最多10，最少1")
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
                } else if (state == -1) {
                    alert("积分不足")
                } else if (state == -2) {
                    alert("货物数量不足")
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

    $(document).on("click", "a[name='productA']", function () {
        $("#p_id").val(this.id)
        one(this.id)
        $("#productModal").modal("show")
        return false
    })

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
                } else {
                    alert(i18N.network_error)
                }
            }
        })
    }

    function buildProduct(product, type) {
        var p = ""
        if (type == 0) {
            p = "<a name='productA' id='" + product.id + "' class='list-group-item'>"
                + product.name +
                "<span class='badge'>"
                + product.price + "\t积分" +
                "</span></a>"
        } else if (type == 1) {
            $("#p_name").html(product.name)
            $("#p_price").html(product.price)
            $("#p_num").html(product.number)
            $("#p_desc").html(product.desc)
        }
        return p
    }


</script>
</body>
</html>