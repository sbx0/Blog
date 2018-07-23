// ============================= 基础js =============================

// ============================= 防止浏览器缓存 =============================
function noCache(url) {
    //  var getTimestamp = Math.random()
    var args = url.split("?")
    var newUrl = args[0]
    if (args[0] == url) {
        var getTimestamp = new Date().getTime()
        newUrl = url + "?noCache=" + getTimestamp
    } else {
        newUrl += "?"
        var pars = args[1].split("&")
        var isNoCache = false
        for (var i = 0; i < pars.length; i++) {
            var par = pars[i].split("=")
            if (par[0] == "noCache") {
                par[1] = new Date().getTime()
                isNoCache = true
            }
            newUrl += par[0] + "=" + par[1]
            if (i < pars.length - 1) newUrl += "&"
        }
        if (!isNoCache) {
            var getTimestamp = new Date().getTime()
            newUrl += "&noCache=" + getTimestamp
        }
    }
    return newUrl;
}

// ============================= 加载登陆数据 =============================
getData()

function getData() {
    $.ajax({
        type: "post",
        url: "data-index",
        dataType: "json",
        success: function (data) {
            var userCount = data.userCount
            if (userCount == 0) $("#loginCount").html("无数据")
            var maxLogin = data.maxLogin
            if (maxLogin == null) $("#maxLoginDate").html("无数据")
            var date = Format(getDate(maxLogin.update_time.time.toString()), "yyyy-MM-dd HH:mm")
            $("#loginCount").html(userCount)
            $("#maxLoginDate").html("最高在线数: <strong class='text-danger'>" + maxLogin.data + "</strong>")
        }
    })
}

// ============================= img 添加 class = "img-responsive" =============================
$("img").addClass("img-responsive")

// ============================= 改写alert =============================

function alert(msg, type) {
    Messenger().post({
        message: msg,
        type: type,
        hideAfter: 3,
        showCloseButton: true
    })
}

// ============================= 跳转https =============================
// $(document).ready(function () {
//     var href = window.location.href
//
//     var localHref = href.substring(0, 16)
//     if (localHref == "http://192.168.1") return false
//     if (localHref == "http://127.0.0.1") return false
//     if (localHref == "http://localhost:8080") return false
//     if (localHref == "http://10.254.13") return false
//
//     var httpHref = href.substring(0, 5)
//     var httpsHref = href.substring(5)
//     if (httpHref == "https") return false
//     else httpsHref = "https:" + httpsHref
//
//     window.location.href = httpsHref
// })

// ============================= 登陆 =============================

// 点击登陆按钮
$("#showLoginModal").click(function () {
    // 打开登陆模态框
    $('#loginModal').modal('toggle')
})

// // 回车键登陆
// var loadState = null
// $(document).keydown(function () {
//     if (loadState == null) {
//         // 用户按下回车键
//         if (event.keyCode == "13") {
//             $("#loginButton").click()
//         }
//     }
// })

// 登陆邮件输入验证
function isEmailOk() {
    if (isEmail($("#inputEmail").val()) == false) {
        alert("请输入有效的邮箱！")
        $("#inputEmail").val("")
        $("#inputEmail").focus()
        return false
    } else if ($("#inputEmail").val() == null || $("#inputEmail").val().trim().length == 0 || $("#inputEmail").val() == "") {
        alert("请输入邮箱！")
        $("#inputEmail").val("")
        $("#inputEmail").focus()
        return false
    }
}

// 登陆密码输入验证
function isPasswordOk() {
    if ($("#inputPassword").val() == null || $("#inputPassword").val().trim().length == 0 || $("#inputPassword").val() == "") {
        alert("请输入密码！")
        $("#inputPassword").focus()
        return false
    }
}

// 登陆按钮点击
var loginState = null
$("#loginButton").click(function () {
    if (isEmailOk() == false) {
        return false
    } else if (isPasswordOk() == false) {
        return false
    }
    if (loginState != null) return false
    loginState = "pending"
    var url = "user-login"
    $.ajax({
        type: "post",
        url: url,
        data: $("#loginForm").serialize(),
        dataType: "json",
        success: function (data) {
            if (data.status == 0) {
                alert("用户名或密码错误！")
                $("#inputEmail").val("")
                $("#inputPassword").val("")
                $("#inputEmail").focus()
            } else if (data.status == 1) {
                location.replace(noCache(location.href))
            }
            loginState = null
        }
    })
    return false
})

