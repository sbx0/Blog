$(document).on("click", ".use-code-a", function () {
    if (this.text == i18N.used) return false
    this.text = i18N.used
    $.ajax({
        url: this.href,
        type: "post",
        dataType: "json",
        success: function (data) {
            var status = data.status
            if (status == 0) {
                alert(i18N.active_success)
            }
            if (status == 1) {
                alert(i18N.no_login)
            }
            if (status == 2) {
                alert(i18N.non_existent)
            }
            if (status == 3) {
                alert(i18N.overdue)
            }
        },
        error: function () {
            alert(i18N.server_error)
        }
    })
    return false
})

var showCodesState = null
$("#showCodes").click(function () {
    if (showCodesState != null) {
        return false
    }
    showCodesState == "pending"
    $('#menuModal').modal('toggle')
    $('#codesModal').modal('toggle')
    $('#modelTitle').html(i18N.package)
    $("#codes").html("")
    $.ajax({
        type: "post",
        url: "user-codes",
        dataType: "json",
        success: function (data) {
            $("#codes").html("")
            var codes = data.codes
            var result = "";
            if (codes.length == 0) {
                result += "<p><h5 class='gif-input-center'>" + i18N.nothing + "</h5></p>"
                $("#codes").append(result)
            }
            for (var i = 0; i < codes.length; i++) {
                result = ""
                var name = codes[i].name
                var effect = codes[i].effect
                var createtime = codes[i].create_time.time
                var stoptime = codes[i].stop_time.time
                var code = codes[i].code
                result += showCode(name, effect, createtime, stoptime, code)
                $("#codes").append(result)
            }
        }, error: function (e) {
            alert(i18N.server_error)
        }
    })
    showCodesState = null
    return false
})

function showCode(name, effect, create_time, stop_time, code) {
    var result = "<div class='code-bg-color alert fade in' role='alert'>"
    result += "<p><h4>" + name + "</h4></p>"
    result += "<p><h5>" + i18N.effect + "：" + effect + "</h5></p>"
    result += "<p><h5>" + i18N.term_of_validity + "：" +
        Format(getDate(create_time.toString()), "yyyy-MM-dd") +
        " " + i18N.to + " " + Format(getDate(stop_time.toString()), "yyyy-MM-dd") +
        '</h5></p>'
    result += '<div class="form-group gif-button">' +
        '<input type="text" class="form-control gif-input-center" name="code" value="' +
        code + '"></div>'
    result += '<div class="form-group gif-button">' +
        '<a class="btn btn-default use-code-a"' +
        'href="user-active?code=' + code + '">' + i18N.use + '</a></div></div>'
    return result
}

