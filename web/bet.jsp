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
                    <h4 id="betTitle">
                        赌注 Beta
                    </h4>
                </i>

                <div id="beginDiv">
                    <c:choose>
                        <c:when test="${sessionScope.user eq null}">
                            <button class="btn btn-danger btn-block gif-button" disabled="disabled">请登陆</button>
                        </c:when>
                        <c:otherwise>
                            <button id="humanBtn" class="btn btn-danger btn-block gif-button hidden">开始匹配</button>
                            <button id="computerBtn" class="btn btn-danger btn-block gif-button">人机对战</button>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div id="matchDiv" class="text-center" hidden>
                    <i>
                        <h4>
                            匹配中
                        </h4>
                    </i>
                    <p>
                        已用
                        <span id="second">
                                0
                            </span>
                        秒
                    </p>
                    <div class="spinner" id="matching">
                        <div class="bounce1"></div>
                        <div class="bounce2"></div>
                        <div class="bounce3"></div>
                    </div>
                </div>

                <div id="countDownDiv" hidden>
                    <p class="text-center">
                        倒计时
                        <span id="countDownSecond">?</span>
                    </p>
                </div>

                <div id="numDiv" hidden>
                    <i>
                        <p class="text-center">
                            选择你的数字
                        </p>
                    </i>
                    <p>
                    <h1 class="text-center">
                        <a id="a1" href="javascript:void(0)">
                            <span id="num1">?</span>
                        </a>
                        &nbsp;&nbsp;
                        <a id="a2" href="javascript:void(0)">
                            <span id="num2">?</span>
                        </a>
                        &nbsp;&nbsp;
                        <a id="a3" href="javascript:void(0)">
                            <span id="num3">?</span>
                        </a>
                        &nbsp;&nbsp;
                        <a id="a4" href="javascript:void(0)">
                            <span id="num4">?</span>
                        </a>
                        &nbsp;&nbsp;
                        <a id="a5" href="javascript:void(0)">
                            <span id="num5">?</span>
                        </a>
                    </h1>
                    </p>
                </div>

                <div id="choseDiv" hidden>
                    <i>
                        <p class="text-center">
                            选择的数字
                        </p>
                        <p>
                        <h1 class="text-center">
                            <a id="aBet" href="javascript:void(0)">
                                <span id="betNum" class="text-success">?</span>
                            </a>
                            <span id="choseNum" hidden>?</span>
                        </h1>
                    </i>
                </div>

                <div id="betDiv" hidden>
                    <i>
                        <p class="text-center">
                            选择赌注
                        </p>
                        <p class="text-center">
                            当前积分：<span id="userIntegral">0</span>
                        </p>
                        <%--<p class="text-center">--%>
                            <%--赌注池：--%>
                            <%--<span id="betPool">0</span>--%>
                        <%--</p>--%>
                        <p>
                        <form class="text-center">
                            <div class="form-group">
                                <input id="betIntegral" type="number" class="form-control text-center" value="10">
                            </div>
                            <div class="form-group">
                                <button id="betBtn" type="button" class="btn btn-danger">确认</button>
                            </div>
                        </form>
                    </i>
                </div>

                <div id="computerDiv" hidden>
                    <i>
                        <p class="text-center">
                            对手的数字
                        </p>
                        <p>
                        <h1 class="text-center">
                            <span id="comNum" class="text-success">?</span>
                        </h1>
                    </i>
                </div>

                <div id="resultDiv" hidden>
                    <i>
                        <p class="text-center">
                            结果
                        </p>
                        <p>
                        <h3 class="text-center">
                            <span id="result">?</span>
                        </h3>
                        <h3 class="text-center">
                            <span id="integral">?</span>
                        </h3>
                        </p>
                    </i>
                </div>

                <div id="vsDiv" hidden>
                    <br><br><br>
                    <i>
                        <p class="text-center">
                            <span id="vsNum">?</span>
                        </p>
                    </i>
                </div>

            </div>


        </div>

        <div class="alert fade in col-sm-12 col-md-6 hidden" role="alert">
            <h4>游戏规则</h4>
            <p></p>
        </div>

    </div>

</div>
