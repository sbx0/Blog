<%--
  Created by IntelliJ IDEA.
  User: winmj
  Date: 2017/7/27
  Time: 14:15
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

<footer class="blog-footer">
    <p>
        <a href="index.jsp">首页</a>
        |
        <a data-toggle="modal" data-target="#submitBug" href="javascript:void(0)">反馈</a>
        |
        <a target="_blank" href="https://github.com/sbx0/Blog">GitHub</a>
    </p>
    <p>
        当前在线数:
        <strong>
                <span id="loginCount" class="text-danger">
                    加载中
                </span>
        </strong>
        &nbsp;
        <span id="maxLoginDate">
                    加载中
        </span>
    </p>
    <p>
        <fmt:message key="copyright"/>
    </p>
</footer>

<div id="submitBug" class="modal fade bs-example-modal-md" tabindex="-1" role="dialog" aria-labelledby="submitBug">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">
                    <a href="bugs.jsp">
                        提交反馈
                    </a>
                </h4>
                <div id="subBugHelp" class="alert alert-warning alert-dismissible fade in browser-check-alert hide"
                     role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="bugSubForm" class="margin-top-20">
                        <div class="form-group">
                            <label for="bugName">缺陷命名</label>
                            <input class="form-control" id="bugName" name="bug.name" placeholder="名称">
                        </div>
                        <div class="form-group">
                            <label for="bugGrade">缺陷评级（<a href="article-one?id=54" target="_Blank">评级标准</a>）</label>
                            <select id="bugGrade" class="form-control" name="bug.grade">
                                <option value="1">建议 - P1</option>
                                <option value="2">低级 - P2</option>
                                <option value="3">一般 - P3</option>
                                <option value="4">严重 - P4</option>
                                <option value="5">致命 - P5</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="bugBewirte">缺陷描述</label>
                            <textarea id="bugBewirte" class="form-control" rows="3" name="bug.bewrite"></textarea>
                        </div>
                        <div class="form-group">
                            <button id="bugBewirteQuick" type="button" class="btn btn-default">
                                快速填写
                            </button>
                            <button id="bugBewirteClean" type="button" class="btn btn-danger">
                                清空
                            </button>
                        </div>
                        <div class="form-group">
                            <div id="photo" class="margin-bottom-10 imgRestrict"></div>
                        </div>
                        <div class="form-group">
                            <form id="upload" name="upload" method="post" action="/UploadServlet"
                                  enctype="multipart/form-data">
                                <div class="form-group">
                                    <input id="file" name="file" type="file">
                                    <p class="help-block">注意：图片最大不能超过10M</p>
                                </div>
                                <button id="submit" name="submit" class="btn btn-default" type="button">上传</button>
                            </form>
                        </div>
                        <div id="isRobot" class="well">
                            <p id="replay" align="center">点击进行人机验证</p>
                            <div class="list-group" id="checkHuman" hidden>
                                <p align="center">正在检测</p>
                                <div class="spinner">
                                    <div class="bounce1"></div>
                                    <div class="bounce2"></div>
                                    <div class="bounce3"></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <button id="subBugButton" type="button" class="btn btn-primary" style="width:100%;">
                                提交
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="confirm" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="submitBug">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title text-danger">
                    注意
                </h4>
                <div class="alert alert-warning alert-dismissible fade in browser-check-alert hide"
                     role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input id="confirmClock" class="hidden" value="0"/>
                    <p id="confirmMsg"></p>
                </div>
                <div class="modal-footer">
                    <button id="confirmOk" type="button" class="btn btn-primary ok" data-dismiss="modal">确认</button>
                    <button type="button" class="btn btn-default cancel" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="js/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
<script src="js/bootstrap.min.js"></script>
<script src="js/ie10-viewport-bug-workaround.js"></script>
<script src="js/message.js"></script>
<script src="js/messenger.min.js"></script>
<script src="js/messenger-theme-flat.js"></script>
<script src="js/base.js"></script>
<script src="js/time-format.js"></script>
<script src="js/browser-check.js"></script>
<script src="js/code.js"></script>
<script src="js/cookie.js"></script>
<script src="js/viewer.min.js"></script>
<script src="js/i18N.js"></script>
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<script>
    (adsbygoogle = window.adsbygoogle || []).push({
        google_ad_client: "ca-pub-7377922292358202",
        enable_page_level_ads: true
    })

    $("#bugBewirteClean").click(function () {
        confirmUpdate("确认清空？", "clean")
    })

    // 魔改版confirm
    function confirmUpdate(msg, clock) {
        $("#confirm").modal('show')
        $("#confirmMsg").html(msg)
        $("#confirmClock").val(clock)
    }

    $("#confirmOk").click(function () {
        var clock = $("#confirmClock").val()
        switch (clock) {
            case "clean":
                clean.call()
                break
            default:
                alert("异常")
        }

    })

    var clean = function bugBewirteClean() {
        $("#bugBewirte").val("")
    }

    $("#bugBewirteQuick").click(function () {
        var url = window.location.href
        var ua = navigator.userAgent.toLowerCase()
        $("#bugBewirte").val("链接:" + url + "\n")
        $("#bugBewirte").val($("#bugBewirte").val() + "环境:" + ua + "\n")
    })

    $(document).ready(function () {
        img = ""
        isRobot = true
    })

    // 图片上传
    document.getElementById("submit").onclick = function () {
        var xhr = new XMLHttpRequest();
        var formData = new FormData();
        var fileInput = document.getElementById("file");
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
                    $("#uploadImg").modal('toggle')
                    img = "<img src=\"" + url + "\">"
                    $("#photo").html(img)
                    fileInput.value = ""
                }
            }
            xhr.send(formData)
            xhr = null
        } else {
            alert("未找到文件")
        }
    }

    // 检测人机
    $("#isRobot").click(function () {
        loadding()
    })

    // 人机检测
    function loadding() {
        $("#replay").hide()
        $("#checkHuman").show()
        setTimeout(function () {
            isRobot = false
            $("#isRobot").hide()
            $("#checkHuman").hide()
        }, 1000)
    }

    //提交反馈 按钮点击
    $("#subBugButton").click(function () {
        if ($("#bugName").val() == "" || $("#bugName").val().length == 0) {
            alert("请输入缺陷名")
            return false
        }
        if ($("#bugBewirte").val() == "" || $("#bugBewirte").val().length == 0) {
            alert("请输入缺陷描述")
            return false
        }
        if (isRobot == true) {
            alert("未通过机器人检测")
            return false
        }
        $("#submitBugLoadding").show()
        $("#bugBewirte").val($("#bugBewirte").val() + img)
        $.ajax({
            cache: true,
            type: "POST",
            url: "bug-submit",
            data: $('#bugSubForm').serialize(),
            async: false,
            success: function (data) {
                var state = data.state
                $("#submitBugLoadding").hide()
                $("#bugName").val("")
                $("#bugBewirte").val("")
                $("#file").val("")
                $("#photo").html("")
                if (state == 0) {
                    alert("提交成功。")
                    newbugs_page = 1
                } else {
                    alert("提交异常，异常码：" + state)
                }
                isRobot = true
                $("#isRobot").show()
                $("#replay").show()
            }
        });
    })

</script>
<c:if test="${session.WW_TRANS_I18N_LOCALE eq null}">
    <script src="js/i18N_zh_CN.js"></script>
</c:if>
<c:if test="${session.WW_TRANS_I18N_LOCALE ne null}">
    <script src="js/i18N_<s:property value="#session.WW_TRANS_I18N_LOCALE"/>.js"></script>
</c:if>