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
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="<fmt:message key="website.name"/>">
    <meta name="author" content="<fmt:message key="bloger"/>">
    <link rel="icon" href="img/favicon.png">

    <title>出错了！菜鸡三连！！！ - <fmt:message key="website.name"/></title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
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
<link href="css/signin.css" rel="stylesheet">
<div class="container">
    <ul class="nav nav-tabs">
        <li id="indexTab" role="presentation">
            <a href="index.jsp">
                <fmt:message key="index"/>
            </a>
        </li>
        <li id="searchTab" role="presentation">
            <a href="search.jsp">
                <fmt:message key="search"/>
            </a>
        </li>
        <li id="toolsTab" role="presentation">
            <a href="tools.jsp">
                <fmt:message key="tools"/>
            </a>
        </li>
        <c:choose>
            <c:when test="${sessionScope.user eq null}">
                <li role="presentation" class="dropdown" style="float: right">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0)" role="button"
                       aria-haspopup="true"
                       aria-expanded="false">
                        <fmt:message key="language"/>
                        <span class="caret">
                        </span>
                    </a>
                    <ul class="dropdown-menu">
                        <li role="presentation">
                            <a href="javascript:void(0)" name="cn_CN">
                                中文
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="javascript:void(0)" name="en_US">
                                English
                            </a>
                        </li>
                    </ul>
                </li>
                <li id="loginTab" role="presentation" style="float: right">
                    <a id="showLoginModal" href="javascript:void(0)">
                        <fmt:message key="login"/>
                    </a>
                </li>
            </c:when>
            <c:otherwise>
                <li role="presentation" class="dropdown" style="float: right">
                    <a id="user-name-a" class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0)"
                       role="button"
                       aria-haspopup="true"
                       aria-expanded="false">
                            ${sessionScope.user.user_name}<span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <c:if test="${sessionScope.user.user_is_admin eq 1}">
                            <li role="presentation">
                                <a href="admin/index.jsp">
                                    <fmt:message key="admin"/>
                                </a>
                            </li>
                            <li class="divider">

                            </li>
                        </c:if>
                        <li role="presentation">
                            <a data-toggle="modal" data-target="#languageModal" href="javascript:void(0)">
                                <fmt:message key="language"/>
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="article-user?id=${sessionScope.user.user_id}">
                                <fmt:message key="personal.page"/>
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="javascript:void(0)" id="message">
                                <fmt:message key="msg"/>
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="javascript:void(0)" id="showCodes">
                                <fmt:message key="package"/>
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="post.jsp">
                                <fmt:message key="post"/>
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="activity.jsp" class="gif-color-1">
                                <fmt:message key="activity"/>
                            </a>
                        </li>
                        <li class="divider">

                        </li>
                        <li role="presentation">
                            <a id="logout" href="javascript:void(0)">
                                <fmt:message key="logout"/>
                            </a>
                        </li>
                    </ul>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>

    <div id="browser-check-alert" class="alert alert-warning alert-dismissible fade in browser-check-alert hide"
         role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">
                &times;
            </span>
        </button>
    </div>
</div>

<div id="codesModal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog"
     aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        &times;
                    </span>
                </button>
                <h4 id="modelTitle" class="modal-title">
                    <fmt:message key="loadding"/>
                </h4>
            </div>
            <div class="modal-body" id="codes">
                <div class="spinner" id="loadding">
                    <div class="bounce1"></div>
                    <div class="bounce2"></div>
                    <div class="bounce3"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="languageModal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog"
     aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        &times;
                    </span>
                </button>
                <h4 class="modal-title">
                    <fmt:message key="language"/>
                </h4>
            </div>
            <div class="modal-body">
                <a href="javascript:void(0)" name="cn_CN">中文</a><br>
                <a href="javascript:void(0)" name="en_US">English</a>
            </div>
        </div>
    </div>
</div>

