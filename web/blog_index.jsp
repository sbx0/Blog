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

    <title><fmt:message key="blog.index"/> - <fmt:message key="website.name"/></title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
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

<div class="container">

    <div class="row">

        <c:choose>
            <c:when test="${sessionScope.user ne null}">
                <div class="col-sm-12 margin-top-20 margin-bottom-10 gif-input-center">
                    <form id="weiboPostForm" class="form-inline">
                        <div class="form-group">
                            <textarea id="postTextarea" name="article.article_content" class="form-control"
                                      placeholder="你不想说点什么吗？" cols="80"></textarea>
                        </div>
                        <div id="photo" class="margin-bottom-10">
                        </div>
                        <div class="btn-group" role="group">
                            <button id="cleanBtn" type="button" class="btn btn-default btn-danger">清空</button>
                            <button id="imgBtn" type="button" class="btn btn-default btn-default">图片</button>
                            <button id="postBtn" type="button" class="btn btn-default btn-default">发布</button>
                        </div>
                    </form>
                </div>
            </c:when>
        </c:choose>


        <div id="container" class="col-sm-9 blog-main margin-top-20">
            <c:choose>
                <c:when test="${empty pageBean.list}">
                    <div>
                        <h3>┗|｀O′|┛ 嗷~~怎么什么都没有~~</h3>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${pageBean.list}" var="article" varStatus="articleStatus">
                        <c:choose>
                            <c:when test="${article.article_title eq '#weibo#'}">
                                <div class="blog-post">
                                    <p class="blog-post-meta">
                                        <a href="article-user?id=${article.article_author.user_id}">
                                                ${article.article_author.user_name}
                                        </a>
                                        <fmt:formatDate value="${article.article_time}" pattern="yyyy-MM-dd HH:mm"/>
                                    </p>
                                    <p class="imgRestrict">
                                            ${article.article_content}
                                    </p>
                                    <a class="readMoreA" href="article-one?id=${article.article_id}">
                                        <fmt:message key="read.more"/>
                                        (${article.article_comment}/${article.article_views})
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="blog-post">
                                    <h2 class="blog-post-title">${article.article_title}</h2>
                                    <p class="blog-post-meta">
                                        <a href="article-user?id=${article.article_author.user_id}">
                                                ${article.article_author.user_name}
                                        </a>
                                        <fmt:formatDate value="${article.article_time}" pattern="yyyy-MM-dd HH:mm"/>
                                    </p>
                                    <p>
                                            ${article.article_content}
                                    </p>
                                    <a class="readMoreA" href="article-one?id=${article.article_id}">
                                        <fmt:message key="read.more"/>
                                        (${article.article_comment}/${article.article_views})
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <nav>
                <ul class="pager">
                    <c:choose>
                        <c:when test="${pageBean.totalPage eq 1 or pageBean.totalPage eq 0}">
                            <li class="previous disabled">
                                <a>
                                    <fmt:message key="prev.page"/>
                                </a>
                            </li>
                            <li>
                                <span>
                                        ${pageBean.currentPage}/${pageBean.totalPage}
                                </span>
                            </li>
                            <li class="next disabled">
                                <a>
                                    <fmt:message key="next.page"/>
                                </a>
                            </li>
                        </c:when>
                        <c:when test="${pageBean.currentPage eq 1}">
                            <li class="previous disabled">
                                <a>
                                    <fmt:message key="prev.page"/>
                                </a>
                            </li>
                            <li>
                                <span>
                                        ${pageBean.currentPage}/${pageBean.totalPage}
                                </span>
                            </li>
                            <li class="next">
                                <a href="article-list?pageNo=${pageBean.currentPage+1}">
                                    <fmt:message key="next.page"/>
                                </a>
                            </li>
                        </c:when>
                        <c:when test="${pageBean.currentPage eq pageBean.totalPage}">
                            <li class="previous">
                                <a href="article-list?pageNo=${pageBean.currentPage-1}">
                                    <fmt:message key="prev.page"/>
                                </a>
                            </li>
                            <li>
                                <span>
                                        ${pageBean.currentPage}/${pageBean.totalPage}
                                </span>
                            </li>
                            <li class="next disabled">
                                <a>
                                    <fmt:message key="next.page"/>
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="previous">
                                <a href="article-list?pageNo=${pageBean.currentPage-1}">
                                    <fmt:message key="prev.page"/></a>
                            </li>
                            <li>
                                <span>
                                        ${pageBean.currentPage}/${pageBean.totalPage}
                                </span>
                            </li>
                            <li class="next">
                                <a href="article-list?pageNo=${pageBean.currentPage+1}">
                                    <fmt:message key="next.page"/>
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </nav>

        </div>

        <div class="col-sm-3 blog-sidebar margin-top-20">
            <div class="sidebar-module sidebar-module-inset">
                <h5><fmt:message key="about"/></h5>
                <p>
                    <fmt:message key="about.text"/>
                </p>
            </div>

            <%--<div class="sidebar-module">--%>
                <%--<h5><fmt:message key="article.month.hotrank"/></h5>--%>
                <%--<ol class="list-unstyled">--%>
                    <%--<c:choose>--%>
                        <%--<c:when test="${hotRankingList eq null || fn:length(hotRankingList) eq 0}">--%>
                            <%--<p class="text-center">暂无博文</p>--%>
                        <%--</c:when>--%>
                        <%--<c:otherwise>--%>
                            <%--<c:forEach items="${hotRankingList}" var="article" varStatus="articleStatus">--%>
                                <%--<li>--%>
                                        <%--${articleStatus.index+1}.--%>
                                    <%--<a href="article-one?id=${article.article_id}">--%>
                                            <%--${article.article_title}--%>
                                    <%--</a>--%>
                                    <%--<fmt:message key="hotrank"/>--%>
                                    <%--:--%>
                                    <%--<fmt:parseNumber integerOnly="true"--%>
                                                     <%--value="${article.article_views/10+article.article_comment*5}"/>--%>
                                <%--</li>--%>
                            <%--</c:forEach>--%>
                        <%--</c:otherwise>--%>
                    <%--</c:choose>--%>
                <%--</ol>--%>
            <%--</div>--%>

            <div class="sidebar-module hidden-xs">
                <h5><fmt:message key="follow.me"/></h5>
                <ol class="list-unstyled">
                    <li><a href="http://weibo.com/ihomemwh" target="_blank">Weibo</a></li>
                    <%--<li><a href="https://github.com/sbx0" target="_blank">GitHub</a></li>--%>
                </ol>
            </div>

            <div class="sidebar-module hidden-xs">
                <h5>广告</h5>
                <a href="https://www.vultr.com/?ref=7466976" target="_blank"><img
                        src="https://www.vultr.com/media/banner_4.png" width="160" height="600"></a>
            </div>

        </div>

    </div>

