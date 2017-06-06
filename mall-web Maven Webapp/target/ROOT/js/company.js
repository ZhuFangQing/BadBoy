$(document).ready(function () {
    $(document).on('change', '#new-province', function () {
        getCity();
    });
    $(document).on('change', '#new-city', function () {
        getArea();
    });

    $(document).on('click', '#completeSub', function () {
        $.ajax({
            url: '/company/updateCompany',
            type: 'POST',
            data: {
                id:$('#companyId').val(),
                legal:$('#legal').val(),
                tel:$('#tel').val(),
                bankName:$('#bankName').val(),
                bankCode:$('#bankCode').val(),
                province:$("#new-province option:selected").attr("value"),
                city:$("#new-city option:selected").attr("value"),
                area:$("#new-area option:selected").attr("value"),
                provinceName:$("#new-province option:selected").attr("valueName"),
                cityName:$("#new-city option:selected").attr("valueName"),
                areaName:$("#new-area option:selected").attr("valueName"),
                address:$('#address').val(),
                customerClass:$("#customerClass option:selected").attr("value"),
                mail:$('#mail').val(),
                companyIndex:$('#companyIndex').val(),
                description:$('#description').val()
            },
            dataType: 'json',
            success: function (resp) {
                console.log(resp);
                if (resp.code != 'SUCCESS') {
                    alert(resp['msg']);
                } else {
                    alert('提交完善信息成功！');
                    location.href="/company/toCompanyInfoPage"
                }
            }
        });
    });
});


function uploadImage(fileName) {
    $("." + fileName).hide();

    $.ajaxFileUpload
    ({
        url: '/company/uploadImage',
        secureuri: false,
        fileElementId: fileName,
        dataType: 'text',
        async:false,
        //服务器成功响应处理函数
        success: function (data) {
            console.log(data);
            if (data == null) {
                alert('图片上传异常，请重新上传');
                return;
            }
            if(data.length > 0 && data.substring(0, 1) != "/"){
                alert("请上传大于10kb的图片");
                return;
            }

            debugger;
            $("." + fileName).show();
            $("input[name='" + fileName + "']").val(data);
            $("input[type='file']").change(function () {
                uploadImage($(this).attr("id"));
            });
        },
        //服务器响应失败处理函数
        error: function (data, status, e) {
            console.log(e);
        }
    });
    return false;
}

function registerCompany() {
    if (check()) {
        $.ajax({
            url: '/company/registerCompany',
            type: 'POST',
            data: $('#companyForm').serialize(),
            dataType: 'json',
            success: function (resp) {
                console.log(resp);
                if (resp.code != 'SUCCESS') {
                    alert(resp['msg']);
                } else {
                    alert('申请成功！');
                    location.reload();
                }
            }
        });
    }
}

function check() {
    debugger;
    var companyName = $("#companyName").val();
    var phone = $("#phone").val();
    var password = $("#password").val();
    var rePassword = $("#rePassword").val();
    var busLicenceCode = $("#busLicenceCode").val();
    var busLicenceImg = $("#busLicenceImg").val();
    var institutionCode = $("#institutionCode").val();
    var institutionImg = $("#institutionImg").val();
    var taxCode = $("#taxCode").val();
    var taxImg = $("#taxImg").val();
    var codeType = $("#codeType").val();

    if (!$.notNull(companyName)) {
        alert("企业名称不能为空!");
        $("#companyName").focus();
        return false;
    }
    if (!$.notNull(password)) {
        alert("密码不能为空!");
        $("#password").focus();
        return false;
    }
    if(password.length < 6 || password.length > 14){
        alert("密码长度应为6-14个字符");
        $("#password").focus();
        return false;
    }
    if (!$.notNull(rePassword)) {
        alert("请再次输入密码!");
        $("#rePassword").focus();
        return false;
    }
    if (password != rePassword) {
        alert("两次密码输入不一致!");
        $("#rePassword").focus();
        return false;
    }
    if(codeType=="1"){
        if (!$.notNull(busLicenceImg)) {
            alert("请上传营业执照复印件!");
            $("#busLicenceImg").focus();
            return false;
        }
        if (!$.notNull(institutionImg)) {
            alert("请上传组织机构代码证复印件!");
            $("#institutionImg").focus();
            return false;
        }
        if (!$.notNull(taxImg)) {
            alert("请上传税务登记证明!");
            $("#taxImg").focus();
            return false;
        }
        // if (!$.notNull(busLicenceCode)) {
        //     alert("营业执照代码不能为空!");
        //     $("#busLicenceCode").focus();
        //     return false;
        // }
        // if (!$.notNull(institutionCode)) {
        //     alert("组织机构代码不能为空!");
        //     $("#institutionCode").focus();
        //     return false;
        // }
        // if (!$.notNull(taxCode)) {
        //     alert("请输入税务登记号!");
        //     $("#taxCode").focus();
        //     return false;
        // }
    }else{
        if (!$.notNull(busLicenceImg)) {
            alert("请上传三证合一复印件!");
            $("#busLicenceImg").focus();
            return false;
        }
    }


/*    if (!MOBILE_REG.test(phone)) {
        alert("手机号码格式不正确!");
        $("#phone").focus();
        return false;
    }
    if (!$.notNull(phone)) {
        alert("请输入手机号!");
        $("#phone").focus();
        return false;
    }*/
    return true;
}

function getProvince() {
    $.ajax({
        url: '/company/getProvince',
        type: 'GET',
        data: {},
        dataType: 'json',
        async: false,
        success: function (resp) {
            $('#new-province').empty();
            for (var i = 0; i < resp.length; i++) {
                $('#new-province').append("" +
                    "<option  value=" + resp[i].regionCode + " valueName=" + resp[i].regionName + " >" + resp[i].regionName + "</option>")
            }
            getCity();
        }
    });
}

function getCity() {
    $.ajax({
        url: '/company/getCity',
        type: 'GET',
        data: {
            provinceCode: $('#new-province').val()
        },
        dataType: 'json',
        async: false,
        success: function (resp) {
            $('#new-city').empty();
            for (var i = 0; i < resp.length; i++) {
                $('#new-city').append("" +
                    "<option value=" + resp[i].regionCode + " valueName=" + resp[i].regionName + ">" + resp[i].regionName + "</option>")
            }
            getArea();
        }
    });
}

function getArea() {
    $.ajax({
        url: '/company/getArea',
        type: 'GET',
        data: {
            cityCode: $('#new-city').val()
        },
        dataType: 'json',
        async: false,
        success: function (resp) {
            $('#new-area').empty();
            for (var i = 0; i < resp.length; i++) {
                $('#new-area').append("" +
                    "<option value=" + resp[i].regionCode + " valueName=" + resp[i].regionName + ">" + resp[i].regionName + "</option>")
            }
        }
    });
}