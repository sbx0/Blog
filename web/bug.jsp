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

    <title>B${bug.id} - 反馈详情 - <fmt:message key="website.name"/></title>

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
<div id="container" class="container">

    <div class="row">

        <div class="col-sm-9 blog-main margin-top-20">
            <ol class="breadcrumb">
                <li><a href="tools.jsp">工具</a></li>
                <li><a href="bugs.jsp">BUG反馈中心</a></li>
                <li class="active">BUG详情</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>B${bug.id}</strong>
                    ${bug.name}
                </div>
                <div class="panel-body imgRestrict">
                    <p>
                    <h4>
                        评级:
                        <strong class="text-danger">
                            ${bug.grade}
                        </strong>
                        &nbsp;
                        状态:
                        <strong class="text-danger">
                            ${bug.state}
                        </strong>
                    </h4>
                    提交时间:
                    <fmt:formatDate value="${bug.submit_time}" type="both" pattern="yyyy-MM-dd HH:mm"/><br>
                    提交者:
                    <a href="article-user?id=${bug.submitter.user_id}">
                        <strong>
                            ${bug.submitter.user_name}
                        </strong>
                    </a><br>
                    <br>
                    描述:<br>
                    ${bug.bewrite}<br>
                    <br>
                    回复人:
                    <a href="article-user?id=${bug.solver.user_id}">
                        <strong>
                            ${bug.solver.user_name}
                        </strong>
                    </a>
                    <br>
                    回复时间:
                    <fmt:formatDate value="${bug.solve_time}" type="both" pattern="yyyy-MM-dd HH:mm"/><br>
                    <br>
                    回复:<br>
                    ${bug.replay}
                    </p>
                </div>
            </div>
        </div>
        <!-- /.blog-main -->

        <div class="col-sm-3 blog-sidebar margin-top-20">
            <c:choose>
            <c:when test="${sessionScope.user != null and sessionScope.user.user_is_admin == 1}">
            <div class="sidebar-module sidebar-module-inset">
                <h4>管理员操作</h4>
                <form id="bugSubForm">
                    <input class="form-control hide" name="bug.id" value="${bug.id}">
                    <div class="form-group">
                        <label for="bugReplay">留言</label>
                        <textarea id="bugReplay" class="form-control" rows="3"
                                  name="bug.replay">${bug.replay}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="bugState">缺陷状态</label>
                        <select id="bugState" class="form-control" name="bug.state">
                            <option value="0">新提交</option>
                            <option value="1" selected="selected">已处理</option>
                            <option value="2">关闭</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <button id="subBugButton" type="button" class="btn btn-primary" style="width:100%;">提交
                        </button>
                    </div>
                    <div class="list-group" id="submitBugLoadding" hidden>
                        <div class="spinner">
                            <div class="bounce1"></div>
                            <div class="bounce2"></div>
                            <div class="bounce3"></div>
                        </div>
                    </div>
                </form>
                </c:when>
                </c:choose>
            </div>
        </div>

        <!-- /.blog-sidebar -->
    </div>
    <!-- /.row -->

</div>
<!-- /.container -->
<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {
        $("#toolsTab").addClass("active")
        var viewer = new Viewer(document.getElementById('container'))
    })
    $("#subBugButton").click(function () {
        if ($("#bugReplay").val() == "" || $("#bugReplay").val().length == 0) {
            alert("请输入留言")
            return false
        }
        $("#submitBugLoadding").show()
        $.ajax({
            cache: true,
            type: "POST",
            url: "bug-solve",
            data: $('#bugSubForm').serialize(),
            async: false,
            success: function (data) {
                var state = data.state
                $("#submitBugLoadding").hide()
                $("#bugName").val("")
                $("#bugBewirte").val("")
                if (state == 0) {
                    alert("提交成功。")
                    location.replace(location.href)
                } else {
                    alert("提交异常，异常码：" + state)
                }
            }
        });
    })

</script>
</body>
</html>