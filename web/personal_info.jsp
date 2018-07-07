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
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="<fmt:message key="website.name"/>">
    <meta name="author" content="<fmt:message key="bloger"/>">
    <link rel="icon" href="img/favicon.png">

    <title>个人资料编辑 - <fmt:message key="website.name"/></title>

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
<s:include value="head.jsp"></s:include>
<div class="container">

    <div class="row">

        <c:choose>
        <c:when test="${sessionScope.user eq null}">
        <div class="alert alert-danger margin-top-20" role="alert">
            未登录！
        </div>
        </c:when>
        <c:when test="${sessionScope.user.user_id ne user.user_id && sessionScope.user.user_is_admin ne 1}">
        <div class="alert alert-danger margin-top-20" role="alert">
            你无权修改其他人的资料！
        </div>
        </c:when>
        <c:when test="${sessionScope.user.user_is_admin eq 1}">
        <div class="col-sm-7 blog-main margin-top-20">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>
                        个人资料编辑
                    </strong>
                </div>
                <div class="panel-body">
                    <form id="personal_info">
                        <input class="form-control hide" name="user.user_id" value="${user.user_id}">
                        <input class="form-control hide" id="birthday" value="${user.user_birthday}">
                        <div class="form-group">
                            <label for="user.user_name">用户名</label>
                            <input id="user.user_name" name="user.user_name" value="${user.user_name}"
                                   class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="user.user_signature">签名</label>
                            <input id="user.user_signature" name="user.user_signature"
                                   value="${user.user_signature}"
                                   class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="user.user_email">邮箱</label>
                            <input id="user.user_email" name="user.user_email" value="${user.user_email}"
                                   class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="user.user_password">密码(已加密)</label>
                            <input id="user.user_password" name="user.user_password"
                                   value="${user.user_password}"
                                   class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="user.user_is_admin">权限</label>
                            <input id="user.user_is_admin" name="user.user_is_admin"
                                   value="${user.user_is_admin}"
                                   class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="user.user_register_time">注册时间</label>
                            <input id="user.user_register_time" name="user.user_register_time"
                                   value="${user.user_register_time}" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="user.user_birthday">生日</label>
                            <input id="user.user_birthday" name="user.user_birthday"
                                   value="${user.user_birthday}"
                                   class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="user.user_integral">积分</label>
                            <input id="user.user_integral" name="user.user_integral"
                                   value="${user.user_integral}"
                                   class="form-control">
                        </div>
                        <div class="form-group">
                            <button id="submitButton" type="button" class="btn btn-primary" style="width:100%;">
                                提交
                            </button>
                        </div>
                    </form>
                    </c:when>
                    <c:otherwise>
                    <div class="col-sm-5 blog-sidebar margin-top-20">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <strong>
                                    账户操作
                                </strong>
                            </div>
                            <div class="panel-body">
                                <a id="deleteAccount" href="javascript:void(0)"
                                   class="btn btn-block btn-danger">注销账户</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-7 blog-main margin-top-20">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <strong>
                                    个人资料编辑
                                </strong>
                            </div>
                            <div class="panel-body">
                                <form id="personal_info">
                                    <input class="form-control hide" name="user.user_id" value="${user.user_id}">
                                    <input class="form-control hide" id="birthday" value="${user.user_birthday}">
                                    <div class="form-group">
                                        <label for="user.user_name">用户名</label>
                                        <input id="user.user_name" name="user.user_name" value="${user.user_name}"
                                               class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label for="user.user_signature">签名</label>
                                        <input id="user.user_signature" name="user.user_signature"
                                               value="${user.user_signature}"
                                               class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label for="user.user_email">邮箱</label>
                                        <input id="user.user_email" name="user.user_email" value="${user.user_email}"
                                               class="form-control" readonly="true">
                                    </div>
                                    <div class="form-group">
                                        <label for="user.user_password">密码(已加密)</label>
                                        <input id="user.user_password" name="user.user_password"
                                               value="${user.user_password}"
                                               class="form-control" readonly="true">
                                    </div>
                                    <div class="form-group">
                                        <label for="user.user_is_admin">权限</label>
                                        <input id="user.user_is_admin" name="user.user_is_admin"
                                               value="${user.user_is_admin}"
                                               class="form-control" readonly="true">
                                    </div>
                                    <div class="form-group">
                                        <label for="user.user_register_time">注册时间</label>
                                        <input id="user.user_register_time" name="user.user_register_time"
                                               value="${user.user_register_time}" class="form-control" readonly="true">
                                    </div>
                                    <div class="form-group">
                                        <label for="user.user_birthday">生日</label>
                                        <input id="user.user_birthday" name="user.user_birthday"
                                               value="${user.user_birthday}"
                                               class="form-control" readonly="true">
                                    </div>
                                    <div class="form-group">
                                        <label for="user.user_integral">积分</label>
                                        <input id="user.user_integral" name="user.user_integral"
                                               value="${user.user_integral}"
                                               class="form-control" readonly="true">
                                    </div>
                                    <div class="form-group">
                                        <button id="submitButton" type="button" class="btn btn-primary"
                                                style="width:100%;">
                                            提交
                                        </button>
                                    </div>
                                </form>
                                </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <!-- /.blog-main -->

                    <!-- /.blog-sidebar -->
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container -->
            <s:include value="foot.jsp"></s:include>
            <script type="text/javascript">

                $("#deleteAccount").click(function () {
                    if (confirm("确认删除？操作一旦完成无法恢复！")) {
                        $.ajax({
                            type: "POST",
                            url: "user-delete",
                            dataType: "json",
                            success: function (data) {
                                var status = data.status
                                if (status == 0) {
                                    alert("注销成功")
                                    $.ajax({
                                        type: "POST",
                                        url: "user-logout",
                                        dataType: "json",
                                        success: function (data) {
                                            var status = data.status
                                            if (status == 0) {
                                                alert("退出登录")
                                                location.replace(location.href)
                                            } else {
                                                alert("系统异常，错误代码：" + status)
                                            }
                                        }
                                    });
                                } else {
                                    alert("系统异常，错误代码：" + status)
                                }
                            }
                        });
                    }
                })

                $("#submitButton").click(function () {
                    if ($("#user.user_name").val == "" || $("#user.user_name").val.length == 0) {
                        alert("请输入用户名")
                        return false
                    } else if ($("#user.user_signature").val == "" || $("#user.user_signature").val.length == 0) {
                        alert("请输入签名")
                        return false
                    }
                    $("#submitLoadding").show()
                    $.ajax({
                        cache: true,
                        type: "POST",
                        url: "user-update",
                        data: $('#personal_info').serialize(),
                        async: false,
                        success: function (data) {
                            var status = data.status
                            if (status == 0) {
                                alert("修改成功")
                                location.replace(location.href)
                            } else {
                                alert("服务器异常，异常码：" + status)
                            }
                        }
                    });
                    $("#submitLoadding").hide()
                })

            </script>
</body>
</html>