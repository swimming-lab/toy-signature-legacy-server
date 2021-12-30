<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES">
    <div class="ibox-title topFixed">
        <a href="javascript:MyCommon.goBack()"><i class="fa fa-arrow-left fa-2x"></i></a>
        <h5 style="font-size: 18px;font-family: yg-jalnan;">임대인만 사용가능</h5>
    </div>
    <div class="middle-box text-center lockscreen animated fadeIn" style="margin-bottom: 25px;width: 270px">
        <div>
            <div class="text-center" style="font-size: 18px;font-weight: 700;">관리자 비밀번호를 입력해주세요.</div>
            <form class="m-t" role="form" action="index.html">
                <div class="form-group">
                    <input id="memberPassword" type="password" class="form-control" placeholder="********" required="" style="text-align: center;height: 50px;font-size: 17px">
                    <input id="customerId" name="customerId" type="hidden" value="${customerId}">
                </div>
                <button id="submit" type="button" class="btn btn-warning block full-width" style="height: 40px;font-size: 18px;border-radius: 10px;font-weight: bold">확인</button>
                <br>
                <button id="reset" type="button" class="btn btn-warning block full-width" style="display:none !important; height: 40px;font-size: 18px;border-radius: 10px;font-weight: bold">비밀번호 초기화 요청</button>
            </form>
        </div>
    </div>
    <my:footer/>

    <!-- global -->
    <script>
    var count = 0,
        layerId = '';
    </script>

    <!-- ready -->
    <script data-for="ready">
        jQuery(($) => {
            $('#submit').on('click', (event) => {
                event.preventDefault();
                submit();
            });

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

            $('#memberPassword').focus();
        });
    </script>

    <!-- function -->
    <script>
        async function submit() {
            if (MyCommon.isEmpty($('#memberPassword').val())) {
                return;
            }
            $('#memberPassword').focus();
            const param = {
                customerId: $('#customerId').val(),
                memberPassword: CryptoJS.SHA512($('#memberPassword').val()).toString()
            };
            const response = await MyAjax.execute('${CONTEXT_PATH}/pc/login/password.json', param, {
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

                if (++count >= 0) {
                    // $('#reset').show();
                }
                return;
            }

            MyCommon.goLink('/pc/main/contractList.view');
        }

        async function resetPassword() {
            const response = await MyAjax.execute('${CONTEXT_PATH}/member/resetMemberPassword.json', {}, {
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

    <script defer src="${CommonCode.PATH_PLUGIN}/crypto/crypto-js.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>
</my:html>
