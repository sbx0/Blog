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
            <div class="col-sm-12 margin-bottom-10">
                <button class="btn btn-danger" data-toggle="modal" data-target="#sellerModal">
                    我要卖
                </button>
            </div>
            <div class="col-sm-12">
                <div class="row">
                    <div class="list-group" id="products">
                        <a href="b?id=223" class="list-group-item undefined">
                            <span class="badge">处理中</span>
                            123123
                        </a>
                        <a href="b?id=223" class="list-group-item undefined">
                            <span class="badge">处理中</span>
                            123123
                        </a>
                        <a href="b?id=223" class="list-group-item undefined">
                            <span class="badge">处理中</span>
                            123123
                        </a>
                        <a href="b?id=223" class="list-group-item undefined">
                            <span class="badge">处理中</span>
                            123123
                        </a>
                        <a href="b?id=223" class="list-group-item undefined">
                            <span class="badge">处理中</span>
                            123123
                        </a>
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
                    <label for="p-authority">购买权限</label>
                    <input id="p-authority" type="number" name="product.authority" class="form-control">
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

<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {
        $("#toolsTab").addClass("active")
        list()
    })

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
                        $("#products").append(buildProduct(products[i]))
                    }
                } else {
                    alert(i18N.network_error)
                }
            }
        })
    }

    function buildProduct(product) {
        var product = "<a class='list-group-item'>"
            + product.name +
            "<span class='badge'>"
            + product.price + "\t积分"
            "</span></a>"
        return product
    }

</script>
</body>
</html>