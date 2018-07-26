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
    <meta name="description" content="<fmt:message key="website.name"/>">
    <meta name="author" content="<fmt:message key="bloger"/>">
    <link rel="icon" href="img/favicon.png">

    <title>B${bug.id} - 反馈详情 - <fmt:message key="website.name"/></title>

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

    <div class="row">

        <div class="col-sm-9 blog-main margin-top-20">
            <ol class="breadcrumb">
                <li><a href="tools.jsp">工具</a></li>
                <li><a href="bugs.jsp">反馈中心</a></li>
                <li class="active">反馈详情</li>
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
                        <strong id="grade">
                            ${bug.grade}
                        </strong>
                        &nbsp;
                        状态:
                        <strong id="state">
                            ${bug.state}
                        </strong>
                    </h4>
                    提交时间:
                    <fmt:formatDate value="${bug.submit_time}" type="both" pattern="yyyy-MM-dd HH:mm"/><br>
                    <input id="submitTime" value="${bug.submit_time}" hidden>
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
                    处理人:
                    <a href="article-user?id=${bug.solver.user_id}">
                        <strong>
                            ${bug.solver.user_name}
                        </strong>
                    </a>
                    <br>
                    解决时间:
                    <input id="solveTime" value="${bug.solve_time}" hidden>
                    <fmt:formatDate value="${bug.solve_time}" type="both" pattern="yyyy-MM-dd HH:mm"/><br>
                    <br>
                    备注:<br>
                    ${bug.replay}
                    </p>
                </div>
            </div>
        </div>

        <div class="col-sm-3 blog-sidebar margin-top-20">
            <div class="sidebar-module sidebar-module-inset">
                <p class="text-center">
                    <span id="submitDays"></span>
                </p>
            </div>
            <c:choose>
            <c:when test="${sessionScope.user != null and sessionScope.user.user_is_admin == 1}">
            <div class="sidebar-module sidebar-module-inset">
                <h4>操作</h4>
                <form id="bSubForm" hidden>
                    <input id="bId" class="form-control hide" name="bug.id" value="${bug.id}">
                    <div class="form-group">
                        <label for="bReplay">备注</label>
                        <textarea id="bReplay" class="form-control" rows="3" name="bug.replay">${bug.replay}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="bState">修改状态</label>
                        <select id="bState" class="form-control" name="bug.state">
                            <option value="2" selected="selected">--- 未选择 ---</option>
                            <option value="0">未处理</option>
                            <option value="-1">处理中</option>
                            <option value="1">已处理</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="bGrade">修改评级</label>
                        <select id="bGrade" class="form-control" name="bug.grade">
                            <option value="0" selected="selected">--- 未选择 ---</option>
                            <option value="1">建议</option>
                            <option value="2">低级</option>
                            <option value="3">一般</option>
                            <option value="4">严重</option>
                            <option value="5">致命</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <button id="subBug" type="button" class="btn btn-default btn-full-weight" disabled>
                            提交
                        </button>
                    </div>
                </form>
                <div id="missionBtnDiv" class="form-group margin-top-20">
                    <div class="spinner">
                        <p class="text-center">检测权限中</p>
                        <div class="bounce1"></div>
                        <div class="bounce2"></div>
                        <div class="bounce3"></div>
                    </div>
                </div>
                </c:when>
                </c:choose>
            </div>
        </div>

    </div>

</div>
<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {
        $("#toolsTab").addClass("active")
        var viewer = new Viewer(document.getElementById('container'))

        var grade = $("#grade").html().toString().trim()
        var state = $("#state").html().toString().trim()

        $("#grade").html(gradeToString(grade))
        $("#state").html(stateToString(state))

        var sTime = $("#submitTime").val()
        sTime = Format(getDate(sTime.toString()), "yyyy-MM-dd")
        var eTime

        if (state == "1") {
            eTime = $("#solveTime").val()
            eTime = Format(getDate(eTime.toString()), "yyyy-MM-dd")
            if (eTime != "1970-01-01") $("#submitDays").html("历时 " + Math.abs(DateMinus(sTime, eTime)) + " 天")
            else $("#submitDays").html("已提交 " + Math.abs(DateMinus(sTime)) + " 天")
        } else {
            $("#submitDays").html("已提交 " + Math.abs(DateMinus(sTime)) + " 天")
        }
        check()
    })

    $(document).on("click", "button[id='missionBtn']", function () {
        var id = $("#bId").val()
        $.ajax({
            url: "bug-job?par=" + id,
            type: "POST",
            success: function (data) {
                if (data.state == 0) {
                    alert("操作成功")
                } else {
                    alert(i18N.network_error)
                }
                location.replace(location.href)
            }
        })
    })

    function check() {
        var id = $("#bId").val()
        var btn = ""
        $.ajax({
            url: "bug-check?par=" + id,
            type: "POST",
            success: function (data) {
                if (data.state == 0) {
                    var state = data.solve_state
                    if (state == -1) {
                        // 可以接受任务
                        btn = "<button id=\"missionBtn\" type=\"button\" class=\"btn btn-primary btn-full-weight\">接受任务</button>"
                        $("#subBug").attr("disabled", true)
                    } else if (state == 0) {
                        // 可以放弃任务
                        $("#bSubForm").show()
                        btn = "<button id=\"missionBtn\" type=\"button\" class=\"btn btn-danger btn-full-weight\">放弃任务</button>"
                        $("#subBug").attr("disabled", false)
                    } else if (state == 1) {
                        // 已被认领的任务
                        btn = ""
                        $("#subBug").attr("disabled", true)
                    } else if (state == 2) {
                        // 已被解决的任务
                        btn = ""
                        $("#bSubForm").show()
                        $("#subBug").attr("disabled", false)
                    }
                    $("#missionBtnDiv").html(btn)
                }
            }
        })
    }

    function stateToString(num) {
        var state
        switch (num) {
            case "0":
                state = "未处理"
                $("#state").addClass("text-primary")
                break
            case "1":
                state = "已处理"
                $("#state").addClass("text-success")
                break
            case "-1":
                state = "处理中"
                $("#state").addClass("text-info")
                break
            default:
                state = "未知"
                $("#state").addClass("text-muted")
        }
        return state
    }

    function gradeToString(num) {
        var grade
        switch (num) {
            case "1":
                grade = "建议"
                $("#grade").addClass("text-primary")
                break
            case "2":
                grade = "低级"
                $("#grade").addClass("text-success")
                break
            case "3":
                grade = "一般"
                $("#grade").addClass("text-info")
                break
            case "4":
                grade = "严重"
                $("#grade").addClass("text-warning")
                break
            case "5":
                grade = "致命"
                $("#grade").addClass("text-danger")
                break
            default:
                grade = "未知"
                $("#grade").addClass("text-muted")
        }
        return grade
    }

    $("#subBug").click(function () {
        $.ajax({
            cache: true,
            type: "POST",
            url: "bug-solve",
            data: $('#bSubForm').serialize(),
            async: false,
            success: function (data) {
                var state = data.state
                $("#bReplay").val("")
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