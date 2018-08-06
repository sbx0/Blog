<%--
  Created by IntelliJ IDEA.
  User: sbx0
  Date: 2017/4/22
  Time: 21:13
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
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="description" content="<fmt:message key="website.name"/>">
    <meta name="author" content="<fmt:message key="bloger"/>">
    <link rel="icon" href="img/favicon.png">

    <c:choose>
        <c:when test="${article.article_title ne '#weibo#'}">
            <title>${article.article_title} - ${article.article_author.user_name} - <fmt:message
                    key="website.name"/></title>
        </c:when>
        <c:otherwise>
            <title>微博详情 - ${article.article_author.user_name} - <fmt:message key="website.name"/></title>
        </c:otherwise>
    </c:choose>

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
<c:choose>
    <c:when test="${article eq null}">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 blog-main margin-bottom-10">
                    <h3 class="article-top text-center"><fmt:message key="article.null.error"/></h3>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div id="container" class="container">

            <div class="row">

                <div class="col-sm-9 blog-main margin-top-20 imgRestrict">
                    <c:choose>
                        <c:when test="${article.article_title ne '#weibo#'}">
                            <h2 class="blog-post-title article-top">${article.article_title}</h2>
                        </c:when>
                    </c:choose>
                    <p class="blog-post-meta">
                        <fmt:message key="author"/>:
                        <a href="u?id=${article.article_author.user_id}">
                                ${article.article_author.user_name}
                        </a>
                        <fmt:message key="time"/>:
                        <fmt:formatDate value="${article.article_time}" type="both"
                                        pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
                    </p>
                    <p>
                            ${article.article_content}
                    </p>
                    <nav>
                        <ul id="pager-nav" class="pager"></ul>
                    </nav>
                </div>

                <div class="col-sm-3 blog-sidebar margin-top-20">
                    <div class="sidebar-module">
                        <h4>标签</h4>
                        <p id="tags">
                            加载中
                        </p>
                    </div>
                    <div class="sidebar-module sidebar-module-inset">
                        <h4><fmt:message key="about"/></h4>
                        <p>
                            <fmt:message key="view"/>:${article.article_views}<br>
                        </p>
                        <c:choose>
                            <c:when test="${sessionScope.user.user_id == article.article_author.user_id or sessionScope.user.user_is_admin == 1}">
                                <h4>
                                    <fmt:message key="admin"/>
                                </h4>
                                <p>
                                    <a id="manageTags" data-toggle="modal" data-target="#manageTagsModal">标签</a>
                                    |
                                    <a href="article-update?id=${article.article_id}">
                                        <fmt:message key="update"/>
                                    </a>
                                    |
                                    <a name="deleteArticle" href="article-delete?id=${article.article_id}"
                                       class="text-danger">
                                        <fmt:message key="delete"/>
                                    </a>
                                </p>
                            </c:when>
                        </c:choose>
                    </div>
                </div>

                <div class="col-sm-12 blog-sidebar">
                    <div class="sidebar-module">
                        <h4><fmt:message key="comment"/></h4>
                        <form action="" method="post" id="commentForm">
                            <div class="form-group">
							<textarea class="form-control" rows="2" id="comment"
                                      name="comment.comment_content"
                                      placeholder="<fmt:message key="comment.no1"/>"></textarea>
                            </div>
                            <c:choose>
                                <c:when test="${sessionScope.user eq null}">
                                    <button class="btn btn-full-weight" disabled="disabled">
                                        <fmt:message key="nologin"/>
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button id="commentButton" type="submit" class="btn btn-primary btn-full-weight">
                                        <fmt:message key="comment"/>
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </form>
                        <div class="commentList" id="commentList">
                            <hr id="endLine">
                            <div class="media" id="loadComments">
                                <div class="media-body">
                                    <div class="spinner" id="loaddingComment">
                                        <div class="bounce1"></div>
                                        <div class="bounce2"></div>
                                        <div class="bounce3"></div>
                                    </div>
                                    <h5 style="text-align: center" id="loadCommentsText">
                                        <fmt:message key="loadding"/>
                                    </h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="changeComment" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog"
             aria-labelledby="changeComment">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span>
                        </button>
                        <h4 id="modelTitle" class="modal-title">修改评论</h4>
                        <form id="changeCommentForm">
                            <input id="changeCommentId" name="comment.comment_id" hidden>
                            <div class="form-group">
                                <textarea id="changeCommentContent" name="comment.comment_content" class="form-control"
                                          rows="3"></textarea>
                            </div>
                            <div class="form-group">
                                <button id="changeCommentBtn" type="button" class="btn btn-primary btn-full-weight">
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

        <div id="manageTagsModal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog"
             aria-labelledby="changeComment">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">标签管理</h4>
                        <form id="manageTagsForm">
                            <p id="tagsList"></p>
                            <div class="form-group">
                                <textarea id="tagsTextarea"
                                          name="tagsText"
                                          placeholder="点击上方的标签即可删除。可一次提交多个标签，标签之间添加空格即可。"
                                          class="form-control"
                                          rows="3"></textarea>
                            </div>
                            <div class="form-group">
                                <button id="submitTags" class="btn btn-primary btn-full-weight">添加</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </c:otherwise>
