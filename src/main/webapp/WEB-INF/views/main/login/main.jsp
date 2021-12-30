<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES">
    <div class="text-center loginscreen" style="background-color: #ffc107;height: 100%;">
        <div class="animated bounceIn" >
            <img src="/resources/publish/img/logo.png" style="width: 34%;margin-top: 40%;margin-left: 9%;"/>
            <div style="margin: 5px 0 0 5%;font-size: 19px;font-family: yg-jalnan">전자임대차 표준계약서</div>
            <div style="font-family: yg-jalnan;font-size: 16px;">작업일보</div>
        </div>
        <div style="position: fixed;bottom:20px;text-align: center;width: 100%;">
            <div id="join" style="border: 1px solid;margin: 5% 10%;padding: 12px;font-size: 19px;font-weight: 500;">
                신규 가입
            </div>
            <div id="login" style="border: 1px solid;margin: 5% 10%;padding: 12px;font-size: 19px;font-weight: 500;background: #343a40;color: #fff;border-color: #000;">
                임대인/대리인 로그인
            </div>
            <div id="direct" style="border: 1px solid;margin: 5% 10%;padding: 5px;font-size: 19px;font-weight: 500;background: #7f8082;color: #fff;border-color: #000;">
                외부장비 직접입력
            </div>
            <div id="test">고객센터 031-986-5527</div>
            <div style="font-size: 10px;">Genius developer Company<span id="version"></span></div>
        </div>
    </div>

    <script data-for="ready">
        jQuery(($) => {
            $('#join').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/login/agreement.view');
            });

            $('#login').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/login/search.view');
            });
            $('#direct').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/login/search.view?mode=direct');
            });
            $('#test').on('click', (event) => {
                event.preventDefault();
                document.location.href="market://details?id=com.swimming.signature"
            });

            if (MyCommon.isApp()) {
                $('#version').html('. ver '+window.SignatureApp.getAppVersion());
                if(window.SignatureApp.getAppVersion() <= 1.2 ){
                    swal({
                        title: "앱이 업데이트 되었습니다.\nPlay스토어에서 업데이트 하세요",
                        showCancelButton: false,
                        confirmButtonText: '확인',
                        customClass: 'custom-small-title'
                    });
                }else{
                    if(window.SignatureApp.getAppVersion() < ${appVersion}){
                        swal({
                            title: "앱이 업데이트 되었습니다.",
                            showCancelButton: false,
                            confirmButtonText: 'Play스토어 이동',
                            customClass: 'custom-small-title'
                        }, function (isConfirm) {
                            document.location.href="market://details?id=com.swimming.signature";
                        });
                    }
                }
            }
        });
    </script>
    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>
</my:html>
