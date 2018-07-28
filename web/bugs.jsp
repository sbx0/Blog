<%--
  Created by IntelliJ IDEA.
  User: winmj
  Date: 2017/9/9
  Time: 17:33
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

    <title>反馈中心 - <fmt:message key="website.name"/></title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <link href="css/messenger.css" rel="stylesheet">
    <link href="css/messenger-theme-flat.css" rel="stylesheet">
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
    <div class="col-sm-12 margin-top-20 margin-bottom-10" role="alert">

        <ol class="breadcrumb">
            <li><a href="tools.jsp">工具</a></li>
            <li class="active">反馈中心</li>
        </ol>

        <div id="rate" class="jumbotron"></div>

        <div class="row">
            <div class="col-sm-12 margin-bottom-10">
                <button id="showSubButton" class="btn btn-danger">
                    提交反馈
                </button>
                <c:choose>
                    <c:when test="${sessionScope.user ne null}">
                        <button id="mySubmitBugBtn" data-toggle="modal" data-target="#mySubmitBug"
                                class="btn btn-default">
                            我的反馈
                        </button>
                    </c:when>
                </c:choose>
                <c:choose>
                    <c:when test="${sessionScope.user.user_is_admin eq 1}">
                        <button id="myBugBtn" data-toggle="modal" data-target="#myBug" class="btn btn-default">
                            我的任务
                        </button>
                        <button id="solveBugBtn" data-toggle="modal" data-target="#solveBug" class="btn btn-success">
                            解决反馈
                        </button>
                    </c:when>
                </c:choose>
            </div>
            <div class="col-sm-12 col-md-6">
                <h4>新提交</h4>
                <div>
                    <div class="list-group" id="new-bugs">
                    </div>
                    <div class="spinner" id="loaddingNewBugs" hidden>
                        <div class="bounce1"></div>
                        <div class="bounce2"></div>
                        <div class="bounce3"></div>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md-6">
                <h4>已处理</h4>
                <div>
                    <div class="list-group" id="solved-bugs"></div>
                    <div class="spinner" id="loaddingSolvedBugs" hidden>
                        <div class="bounce1"></div>
                        <div class="bounce2"></div>
                        <div class="bounce3"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="myBug" class="modal fade bs-example-modal-md" tabindex="-1" role="dialog" aria-labelledby="mySubmitBug">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">我的任务</h4>
                <div class="alert alert-warning alert-dismissible fade in browser-check-alert hide" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </div>
            <div class="modal-body">
                <div id="myBugList" class="list-group"></div>
            </div>
        </div>
    </div>
</div>

<div id="mySubmitBug" class="modal fade bs-example-modal-md" tabindex="-1" role="dialog" aria-labelledby="mySubmitBug">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">我的反馈</h4>
                <div class="alert alert-warning alert-dismissible fade in browser-check-alert hide" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </div>
            <div class="modal-body">
                <div id="mySubmitBugList" class="list-group"></div>
            </div>
        </div>
    </div>
</div>

<div id="solveBug" class="modal fade bs-example-modal-md" tabindex="-1" role="dialog" aria-labelledby="solveBug">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">解决反馈</h4>
                <div class="alert alert-warning alert-dismissible fade in browser-check-alert hide" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </div>
            <div class="modal-body">
                <div id="solveBugLoadding" class="spinner">
                    <p class="text-center">正在分配任务</p>
                    <div class="bounce1"></div>
                    <div class="bounce2"></div>
                    <div class="bounce3"></div>
                </div>
                <div id="solveBugList" class="list-group"></div>
            </div>
        </div>
    </div>
</div>

