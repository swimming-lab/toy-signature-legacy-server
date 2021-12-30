<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES" navigationBar="1">
    <div id="wrapper">

        <div id="page-wrapper" class="gray-bg">
            <div class="wrapper wrapper-content animated fadeIn">
                <div class="row">
                    <div class="col-lg-3">
                        <div style="padding: 20px 10px">
                            <div class="row">
                                <div class="col-12 text-left">
                                    <div class="font-bold" style="font-size: 21px">${memberVO.bizcoNm}(${memberVO.name})님,</div>
                                    <div class="font-bold" style="font-size: 21px">안녕하세요.</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3">
                        <div class="ibox-content text-center" style="border:1px solid #f8ac59;padding:20px 0">
                            <div class="font-bold" style="font-size:20px;padding-top: 15px;letter-spacing: 1.5px">건설기계임대차 표준계약서</div>
                            <p class="font-bold" style="letter-spacing: 0.5px">공정거래위원회 표준약관 제10059호</p>

                            <div class="text-center" style="padding: 5px 0">
                                <button class="contractNew btn btn-success btn-outline" style="margin-right:10px;padding: 8px 20px;font-size: 16px;font-weight: bold;height: 50px" type="button"><i class="fa fa-check"></i>&nbsp;작성하기</button>
                                <button class="contractLoad btn btn-warning btn-outline" type="button" style="padding: 8px 20px;font-size: 16px;font-weight: bold;height: 50px"><i class="fa fa-upload"></i>&nbsp;&nbsp;<span class="bold">불러오기</span></button>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg">
                        <div style="padding-left: 10px;background: #dcdbdb;margin-top: 20px;height: 40px;line-height: 39px;font-weight: 600;border-radius:8px;font-size: 12px;" class="arrears">
                            <i class="fa fa-share-alt text-center" style="background-color: #FF9800;border-radius: 15px;height: 24px;width: 24px;line-height: 24px;color:#fff;font-size:14px;margin-right: 5px;"></i>
                            체불건이 있다면, 공유하고 알림 받으세요!
                            <i class="fa fa-chevron-right" style="float: right;line-height: 43px;padding-right: 5px;"></i>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="row" style="margin: 20px 0;border: 1px solid #ccc;height: 115px; padding:5px 0px">
                            <div class="text-left" style="width: 70%;padding-left: 3%">
                                <div class="font-bold" style="font-size: 16px;margin: 10px 0;">지금 장비를 등록하세요!</div>
                                <div style="font-size: 11px">한번 등록하면 계약서 작성이 쉬워져요!</div>
                                <div class="equip" style="font-size: 12px;margin-top: 18px;color: blue;">장비 등록하기 ></div>
                            </div>
                            <div class="text-right">
                                <img src="/resources/publish/img/excavator-5027980_640.png" width="75" style="margin-top:15px">
                            </div>
                        </div>
                    </div>

                    <div class="col-lg text-center" style="margin-bottom: 20px;" >
                        <a class="btn btn-success btn-facebook full-width" style="color:#fff" href="tel:031-986-5527">
                            <i class="fa fa-phone"> </i> 고객센터 전화연결
                        </a>
                    </div>

                    <div class="col-lg text-center" style="margin: 10px 0 20px 0;" >
                        <a class="logout">
                            <u>첫화면으로 가기</u>
                        </a>
                    </div>
                    <c:if test="${memberVO.adminTp != null && (isChecked != null && isChecked == true)}">
                    <div class="col-lg text-center" style="margin: 30px;" >
                        <button type="button" class="admin_member btn btn-outline btn-success" style="width: 48%">회원관리</button>
                        <button type="button" class="admin_arrears btn btn-outline btn-danger" style="width: 48%">체불신고 관리</button>
                    </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script data-for="ready">
        jQuery(($) => {
            $('.contractNew').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/contract/insertForm.view');
                return false;
            });

            $('.contractLoad').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/contract/load.view');
                return false;
            });

            $('.arrears').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/arrears/form.view');
                return false;
            });

            $('.arrearsList').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/arrears/list.view');
                return false;
            });

            $('.home').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/main/main.view');
                return false;
            });

            $('.equip').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/equip/list.view');
                return false;
            });

            $('.logout').on('click', (event) => {
                event.preventDefault();
                MyCookie.removeCookie("signature_autologin");
                MyCommon.goLink('/login/logout.view');
                return false;
            });

            <c:if test="${memberVO.adminTp != null}">
            $('.admin_member').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/admin/member.view');
                return false;
            });

            $('.admin_arrears').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/admin/arrears.view');
                return false;
            });
            </c:if>
            if (MyCommon.isApp()) {
                try{
                    if(window.SignatureApp.getAppVersion() <= 1.2){
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
                }catch(e){
                    swal({
                        title: "앱이 업데이트 되었습니다.\nPlay스토어에서 업데이트 하세요",
                        showCancelButton: false,
                        confirmButtonText: '확인',
                        customClass: 'custom-small-title'
                    });
                }
            }
        });
    </script>
    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>
</my:html>
