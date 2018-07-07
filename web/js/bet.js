$(document).ready(function () {
    var matchComplete = false
    var chose
    var round = 1
    var number
    var computerNum
    var result = ""
    var userIntegral = 0
    var betIntegral = 0
    var vsNum

    function match() {
        round = 1
        result = ""
        $.ajax({
            type: "post",
            url: "user-betVSComputer",
            dataType: "json",
            success: function (data) {
                $("#matchDiv").hide()
                $("#resultDiv").hide()
                matchComplete = true
                var userNum = data.userNum
                vsNum = data.vsNum
                $("#vsDiv").show()
                $("#vsNum").html(vsNum)
                userIntegral = data.userIntegral
                $("#userIntegral").html(userIntegral)

                // computerNum = data.computerNum
                $("#numDiv").show()
                $("#num1").html(userNum[0])
                $("#num2").html(userNum[1])
                $("#num3").html(userNum[2])
                $("#num4").html(userNum[3])
                $("#num5").html(userNum[4])
            }
        })
    }

    $("#betBtn").click(function () {
        betIntegral = $("#betIntegral").val()

        if (betIntegral > userIntegral) {
            alert("积分不足")
            return false
        } else if (betIntegral < 10) {
            alert("最低赌注10积分")
            return false
        }

        $("#matchDiv").hide()

        var url = "user-vsComputer?num=" + number + "&bet=" + betIntegral + "&vsNum=" + vsNum

        $.ajax({
            type: "post",
            dataType: "json",
            url: url,
            success: function (data) {
                var status = data.status
                if (status == 1) {
                    alert("已结束")
                } else if (status == 2) {
                    alert("比赛不存在")
                } else if (status == 0) {
                    $(chose).hide()
                    result += data.result
                    $("#result").html(result)
                    var integral = data.integral
                    userIntegral = data.userIntegral
                    $("#userIntegral").html(userIntegral)
                    if(round > 3) {
                        $("#integral").html(integral + "<p>当前积分："+userIntegral+"</p>")
                    } else {
                        $("#integral").html(integral)
                    }
                }
            }
        })

        $("#numDiv").show()
        $("#betDiv").hide()
        $("#resultDiv").show()
        round++
        if (round > 3) {
            $("#choseDiv").hide()
            $("#resultDiv").show()
            $("#beginDiv").show()
            $("#numDiv").hide()
            $("#a1").show()
            $("#a2").show()
            $("#a3").show()
            $("#a4").show()
            $("#a5").show()
        }
    })

    $("#computerBtn").click(function () {
        $("#beginDiv").hide()
        $("#matchDiv").show()

        console.log("Begin matching")
        countTime(0)
        match()

        // console.log("Begin vs computer")
        // countdown(3)
    })

    // 倒计时 秒数
    function countDown(second) {
        if (second <= 0) {
            $("#countDownDiv").hide()
            alert("已超时")
            $("#result").html("<p class='text-danger'>败北</p>")
            // $("#result").html("<p class='text-success'>胜利</p>")
            // $("#result").html("<p class='text-info'>流局</p>")
            return false
        }
        // console.log(second)
        $("#countDownSecond").html(second)
        second--
        timeout = setTimeout(function () {
            countDown(second)
        }, 1000)
    }

    // 正数 秒数
    function countTime(second) {
        if (matchComplete) {
            clearTimeout(timeout)
            return false
        }

        if (second > 10) {
            alert("暂时没有可用的机器人，请稍后再试")
            $("#matchDiv").hide()
            $("#beginDiv").show()
            return false
        }
        // console.log(second)
        $("#second").html(second)
        second++
        timeout = setTimeout(function () {
            countTime(second)
        }, 1000)
    }

    function choseNum(num) {
        clearTimeout(timeout)
        countDown(30)
        $("#numDiv").hide()
        $("#choseDiv").show()
        number = document.getElementById("num" + num).innerText;
        $("#betNum").html(number)
        $("#choseNum").html("#a" + num)
        $("#a" + num).hide()
        $("#betDiv").show()
        $("#resultDiv").hide()
    }

    $("#a1").click(function () {
        choseNum(1)
    })

    $("#a2").click(function () {
        choseNum(2)
    })

    $("#a3").click(function () {
        choseNum(3)
    })

    $("#a4").click(function () {
        choseNum(4)
    })

    $("#a5").click(function () {
        choseNum(5)
    })

    $("#aBet").click(function () {
        $("#betDiv").hide()
        $("#choseDiv").show()
        chose = document.getElementById("choseNum").innerText;
        if (chose == "?") return
        clearTimeout(timeout)
        countDown(15)
        $("#numDiv").show()
        $(chose).show()
        $("#betNum").html("?")
        $("#choseNum").html("?")
    })

})
