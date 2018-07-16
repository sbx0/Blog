<%--
  Created by IntelliJ IDEA.
  User: winmj
  Date: 2017/12/19
  Time: 13:52
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

    <title><fmt:message key="blog.index"/> - <fmt:message key="website.name"/></title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <link href="css/messenger.css" rel="stylesheet">
    <link href="css/messenger-theme-flat.css" rel="stylesheet">
    <link href="css/viewer.min.css" rel="stylesheet">
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
    <div class="row">

        <div id="ad-div" class="jumbotron">
            <h1>Ducsr.cn</h1>
        </div>

        <div id="container">
            <div id="randomArticle" class="blog-main col-sm-12 margin-top-20 imgRestrict">
                <div class="spinner">
                    <div class="bounce1"></div>
                    <div class="bounce2"></div>
                    <div class="bounce3"></div>
                </div>
            </div>
        </div>

        <div id="afterRandom" class="text-center margin-bottom-10" hidden>
            <a class="readMoreA" href="article-list">查看更多</a>
        </div>

    </div>
</div>
<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {
        getRandomArticle()
        showAD(1)
    })

    function showAD(type) {
        var ad0 = "<h1>Ducsr.cn</h1>"
        var ad1 = "<h1><a href=\"https://weibo.com/ihomemwh\" target='_blank'>You know nothing</a></h1>"
        var ad2 = "<a href=\"https://www.vultr.com/?ref=7466976\" alt=\"Vultr\" target='_blank'><img src=\"https://www.vultr.com/media/banner_2.png\" width=\"468\" height=\"60\"></a>"
        switch (type) {
            case 0:
                $("#ad-div").html(ad0)
                break
            case 1:
                $("#ad-div").html(ad1)
                break
            case 2:
                $("#ad-div").html(ad2)
                break
            default:
                $("#ad-div").html(ad0)
                type = 0
                break
        }
        setTimeout(function () {
            showAD(++type)
        }, 5000)
    }

    function showArticles(articles) {
        $("#randomArticle").html("")
        var html = ""
        for (var i = 0; i < articles.length; i++) {
            var time = Format(getDate(articles[i].date.time.toString()), "yyyy-MM-dd HH:mm")
            html += '<div class="blog-post">'
            if (articles[i].title != "#weibo#") {
                html +=
                    '<h2 class="blog-post-title">' +
                    articles[i].title +
                    '</h2>'
            }
            html +=
                '<p class="blog-post-meta">' +
                ' <a href="article-user?id=' +
                articles[i].user_id
                + '">' + articles[i].user_name + '</a>&nbsp;' + time +
                '</p>' +
                '<p>' + articles[i].content +
                '</p>' +
                '<a class="readMoreA" href="article-one?id=' + articles[i].id + '">查看详情</a>' +
                '</div>'
            $("#randomArticle").html($("#randomArticle").html() + html)
            html = ""
        }
        $("img").addClass("img-responsive")
        var viewer = new Viewer(document.getElementById('container'))
    }

    function getRandomArticle() {
        $.ajax({
            type: "post",
            url: "article-random",
            dataType: "json",
            success: function (data) {
                var articles = data.articles
                if (articles == null) {
                    $("#randomArticle").html("<p class='text-center'>暂无博文</p>")
                } else {
                    showArticles(articles)
                }
                $("#afterRandom").show()
            }
        })
    }

</script>
</body>
</html>