<%--
  Created by IntelliJ IDEA.
  User: sbx0
  Date: 2017/5/6
  Time: 14:07
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
    <meta name="description" content="<fmt:message key="website.name"/>">
    <meta name="author" content="<fmt:message key="bloger"/>">
    <link rel="icon" href="img/favicon.png">

    <title>搬瓦工信息查询 - <fmt:message key="website.name"/></title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/messenger.css" rel="stylesheet">
    <link href="css/messenger-theme-flat.css" rel="stylesheet">
    <link href="css/signin.css" rel="stylesheet">
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
    <div class="col-sm-12 margin-top-20">

        <ol class="breadcrumb">
            <li><a href="tools.jsp">工具</a></li>
            <li class="active">搬瓦工信息查询</li>
        </ol>
        <form class="form-signin" action="" method="post" id="inputForm">
            <label for="inputVEID" class="sr-only">VEID</label>
            <input type="text" id="inputVEID" name="inputApiKey" class="form-control" placeholder="请输入 VEID">
            <label for="inputApiKey" class="sr-only">API KEY</label>
            <input type="text" id="inputApiKey" name="inputApiKey" class="form-control" placeholder="请输入 API KEY">
            <button id="getInfo" class="btn btn-primary btn-block" type="button">查询服务器信息</button>
            <button id="thisInfo" class="btn btn-default btn-block" type="button">查看此服务器信息</button>
        </form>
        <div class="spinner" id="loaddingInfo" hidden>
            <div class="bounce1"></div>
            <div class="bounce2"></div>
            <div class="bounce3"></div>
        </div>
        <form id="infoForm" hidden>
            <div class="form-signin">
                <label id="dataLable">流量使用：</label>
                <div class="progress">
                    <div id="dataProgress" class="progress-bar" role="progressbar" aria-valuenow="100"
                         aria-valuemin="10"
                         aria-valuemax="100" style="width: 100%;">
                        100%
                    </div>
                </div>
                <label id="dateLable" for="data_next_reset">流量重置日期：</label>
                <input type="text" class="form-control" id="data_next_reset" readonly>
                <label id="memLable" for="memProgress">内存：</label>
                <div class="progress">
                    <div id="memProgress" class="progress-bar" role="progressbar" aria-valuenow="100" aria-valuemin="10"
                         aria-valuemax="100" style="width: 100%;">
                        100%
                    </div>
                </div>
                <label id="swapLable" for="swapProgress">SWAP：</label>
                <div class="progress">
                    <div id="swapProgress" class="progress-bar" role="progressbar" aria-valuenow="100"
                         aria-valuemin="10"
                         aria-valuemax="100" style="width: 100%;">
                        100%
                    </div>
                </div>
                <label id="diskLable" for="swapProgress">SWAP：</label>
                <div class="progress">
                    <div id="diskProgress" class="progress-bar" role="progressbar" aria-valuenow="100"
                         aria-valuemin="10"
                         aria-valuemax="100" style="width: 100%;">
                        100%
                    </div>
                </div>
                <p id="info"></p>
            </div>
        </form>
    </div>
