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

    <title>消息中心 - <fmt:message key="website.name"/></title>

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
            <li class="active">消息中心</li>
        </ol>

        <h3>
            消息中心 Beta v0.1
        </h3>
        <c:choose>
            <c:when test="${sessionScope.user eq null}">
                <div class="alert alert-danger margin-top-20" role="alert">
                    未登录！
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <div class="col-sm-12 col-md-6">
                        <div class="panel panel-default">
                            <div id="user_name" class="panel-heading">加载中</div>
                            <div id="chatroom" class="panel-body chat-div">
                            </div>
                        </div>
                        <form id="msg-form" method="post" hidden>
                            <div class="form-group">
                                <textarea id="msg-content" name="message.content" class="form-control"
                                          rows="2"></textarea>
                            </div>
                            <button id="send-msg-btn" type="button" class="btn btn-primary btn-full-weight">发送</button>
                        </form>
                    </div>
                    <div class="col-sm-12 col-md-6">
                        <div class="input-group form-group margin-top-20">
                            <c:choose>
                                <c:when test="${param.id ne null}">
                                    <input id="user_id" type="text" class="form-control" placeholder="输入对方的ID"
                                           value="${param.id}">
                                </c:when>
                                <c:otherwise>
                                    <input id="user_id" type="text" class="form-control" placeholder="输入对方的ID"
                                           value="${sessionScope.user.user_id}">
                                </c:otherwise>
                            </c:choose>
                            <span class="input-group-btn">
                        <button id="goChat" class="btn btn-default" type="button">开始</button>
                    </span>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<s:include value="foot.jsp"></s:include>
<script type="text/javascript">

    var id = $("#user_id").val()
    $("#user_id").val("")

    $(document).ready(function () {
        $("#toolsTab").addClass("active")
        scrollTop()
        getMsg()
        if (unreadSession != null) clearTimeout(unreadSession)
        newMsgSession = window.setInterval(newMsg, 1000);
    })

    $("#goChat").click(function () {
        id = $("#user_id").val()
        chatWith(id)
    })

    function chatWith(user_id) {
        id = user_id
        getMsg()
    }

    function getMsg() {
        $.ajax({
            type: "post",
            url: "user-chat?id=" + id,
            dataType: "json",
            success: function (data) {
                var status = data.status
                if (status == 0) {
                    var user_id = data.user_id
                    var my_id = data.my_id
                    var user_name
                    if (user_id == my_id) {
                        user_name = "系统消息"
                        $("#msg-form").hide()
                    } else {
                        user_name = data.user_name
                        $("#msg-form").show()
                    }
                    $("#chatroom").html("")
                    var messages = data.message

                    $("#user_name").html(user_name)
                    var result = ""
                    if (messages.length == 0) {
                        result += "<p><h5 class='text-center'>" + i18N.no_msg_right_now + "</h5></p>"
                        $("#chatroom").append(result)
                    }
                    for (var i = 0; i < messages.length; i++) {
                        var id = messages[i].id
                        var content = messages[i].content
                        var sendUserName = messages[i].sendUser.user_name
                        var sendUserId = messages[i].sendUser.user_id
                        var sendTime = messages[i].sendTime.time
                        var isRead = messages[i].isRead
                        var time = Format(getDate(sendTime.toString()), "yyyy-MM-dd HH:mm:ss");
                        if (sendUserId == user_id) {
                            if (isRead == 0) read(id)
                            showMsg(content, time)
                        } else if (sendUserId == my_id) {
                            sendSuccess(content, time)
                        }
                    }
                } else {
                    alert(i18N.network_error)
                }
                scrollTop()
            }
        })
    }

    $(document).keydown(function (e) {
        var e = e || event;
        // 用户按下回车键
        if (e.keyCode == "13") {
            $("#send-msg-btn").click()
            return false
        }
    })

    $("#send-msg-btn").click(function () {
        var msgContent = $("#msg-content").val()
        if (msgContent == null || msgContent.length == 0) {
            alert(i18N.no_content)
            return false
        }
        var date = new Date()
        var time = Format(date, "刚刚");
        sendMsg(msgContent, time, id)
        $("#msg-content").val("")
        scrollTop()
    })

    function sendMsg(content, date, id) {
        $.ajax({
            type: "post",
            url: "user-send?id=" + id,
            data: $('#msg-form').serialize(),
            success: function (data) {
                var status = data.status
                if (status == 0) {
                    sendSuccess(content, date)
                } else if (status == 1) {
                    alert("系统消息无法回复。")
                } else {
                    var html = "<p class='text-center text-danger'>发送失败</p>"
                    $("#chatroom").append(html)
                    alert(i18N.network_error)
                }
                scrollTop()
            }
        })
    }

    function sendSuccess(content, date) {
        var html = "<p class='chat-send'>" +
            "<span class='chat-span'>" + date + "</span>" +
            "<br>" +
            content +
            "</p>"
        $("#chatroom").append(html)
    }

    function showMsg(content, date) {
        var html = "<p class='chat-p'>" +
            "<span class='chat-span'>" + date + "</span>" +
            "<br>" +
            content +
            "</p>"
        $("#chatroom").append(html)
    }

    function scrollTop() {
        $('#chatroom').scrollTop($('#chatroom')[0].scrollHeight);
    }

    function newMsg() {
        if (!isLogin)
            return
        $.ajax({
            type: "post",
            url: "user-unreadCount",
            dataType: "json",
            success: function (data) {
                var status = data.status
                if (status == 1) {
                    isLogin = false
                } else if (status == 2) {
                    alert(i18N.server_error)
                } else if (status == 0) {
                    var count = data.count
                    if (count > 0) {
                        $("#unread-count").html(count)
                        $("#msg-count").html(count)
                        getMsg()
                    } else if (count == 0) {
                        $("#unread-count").html("")
                        $("#msg-count").html("")
                    }
                }
            }
        })
        return false
    }

    function read(id) {
        $.ajax({
            type: "post",
            url: "user-know?id=" + id,
            dataType: "json",
            success: function (data) {
                var status = data.status
                if (status == 1) alert(i18N.server_error)
                if (status == 0) newMsg()
            }
        })
    }

</script>
</body>
</html>