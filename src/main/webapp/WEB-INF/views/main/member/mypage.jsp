<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES" modal="YES" navigationBar="3">
    <div class="animated fadeIn">
        <div class="ibox-title topFixed">
            <a href="javascript:MyCommon.goBack()"><i class="fa fa-arrow-left fa-2x"></i></a>
            <c:choose>
                <c:when test="${isAdmin == true}">
                    <h5 style="font-size: 18px;font-family: yg-jalnan;">회원정보</h5>
                </c:when>
                <c:otherwise>
                    <h5 style="font-size: 18px;font-family: yg-jalnan;">내정보</h5>
                </c:otherwise>
            </c:choose>
        </div>
        <div style="padding:10px;margin-top:48px" class="topFixed-body">
            <c:if test="${isAdmin == null}">
                <div style="text-align: right;font-size: 11px">전자임대차계약서 버전 : <span id="appVersion"></span></div>
            </c:if>
            <div style="font-size: 18px;font-weight: bold;">${memberVO.bizcoNm} <span style="font-size: 16px">(${memberVO.name})</span></div>
            <div style="font-size: 15px;font-weight: bold;">사업자번호 : ${memberVO.bizcoRegNo}</div>
            <div style="display: flex">
                계약서 사업자번호 노출제한 :
                <div class="switch" style="margin-left: 10px">
                    <div class="onoffswitch">
                        <input type="checkbox" <c:if test="${viewBizcoYn != null && viewBizcoYn == 'N'}">checked</c:if> class="onoffswitch-checkbox" id="viewBizcoYn">
                        <label class="onoffswitch-label" for="viewBizcoYn">
                            <span class="onoffswitch-inner"></span>
                            <span class="onoffswitch-switch"></span>
                        </label>
                    </div>
                </div>
            </div>
            <form id="form">
                <div class="row">
                    <div class="col-lg-8">
                        <div class="form-group">
                            <input id="name" name="name" type="hidden" value="${memberVO.name}">
                            <input id="bizcoNm" name="bizcoNm" type="hidden" value="${memberVO.bizcoNm}">
                            <input id="bizcoRegNo" name="bizcoRegNo" type="hidden" value="${memberVO.bizcoRegNo}">
                            <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">핸드폰번호 <span style="font-size: 13px">(이 번호로 계약서가 발송됩니다.)</span></label>
                            <input id="telNo" name="telNo" type="tel" class="form-control required" maxlength="13" placeholder="숫자만 입력해주세요." style="height: 45px;" value="${memberVO.telNo}">
                            <input id="nationIdNo" name="nationIdNo" type="hidden" >
                        </div>
                        <div class="form-group">
                            <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">사업장 주소</label>
                            <div class="input-group" style="margin-bottom: 5px">
                                <input id="zipNo" name="zipNo" type="tel" class="form-control" readonly value="${memberVO.zipNo}">
                                <div id="postSearch" class="input-group-append">
                                    <span class="input-group-addon">우편번호 검색</span>
                                </div>
                            </div>
                            <input id="addrOffice" name="addrOffice" type="text" class="form-control required" style="margin-bottom: 5px" value="${memberVO.addrOffice}">
                            <input id="addrOfficeDtl" name="addrOfficeDtl" type="text" class="form-control required" value="${memberVO.addrOfficeDtl}">

                            <input id="bankCd" name="bankCd" type="hidden" value="">
                            <input id="accontNo" name="accontNo" type="hidden" value="">
                        </div>
                        <div class="form-group">
                            <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">비밀번호</label>
                            <div style="text-align: center">
                                <button type="button" class="btn btn-outline btn-success" data-toggle="modal" data-target="#appPasswordModal" style="width: 48%">앱 로그인<br>비밀번호 변경</button>
                                <button type="button" class="btn btn-outline btn-success" data-toggle="modal" data-target="#memberPasswordModal" style="width: 48%">계약서 관리<br>비밀번호 변경</button>
                            </div>
                        </div>

                        <div id="join" style="width: 100%;height: 50px;text-align: center;background: #ffc107;color: #fff;line-height: 50px;font-size: 18px;font-weight: bold;margin-top: 30px;">
                            수정하기
                        </div>
                        <div style="text-align: center;margin-top: 25px">고객센터 031-986-5527</div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- 계정 관리 패스워드 변경 -->
    <div class="modal inmodal fade" id="memberPasswordModal" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-sm "><!--modal-dialog-centered-->
            <div class="modal-content">
                <!--div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">장비등록</h4>
                </div-->
                <div class="modal-body">
                    <form id="memberPasswordForm">
                        <div class="form-group">
                            <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">관리자전용(계약서관리) 비밀번호 *</label>
                            <input id="u_memberPassword" name="u_memberPassword" type="password" minlength="6" maxlength="12" placeholder="6-12자리의 비밀번호를 입력해주세요." class="form-control required" style="height: 45px;font-size: 17px">
                        </div>
                        <div class="form-group">
                            <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">관리자전용(계약서관리) 비밀번호 확인 *</label>
                            <input id="u_memberPassword_2" name="u_memberPassword_2" type="password" minlength="6" maxlength="12" placeholder="6-12자리의 비밀번호를 다시한번 입력해주세요." class="form-control required" style="height: 45px;font-size: 17px">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white" data-dismiss="modal" style="padding: 10px 30px">취소</button>
                    <button id="updateMemberPassword" type="button" class="btn btn-warning" style="padding: 10px 30px">수정</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 앱 로그인 패스워드 변경 -->
    <div class="modal inmodal fade" id="appPasswordModal" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-sm "><!--modal-dialog-centered-->
            <div class="modal-content">
                <!--div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">장비등록</h4>
                </div-->
                <div class="modal-body">
                    <form id="appPasswordForm">
                        <div class="form-group">
                            <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">앱 로그인 비밀번호 *</label>
                            <input id="u_appPassword" name="u_appPassword" type="number" pattern="[0-9]*" maxlength="4" inputmode="numeric" oninput="maxLengthCheck(this)" placeholder="숫자 4자리를 입력해주세요." class="form-control required" style="-webkit-text-security:disc;height: 45px;font-size: 17px">
                        </div>
                        <div class="form-group">
                            <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">앱 로그인 비밀번호 확인 *</label>
                            <input id="u_appPassword_2" name="u_appPassword_2" type="number" pattern="[0-9]*" maxlength="4" inputmode="numeric" oninput="maxLengthCheck(this)" placeholder="숫자 4자리를 다시한번 입력해주세요." class="form-control required" style="-webkit-text-security:disc;height: 45px;font-size: 17px">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white" data-dismiss="modal" style="padding: 10px 30px">취소</button>
                    <button id="updateAppPassword" type="button" class="btn btn-warning" style="padding: 10px 30px">수정</button>
                </div>
            </div>
        </div>
    </div>


    <div>
        <input id="memberVO" type="hidden" value="${fn:escapeXml(Gson.toJson(memberVO))}">
        <c:if test="${isAdmin == true}">
            <input id="customerId" type="hidden" value="${memberVO.customerId}">
        </c:if>
    </div>


    <div id="daumPost" class="modal" style="display: none">
        <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
    </div>
    <!--div><button id="join" type="button" class="btn btn-primary block full-width m-b">Login</button></div-->

    <script>
        async function join() {
            const memberVO = {
                customerId          : $('#customerId').val(),         //'회원ID'
                bizcoNm             : $('#bizcoNm').val(),            //'상호'
                bizcoRegNo          : $('#bizcoRegNo').val(),         //'사업자등록번호'
                name                : $('#name').val(),               //'성명'
                nationIdNo          : $('#nationIdNo').val(),         //'주민등록번호'
                telNo               : $('#telNo').val(),              //'연락처'
                zipNo               : $('#zipNo').val(),              //'우편번호'
                addrOffice          : $('#addrOffice').val(),         //'기본주소'
                addrOfficeDtl       : $('#addrOfficeDtl').val(),      //'상세주소'
                bankCd              : $('#bankCd').val(),             //'은행코드'
                accontNo            : $('#accontNo').val(),           //'계좌번호'
                viewBizcoYn         : $("input:checkbox[id=viewBizcoYn]").is(":checked")==true?'N':'Y',           //'사업자번호 노출여부'
            };
            const response = await MyAjax.execute('${CONTEXT_PATH}/member/update.json', memberVO, {
                autoResultFunctionTF: false,
                type: "POST"
            });
            if (!_.startsWith(response.code, 'S')) {
                swal({
                    title: response.message,
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                });
                return;
            }
            swal({
                title: '수정 완료',
                text: '',
                type: 'success',
                timer: 1000,
                showConfirmButton: false,
            }, function() {
                MyCommon.goLink('/member/mypage.view');
            });
        }

        async function memberPassword() {
            const p1 = $('#u_memberPassword').val();
            const p2 = $('#u_memberPassword_2').val()

            if (p1.length < 6 || p2.length < 6) {
                swal({
                    title: '비밀번호를 6자리 이상 입력해주세요.',
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                }, function() {
                    $('#u_memberPassword').focus();
                });
                return;
            }

            if (p1 != p2) {
                swal({
                    title: '입력하신 비밀번호가 일치하지 않습니다.',
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                }, function() {
                    $('#u_memberPassword').focus();
                });
                return;
            }

            const memberVO = {
                customerId      : $('#customerId').val(),         //'회원ID'
                memberPassword  : CryptoJS.SHA512(p1).toString(), //'계약서관리비밀번호'
            };

            const response = await MyAjax.execute('${CONTEXT_PATH}/member/updatePassword.json', memberVO,  {
                autoResultFunctionTF: false,
                type: "POST"
            });
            if (!_.startsWith(response.code, 'S')) {
                swal({
                    title: response.message,
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                });
                return;
            }
            $('#memberPasswordModal').modal('hide');
            swal({
                title: '변경 완료',
                type: 'success',
                timer: 1000,
                showConfirmButton: false,
            });
        }

        async function appPassword() {
            const p1 = $('#u_appPassword').val();
            const p2 = $('#u_appPassword_2').val()

            if (p1.length < 4 || p2.length < 4) {
                swal({
                    title: '비밀번호를 4자리로 입력해주세요.',
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                }, function() {
                    $('#u_appPassword').focus();
                });
                return;
            }

            if (p1 != p2) {
                swal({
                    title: '입력하신 비밀번호가 일치하지 않습니다.',
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                }, function() {
                    $('#u_appPassword').focus();
                });
                return;
            }

            const memberVO = {
                customerId      : $('#customerId').val(),         //'회원ID'
                appPassword     : p1,                             //'앱비밀번호'
            };

            const response = await MyAjax.execute('${CONTEXT_PATH}/member/updatePassword.json', memberVO,  {
                autoResultFunctionTF: false,
                type: "POST"
            });
            if (!_.startsWith(response.code, 'S')) {
                swal({
                    title: response.message,
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                });
                return;
            }
            $('#appPasswordModal').modal('hide');
            swal({
                title: '변경 완료',
                type: 'success',
                timer: 1000,
                showConfirmButton: false,
            });
        }

        function maxLengthCheck(object){
            if (object.value.length > object.maxLength){
                object.value = object.value.slice(0, object.maxLength);
            }
        }

        // android bridge : closeLayer
        function closeLayer() {
            if (layerId == 'daumPost') {
                // postSearch
                closeDaumPostcode();
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

        function getAppVersion() {
            if (MyCommon.isApp()) {
                return window.SignatureApp.getAppVersion();
            } else {
                return 'web';
            }
        }
    </script>

    <!-- global -->
    <script>
    var layerId = '';
    </script>

    <!-- Plugin 실행 -->
    <script src="${CommonCode.PATH_PLUGIN}/crypto/crypto-js.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Jquery Validate -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/validate/jquery.validate.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Input Mask-->
    <script src="${CommonCode.PATH_PLUGIN}/common/input-mask.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- 다음 주소 API -->
    <script defer src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <!-- Plugin 실행 -->
    <script>
    $('#daumPost').on('show.bs.modal', function (e) {
        setIsLayer(true);
        layerId = 'daumPost';
    });
    $('#daumPost').on('hidden.bs.modal', function (e) {
        setIsLayer(false);
        layerId = '';
    });
    // modal trigger
    $('#memberPasswordModal').on('show.bs.modal', function (e) {
        setIsLayer(true);
        layerId = 'memberPasswordModal';
    });
    $('#appPasswordModal').on('show.bs.modal', function (e) {
        setIsLayer(true);
        layerId = 'appPasswordModal';
    });
    $('#memberPasswordModal').on('hidden.bs.modal', function (e) {
        setIsLayer(false);
        layerId = '';
    });
    $('#appPasswordModal').on('hidden.bs.modal', function (e) {
        setIsLayer(false);
        layerId = '';
    });

    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        var element_layer = document.getElementById('daumPost');
        element_layer.style.display = 'none';
        MyModal.close($('#daumPost'));
    }

    function postCodeSearch() {
        MyModal.open($('#daumPost'));

        // 우편번호 찾기 화면을 넣을 element
        var element_layer = document.getElementById('daumPost');

        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    // document.getElementById("sample6_extraAddress").value = extraAddr;

                } else {
                    // document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipNo').value = data.zonecode;
                document.getElementById("addrOffice").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addrOfficeDtl").focus();

                // element_layer.style.display = 'none';
                MyModal.close($('#daumPost'));
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);
    }
    </script>

    <script>
    $(document).ready(function() {
        $('#form').validate({
            invalidHandler: function (form, validator) {
                if (validator.numberOfInvalids()) {
                    validator.errorList[0].element.focus();
                }
            },
            errorPlacement: function(error, element) {
                element.before(error);
            },
            rules: {
                telNo: {required: true},
                bizcoRegNo: {required: true, bizcoRegNo: true, rangelength:[12,12]},
                // zipNo: {required: true},
                addrOffice: {required: true},
                addrOfficeDtl: {required: true},
            },
            messages: {
                telNo: {required: '연락처를 유효하지 않습니다..'},
                bizcoRegNo: {required: '사업자등록번호를 입력해주세요.', bizcoRegNo: '사업자등록번호를 입력해주세요.', rangelength: '사업자등록번호를 입력해주세요.'},
                // zipNo: {required: '우편번호를 입력해주세요.'},
                addrOffice: {required: '주소를 입력해주세요.'},
                addrOfficeDtl: {required: '상세주소를 입력해주세요.'},
            }
        });
    });
    </script>
    <script data-for="ready">
    jQuery(($) => {
        const memberVO = JSON.parse($('#memberVO').val());
        // 은행코드 선택하기
        $('#bankCd').val(memberVO.bankCd).prop("selected", true);

        // 앱 버전 표기
        <c:if test="${isAdmin == null}">
        $('#appVersion').text(getAppVersion());
        </c:if>

        $('#join').on('click', (event) => {
            event.preventDefault();
            join();
        });

        // 계정 관리 패스워드 변경
        $('#updateMemberPassword').on('click', (event) => {
            event.preventDefault();
            memberPassword();
        });

        // 앱 로그인 패스워드 변경
        $('#updateAppPassword').on('click', (event) => {
            event.preventDefault();
            appPassword();
        });

        $('#postSearch').on('click', (event) => {
            event.preventDefault();
            postCodeSearch();
        });

        new InputMask().Initialize(document.querySelectorAll("#telNo"), {mask: InputMaskDefaultMask.Phone});
        new InputMask().Initialize(document.querySelectorAll("#nationIdNo"), {mask: InputMaskDefaultMask.Ssn});
        new InputMask().Initialize(document.querySelectorAll("#bizcoRegNo"), {mask: InputMaskDefaultMask.Biz});
    });
    </script>
</my:html>
