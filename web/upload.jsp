<%--
  Created by IntelliJ IDEA.
  User: 星灵
  Date: 2018/6/22
  Time: 15:15
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
    <meta name="description" content="BUG详情">
    <meta name="author" content="以下是胡扯">
    <link rel="icon" href="img/favicon.png">

    <title>上传测试</title>

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

<form id="upload" name="upload" method="post" action="/UploadServlet" enctype="multipart/form-data">
    <input id="file" name="file" type="file">
    <button id="submit" name="submit" type="button">上传</button>
</form>
</body>
</html>
<!-- /.container -->
<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    document.getElementById("submit").onclick = function () {
        var xhr = new XMLHttpRequest();
        var formData = new FormData();
        var fileInput = document.getElementById("file");
        var file = fileInput.files[0];
        formData.append('myFile', file);
        xhr.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                var json = JSON.parse(this.responseText)
                alert("状态：" + json.state)
                alert("文件名：" + json.filename)
                alert("原始名：" + json.originalname)
                alert("标题：" + json.title)
                alert("种类：" + json.type)
                alert("链接：" + json.url)
                alert("大小：" + json.size)
            }
        }
        xhr.open("POST", "http://upload.ducsr.cn/UploadServlet");
        xhr.onload = function () {
            if (this.status === 200) {
                //对请求成功的处理
                alert("上传成功")
            }
        }
        xhr.send(formData)
        xhr = null
    }
</script>