<%--
  Created by IntelliJ IDEA.
  User: sbx0
  Date: 2017/4/22
  Time: 21:13
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

    <title>${user.user_name} - <fmt:message key="website.name"/></title>

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

    <div class="blog-header">
        <div class="row">
            <div class="col-xs-8">
                <h1 class="blog-title">
                    ${user.user_name}
                    <%--<c:if test="${user.user_id eq '1'}">--%>
                    <%--<img src="img/zhanzhang.png" class="status-img" title="称号：站长">--%>
                    <%--</c:if>--%>
                    <%--<c:if test="${user.user_is_admin eq '1'}">--%>
                    <%--<img src="img/admin.png" class="status-img" title="称号：管理员">--%>
                    <%--</c:if>--%>
                    <%--<c:forEach items="${statuses}" var="status">--%>
                    <%--<c:if test="${status.name eq '欧皇'}">--%>
                    <%--<img src="img/ouhuang.png" class="status-img" title="称号：欧皇">--%>
                    <%--</c:if>--%>
                    <%--<c:if test="${status.name eq 'VIP'}">--%>
                    <%--<img src="img/vip.png" class="status-img" title="称号：VIP">--%>
                    <%--</c:if>--%>
                    <%--</c:forEach>--%>
                </h1>
                <p class="lead blog-description">
                    ${user.user_signature}
                </p>
            </div>
            <div class="col-xs-4">
                <a class="btn btn-success btn-full-weight margin-bottom-10" href="msg.jsp?id=${user.user_id}">
                    与TA聊天
                </a>
            </div>
        </div>
    </div>

    <div class="row">

        <div class="col-sm-9 blog-main">
            <c:choose>
                <c:when test="${empty pageBean.list}">
                    <div>
                        <h2><fmt:message key="user.no.article"/></h2>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${pageBean.list}" var="article" varStatus="articleStatus">
                        <c:choose>
                            <c:when test="${article.article_title eq '#weibo#'}">
                                <div class="blog-post">
                                    <p class="blog-post-meta">
                                        <fmt:formatDate value="${article.article_time}" pattern="yyyy-MM-dd HH:mm"/>
                                    </p>
                                    <p class="imgRestrict">
                                            ${article.article_content}
                                    </p>
                                    <a href="a?id=${article.article_id}&u_id=${article.article_author.user_id}">
                                        <fmt:message key="read.more"/>
                                        (${article.article_comment}/${article.article_views})
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="blog-post">
                                    <h2 class="blog-post-title">${article.article_title}</h2>
                                    <p class="blog-post-meta">
                                        <fmt:formatDate value="${article.article_time}" type="both"
                                                        pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
                                    </p>
                                    <p class="imgRestrict">${article.article_content}</p>
                                    <a href="a?id=${article.article_id}&u_id=${article.article_author.user_id}">
                                        <fmt:message key="read.more"/>
                                        (${article.article_comment}/${article.article_views})
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <nav>
                        <ul class="pager">
                            <c:choose>
                                <c:when test="${pageBean.totalPage eq 1}">
                                    <li class="previous disabled">
                                        <a><fmt:message key="prev.page"/></a>
                                    </li>
                                    <li>
                                        <span>${pageBean.currentPage}/${pageBean.totalPage}</span>
                                    </li>
                                    <li class="next disabled">
                                        <a><fmt:message key="next.page"/></a>
                                    </li>
                                </c:when>
                                <c:when test="${pageBean.currentPage eq 1}">
                                    <li class="previous disabled">
                                        <a><fmt:message key="prev.page"/></a>
                                    </li>
                                    <li>
                                        <span>${pageBean.currentPage}/${pageBean.totalPage}</span>
                                    </li>
                                    <li class="next">
                                        <a href="article-user?id=${user.user_id}&pageNo=${pageBean.currentPage+1}"><fmt:message
                                                key="next.page"/></a>
                                    </li>
                                </c:when>
                                <c:when test="${pageBean.currentPage eq pageBean.totalPage}">
                                    <li class="previous">
                                        <a href="article-user?id=${user.user_id}&pageNo=${pageBean.currentPage-1}"><fmt:message
                                                key="prev.page"/></a>
                                    </li>
                                    <li>
                                        <span>${pageBean.currentPage}/${pageBean.totalPage}</span>
                                    </li>
                                    <li class="next disabled">
                                        <a><fmt:message key="next.page"/></a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="previous">
                                        <a href="article-user?id=${user.user_id}&pageNo=${pageBean.currentPage-1}"><fmt:message
                                                key="prev.page"/></a>
                                    </li>
                                    <li>
                                        <span>${pageBean.currentPage}/${pageBean.totalPage}</span>
                                    </li>
                                    <li class="next">
                                        <a href="article-user?id=${user.user_id}&pageNo=${pageBean.currentPage+1}"><fmt:message
                                                key="next.page"/></a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </nav>
                </c:otherwise>
            </c:choose>

        </div>

        <div class="col-sm-3 blog-sidebar">
            <div class="sidebar-module sidebar-module-inset">
                <h4><fmt:message key="user.data"/></h4>
                <p>
                    <fmt:message key="integral"/>：${user.user_integral}<br>
                    <c:choose>
                        <c:when test="${user.user_is_admin == 1}">
                            <fmt:message key="authority"/>：<a><fmt:message key="user.admin"/></a><br>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="authority"/>：<a><fmt:message key="user.ordinary"/></a><br>
                        </c:otherwise>
                    </c:choose>
                    <fmt:message key="user.birthday"/>：<a><fmt:formatDate value="${user.user_birthday}" type="both"
                                                                          pattern="yyyy-MM-dd"></fmt:formatDate></a><br>
                    <fmt:message key="user.register.time"/>： <a><fmt:formatDate value="${user.user_register_time}"
                                                                                type="both"
                                                                                pattern="yyyy-MM-dd HH:mm"></fmt:formatDate></a><br>
                </p>
            </div>
        </div>

    </div>

</div>
<s:include value="foot.jsp"></s:include>
</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {
        var viewer = new Viewer(document.getElementById('container'))
    })
</script>