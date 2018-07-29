<%--
  Created by IntelliJ IDEA.
  User: winmj
  Date: 2017/9/9
  Time: 17:33
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

    <title>#${tag.name} - 标签 - <fmt:message key="website.name"/></title>

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
<div id="container" class="container">

    <div class="row">

        <div class="col-sm-9 blog-main margin-top-20">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3>
                        <strong>
                            #${tag.name}
                        </strong>
                    </h3>
                </div>
                <div class="panel-body">
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
            </div>
        </div>

        <div class="col-sm-3 blog-sidebar margin-top-20">

        </div>

    </div>

</div>
<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {
        tagLinkId = 0
        article()
    })

    function article() {
        $.ajax({
            url: "tag!info?id=${tag.id}&tagLink.id=" + tagLinkId,
            type: "POST",
            success: function (data) {
                var state = data.state
                if (state == 0) {
                    var articles = data.articles
                    buildArticles(articles)
                } else {
                    alert(i18N.network_error)
                }
            }
        })
    }

    function buildArticles(articles) {
        if (articles == null || articles.length == 0) {
            var articleStr = ""
            articleStr += "<li class='list-group-item' style='text-align: center'>"
            articleStr += "没了"
            articleStr += "</li>"
            $("#result").append(articleStr)
        } else {
            var articleStr = ""
            var u_name = ""
            for (var i = 0; i < articles.length; i++) {
                u_name = articles[i].u_name
                if (u_name.length > 5) {
                    u_name = u_name.substring(0, 5) + "..."
                }
                articleStr += "<li class='list-group-item'>"
                articleStr += "<a target='_blank' href='a?id=" + articles[i].id + "'>" + articles[i].title + "</a>"
                articleStr += "<span class='badge'>" + i18N.author + ":<a target='_blank' class='span_url' href='u?id=" + articles[i].u_id + "'>" + u_name + "</a></span></li>"
            }
            $("#result").append(articleStr)
        }
    }

</script>
</body>
</html>