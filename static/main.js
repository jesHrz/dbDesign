var $$ = mdui.JQ;

$$(function () {
    var baseURL = "http://localhost:63342/dbDesign";
    var loginURL = "http://localhost/"
    var toradoPort = "29888";
    $$('#login').on('click', function () {
        var usr = $$('#username').val();
        var pwd = $$('#password').val();
        if (usr === "") {
            alert("请输入学号");
            return;
        }
        if (pwd === "") {
            alert("请输入密码");
            return;
        }
        if (pwd === "" && usr === "") {
            alert("请输入学号和密码");
            return;
        }
        $$.ajax({
            method: 'POST',
            url: loginURL + toradoPort,
            data: {
                usr: usr,
                pwd: pwd
            },
            success: function (res) {
                alert(res);
            },
            error: function () {
                alert("error");
            }
        });
        return false;
    });
    $$('#register').on('click', function () {
        window.location = baseURL + "/register/reg.html";
    });
});