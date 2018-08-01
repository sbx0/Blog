<%--
  Created by IntelliJ IDEA.
  User: winmj
  Date: 2017/9/9
  Time: 17:02
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

    <title>工具箱 - <fmt:message key="website.name"/></title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">
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
    <div class="margin-bottom-10 margin-top-20" role="alert">
        <div class="row">

            <div class="hidden-sm hidden-xs col-md-3 imgRestrict">
                <a href="https://www.vultr.com/?ref=7466976">
                    <img src="https://www.vultr.com/media/banner_3.png" width="300" height="250">
                </a>
            </div>

            <div class="col-sm-12 col-md-6">
                <div class="list-group">
                    <a href="" class="list-group-item list-group-item-success disabled">
                        <span class="badge">即将推出</span>
                        <strong>
                            积分市场
                        </strong>
                    </a>
                    <a href="msg.jsp" class="list-group-item">
                        <span class="badge">测试版</span>
                        <strong>
                            消息中心
                        </strong>
                    </a>
                    <a href="search.jsp" class="list-group-item">
                        <span class="badge">测试版</span>
                        <strong>
                            全局搜索
                        </strong>
                    </a>
                    <a href="bugs.jsp" class="list-group-item list-group-item-danger">
                        <span class="badge">正式版</span>
                        <strong>
                            反馈中心
                        </strong>
                    </a>
                    <c:choose>
                        <c:when test="${sessionScope.user.user_is_admin eq 1}">
                            <a href="admin_index.jsp" class="list-group-item list-group-item-warning">
                                <span class="badge">测试版</span>
                                <strong>
                                    后台管理
                                </strong>
                            </a>
                        </c:when>
                    </c:choose>
                    <a href="banwagon.jsp" class="list-group-item list-group-item-heading disabled">
                        <span class="badge">停止维护</span>
                        <strong>
                            搬瓦工查询
                        </strong>
                    </a>
                </div>
            </div>

            <div class="hidden-sm hidden-xs col-md-3 imgRestrict">
                <a href="https://www.vultr.com/?ref=7466976"><img src="https://www.vultr.com/media/banner_3.png" width="300" height="250"></a>
            </div>

        </div>
    </div>
</div>
<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {
        $("#toolsTab").addClass("active")
    })
</script>
</body>
</html>

