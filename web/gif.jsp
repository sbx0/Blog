<%--
  Created by IntelliJ IDEA.
  User: winmj
  Date: 2017/7/27
  Time: 21:51
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

<div class="container">
    <div class="row">

        <div class=" col-sm-12 col-md-6">
            <div class="alert alert-warning fade in margin-top-20" role="alert">
                <i>
                    <h4 id="gifTitle">
                        积分抽奖
                    </h4>
                </i>
                <p id="gifResult"></p>
                <c:choose>
                    <c:when test="${sessionScope.user eq null}">
                        <button class="btn btn-danger btn-block gif-button" disabled="disabled">请登陆</button>
                    </c:when>
                    <c:otherwise>
                        <button id="gifButton" class="btn btn-danger btn-block gif-button">点击抽奖</button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="alert fade in col-sm-12 col-md-6" role="alert">
            <h4>中奖记录</h4>
            <div class="list-group">
                <p class="list-group-item ">
                <span class="badge">
                    加载中
                </span>
                    加载中
                </p>
                <a name="load-more" class="list-group-item text-center">加载更多</a>
            </div>
        </div>
    </div>

</div>