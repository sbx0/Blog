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
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="<fmt:message key="website.name"/>">
    <meta name="author" content="<fmt:message key="bloger"/>">
    <link rel="icon" href="img/favicon.png">

    <title>反馈中心 - <fmt:message key="website.name"/></title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
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

        <div class="row">
            <div class="col-sm-12 margin-bottom-10">
                <button id="showSubButton" class="btn btn-danger">
                    提交反馈
                </button>
                <button class="btn btn-default">
                    我的反馈
                </button>
                <button class="btn btn-default">
                    我的任务
                </button>
                <button id="solveBugBtn" data-toggle="modal" data-target="#solveBug" class="btn btn-success">
                    解决反馈
                </button>
            </div>
            <div class="col-sm-12 col-md-6">
                <h4>最近提交</h4>
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
                <h4>已解决</h4>
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

<div id="submitBug" class="modal fade bs-example-modal-md" tabindex="-1" role="dialog" aria-labelledby="submitBug">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 id="modelTitle" class="modal-title">提交反馈</h4>
                <div id="subBugHelp" class="alert alert-warning alert-dismissible fade in browser-check-alert hide"
                     role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <form id="bugSubForm" class="margin-top-20">
                        <div class="form-group">
                            <label for="bugName">缺陷命名</label>
                            <input class="form-control" id="bugName" name="bug.name" placeholder="名称">
                        </div>
                        <div class="form-group">
                            <label for="bugGrade">缺陷评级（<a href="article-one?id=54" target="_Blank">评级标准</a>）</label>
                            <select id="bugGrade" class="form-control" name="bug.grade">
                                <option value="1">建议 - P1</option>
                                <option value="2">低级 - P2</option>
                                <option value="3">一般 - P3</option>
                                <option value="4">严重 - P4</option>
                                <option value="5">致命 - P5</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="bugBewirte">缺陷描述</label>
                            <textarea id="bugBewirte" class="form-control" rows="3" name="bug.bewrite"></textarea>
                        </div>
                        <div class="form-group">
                            <div id="photo" class="margin-bottom-10"></div>
                        </div>
                        <div class="form-group">
                            <form id="upload" name="upload" method="post" action="/UploadServlet"
                                  enctype="multipart/form-data">
                                <div class="form-group">
                                    <input id="file" name="file" type="file">
                                    <p class="help-block">注意：图片最大不能超过10M</p>
                                </div>
                                <button id="submit" name="submit" class="btn btn-default" type="button">上传</button>
                            </form>
                        </div>
                        <div id="isRobot" class="well">
                            <p id="replay" align="center">点击进行人机验证</p>
                            <div class="list-group" id="checkHuman" hidden>
                                <p align="center">正在检测</p>
                                <div class="spinner">
                                    <div class="bounce1"></div>
                                    <div class="bounce2"></div>
                                    <div class="bounce3"></div>
                                </div>
                            </div>
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
                </div>
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
    })

    $("#solveBugBtn").click(function () {
        $.ajax({
            url: "bug-get",
            type: "POST",
            dataType: "json",
            success: function (data) {
                var state = data.state
                if (state == 0) {
                    var id = data.id
                    var name = data.name
                    var grade = data.grade
                    $("#solveBugList").html(buildBugItem(id, grade, name, 1))
                } else {
                    $("#solveBugList").html("<p class=\"text-center\">获取失败</p>")
                }
                $("#solveBugLoadding").hide()
            }
        })

    })

    document.getElementById("submit").onclick = function () {
        var xhr = new XMLHttpRequest();
        var formData = new FormData();
        var fileInput = document.getElementById("file");
        var file = fileInput.files[0];
        var json
        var url
        formData.append('myFile', file);
        xhr.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                json = JSON.parse(this.responseText)
                url = "http://upload.ducsr.cn/" + json.url
            }
        }
        xhr.open("POST", "http://upload.ducsr.cn/UploadServlet");
        xhr.onload = function () {
            if (this.status === 200) {
                $("#uploadImg").modal('toggle')
                img = "<img src='" + url + "' class='img-responsive'>"
                $("#photo").html(img)
                fileInput.value = ""
            }
        }
        xhr.send(formData)
        xhr = null
    }

    $("#isRobot").click(function () {
        loadding()
    })

    function loadding() {
        $("#replay").hide()
        $("#checkHuman").show()
        setTimeout(function () {
            isRobot = false
            $("#isRobot").hide()
            $("#checkHuman").hide()
        }, 1000)
    }

    $("#showSubButton").click(function () {
        $("#submitBug").modal('toggle')
    })

    $("#subBugButton").click(function () {
        if ($("#bugName").val() == "" || $("#bugName").val().length == 0) {
            alert("请输入缺陷名")
            return false
        }
        if ($("#bugBewirte").val() == "" || $("#bugBewirte").val().length == 0) {
            alert("请输入缺陷描述")
            return false
        }
        if (isRobot == true) {
            alert("未通过机器人检测")
            return false
        }
        $("#submitBugLoadding").show()
        $("#bugBewirte").val($("#bugBewirte").val() + img)
        $.ajax({
            cache: true,
            type: "POST",
            url: "bug-submit",
            data: $('#bugSubForm').serialize(),
            async: false,
            success: function (data) {
                var state = data.state
                $("#submitBugLoadding").hide()
                $("#bugName").val("")
                $("#bugBewirte").val("")
                if (state == 0) {
                    alert("提交成功。")
                    newbugs_page = 1
                    showBugs(0)
                } else {
                    alert("提交异常，异常码：" + state)
                }
                isRobot = true
                $("#isRobot").show()
                $("#replay").show()
            }
        });
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
                        if (what == 1) {
                            $(whatbugs).append(buildBugItem(id, what, name, 0))
                        } else {
                            $(whatbugs).append(buildBugItem(id, grade, name, 1))
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

    function buildBugItem(id, grade, name, type) {
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
        var bugItem = "<a target='_blank' href='bug-one?par=" + id + "'" +
            "class='list-group-item " + gradeClass + "'>" +
            "<span class='badge'>" +
            "B" + id +
            "</span>" +
            name +
            "</a>"
        return bugItem
    }
</script>
</body>
</html>