
var gifState = null

$(document).keydown(function () {
    if (gifState == null) {
        // 用户按下回车键
        if (event.keyCode == "13") {
            $("#gifButton").click()
        }
    }
})

$("#gifButton").click(function () {
    if (gifState != null) {
        return false
    }
    gifState = "pending"
    document.body.scrollTop = document.documentElement.scrollTop = 0
    $("#gifTitle").html("<h4>" + i18N.lottery + "</h4>")
    $("#gifResult").html("<div class=\"spinner\" id=\"loadding\">" +
        "<div class=\"bounce1\">" +
        "</div><div class=\"bounce2\">" +
        "</div><div class=\"bounce3\"></div>")
    $("#gifButton").attr("disabled", true)
    gifState = setTimeout(function () {
        $.ajax({
            type: "post",
            url: "user-gif",
            dataType: "json",
            success: function (data) {
                var status = data.status
                var num1 = data.num1
                var num2 = data.num2
                var result = ""
                if (status == 0) {
                    $("#gifTitle").html("<h4>" + i18N.gif_result + ":</h4>")
                    var info = data.info
                    if (info != null) {
                        result += "<p><h5>" + info + "</h5></p>"
                    } else {
                        var code = data.code
                        var name = code.name
                        var createtime = code.create_time.time
                        var stoptime = code.stop_time.time
                        var effect = code.effect
                        var codes = code.code
                        result += showCode(name, effect, createtime, stoptime, codes)
                    }
                    result += "<h6 style='text-align: right'>" + i18N.gif_number + ":" + num1 + "</h6>"
                    result += "<h6 style='text-align: right'>" + i18N.gif_user_number + ":" + num2 + "</h6>"
                } else if (status == 1) {
                    result += "<p><h5>" + i18N.no_enough_integral + "</h5></p>"
                } else if (status == 2) {
                    result += "<p><h5>" + i18N.no_login + "</h5></p>"
                }
                $("#gifResult").html(result)
                $("#gifButton").attr("disabled", false)
            }, error: function (e) {
                alert(i18N.server_error)
            }
        });
        gifState = null
    }, 10)
})