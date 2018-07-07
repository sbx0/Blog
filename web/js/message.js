var isLogin = true

$(document).ready(function () {
    unreadCount()
    unreadSession = window.setInterval(unreadCount, 10000);
})

function showMessage(id, sendUserName, sendUserId, content, sendTime) {
    var result = ""
    result += "<p class='message'>" +
        Format(getDate(sendTime.toString()), "yyyy-MM-dd HH:mm") + " " +
        "<a href='article-user?id=" + sendUserId + "'>" +
        sendUserName + "</a>" + "：" + content + "</p>" +
        " <p class='message' style='text-align: right'>" +
        // "<a href='user-know?id=" + id + "' name='i-know'>" + i18N.know + "</a>" +
        "<a href='msg.jsp?id=" + sendUserId + "'>查看</a>" +
        "</p><hr class='message-hr'>"
    return result
}

$(document).on("click", "a[name='i-know']", function () {
    var url = this.href
    if (this.text == i18N.looked) {
        return false
    }
    this.text = i18N.looked
    $.ajax({
        type: "post",
        url: url,
        dataType: "json",
        success: function (data) {
            var status = data.status
            if (status == 1) alert(i18N.server_error)
            if (status == 0) unreadCount()
        }
    })
    return false
})

function unreadCount() {
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
                } else if (count == 0) {
                    $("#unread-count").html("")
                    $("#msg-count").html("")
                }
            }
        }
    })
    return false
}

var messageState = null
$("#message").click(function () {
    if (messageState != null) {
        return false
    }
    messageState == "pending"
    $('#menuModal').modal('toggle')
    $('#codesModal').modal('toggle')
    $('#modelTitle').html(i18N.msg)
    $("#codes").html("")
    $.ajax({
        type: "post",
        url: "user-message",
        dataType: "json",
        success: function (data) {
            $("#codes").html("")
            var messages = data.message
            var result = ""
            if (messages.length == 0) {
                result += "<p><h5 class='gif-input-center'>" + i18N.no_msg_right_now + "</h5></p>"
                $("#codes").append(result)
            }
            for (var i = 0; i < messages.length; i++) {
                var id = messages[i].id
                var content = messages[i].content
                var sendUserName = messages[i].sendUser.user_name
                var sendUserId = messages[i].sendUser.user_id
                var sendTime = messages[i].sendTime.time
                result += showMessage(id, sendUserName, sendUserId, content, sendTime)
                $("#codes").append(result)
                result = ""
            }
        }
    })
    messageState = null
    return false
})