// ============================= 注册 =============================
// 打开登陆模态框
$("#showRegisterModel").click(function () {
    $('#loginModal').modal('toggle')
    $('#registerModal').modal('toggle')
})

// 注册回车事件
// var keyDownState = null
// $(document).keydown(function () {
//     if (keyDownState == null) {
//         keyDownState = "pending"
//         // 用户按下回车键
//         if (event.keyCode == "13") {
//             $("#registerButton").click()
//         }
//         keyDownState = null
//     }
// })


// 用户名输入验证
function registerIsNameOk() {
    if ($("#registerName").val() == null || $("#registerName").val().trim().length == 0 || $("#registerName").val().trim().length > 13 || $("#registerName").val() == "") {
        alert("请输入有效的用户名！")
        $("#registerName").val("")
        $("#registerName").focus()
        return false
    }
}

// 邮件输入验证
function registerIsEmailOk() {
    if ($("#registerEmail").val() == null || $("#registerEmail").val().trim().length == 0 || $("#registerEmail").val() == "") {
        alert("请输入有效的邮箱地址！")
        $("#registerEmail").val("")
        $("#registerEmail").focus()
        return false
    } else if (isEmail($("#registerEmail").val()) == false) {
        alert("请输入有效的邮箱！")
        $("#registerEmail").val("")
        $("#registerEmail").focus()
        return false
    }
}

// 密码输入验证
function registerIsPasswordOk() {
    if ($("#registerPassword").val() == null || $("#registerPassword").val().trim().length == 0 || $("#registerPassword").val() == "") {
        alert("请输入密码！")
        $("#registerPassword").focus()
        return false
    }
}

// 注册
$("#registerButton").click(function () {
        if (registerIsNameOk() == false) {
            return false
        } else if (checkEmail($("#inputEmail").val(), "login") == false) {
            return false
        } else if (registerIsEmailOk() == false) {
            return false
        } else if (registerIsPasswordOk() == false) {
            return false
        }
        $.ajax({
            type: "post",
            url: "user-register",
            data: $("#registerForm").serialize(),
            dataType: "json",
            success: function (data) {
                if (data.status == 0) {
                    $('#registerModal').modal('toggle')
                    $('#loginModal').modal('toggle')
                    alert("注册成功！赶快登陆吧！")
                } else {
                    alert("注册失败！错误代码：" + data.status)
                }
            }, error: function (e) {
                alert("服务器出错！")
            }
        })
        return false
    }
);

// ============================= 注销 =============================
var logoutState = null
$("#logout").click(function () {
    if (loginState != null) return false
    loginState = "pending"
    $.ajax({
        type: "post",
        url: "user-logout",
        dataType: "json",
        success: function (data) {
            if (data.status == 1) {
                alert(i18N.server_error)
                location.replace(noCache(location.href))
            } else if (data.status == 0) {
                location.replace(noCache(location.href))
            }
            loginState = null
        }
    })
})

// ============================= 公用方法 =============================

// 1.用户名查重
function checkName(val) {
    var name = val.trim()
    var url = "user-checkName"
    $.ajax({
        type: "post",
        url: url,
        data: {"check": name},
        dataType: "json",
        success: function (data) {
            if (data.status == 1) {
                alert(name + "，此用户名已注册。")
                return false
            }
        }
    })
}

// 2.邮箱验证
function checkEmail(val, type) {
    var email = val.trim()
    var url = "user-checkEmail";
    $.ajax({
        type: "post",
        url: url,
        data: {"check": email},
        dataType: "json",
        success: function (data) {
            if (type == "login") {
                if (data.status == 0) {
                    alert(email + "，此邮箱尚未注册。")
                    return false
                }
            } else if (type == "register") {
                if (data.status == 1) {
                    alert(email + "，此邮箱已注册。")
                    return false
                }
            }
        }
    })
}

// 3.邮件格式验证
function isEmail(str) {
    var reg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/
    return reg.test(str)
}