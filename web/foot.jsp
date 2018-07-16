<%--
  Created by IntelliJ IDEA.
  User: winmj
  Date: 2017/7/27
  Time: 14:15
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

<footer class="blog-footer">
    <p>
        <a href="index.jsp" class="text-danger">真首页</a>
        |
        <a href="bugs.jsp" class="text-danger">意见反馈</a>
    </p>
    <p>
        当前在线数:
        <strong>
                <span id="loginCount" class="text-danger">
                    加载中
                </span>
        </strong>
        &nbsp;
        <span id="maxLoginDate">
                    加载中
        </span>
    </p>
    <p>
        <fmt:message key="copyright"/>
    </p>
</footer>

<script src="js/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
<script src="js/bootstrap.min.js"></script>
<script src="js/ie10-viewport-bug-workaround.js"></script>
<script src="js/message.js"></script>
<script src="js/messenger.min.js"></script>
<script src="js/messenger-theme-flat.js"></script>
<script src="js/base.js"></script>
<script src="js/time-format.js"></script>
<script src="js/browser-check.js"></script>
<script src="js/code.js"></script>
<script src="js/cookie.js"></script>
<script src="js/viewer.min.js"></script>
<script src="js/i18N.js"></script>
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<script>
    (adsbygoogle = window.adsbygoogle || []).push({
        google_ad_client: "ca-pub-7377922292358202",
        enable_page_level_ads: true
    });
</script>
<c:if test="${session.WW_TRANS_I18N_LOCALE eq null}">
    <script src="js/i18N_zh_CN.js"></script>
</c:if>
<c:if test="${session.WW_TRANS_I18N_LOCALE ne null}">
    <script src="js/i18N_<s:property value="#session.WW_TRANS_I18N_LOCALE"/>.js"></script>
</c:if>