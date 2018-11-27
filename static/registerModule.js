let $$ = mdui.JQ;


let Handler = function () {
    let schoolStatus = true;
    let schoolId = "";
    let sidStatus = true;

    //检查学号
    function checkSid(sid, status) {
        let hasError = false;
        let exp = /^[0-9]*$/;
        if (sid.length === 0) {
            $$('#usernameError').text('请输入学号');
            hasError = true;
        }
        else if (status) {
            $$('#usernameError').text('学号已存在');
            hasError = true;

        }
        else if(!exp.test(sid)){
            $$('#usernameError').text('学号只能是数字');
            hasError = true;
        }

        if (hasError) {
            $$('#usernameTextfield').addClass('mdui-textfield-invalid');
            return false;
        }
        else {
            $$('#usernameTextfield').removeClass('mdui-textfield-invalid');
            return true;
        }

    }

    // 检查密码
    function checkPwd(pwd) {
        let hasError = false;
        let $error = $$('#passwordError');
        let exp = /^[\da-z]+$/i;
        if (pwd.length < 6) {
            $error.text('密码长度不能小于6');
            hasError = true;
        }
        else if (pwd.length > 20) {
            $error.text('密码长度不能大于20');
            hasError = true;
        }
        else if (!exp.test(pwd)) {
            $error.text('密码只能由数字和大小写字母组成');
            hasError = true;
        }

        if (hasError) {
            $$('#passwordTextfield').addClass('mdui-textfield-invalid');
            return false;
        }
        else {
            $$('#passwordTextfield').removeClass('mdui-textfield-invalid');
            return true;
        }
    }

    //检查确认密码
    function confirmPwd(pwd, confirmPwd) {
        if (pwd === confirmPwd) {
            $$('#passwordConfirmTextfield').removeClass('mdui-textfield-invalid');
            return true;
        }
        else {
            $$('#passwordConfirmError').text('两次密码不一致');
            $$('#passwordConfirmTextfield').addClass('mdui-textfield-invalid');
            return false;
        }
    }

    //检查学校名称
    function checkSchool(schoolName, status) {
        let $error = $$('#schoolError');
        let hasError = false;
        if (schoolName === "") {
            $error.text('请填写学校名称');
            hasError = true;
        }
        else if (!status) {
            $error.text('没有找到 ' + schoolName);
            hasError = true;
        }

        if (hasError) {
            $$('#schoolTextfield').addClass('mdui-textfield-invalid');
            return false;
        }
        else {
            $$('#schoolTextfield').removeClass('mdui-textfield-invalid');
            return true;
        }
    }

    //检查姓名
    function checkName(name) {
        if (name === "") {
            $$('#nameError').text('请输入姓名');
            $$('#nameTextfield').addClass('mdui-textfield-invalid');
            return false;
        }
        else {
            $$('#nameTextfield').removeClass('mdui-textfield-invalid');
            return true;
        }
    }

    function schoolInputEvent() {
        //查询学校是否合法
        $$('#school').on('change', function () {
            let schoolName = $$('#school').val();
            schoolStatus = true;
            $$.ajax({
                method: 'GET',
                url: baseUrl + '/register-check',
                data: {
                    type: 'school',
                    info: schoolName
                },
                success: function (ret) {
                    let res = JSON.parse(ret);
                    schoolStatus = res.success;
                    if (schoolStatus) schoolId = res.data[0]['school_id'];
                },
                error: function () {
                    schoolStatus = false;
                },
                complete: function () {
                    checkSchool(schoolName, schoolStatus);
                }
            });
        });
    }

    function sidInputEvent() {
        //检查是否有重复学号
        $$('#username').on('change', function () {
            let sid = $$('#username').val();
            sidStatus = true;
            $$.ajax({
                method: 'GET',
                url: baseUrl + '/register-check',
                data: {
                    type: 'sid',
                    info: sid
                },
                success: function (ret) {
                    let res = JSON.parse(ret);
                    sidStatus = res.success;
                },
                error: function () {
                    sidStatus = false;
                },
                complete: function () {
                    checkSid(sid, sidStatus);
                }
            })
        })
    }


    function registerInit() {

        $$('#confirmRegister').on('click', function () {
            let sid = $$('#username').val();
            let pwd = $$('#password').val();
            let pwdConfirm = $$('#passwordConfirm').val();
            let name = $$('#name').val();
            let school = $$('#school').val();

            let ready = checkSid(sid, sidStatus) && checkPwd(pwd) && confirmPwd(pwd, pwdConfirm) && checkName(name) && checkSchool(school, schoolStatus);
            if (!ready) return;

            $$.ajax({
                method: 'POST',
                url: baseUrl + '/register',
                data: {
                    usr: sid,
                    pwd: hex_md5(pwd),
                    name: name,
                    school: schoolId
                },
                success: function (ret) {
                    let res = JSON.parse(ret);
                    if (res.success) {
                        mdui.dialog({
                            title: '成功!',
                            content: '注册成功, 请返回登陆界面重新登陆!',
                            buttons: [{
                                text: '确定', onClick: function () {
                                    window.location.href = 'login.html';
                                }
                            }]
                        });
                    }
                    else {
                        mdui.dialog({
                            title: '失败',
                            content: '请重试！',
                            buttons: [{text: '确定'}]
                        });
                    }
                },
                error: function () {
                    mdui.dialog({
                        title: '失败',
                        content: '服务器好像出了点问题...',
                        buttons: [{text: '确定'}]
                    });
                }
            });
        });
    }

    function checkPwdInit() {
        $$('#password').on('change', function () {
            let pwd = $$('#password').val();
            checkPwd(pwd);
        })
    }

    function checkConfirmPwdInit() {
        $$('#passwordConfirm').on('change', function () {
            let pwd = $$('#password').val();
            let pwdConfirm = $$('#passwordConfirm').val();
            confirmPwd(pwd, pwdConfirm);
        });
    }

    return {
        init: function () {
            schoolInputEvent();
            sidInputEvent();
            registerInit();
            checkConfirmPwdInit();
            checkPwdInit();
        }
    }
}();

$$(function () {
    Handler.init();
});