</div>
<s:include value="foot.jsp"></s:include>
<script type="text/javascript">
    $(document).ready(function () {
        $("#toolsTab").addClass("active")

        $("#getInfo").click(function () {
            $("#infoForm").hide()
            $("#loaddingInfo").show()
            var veid = $("#inputVEID").val()
            var api_key = $("#inputApiKey").val()
            if (veid == null || veid.length == 0 || veid == "") {
                alert("请输入VEID")
                $("#loaddingInfo").hide()
                $("#inputVEID").focus()
            } else if (api_key == null || api_key.length == 0 || api_key == "") {
                alert("请输入API_KEY")
                $("#loaddingInfo").hide()
                $("#inputApiKey").focus()
            } else {
                $.ajax({
                    type: "post",
                    url: "admin-banwagon?veid=" + veid + "&api_key=" + api_key,
                    dataType: "json",
                    success: function (data) {
                        if (data.status == 1) {
                            alert("参数异常")
                            $("#loaddingInfo").hide()
                        } else if (data.status == 2) {
                            alert("查询异常，请检查UEID和API_KEY")
                            $("#loaddingInfo").hide()
                        } else if (data.status == 0) {
                            $("#loaddingInfo").hide()
                            $("#infoForm").show()
                            showInfo(data)
                        }
                    }
                })
            }
        })

        $("#thisInfo").click(function () {
            $("#infoForm").hide()
            $("#loaddingInfo").show()
            $.ajax({
                type: "post",
                url: "admin-info",
                dataType: "json",
                success: function (data) {
                    if (data.status == 1) {
                        alert("参数异常")
                        $("#loaddingInfo").hide()
                    } else if (data.status == 2) {
                        alert("查询异常")
                        $("#loaddingInfo").hide()
                    } else if (data.status == 0) {
                        $("#loaddingInfo").hide()
                        $("#infoForm").show()
                        showInfo(data)
                    }
                }
            })
        })

        function showInfo(data) {
            var ve_status = data.ve_status
            var ve_mac1 = data.ve_mac1
            var ve_used_disk_space_b = data.ve_used_disk_space_b
            var ve_disk_quota_gb = data.ve_disk_quota_gb
            var is_cpu_throttled = data.is_cpu_throttled
            var ssh_port = data.ssh_port
            var live_hostname = data.live_hostname
            var load_average = data.load_average
            var mem_available_kb = data.mem_available_kb
            var swap_total_kb = data.swap_total_kb
            var swap_available_kb = data.swap_available_kb

            var plan_monthly_data = bytesToGb(data.plan_monthly_data)
            var data_counter = bytesToGb(data.data_counter)
            var percent = (data_counter / plan_monthly_data) * 100
            percent = percent.toFixed(2)
            var no_use_percent = 100.00 - percent
            $("#dataProgress").width(no_use_percent.toFixed(2) + "%")
            $("#dataProgress").html("剩余 " + no_use_percent.toFixed(2) + "%")
            $("#dataLable").html("流量使用：" + percent + "% " + data_counter + "GB/" + plan_monthly_data + "GB")
            var data_surplus = plan_monthly_data - data_counter
            data_surplus = data_surplus.toFixed(1)

            var data_next_reset = data.data_next_reset
            data_next_reset = new Date(data_next_reset * 1000)
            data_next_reset = Format(data_next_reset, "yyyy-MM-dd")
            var day = DateMinus(data_next_reset) + 1
            var day_bandwidth = data_surplus / day
            day_bandwidth = day_bandwidth.toFixed(1)

            $("#data_next_reset").val(data_next_reset)
            $("#dateLable").html("流量重置：剩余" + day + "天，平均每日可用" + day_bandwidth + "GB")

            var node_ip = data.node_ip
            var node_location = data.node_location
            var plan = data.plan
            var plan_disk = bytesToGb(data.plan_disk)
            var plan_ram = bytesToMb(data.plan_ram)
            var plan_swap = bytesToMb(data.plan_swap)
            var os = data.os
            var error = data.error

            mem_available_kb = kbToMb(mem_available_kb)
            percent = (mem_available_kb / plan_ram) * 100
            no_use_percent = 100.00 - percent
            $("#memProgress").width(no_use_percent.toFixed(1) + "%")
            $("#memProgress").html("")
            $("#memLable").html("内存:" + (plan_ram - mem_available_kb).toFixed(1) + "/" + plan_ram + " MB")

            swap_total_kb = kbToMb(swap_total_kb)
            swap_available_kb = kbToMb(swap_available_kb)
            percent = (swap_available_kb / swap_total_kb) * 100
            no_use_percent = 100.00 - percent
            swap_available_kb = (swap_total_kb - swap_available_kb).toFixed(1)
            $("#swapProgress").width(no_use_percent.toFixed(1) + "%")
            $("#swapProgress").html("")
            $("#swapLable").html("SWAP:" + swap_available_kb + "/" + swap_total_kb + " MB")

            ve_used_disk_space_b = bytesToGb(ve_used_disk_space_b)
            percent = ((ve_disk_quota_gb - ve_used_disk_space_b) / ve_disk_quota_gb) * 100
            no_use_percent = 100.00 - percent
            $("#diskProgress").width(no_use_percent.toFixed(1) + "%")
            $("#diskProgress").html("")
            $("#diskLable").html("硬盘:" + ve_used_disk_space_b + "/" + ve_disk_quota_gb + " GB")

            $("#info").html(
                "服务器详细信息:<br/>" +
                "IP:" + node_ip + "<br/>" +
                "MAC地址:" + ve_mac1 + "<br/>" +
                "SSH端口:" + ssh_port + "<br/>" +
                "Hostname:" + live_hostname + "<br/>" +
                "状态:" + ve_status + "<br/>" +
                "负载均衡:" + load_average + "<br/>" +
                "系统:" + os + "<br/>" +
                "物理地址(国家/地区):" + node_location + "<br/>" +
                "CPU状态:" + is_cpu_throttled + "<br/>" +
                "套餐类型:<a href='https://www.bwh1.net/' target='_blank\'>" + plan + "<a/><br/>" +
                "流量(月):" + plan_monthly_data + " GB<br/>" +
                "硬盘:" + plan_disk + " GB<br/>" +
                "内存:" + plan_ram + " MB<br/>" +
                "SWAP:" + plan_swap + " MB<br/>" +
                "错误:" + error + "<br/>" +
                "")

        }

        function bytesToGb(num) {
            num = num / 1024
            num = num / 1024
            num = num / 1024
            num = num.toFixed(1)
            return num
        }

        function bytesToMb(num) {
            num = num / 1024
            num = num / 1024
            num = num.toFixed(1)
            return num
        }

        function kbToMb(num) {
            num = num / 1024
            num = num.toFixed(1)
            return num
        }
    })
</script>
</body>
</html>