<div id="loginModal" class="modal fade bs-example-modal-sm"
     tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        &times;
                    </span>
                </button>
                <h4 class="modal-title">
                    <fmt:message key="login"/>
                </h4>
            </div>
            <div class="modal-body">
                <form id="loginForm" class="form-signin">
                    <c:choose>
                        <c:when test="${sessionScope.user eq null}">
                            <span class="help-block">
                                <p>
                                    <fmt:message key="login.no.accounts"/>
                                    <a id="showRegisterModel" href="javascript:void(0)">
                                        <fmt:message key="login.to.register"/>
                                    </a>
                                </p>
                            </span>
                            <label for="inputEmail" class="sr-only">
                                <fmt:message key="email"/>
                            </label>
                            <input id="inputEmail" type="text" class="form-control" name="user.user_email"
                                   placeholder="<fmt:message key='email'/>"/>
                            <label for="inputPassword" class="sr-only">
                                <fmt:message key="password"/>
                            </label>
                            <input id="inputPassword" type="password" class="form-control" name="user.user_password"
                                   placeholder="<fmt:message key="password"/>">
                            <button id="loginButton" type="submit" class="btn btn-primary btn-block">
                                <fmt:message key="login"/>
                            </button>
                        </c:when>
                    </c:choose>
                </form>
            </div>
        </div>
    </div>
</div>

<div id="registerModal" class="modal fade bs-example-modal-sm"
     tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        &times;
                    </span>
                </button>
                <h4 class="modal-title">
                    <fmt:message key="register"/>
                </h4>
            </div>
            <div class="modal-body">
                <form id="registerForm" class="form-signin">
                    <label for="registerName" class="sr-only">
                        <fmt:message key="user.name"/>
                    </label>
                    <input type="text" id="registerName" name="user.user_name" class="form-control"
                           placeholder="<fmt:message key="user.name"/>">
                    <label for="registerEmail" class="sr-only">
                        <fmt:message key="email"/>
                    </label>
                    <input type="text" id="registerEmail" name="user.user_email" class="form-control"
                           placeholder="<fmt:message key="email"/>">
                    <label for="registerPassword" class="sr-only">
                        <fmt:message key="password"/>
                    </label>
                    <input type="password" id="registerPassword" name="user.user_password" class="form-control"
                           placeholder="<fmt:message key="password"/>">
                    <button id="registerButton" class="btn btn-primary btn-block" type="submit">
                        <fmt:message key="register"/>
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row margin-bottom-10 margin-top-20 text-center">
        <h2>
            我是谁？！<br>我在哪？！<br>谁在打我？！<br>
        </h2>
        <h4 class="text-danger">
            很抱歉，系统出现了一些不可预见的错误<br>
            或<br>
            该页面已被删除
        </h4>
        <p>
            您可以在
            <strong>
                <a href="bugs.jsp">
                    反馈中心
                </a>
            </strong>
            提交您遇到的问题
        </p>
    </div>
</div>

<footer class="blog-footer">
    <p>
        <fmt:message key="copyright"/>
    </p>
</footer>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="js/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
<script src="js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="js/ie10-viewport-bug-workaround.js"></script>
<script src="js/base.js"></script>
<script src="js/time-format.js"></script>
<script src="js/browser-check.js"></script>
<script src="js/code.js"></script>
<script src="js/cookie.js"></script>
<script src="js/message.js"></script>
<script src="js/messenger.min.js"></script>
<script src="js/messenger-theme-flat.js"></script>
<script src="js/viewer.min.js"></script>
<script src="js/i18N.js"></script>
<c:if test="${session.WW_TRANS_I18N_LOCALE eq null}">
    <script src="js/i18N_cn_CN.js"></script>
</c:if>
<c:if test="${session.WW_TRANS_I18N_LOCALE ne null}">
    <script src="js/i18N_<s:property value="#session.WW_TRANS_I18N_LOCALE"/>.js"></script>
</c:if>
</body>
</html>