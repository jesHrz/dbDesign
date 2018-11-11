let $$ = mdui.JQ;

let loginPageHandler = function () {

    function loginEventInit() {
        $$('#login').on('click', function () {
            let usr = $$('#username').val();
            let pwd = hex_md5($$('#password').val());

            let loginUrl = baseUrl + '/login';


            let okUSR = usr.length !== 0;

            let okPWD = pwd.length !== 0;

            if (!okUSR) {
                $$('#usernameTextfield').addClass('mdui-textfield-invalid');
            }
            else {
                $$('#usernameTextfield').removeClass('mdui-textfield-invalid');
            }

            if (!okPWD) {
                $$('#passwordTextfield').addClass('mdui-textfield-invalid');
            }
            else {
                $$('passwordTextfield').removeClass('mdui-textfield-invalid');
            }

            if (!okPWD || !okUSR) return;

            $$("#login").text("登录中...");
            //登录按钮设置为disabled防止连按enter
            $$('#login').prop('disabled', true);
            $$.ajax({
                method: 'POST',
                url: loginUrl,
                data: {
                    usr: usr,
                    pwd: pwd
                },
                success: function (ret) {
                    let res = JSON.parse(ret);
                    if (res.success)
                        mdui.dialog({
                            title: '登录成功!',
                            content: 'OK',
                            buttons: [{text: '确定'}]
                        });
                    else {
                        mdui.dialog({
                            title: '登录失败',
                            content: '学号或密码错误, 请重新登陆!',
                            buttons: [{text: '确定'}]
                        });
                    }
                },
                error: function () {
                    mdui.dialog({
                        title: '登录失败',
                        content: '服务器好像出了点问题...',
                        buttons: [{text: '确定'}]
                    });
                },
                complete: function () {
                    $$('#login').text("登录");
                    //恢复按钮
                    $$('#login').prop('disabled', false);
                }
            });
        });
    }

    function registerEventInit() {
        $$('#register').on('click', function () {
            window.location = "/register/reg.html";
        });
    }

    return {
        init: function () {
            loginEventInit();
            registerEventInit();
        }
    }
}();


$$(function () {
    loginPageHandler.init();
});