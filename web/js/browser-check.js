$(document).ready(function () {
    Messenger.options = {
        extraClasses: 'messenger-fixed messenger-on-bottom',
        theme: 'flat'
    }
    checkBrowser()
})

function checkBrowser() {
    var Sys = {}
    var ua = navigator.userAgent.toLowerCase()
    var s
    (s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
        (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
            (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
                (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
                    (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0
    /*以下进行测试*/
    // if (Sys.chrome) {
    //     var version = Sys.chrome.substring(0, 2)
    //     if (version < 60) {
    //         checkBrowserText("Chrome", Sys.chrome)
    //     }
    // }
    if (Sys.ie) checkBrowserText("Ie", Sys.ie)
    if (Sys.opera) checkBrowserText("Opera", Sys.opera)
    // if (Sys.safari) checkBrowserText("Safari", Sys.safari)
}

function checkBrowserText(text, sys) {
    var closeButton = '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
    $("#browser-check-alert").html(closeButton + i18N.browser_check_1 + ' <strong>' + text + ' ' + sys + '</strong> ' + i18N.browser_check_2 + '<br>');
    $("#browser-check-alert").removeClass("hide")
}