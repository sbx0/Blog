<%--
  Created by IntelliJ IDEA.
  User: winmj
  Date: 2017/7/30
  Time: 13:55
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

    <title>后台首页</title>

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
    <div class="row">
        <div class="container">
            <div class="blog-main margin-top-20">

                <ol class="breadcrumb">
                    <li><a href="tools.jsp">工具</a></li>
                    <li class="active">后台管理</li>
                </ol>

                <c:choose>
                    <c:when test="${sessionScope.user eq null}">
                        <div class="alert alert-danger margin-top-20" role="alert">
                            未登录！
                        </div>
                    </c:when>
                    <c:when test="${sessionScope.user.user_is_admin ne 1}">
                        <div class="alert alert-danger margin-top-20" role="alert">
                            无权限！
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="form-group form-table">
                            <label>表</label>
                            <select class="form-control" id="table-select">
                                <option value="1">文章</option>
                                <option value="2">用户</option>
                                <option value="3">评论</option>
                                    <%--<option value="4">消息</option>--%>
                                    <%--<option value="5">激活码</option>--%>
                                    <%--<option value="6">状态</option>--%>
                            </select>
                        </div>
                        <div class="form-group form-table">
                            <label>页码</label>
                            <input type="number" class="form-control" id="page" value="1">
                        </div>
                        <div class="form-group form-table">
                            <label>条数</label>
                            <input type="number" class="form-control" id="pageSize" value="10">
                        </div>
                        <div class="form-group form-table">
                            <button id="load" class="btn btn-primary" style="width: 100%">加载数据</button>
                        </div>
                        <div class="spinner" id="loaddingTable" hidden>
                            <div class="bounce1"></div>
                            <div class="bounce2"></div>
                            <div class="bounce3"></div>
                        </div>
                        <div id="table" hidden>
                            <div class="table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead id="table-title"></thead>
                                    <tbody id="table-body"></tbody>
                                </table>
                            </div>
                            <nav>
                                <ul class="pager">
                                    <li id="page-prev-li" class="previous">
                                        <a id="page-prev-a" href="javascript:void(0)">
                                            上一页
                                        </a>
                                    </li>
                                    <li>
                                        <span></span>
                                    </li>
                                    <li id="page-next-li" class="next">
                                        <a id="page-next-a" href="javascript:void(0)">
                                            下一页
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- /.blog-main -->

        </div>
    </div>
    <!-- /.row -->

    <div id="changeComment" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog"
         aria-labelledby="changeComment">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span>
                    </button>
                    <h4 id="modelTitle" class="modal-title">评论</h4>
                    <form id="changeCommentForm">
                        <input id="changeCommentId" name="comment.comment_id" hidden>
                        <div class="form-group">
                                <textarea id="changeCommentContent" name="comment.comment_content" class="form-control"
                                          rows="3"></textarea>
                        </div>
                        <div class="form-group">
                            <button id="changeCommentBtn" type="button" class="btn btn-primary" style="width:100%;">
                                提交
                            </button>
                        </div>
                        <div class="list-group" id="changeCommentLoad" hidden>
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
<!-- /.container -->
<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {

        $("#toolsTab").addClass("active")
        checkBrowser()

        $("#load").click()

    })

    $("#table-select").change(function () {
        $("#load").click()
    })

    $(document).on("click", "a[name='del']", function () {

        if (confirm("确认删除？注意此操作无法恢复！", i18N.delete_confirm)) {
            var href = this.href
            $.ajax({
                type: "post",
                url: href,
                dataType: "json",
                success: function (data) {
                    var status = data.status
                    if (status == 0) {
                        alert('删除成功', 'success')
                    } else if (status == 1 || status == 2) {
                        alert("删除失败，请稍后再试！")
                    }
                    pageControl(0)
                }
            })
        }

        return false
    })

    $("#load").click(function () {
        pageControl(0)
        return false
    })

    function loadData(page, pageSize, select) {
        if (pageSize > 10000000) {
            $("#pageSize").val("10000000")
            pageSize = 10000000
            alert("最多查询10000000条记录")
        }
        var url = "admin-"
        if (select == 1) {
            url += "article"
        } else if (select == 2) {
            url += "user"
        } else if (select == 3) {
            url += "comment"
        } else {
            alert("暂时无法操作")
            $("#loaddingTable").hide()
            return false
        }
        url += "?page=" + page + "&pageSize=" + pageSize
        $.ajax({
                type: "post",
                url: url,
                dataType: "json",
                success: function (data) {
                    $("#loaddingTable").hide()
                    $("#table").show()

                    $("#page-prev-li").removeClass("disabled")
                    $("#page-next-li").removeClass("disabled")
                    $("#page-prev-a").removeClass("not-active")
                    $("#page-next-a").removeClass("not-active")

                    var title = data.title
                    loadTitle(title)
                    var body = data.body
                    if (body.length == 0) {
                        $("#page").val(page)
                        $("#page-prev-li").addClass("disabled")
                        $("#page-next-li").addClass("disabled")
                        $("#page-prev-a").addClass("not-active")
                        $("#page-next-a").addClass("not-active")
                    } else if (body.length < pageSize) {
                        $("#page-next-li").addClass("disabled")
                        $("#page-next-a").addClass("not-active")
                    }
                    if (page == 1) {
                        $("#page-prev-li").addClass("disabled")
                        $("#page-prev-a").addClass("not-active")
                    }
                    loadBody(body)
                }
            }
        )
    }

    function loadTitle(title) {
        var tableTitle = "<tr>"
        for (var i = 0; i < title.length; i++) {
            tableTitle += "<th>" + title[i] + "</th>"
        }
        tableTitle += "</tr>"
        $("#table-title").html(tableTitle)
    }

    function loadBody(body) {
        var select = $("#table-select").val()
        $("#table-body").html("")
        var tableBody
        if (select == 1) {
            for (var i = 0; i < body.length; i++) {
                var time = Format(getDate(body[i].article_time.time.toString()), "yyyy-MM-dd HH:mm")
                tableBody = "<tr>"
                tableBody += "<td>" + body[i].article_id + "</td>"
                tableBody += "<td>" + body[i].article_title + "</td>"
                tableBody += "<td>" + body[i].article_author.user_name + "</td>"
                tableBody += "<td>" + time + "</td>"
                tableBody += "<td>" + body[i].article_views + "</td>"
                tableBody += "<td>" + body[i].article_comment + "</td>"
                tableBody += "<td>" +
                    "<a name='del' href='article-deleteReturnJson?id=" + body[i].article_id + "' class='text-danger'>删除</a>&nbsp;" +
                    "<a name='update' href='article-update?id=" + body[i].article_id + "' target='_Blank'>修改</a>&nbsp;" +
                    "<a name='show' href='article-one?id=" + body[i].article_id + "' target='_Blank'>查看</a>" +
                    "</td>"
                tableBody += "</tr>"
                $("#table-body").append(tableBody)
            }
        } else if (select == 2) {
            for (var i = 0; i < body.length; i++) {
                var register_time = Format(getDate(body[i].user_register_time.time.toString()), "yyyy-MM-dd HH:mm")
                var user_birthday = Format(getDate(body[i].user_birthday.time.toString()), "yyyy-MM-dd")
                tableBody = "<tr>"
                tableBody += "<td>" + body[i].user_id + "</td>"
                tableBody += "<td>" + body[i].user_name + "</td>"
                tableBody += "<td>" + body[i].user_email + "</td>"
                tableBody += "<td>*</td>"
                tableBody += "<td>" + body[i].user_is_admin + "</td>"
                tableBody += "<td>" + register_time + "</td>"
                tableBody += "<td>" + user_birthday + "</td>"
                tableBody += "<td>" + body[i].user_signature + "</td>"
                tableBody += "<td>" + body[i].user_integral + "</td>"
                tableBody += "<td>" +
                    "<a name='del' href='user-delete?id=" + body[i].user_id + "' class='text-danger'>删除<a/>" +
                    "&nbsp;" +
                    "<a href='user-info?id=" + body[i].user_id + "' target='_Blank'>修改<a/>" +
                    "&nbsp;" +
                    "<a href='article-user?id=" + body[i].user_id + "' target='_Blank'>查看<a/>" +
                    "</td>"
                tableBody += "</tr>"
                $("#table-body").append(tableBody)
            }
        } else if (select == 3) {
            for (var i = 0; i < body.length; i++) {
                var comment_time = Format(getDate(body[i].comment_time.time.toString()), "yyyy-MM-dd HH:mm")
                tableBody = "<tr>"
                tableBody += "<td>" + body[i].comment_id + "</td>"
                tableBody += "<td>" + body[i].comment_floor + "</td>"
                tableBody += "<td>" + body[i].user_id + "</td>"
                tableBody += "<td>" + body[i].article_id + "</td>"
                tableBody += "<td><a id ='" + body[i].comment_id + "' name='showComment' href='javascript:void(0)'>查看</a>"
                tableBody += "<td>" + comment_time + "</td>"
                tableBody += "<td>" +
                    "<a name='deleteComment' href='article-deleteC?id=" + body[i].comment_id + "&a_id=" + body[i].article_id + "' class='text-danger'>" + i18N.delete + "</a>" +
                    "&nbsp;" +
                    "<a id ='" + body[i].comment_id + "' name='updateComment' href='javascript:void(0)'>" + i18N.update + "</a>"
                "</td>"
                tableBody += "</tr>"
                $("#table-body").append(tableBody)
            }
        }
    }

    $("#page-prev-a").click(function () {
        pageControl(1)
    })

    $("#page-next-a").click(function () {
        pageControl(2)
    })

    function pageControl(type) {
        $("#loaddingTable").show()
        $("#table-title").html("")
        $("#table-body").html("")
        var select = $("#table-select").val()
        var page = new Number($("#page").val().toString())
        if (type == 1) page = page - 1
        if (type == 2) page = page + 1
        if (page < 1) page = 1
        if (page > 999) page = 999
        var pageSize = $("#pageSize").val()
        loadData(page, pageSize, select)
        $("#page").val(page)
    }

    $("#table-select").change(function () {
        $("#page").val(1)
        $("#pageSize").val(10)
    })


    // 评论相关
    // 为所有name为deleteComment的a标签绑定一个点击事件
    $(document).on("click", "a[name='deleteComment']", function () {
        if (confirm(i18N.delete_confirm)) {
            var href = this.href
            $.ajax({
                type: "post",
                url: href,
                dataType: "json",
                success: function (data) {
                    var status = data.status
                    if (status == 0) {
                        alert('删除成功', 'success')
                    } else if (status == 3) {
                        alert("删除评论失败，积分不足")
                    }
                    pageControl(0)
                }
            })
        }
        return false
    })

    function getComment(id) {
        var con
        $.ajax({
            async: false,
            type: "post",
            url: "article-getOneComment?id=" + id,
            dataType: "json",
            async: false,
            success: function (data) {
                var c = data.comment
                con = c.content
            }
        })
        return con
    }

    $(document).on("click", "a[name='updateComment']", function () {
        $("#changeCommentBtn").show()
        $("#changeCommentContent").val("")
        var id = this.id
        var content = getComment(id)
        $("#changeCommentId").val(id)
        $("#changeCommentContent").val(content)
        $("#changeComment").modal('toggle')
        return false
    })

    $(document).on("click", "a[name='showComment']", function () {
        $("#changeCommentBtn").hide()
        $("#changeCommentContent").val("")
        var id = this.id
        var content = getComment(id)
        $("#changeCommentId").val(id)
        $("#changeCommentContent").val(content)
        $("#changeComment").modal('toggle')
        return false
    })

    $("#changeCommentBtn").click(function () {
        var content = $("#changeCommentContent").val()
        if (content.length > 150) {
            alert("评论过长")
            return false
        } else if (content == null || content.length == 0) {
            alert("不能为空")
            return false
        }
        $("#changeCommentLoad").show()
        $.ajax({
            type: "post",
            url: "article-updateComment",
            data: $('#changeCommentForm').serialize(),
            success: function (data) {
                var status = data.status
                if (status == 0) {
                    alert("修改成功")
                    $("#changeComment").modal('toggle')
                    pageControl(0)
                }
            }
        })
        $("#changeCommentLoad").hide()
    })

</script>
</body>
</html>