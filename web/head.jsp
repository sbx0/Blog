<%--
  Created by IntelliJ IDEA.
  User: winmj
  Date: 2017/7/27
  Time: 13:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    // 清除页面缓存
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", -10);
%>
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

<link href="css/signin.css" rel="stylesheet">
<link href="css/blog.css" rel="stylesheet">
<div class="container">
    <ul class="nav nav-tabs">
        <li id="indexTab" role="presentation">
            <a href="article-list">
                <fmt:message key="index"/>
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
                    <a data-toggle="modal" data-target="#languageModal" href="javascript:void(0)">
                        <fmt:message key="language"/>
                    </a>
                </li>
                <li id="loginTab" role="presentation" style="float: right">
                    <a id="showLoginModal" href="javascript:void(0)">
                        <fmt:message key="login"/>
                    </a>
                </li>
            </c:when>
            <c:otherwise>
                <li role="presentation" class="dropdown" style="float: right">
                    <a data-toggle="modal" data-target="#languageModal" href="javascript:void(0)">
                        <fmt:message key="language"/>
                    </a>
                </li>
                <li role="presentation" class="dropdown" style="float: right">
                    <a id="user-name-a" data-toggle="modal" data-target="#menuModal" href="javascript:void(0)">
                            ${sessionScope.user.user_name}
                        <span id="unread-count" class="badge"></span>
                    </a>
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

<div id="codesModal" class="modal fade bs-example-modal-md" tabindex="-1" role="dialog"
     aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-md" role="document">
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

<div id="menuModal" class="modal fade bs-example-modal-md" tabindex="-1" role="dialog"
     aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        &times;
                    </span>
                </button>
                <h4 class="modal-title">
                    菜单
                </h4>
            </div>
            <div class="modal-body text-center">
                <h4>

                    <div class="row margin-bottom-10">
                        <div class="col-xs-12">
                            <div class="col-xs-12">
                                <a href="activity.jsp" class="btn btn-default menu-a" role="button">
                                    <span class="glyphicon glyphicon-flag" aria-hidden="true"></span>
                                    <strong>
                                        火爆积分游戏上线！
                                    </strong>
                                </a>
                            </div>
                        </div>
                    </div>

                    <c:if test="${sessionScope.user.user_is_admin eq 1}">
                        <div class="row margin-bottom-10">
                            <div class="col-xs-12">
                                <div class="col-xs-12">
                                    <a href="admin_index.jsp" class="btn btn-default menu-a" role="button">
                                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                                        <fmt:message key="admin"/>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <div class="row margin-bottom-10">
                        <div class="col-xs-12">
                            <div class="col-xs-4">
                                <a href="msg.jsp" id="message" class="btn btn-default menu-a" role="button">
                                    <span class="glyphicon glyphicon-bell" aria-hidden="true"></span>
                                    <fmt:message key="msg"/>
                                    <span id="msg-count" class="badge"></span>
                                </a>
                            </div>
                            <div class="col-xs-4">
                                <a href="javascript:void(0)" id="showCodes" class="btn btn-default menu-a"
                                   role="button">
                                    <span class="glyphicon glyphicon-gift" aria-hidden="true"></span>
                                    <fmt:message key="package"/>
                                </a>
                            </div>
                            <div class="col-xs-4">
                                <a href="post.jsp" class="btn btn-success menu-a" role="button">
                                    <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
                                    <fmt:message key="post"/>
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="row margin-bottom-10">
                        <div class="col-xs-12">
                            <div class="col-xs-4">
                                <a href="article-user?id=${sessionScope.user.user_id}" class="btn btn-default menu-a"
                                   role="button">
                                    <span class="glyphicon glyphicon-home" aria-hidden="true"></span>
                                    <fmt:message key="personal.page"/>
                                </a>
                            </div>
                            <div class="col-xs-4">
                                <a href="user-info?id=${sessionScope.user.user_id}" class="btn btn-default menu-a"
                                   role="button">
                                    <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                    <fmt:message key="user.data"/>
                                </a>
                            </div>
                            <div class="col-xs-4">
                                <a id="logout" href="javascript:void(0)" class="btn btn-danger menu-a" role="button">
                                    <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
                                    <fmt:message key="logout"/>
                                </a>
                            </div>
                        </div>
                    </div>

                </h4>
            </div>
        </div>
    </div>
</div>

<div id="languageModal" class="modal fade bs-example-modal-md" tabindex="-1" role="dialog"
     aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-md" role="document">
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
            <div class="modal-body text-center">

                <div class="row margin-bottom-10">
                    <div class="col-xs-12">
                        <div class="col-xs-4">
                            <a href="javascript:void(0)" name="zh_CN" class="btn btn-success btn-md"
                               role="button">简体中文</a>
                        </div>
                        <div class="col-xs-4">
                            <a href="javascript:void(0)" name="zh_TW" class="btn btn-danger btn-md"
                               role="button">繁体中文</a>
                        </div>
                        <div class="col-xs-4">
                            <a href="javascript:void(0)" name="en_US" class="btn btn-danger btn-md" role="button">English</a>
                        </div>
                    </div>
                </div>

                <div class="row margin-top-20">
                    <div class="col-xs-12">
                        <p class="text-warning">红色标注表示翻譯尚未完成。</p>
                        <p class="text-warning">The red label indicates that the translation has not been completed.</p>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<div id="loginModal" class="modal fade bs-example-modal-md"
     tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-md" role="document">
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
                            <label for="inputEmail">
                                <fmt:message key="email"/>
                            </label>
                            <input id="inputEmail" type="text" class="form-control" name="user.user_email"
                                   placeholder="<fmt:message key='email'/>"/>
                            <label for="inputPassword">
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

<div id="registerModal" class="modal fade bs-example-modal-md"
     tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-md" role="document">
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
                    <label for="registerName">
                        <fmt:message key="user.name"/>
                    </label>
                    <input type="text" id="registerName" name="user.user_name" class="form-control"
                           placeholder="<fmt:message key="user.name"/>">
                    <label for="registerEmail">
                        <fmt:message key="email"/>
                    </label>
                    <input type="text" id="registerEmail" name="user.user_email" class="form-control"
                           placeholder="<fmt:message key="email"/>">
                    <label for="registerPassword">
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