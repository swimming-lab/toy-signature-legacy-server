<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES">
    <div class="ibox-title">
        <a href="javascript:MyCommon.goBack()"><i class="fa fa-arrow-left fa-2x"></i></a>
        <h5 style="font-size: 18px;font-family: yg-jalnan;">앱 비밀번호 입력</h5>
    </div>
    <div class="passwordBox animated fadeIn">
        <div class="row">
            <div class="col-md-12">
                <div class="ibox-content text-center">
                    <div style="font-weight: 700;font-size: 19px">비밀번호를 입력하세요.</div>
                    <p>
                        대리인인 경우 임대인에게 비밀번호를 문의하세요
                    </p>

                    <div class="row text-center">
                        <div class="col-lg-12">
                            <div class="form-group" style="display: inline-flex">
                                <input type="number" id="password1" onkeyup="passwordSet(this, '', '2', event)" maxlength="1" oninput="maxLengthCheck(this)" style="width: 45px;height: 50px;margin: 0 10px;border: 0;font-size: 20px;border-bottom: 2px solid;text-align: center;-webkit-text-security: disc;"/>
                                <input type="number" id="password2" onkeyup="passwordSet(this, '1', '3', event)" maxlength="1" oninput="maxLengthCheck(this)" style="width: 45px;height: 50px;margin: 0 10px;border: 0;font-size: 20px;border-bottom: 2px solid;text-align: center;-webkit-text-security: disc;"/>
                                <input type="number" id="password3" onkeyup="passwordSet(this, '2', '4', event)" maxlength="1" oninput="maxLengthCheck(this)" style="width: 45px;height: 50px;margin: 0 10px;border: 0;font-size: 20px;border-bottom: 2px solid;text-align: center;-webkit-text-security: disc;"/>
                                <input type="number" id="password4" onkeyup="passwordSet(this, '3', 'OK', event)" maxlength="1" oninput="maxLengthCheck(this)" style="width: 45px;height: 50px;margin: 0 10px;border: 0;font-size: 20px;border-bottom: 2px solid;text-align: center;-webkit-text-security: disc;"/>
                                <form id="passwordFrom">
                                <input id="customerId" name="customerId" type="hidden" value="${customerId}">
                                <input id="appPassword" name="appPassword" type="hidden">
                                </form>
                            </div>
                        </div>
                    </div>

                    <br>
                    <button id="reset" type="button" class="btn btn-warning block full-width" style="display:none !important; height: 40px;font-size: 18px;border-radius: 10px;font-weight: bold">비밀번호 초기화 요청</button>
                </div>
            </div>
        </div>
    </div>

    <my:footer/>

    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Jquery Validate -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/validate/jquery.validate.min.js${CommonCode.RESOUCE_VERSION}"></script>

    <!-- global -->
    <script>
    var count = 0,
        layerId = '';
    </script>

    <!-- ready -->
    <script data-for="ready">
     $('#password1').focus();

     $('#reset').on('click', (event) => {
         event.preventDefault();
         setIsLayer(true);
         layerId = 'resetPassword';

         swal({
             title: '패스워드를 초기화하시겠습니까?',
             type: 'warning',
             showCancelButton: true,
             cancelButtonText: '취소',
             confirmButtonColor: "#DD6B55",
             confirmButtonText: '요청',
             closeOnConfirm: false
         }, function (isConfirm) {
             if (isConfirm) {
                 resetPassword();
             }
             setIsLayer(false);
             layerId = '';
         });

         return false;
     });
    </script>

    <!-- function -->
    <script>
        async function passwordSet(obj,prevObj,nextObj,event){
            //백스페이스 눌렀을 경우 (지우기)
            if (event.keyCode == 8) {
                if (prevObj != '') {
                    $('#password' + prevObj).focus();
                }
            } else {
                if (nextObj == 'OK') {
                    $('#password1').focus();
                    const param = {
                        customerId: $('#customerId').val(),
                        appPassword: $('#password1').val() + $('#password2').val() + $('#password3').val() + $('#password4').val()
                    };
                    const response = await MyAjax.execute('${CONTEXT_PATH}/login/loginProcess.json', param, {
                        autoResultFunctionTF: false,
                        type: "POST"
                    });
                    if (!_.startsWith(response.code, 'S')) {
                        swal({
                            title: response.message,
                            showCancelButton: false,
                            confirmButtonText: '확인',
                            customClass: 'custom-small-title'
                        }, function () {
                            $('#password1').val('');
                            $('#password2').val('');
                            $('#password3').val('');
                            $('#password4').val('');
                            $('#password1').focus();
                        });

                        if (++count >= 0) {
                            $('#reset').show();
                        }
                    } else {
                        MyCommon.goLink('/main/main.view');
                    }
                } else {
                    if ($(obj).val().length == 1) {
                        $('#password' + nextObj).focus();
                    }
                }
            }
        }

        async function resetPassword() {
            const param = {
                customerId: $('#customerId').val(),
            };
            const response = await MyAjax.execute('${CONTEXT_PATH}/login/resetAppPassword.json', param, {
                autoResultFunctionTF: false,
                type: "POST"
            });
            console.log(response);

            if (!_.startsWith(response.code, 'S')) {
                swal({
                    title: response.message,
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                },function() {
                    $('#memberPassword').val('');
                    $('#memberPassword').focus();
                });

                return;
            }

            swal({
                title: '패스워드 초기화 요청 완료',
                text: '',
                type: 'success',
                timer: 1000,
                showConfirmButton: false,
                customClass: 'custom-small-title'
            }, function() {
                MyCommon.goLink('/')
            });
        }

        // android bridge : closeLayer
        function closeLayer() {
            if (layerId == 'resetPassword') {
                $('.sweet-alert .sa-button-container .cancel').trigger('click');
            } else {
                $('#' + layerId).modal('hide');
            }
        }
        // android bridge : setLayerId
        function setIsLayer(isLayer) {
            if (MyCommon.isApp()) {
                window.SignatureApp.setIsLayer(isLayer);
            }
        }
    </script>
</my:html>
