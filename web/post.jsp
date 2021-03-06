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
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="description" content="<fmt:message key="website.name"/>">
    <meta name="author" content="<fmt:message key="bloger"/>">
    <link rel="icon" href="img/favicon.png">

    <c:choose>
        <c:when test="${saveOrUpdate eq 'update'}">
            <title>修改文章 - <fmt:message key="website.name"/></title>
        </c:when>
        <c:otherwise>
            <title>发表文章 - <fmt:message key="website.name"/></title>
        </c:otherwise>
    </c:choose>

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
    <script type="text/javascript" src="js/wangEditor.min.js"></script>
</head>
<c:choose>
<c:when test="${sessionScope.user eq null}">
<body></c:when>
<c:otherwise>
<body>
</c:otherwise>
</c:choose>
<s:include value="head.jsp"></s:include>
<div class="container">

    <c:choose>
        <c:when test="${sessionScope.user eq null}">
            <div class="alert alert-danger margin-top-20" role="alert">
                请先登录！
            </div>
        </c:when>
        <c:when test="${sessionScope.user.user_id ne article.article_author.user_id && article ne null && sessionScope.user.user_is_admin ne 1}">
            <div class="alert alert-danger margin-top-20" role="alert">
                你无权修改其他人的文章！
            </div>
        </c:when>
        <c:otherwise>

            <div class="blog-main margin-bottom-10 margin-top-20">
                <div id="editor"></div>
            </div>

            <div class="blog-main">
                <form id="upload" name="upload" method="post" action="/UploadServlet" enctype="multipart/form-data">
                    <div class="form-group">
                        <input id="aFile" name="file" type="file">
                        <p class="help-block">注意：图片最大不能超过10M</p>
                    </div>
                    <button id="aFileSubmit" name="submit" class="btn btn-default" type="button">上传</button>
                </form>
            </div>

            <form id="postForm" class="margin-bottom-10 margin-top-20" action="">

                <!-- /.blog-main -->
                <div class="blog-sidebar">
                    <div class="sidebar-module">

                        <div class="form-group">
                            <c:choose>
                                <c:when test="${article.article_title ne '#weibo#'}">
                                    <label>文章标题</label>
                                    <input type="text" name="article.article_title" id="article_title"
                                           class="form-control"
                                           value="${article.article_title}"/>
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="article.article_title" id="article_title"
                                           class="form-control"
                                           value="${article.article_title}"/>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <c:choose>
                            <c:when test="${saveOrUpdate == 'update'}">
                                <c:choose>
                                    <c:when test="${sessionScope.user.user_is_admin eq 1}">
                                        <div class="form-group">
                                            <label>用户ID</label>
                                            <input type="text" name="article.article_author.user_id"
                                                   value="${article.article_author.user_id}" class="form-control"/>
                                        </div>
                                        <div class="form-group">
                                            <label>评论数</label>
                                            <input type="text" name="article.article_comment"
                                                   value="${article.article_comment}" class="form-control"/>
                                        </div>
                                        <div class="form-group">
                                            <label>阅读数</label>
                                            <input type="text" name="article.article_views"
                                                   value="${article.article_views}" class="form-control"/>
                                        </div>
                                        <div class="form-group">
                                            <label>文章ID</label>
                                            <input type="text" name="article.article_id" value="${article.article_id}"
                                                   class="form-control" readonly/>
                                        </div>
                                        <div class="form-group">
                                            <label>发布时间</label>
                                            <input type="text" name="article.article_time"
                                                   value="${article.article_time}" class="form-control" readonly/>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="hidden" name="article.article_id" value="${article.article_id}"/>
                                        <input type="hidden" name="article.article_time"
                                               value="${article.article_time}"/>
                                        <input type="hidden" name="article.article_author.user_id"
                                               value="${article.article_author.user_id}"/>
                                        <input type="hidden" name="article.article_views"
                                               value="${article.article_views}"/>
                                        <input type="hidden" name="article.article_comment"
                                               value="${article.article_comment}"/>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                        </c:choose>
                    </div>

                    <input type="hidden" name="article.article_content" id="article_content"
                           value='${article.article_content}'/>
                    <div class="btn-group margin-bottom-10 btn-full-weight" role="group" aria-label="...">
                        <button id="commentButton" type="submit" class="btn btn-primary btn-full-weight">
                            发表文章
                        </button>
                    </div>
                </div>
                <!-- /.blog-sidebar -->
            </form>
        </c:otherwise>
    </c:choose>
</div><!-- /.container -->
<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {

        //实例化编辑器
        var E = window.wangEditor
        var editor = new E('#editor')
        editor.customConfig.menus = [
            'head',  // 标题
            'bold',  // 粗体
            'italic',  // 斜体
            'link',  // 插入链接
            'list',  // 列表
            'justify',  // 对齐方式
            'image',  // 插入图片
            'code',  // 插入代码
            'video', // 视频
            'undo',  // 撤销
            'redo'  // 重复
        ]

        editor.customConfig.zIndex = 1
        editor.create()

        editor.txt.html($("#article_content").val())

        var commentState = null
        $("#commentButton").click(function () {
            var html = editor.txt.html()
            $("#article_content").val(html)
            var url = "article-post"
            if ($("#article_content").val() == null || $("#article_content").val().trim().length == 0 || $("#article_content").val() == "") {
                alert("请输入文章内容！")
                $("#article_content").val("")
                return false
            } else if ($("#article_title").val() == null || $("#article_title").val().trim().length == 0 || $("#article_title").val() == "") {
                alert("请输入标题！")
                $("#article_title").val("")
                return false
            } else if ($("#article_title").val().trim().length > 30) {
                alert("标题最长30个字符！")
                $("#article_title").val($("#article_title").val().trim().substring(0, 30))
                return false
            } else {
                if (commentState != null) return false
                commentState = "pending"
                $.ajax({
                    type: "post",
                    url: url,
                    data: $("#postForm").serialize(),
                    dataType: "json",
                    success: function (data) {
                        // 接收json数据
                        var saveOrUpdate = data.saveOrUpdate
                        var status = data.status
                        if (status == 0) {
                            if (saveOrUpdate == 'save') {
                                setCookie("msg", data.msg, 1)
                                window.location.href = "index"
                            } else if (saveOrUpdate == 'update') {
                                window.location.href = "article-one?id=${article.article_id}"
                            }
                        } else if (status == 1) {
                            if (saveOrUpdate == 'save') {
                                alert("服务器异常！发表博文失败！")
                            } else if (saveOrUpdate == 'update') {
                                alert("服务器异常！修改博文失败！")
                            }
                        }
                        commentState = null
                    }, error: function (e) {
                        alert("服务器出错！")
                    }
                })
                return false
            }
        })

        document.getElementById("aFileSubmit").onclick = function () {
            $("#aFileSubmit").hide()
            var xhr = new XMLHttpRequest();
            var formData = new FormData();
            var fileInput = document.getElementById("aFile");
            var file = fileInput.files[0];
            if (file != null) {
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
                        var img = "<img src=\"" + url + "\">"
                        editor.txt.append(img)
                        fileInput.value = ""
                        $("#aFileSubmit").show()
                    }
                }
                xhr.send(formData)
                xhr = null
            } else {
                alert("未找到文件")
            }
        }

    })

</script>
</body>
</html>