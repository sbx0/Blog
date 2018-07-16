<%--
  Created by IntelliJ IDEA.
  User: sbx0
  Date: 2017/5/6
  Time: 14:07
  To change this template use File | Settings | File Templates.
--%>
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

    <title>搜索 - <fmt:message key="website.name"/></title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <link href="css/messenger.css" rel="stylesheet">
    <link href="css/messenger-theme-flat.css" rel="stylesheet">
    <link href="css/blog.css" rel="stylesheet">
    <link href="css/signin.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<s:include value="head.jsp"></s:include>
<div class="container">
    <div id="searchForm" class="col-sm-12 margin-top-20 margin-bottom-10">

        <ol class="breadcrumb">
            <li><a href="tools.jsp">工具</a></li>
            <li class="active">全局搜索</li>
        </ol>

        <h3>全局搜索 Beta 0.1</h3>
        <form class="form-inline">
            <div class="form-group">
                <label for="keywords">范围:</label>
                <select id="type" class="form-control">
                    <option value="1">文章标题</option>
                    <option value="2">文章内容</option>
                    <option value="3">用户名</option>
                </select>
            </div>
            <div class="form-group">
                <label for="keywords">关键词:</label>
                <input id="keywords" type="text" class="form-control" placeholder="关键词">
            </div>
            <button id="searchBtn" type="button" class="btn btn-default">搜索</button>
        </form>
    </div>
    <div class="col-sm-12 margin-top-20 margin-bottom-10">
        <ul id="result" class="list-group">

        </ul>
        <div class="list-group" id="loading" hidden>
            <div class="spinner">
                <div class="bounce1"></div>
                <div class="bounce2"></div>
                <div class="bounce3"></div>
            </div>
        </div>
    </div>
</div>


<s:include value="foot.jsp"></s:include>
<script src="js/gif.js"></script>
<script type="text/javascript">
    $(document).ready(function () {

        var pageNo = 1

        $("#searchBtn").click(function () {
            pageNo = 1
            $("#result").html("")
            loadResult()
        })

        $(document).on("click", "a[name='loadResult']", function () {
            $("a[name='loadResult']").remove()
            loadResult()
        })

        function loadResult() {
            var keywords = $("#keywords").val().trim()
            var type = $("#type").val()
            if (keywords.length == 0) {
                alert(i18N.no_keywords)
            } else {
                $("#loading").show()
                $.ajax({
                    type: "post",
                    url: "article-search?keywords=" + encodeURI(encodeURI(keywords.trim())) + "&type=" + type + "&pageNo=" + pageNo,
                    dataType: "json",
                    success: function (data) {
                        var result = data.result
                        showSearchResult(result, type)
                        $("#loading").hide()
                    },
                    error: function () {
                        alert(i18N.server_error)
                    }
                })
            }
        }

        function showSearchResult(result, type) {

            var load = "<a name='loadResult'"
            load += "class='list-group-item' style='text-align: center'>"
            load += "加载更多"
            load += "</a>"
            if (pageNo == -1) return false
            if (result == null || result.length == 0) {
                var resultStr = ""
                resultStr += "<li class='list-group-item' style='text-align: center'>"
                resultStr += "没了"
                resultStr += "</li>"
                $("#result").append(resultStr)
                pageNo = -1
            } else if (type == 1 || type == 2) {
                var resultStr = ""
                var author_name = ""
                for (var i = 0; i < result.length; i++) {
                    author_name = result[i].author_name
                    if (author_name.length > 5) {
                        author_name = author_name.substring(0, 5) + "..."
                    }
                    resultStr += "<li class='list-group-item'>"
                    resultStr += "<a target='_blank' href='article-one?id=" + result[i].article_id + "'>" + result[i].article_title + "</a>"
                    resultStr += "<span class='badge'>" + i18N.author + ":<a target='_blank' class='span_url' href='article-user?id=" + result[i].author_id + "'>" + author_name + "</a></span></li>"
                }
                if (pageNo == 1) {
                    $("#result").html(resultStr + load)
                } else {
                    $("#result").append(resultStr + load)
                }
                pageNo++
            }

        }
    })
</script>
</body>
</html>
