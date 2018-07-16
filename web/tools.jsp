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

            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <h1 class="text-center">
                        <strong>
                            消息中心 Beta
                        </strong>
                    </h1>
                    <div class="caption">
                        <p>版本:
                            <a>
                                1.0
                            </a>
                        </p>
                        <p>上线时间:
                            <a href="article-one?id=72">
                                未知
                            </a>
                        </p>
                        <p>
                            万物基于沟通
                        </p>
                        <p>
                            <a href="msg.jsp" class="btn btn-primary" role="button">
                                立即使用
                            </a>
                            &nbsp;
                            <a href="javascript:void(0)" class="btn btn-default" role="button">
                                评价
                            </a>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <h1 class="text-center">
                        <strong>
                            全局搜索 Beta
                        </strong>
                    </h1>
                    <div class="caption">
                        <p>版本:
                            <a>
                                1.0
                            </a>
                        </p>
                        <p>上线时间:
                            <a href="article-one?id=72">
                                2017-12-11
                            </a>
                        </p>
                        <p>
                            搜索一切
                        </p>
                        <p>
                            <a href="search.jsp" class="btn btn-primary" role="button">
                                立即使用
                            </a>
                            &nbsp;
                            <a href="javascript:void(0)" class="btn btn-default" role="button">
                                评价
                            </a>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <h1 class="text-center">
                        <strong>
                            反馈中心 Beta
                        </strong>
                    </h1>
                    <div class="caption">
                        <p>版本:
                            <a>
                                1.0
                            </a>
                        </p>
                        <p>上线时间:
                            <a href="article-one?id=55">
                                2017-09-21
                            </a>
                        </p>
                        <p>您的意见对我们至关重要</p>
                        <p>
                            <a href="bugs.jsp" class="btn btn-primary" role="button">
                                立即使用
                            </a>
                            &nbsp;
                            <a href="javascript:void(0)" class="btn btn-default" role="button">
                                评价
                            </a>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <h1 class="text-center">
                        <strong>
                            搬瓦工查询 Beta
                        </strong>
                    </h1>
                    <div class="caption">
                        <p>版本:
                            <a>
                                1.0
                            </a>
                        </p>
                        <p>上线时间:
                            <a href="article-one?id=61">
                                2017-08-14
                            </a>
                        </p>
                        <p>搬瓦工，便宜又好用</p>
                        <p>
                            <a href="banwagon.jsp" class="btn btn-primary" role="button">
                                立即使用
                            </a>
                            &nbsp;
                            <a href="javascript:void(0)" class="btn btn-default" role="button">
                                评价
                            </a>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-md-4">
                <div class="thumbnail">
                    <h1 class="text-center">
                        <strong>
                            后台管理 Beta
                        </strong>
                    </h1>
                    <div class="caption">
                        <p>版本:
                            <a>
                                1.0
                            </a>
                        </p>
                        <p>上线时间:
                            <a href="article-one?id=46">
                                2017-09-01
                            </a>
                        </p>
                        <p>权限狗的世界</p>
                        <c:choose>
                            <c:when test="${sessionScope.user.user_is_admin eq 1}">
                                <p>
                                    <a href="admin_index.jsp" class="btn btn-primary" role="button">
                                        立即使用
                                    </a>
                                    &nbsp;
                                    <a href="javascript:void(0)" class="btn btn-default" role="button">
                                        评价
                                    </a>
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p>
                                    <a href="javascript:void(0)" class="btn btn-primary disabled" role="button">
                                        暂无权限
                                    </a>
                                    &nbsp;
                                    <a href="javascript:void(0)" class="btn btn-default" role="button">
                                        评价
                                    </a>
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
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