</div>

<div id="uploadImg" class="modal fade bs-example-modal-md" tabindex="-1" role="dialog" aria-labelledby="uploadImg">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 id="modelTitle" class="modal-title">上传图片</h4>
                <div class="alert alert-warning alert-dismissible fade in browser-check-alert hide"
                     role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                </div>
            </div>
            <div class="modal-body">
                <form id="upload" name="upload" method="post" action="/UploadServlet" enctype="multipart/form-data">
                    <div class="form-group">
                        <input id="file" name="file" type="file">
                        <p class="help-block">注意：图片最大不能超过10M</p>
                    </div>
                    <button id="submit" name="submit" class="btn btn-default" type="button">上传</button>
                </form>
            </div>
        </div>
    </div>
</div>

<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {
        img = ""

        var viewer = new Viewer(document.getElementById('container'))

        $("#indexTab").addClass("active")
        checkMsg()

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
                img = "<img src=\"" + url + "\">"
                $("#photo").html(img)
                fileInput.value = ""
            }
        }
        xhr.send(formData)
        xhr = null
    }

    $("#imgBtn").click(function () {
        $("#uploadImg").modal('toggle')
    })

    $(document).keydown(function (e) {
        var e = e || event;
        // 用户按下回车键
        if (e.keyCode == "13") {
            $("#postBtn").click()
            return false
        }
    })

    $("#cleanBtn").click(function () {
        if (!confirm("确认清空？")) return false
        $("#postTextarea").val("")
        alert("清空完成")
    })

    $("#postBtn").click(function () {
        var text = $("#postTextarea").val()
        if (text == null || text.length == 0) {
            alert("请输入内容后发布")
            return false
        } else if (text.length > 140) {
            alert("微博长度限制为140字符，您已超过")
            return false
        } else {
            $("#postTextarea").val($("#postTextarea").val() + img)
            $.ajax({
                type: "post",
                url: "article-weibo",
                data: $('#weiboPostForm').serialize(),
                dataType: "json",
                success: function (data) {
                    var status = data.status
                    if (status == 0) {
                        alert("发布成功")
                        location.replace(location.href)
                    } else {
                        alert("服务器异常")
                    }
                }
            })
        }
    })

</script>
</body>
</html>