</c:choose>

<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {

        // 评论第一次ajax加载的数据是第1页
        var pageNo = 1
        var loadComments = '<div class="media" id="loadComments"><div class="media-body"><div class="spinner" id="loaddingComments"><div class="bounce1"></div><div class="bounce2"></div><div class="bounce3"></div></div><h5 style="text-align: center" id="loadCommentsText">加载评论中</h5></div> </div>'
        var noMoreComments = '<h5 style="text-align: center" id="loadCommentsText">' + i18N.load_over + '</h5>'
        var noComments = '<h5 style="text-align: center" id="loadCommentsText">' + i18N.no_comment + '</h5>'
        var scrollTop = $(this).scrollTop()
        var scrollHeight = $(document).height()
        var windowHeight = $(this).height()

        var viewer = new Viewer(document.getElementById('container'))

        // 默认加载1次
        ajaxLoadComments()

        // 加载标签
        loadTags()

        // 上一篇下一篇
        prveNext()

        var commnetState = null
        $(document).keydown(function (e) {
            var e = e || event;
            // 用户按下回车键
            if (e.keyCode == "13") {
                $("#commentButton").click()
                return false
            }
            commnetState = null
        })

        // 为所有name为deleteArticle的a标签加一个点击事件
        $("a[name='deleteArticle']").click(function () {
            if (confirm(i18N.delete_confirm)) {
                return true
            }
            return false
        })

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
                            $(".commentList").html("<hr id='endLine'>" + loadComments)
                            pageNo = 1
                            ajaxPage = 0
                            ajaxLoadComments()
                        } else if (status == 3) {
                            alert("删除评论失败，积分不足")
                        }
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
                        $(".commentList").html("<hr id='endLine'>" + loadComments)
                        pageNo = 1
                        ajaxPage = 0
                        ajaxLoadComments()
                        // location.replace(location.href)
                    }
                }
            })
            $("#changeCommentLoad").hide()
        })

        // 评论按钮点击事件
        $("#commentButton").click(function () {
            var commentContent = $("#comment").val()
            if (commentContent == null || commentContent.trim().length == 0 || commentContent == "") {
                alert(i18N.comment_confirm)
                $("#comment").val("")
                $("#comment").focus()
                return false
            } else if (commentContent.length > 150) {
                alert("评论过长")
                return false
            } else {
                var url = "article-comment?id=${article.article_id}"
                if (commnetState != null) return false
                commnetState = "pending"
                $.ajax({
                    type: "post",
                    url: url,
                    data: $("#commentForm").serialize(),
                    dataType: "json",
                    success: function (data) {
                        // 状态
                        var status = data.status
                        var comments = data.comments
                        var user_id = data.user_id
                        var is_admin = data.is_admin
                        if (status == 0) {
                            alert(data.msg, 'success')
                            $(".commentList").html("<hr id='endLine'>" + loadComments)
                            showComments(comments, user_id, is_admin)
                            // 小于5时，为最后一页。等于1时，没有评论。
                            if (comments.length < 5) {
                                $("#loaddingComment").addClass("hide")
                                $("#loadComments").html(noMoreComments)
                            }
                            pageNo = 2
                            $("#comment").val("")
                        } else {
                            alert(i18N.comment_fail)
                        }
                        commnetState = null
                    }, error: function (e) {
                        alert(i18N.server_error)
                    }
                })
            }
            return false
        })

        // 点击加载评论 jq动态加载，JS动态添加的控件也能对事件响应
        $(document).on("click", "#loadComments", function () {
            if ($("#loadComments").html() != noMoreComments) {
                ajaxLoadComments()
            }
        })

        // 当滚动到当前页面的底部时
        $(window).scroll(function () {
            if ($("#loadComments").html() != noMoreComments) {
                scrollTop = $(this).scrollTop()
                scrollHeight = $(document).height()
                windowHeight = $(this).height()
                if (scrollTop + windowHeight + 180 >= scrollHeight) {
                    // 如果加载状态为null,则可以继续加载
                    ajaxLoadComments()
                }
            }
        })

        // 加载评论
        var ajaxPage = 1

        function ajaxLoadComments() {
            if (ajaxPage == pageNo) return
            ajaxPage = pageNo
            var url = "article-load?id=${article.article_id}"
            url = url + "&pageNo=" + pageNo
            $.ajax({
                type: "post",
                url: url,
                dataType: "json",
                success: function (data) {
                    // ID
                    var user_id = data.user_id
                    var is_admin = data.is_admin
                    // 状态
                    var status = data.status
                    // 评论
                    var comments = data.comments
                    if (status == 3) {
                        $("#loaddingComment").addClass("hide")
                        $("#loadComments").html(noComments)
                    } else if (status == 0) {
                        showComments(comments, user_id, is_admin)
                        // 小于5时，为最后一页。等于1时，没有评论。
                        if (comments.length < 5) {
                            $("#loaddingComment").addClass("hide")
                            $("#loadComments").html(noMoreComments)
                        }
                        pageNo++
                    } else if (status == 2) {
                        alert(i18N.load_comment_error)
                    }
                }, error: function (e) {
                    alert(i18N.comment_fail)
                }
            })
        }

        // 显示评论
        function showComments(comments, user_id, is_admin) {
            for (var i = 0; i < comments.length; i++) {
                var com_user_id = comments[i].comment_user.user_id
                var time = Format(getDate(comments[i].comment_time.time.toString()), "yyyy-MM-dd HH:mm");
                var comment = '<hr><div class="media" id="comment' + comments[i].comment_floor + '"><div class="media-left">\n' +
                    //                    '    <a href="#">\n' +
                    //                    '      <img class="media-object" src="img/favicon.png" alt="...">\n' +
                    //                    '    </a>\n' +
                    '</div><div class="media-body"><h5 class="media-heading">#'
                comment = comment + comments[i].comment_floor + '<a href="u?id=' +
                    comments[i].comment_user.user_id + '"> ' +
                    comments[i].comment_user.user_name +
                    '</a> ' + time + ' '
                if (com_user_id == user_id || is_admin == 1) {
                    comment = comment + "&nbsp;<a name='deleteComment' href='article-deleteC?id=" + comments[i].comment_id + "&a_id=" + comments[i].comment_article.article_id + "' class='text-danger'>" + i18N.delete + "</a> <a id ='" + comments[i].comment_id + "' name='updateComment' class='text-danger'>" + i18N.update + "</a></h5>"
                } else {
                    comment = comment + "</h5>"
                }
                comment = comment + "<p>" + comments[i].comment_content + "</p>" +
                    '</div></div>'
                $("#endLine").before(comment)
            }
        }

    })

    $(document).on("click", "a[name='removeTag']", function () {
        if (!confirm("确认删除此标签？")) return false
        var url = this.href
        $.ajax({
            url: url,
            type: "POST",
            success: function (data) {
                var state = data.state
                if (state == 0) {
                    loadTags()
                } else {
                    alert(i18N.network_error)
                }
            }
        })
        return false
    })

    $("#submitTags").click(function () {
        if ($("#tagsTextarea").val().trim().length == 0) {
            alert("无标签输入")
            return false
        }
        $.ajax({
            type: "post",
            url: "tag!add?id=${article.article_id}",
            data: $("#manageTagsForm").serialize(),
            dataType: "json",
            success: function (data) {
                var state = data.state
                if (state == 0) {
                    $.ajax({
                        url: "tag!article?id=${article.article_id}",
                        type: "POST",
                        success: function (data) {
                            $("#tagsTextarea").val("")
                            loadTags()
                        }
                    })
                } else {
                    alert(i18N.network_error)
                }
            }
        })
        return false
    })

    $("#manageTags").click(function () {
        loadTags()
    })

    function loadTags() {
        $.ajax({
            url: "tag!article?id=${article.article_id}",
            type: "POST",
            success: function (data) {
                var state = data.state
                var tags, id, name, tagsHtml = "", removeTagsHtml = ""
                if (state == 0) {
                    tags = data.tags
                    for (var i = 0; i < tags.length; i++) {
                        id = tags[i].id
                        t_id = tags[i].t_id
                        name = tags[i].name
                        removeTagsHtml += "<a name=\"removeTag\" href=\"tag!remove?id=" + id + "\">#" + name + "</a>&nbsp;"
                        tagsHtml += "<a href=\"t?id=" + t_id + "\">#" + name + "</a>&nbsp;"
                    }
                } else {
                    tagsHtml = "暂无标签"
                    removeTagsHtml = "暂无标签"
                }
                $("#tags").html(tagsHtml)
                $("#tagsList").html(removeTagsHtml)
            }
        })
    }

    function prveNext() {
        var u_id, url
        var args = location.href.split("?")
        if (args[0] != location.href) {
            var pars = args[1].split("&")
            for (var i = 0; i < pars.length; i++) {
                var par = pars[i].split("=")
                if (par[0] == "u_id") u_id = par[1]
            }
        }

        if (u_id != null) url = "article-prevNext?id=${article.article_id}&u_id=" + u_id
        else url = "article-prevNext?id=${article.article_id}"

        $.ajax({
                url: url,
                type: "POST",
                success: function (data) {
                    var prev = data.prev
                    var nav = ""
                    if (prev != null) {
                        if (u_id != null) url = "a?id=" + prev.id + "&u_id=" + u_id
                        else url = "a?id=" + prev.id
                        nav += "<li class=\"previous\"><a href=\"" + url + "\" title=\"" + prev.title + "\">上一篇</a></li>"
                    }
                    var next = data.next
                    if (next != null) {
                        if (u_id != null) url = "a?id=" + next.id + "&u_id=" + u_id
                        else url = "a?id=" + next.id
                        nav += "<li class=\"next\"><a href=\"" + url + "\" title=\"" + next.title + "\">下一篇</a></li>"
                    }
                    $("#pager-nav").html(nav)
                }
            }
        )
    }

</script>
</body>
</html>