<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {
        $("#toolsTab").addClass("active")
        isRobot = true
        newbugs_page = 1
        solvedbus_page = 1
        showBugs(0)
        showBugs(1)

        img = ""

        getRate()
    })

    // 解决率
    function getRate() {
        $.ajax({
            url: "bug-rate",
            type: "POST",
            dataType: "json",
            success: function (data) {
                var rate = data.rate
                $("#rate").html("<h1><a href=\"javascript:void(0)\" title=\"反馈实时解决率\">" + rate + "</a></h1>")
            }
        })
    }

    // 我的任务 按钮点击
    $("#myBugBtn").click(function () {
        $("#myBugList").html(buildLoadding("加载中"))
        $.ajax({
            url: "bug-mission",
            type: "POST",
            dataType: "json",
            success: function (data) {
                $("#myBugList").html("")
                var state = data.state
                if (state == 0) {
                    var bugs = data.bugs
                    if (bugs.length == 0) {
                        $("#myBugList").html("<p class=\"text-center\">暂无任务</p>")
                    } else {
                        var id
                        var name
                        var grade
                        for (var i = 0; i < bugs.length; i++) {
                            id = bugs[i].id
                            name = bugs[i].name
                            grade = bugs[i].grade
                            state = bugs[i].state
                            $("#myBugList").append(buildBugItem(id, grade, state, name, 1))
                        }
                    }
                } else {
                    $("#myBugList").html("<p class=\"text-center\">获取失败</p>")
                }
            }
        })
    })

    // 我的反馈 按钮点击
    $("#mySubmitBugBtn").click(function () {
        $("#mySubmitBugList").html(buildLoadding("加载中"))
        $.ajax({
            url: "bug-my",
            type: "POST",
            dataType: "json",
            success: function (data) {
                $("#mySubmitBugList").html("")
                var state = data.state
                if (state == 0) {
                    var bugs = data.bugs
                    if (bugs.length == 0) {
                        $("#mySubmitBugList").html("<p class=\"text-center\">暂无反馈</p>")
                    } else {
                        var id
                        var name
                        var grade
                        for (var i = 0; i < bugs.length; i++) {
                            id = bugs[i].id
                            name = bugs[i].name
                            grade = bugs[i].grade
                            state = bugs[i].state
                            $("#mySubmitBugList").append(buildBugItem(id, grade, state, name, 1))
                        }
                    }
                } else {
                    $("#mySubmitBugList").html("<p class=\"text-center\">获取失败</p>")
                }
            }
        })
    })

    // 构造 加载
    function buildLoadding(text) {
        var loadding = "<div class=\"spinner\">\n" +
            "<p class=\"text-center\">" + text + "</p>\n" +
            "<div class=\"bounce1\"></div>\n" +
            "<div class=\"bounce2\"></div>\n" +
            "<div class=\"bounce3\"></div>\n" +
            "</div>"
        return loadding
    }

    // 构造 页脚
    function buildPager(id1, fun1, a1, id2, fun2, a2) {
        var pager = "<ul class=\"pager\">\n" +
            "\t\t<li class=\"previous\">\n" +
            "\t\t\t<a id=\"" + id1 + "\" href=\"" + fun1 + "\" >" + a1 + "</a>\n" +
            "\t\t</li>\n" +
            "\t\t<li class=\"next\">\n" +
            "\t\t\t<a id=\"" + id2 + "\" href=\"" + fun2 + "\" >" + a2 + "</a>\n" +
            "\t\t</li>\n" +
            "\t</ul>"
        return pager
    }

    // 解决反馈 按钮点击
    $("#solveBugBtn").click(function () {
        $.ajax({
            url: "bug-get",
            type: "POST",
            dataType: "json",
            success: function (data) {
                $("#solveBugList").html("")
                var state = data.state
                if (state == 0) {
                    var bugs = data.bugs
                    if (bugs.length == 0) {
                        $("#solveBugList").html("<p class=\"text-center\">没有待处理的反馈</p>")
                    } else {
                        var id
                        var name
                        var grade
                        for (var i = 0; i < bugs.length; i++) {
                            id = bugs[i].id
                            name = bugs[i].name
                            grade = bugs[i].grade
                            state = bugs[i].state
                            $("#solveBugList").append(buildBugItem(id, grade, state, name, 1))
                        }
                    }
                    // $("#solveBugList").append(buildPager("skip", "javascript:void(0)", "跳过", "accept", "javascript:void(0)", "接受"))
                } else {
                    $("#solveBugList").html("<p class=\"text-center\">获取失败</p>")
                }
                $("#solveBugLoadding").hide()
            }
        })
    })

    // 提交反馈模态框显示 按钮点击
    $("#showSubButton").click(function () {
        $("#submitBug").modal('toggle')
    })

    $(document).on("click", "a[name='loadnewbugs']", function () {
        showBugs(0)
    })

    $(document).on("click", "a[name='loadsolvedbugs']", function () {
        showBugs(1)
    })

    function showBugs(what) {
        var whatbugs
        var loadname
        var pageNo
        var loadding
        if (what == '0') {
            pageNo = newbugs_page
            whatbugs = "#new-bugs"
            newbugs_page = newbugs_page + 1
            loadname = "loadnewbugs"
            loadding = "#loaddingNewBugs"
        } else {
            pageNo = solvedbus_page
            whatbugs = "#solved-bugs"
            solvedbus_page = solvedbus_page + 1
            loadname = "loadsolvedbugs"
            loadding = "#loaddingSolvedBugs"
        }
        if (pageNo == 1) {
            $(whatbugs).html("")
        }
        $("a[name='" + loadname + "']").remove()
        $(loadding).show()
        $.ajax({
            url: "bug-list?page=" + pageNo + "&what=" + what,
            type: "post",
            dataType: "json",
            success: function (data) {
                var bugs = data.bugs
                if (typeof(bugs) == "undefined") {
                    if (pageNo == 1) {
                        $(whatbugs).append("<p class=\"text-center\">什么都没有</p>")
                    }
                    $("a[name='" + loadname + "']").hide()
                } else {
                    for (var i = 0; i < bugs.length; i++) {
                        var bug = bugs[i]
                        var id = bug[0]
                        var name = bug[1]
                        var grade = bug[2]
                        var state = bug[3]
                        if (what == 1) {
                            $(whatbugs).append(buildBugItem(id, what, state, name, 0))
                        } else {
                            $(whatbugs).append(buildBugItem(id, grade, state, name, 1))
                        }
                    }
                    if (bugs.length > 9) {
                        $(whatbugs).append(
                            "<a name='" + loadname + "'" +
                            "class=\"list-group-item text-center\">" +
                            "加载更多" +
                            "</a>"
                        )
                    }
                }
                $(loadding).hide()
            }
        })
    }

    function buildBugItem(id, grade, state, name, type) {
        var gradeClass
        if (type == 0) {
            if (grade == 1) {
                gradeClass = "list-group-item-success"
            }
        } else if (grade == 3) {
            gradeClass = "list-group-item-info"
        } else if (grade == 4) {
            gradeClass = "list-group-item-warning"
        } else if (grade == 5) {
            gradeClass = "list-group-item-danger"
        }

        var state = stateToString(state + "")

        var bugItem = "<a href='b?id=" + id + "'" +
            "class='list-group-item " + gradeClass + "'>" + state + name +
            "</a>"
        return bugItem
    }

    function stateToString(num) {
        var state
        switch (num) {
            case "0":
                state = "<span class='badge alert-danger'>未处理</span>"
                break
            case "1":
                state = "<span class='badge alert-success'>已处理</span>"
                break
            case "-1":
                state = "<span class='badge'>处理中</span>"
                break
            default:
                state = "<span class='badge alert-warning'>未知</span>"
        }
        return state
    }

</script>
</body>
</html>