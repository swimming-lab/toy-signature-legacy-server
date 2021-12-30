<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES" modal="YES" step="YES">
<div class="animated fadeIn">
    <div class="ibox-title topFixed">
        <a href="javascript:MyCommon.goBack();"><i class="fa fa-arrow-left fa-2x"></i></a>
        <h5 style="font-size: 18px;font-family: yg-jalnan;">회원가입(정보입력)</h5>
    </div>
    <div style="padding:10px;margin-top:58px" class="topFixed-body">
        <form id="form">
        <div class="row">
            <div class="col-lg-8">
                <div class="form-group">
                    <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">이름</label>
                    <input id="name" name="name" type="text" class="form-control required" style="height: 45px;">
                </div>
                <div class="form-group">
                    <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">핸드폰번호 <span style="font-size: 13px">(이 번호로 계약서가 발송됩니다.)</span></label>
                    <input id="telNo" name="telNo" type="tel" class="form-control required" maxlength="13" placeholder="숫자만 입력해주세요." style="height: 45px;">
                    <input id="nationIdNo" name="nationIdNo" type="hidden" >
                </div>
                <!--
                <div class="form-group">
                    <label>주민등록번호</label>
                    <input id="nationIdNo" name="nationIdNo" type="tel" class="form-control required" maxlength="14" placeholder="숫자만 입력해주세요.">
                </div>
                -->
                <div class="form-group">
                    <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">상호</label>
                    <input id="bizcoNm" name="bizcoNm" type="text" class="form-control required" style="height: 45px;">
                </div>
                <div class="form-group">
                    <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">사업자등록번호</label>
                    <input id="bizcoRegNo" name="bizcoRegNo" type="tel" class="form-control required" maxlength="12" placeholder="숫자만 입력해주세요." style="height: 45px;">
                </div>
                <div class="form-group">
                    <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">사업장 주소</label>
                    <div class="input-group" style="margin-bottom: 5px">
                        <input id="zipNo" name="zipNo" type="tel" class="form-control" readonly>
                        <div id="postSearch" class="input-group-append">
                            <span class="input-group-addon">우편번호 검색</span>
                        </div>
                    </div>
                    <input id="addrOffice" name="addrOffice" type="text" class="form-control required" style="margin-bottom: 5px">
                    <input id="addrOfficeDtl" name="addrOfficeDtl" type="text" class="form-control required">

                    <input id="bankCd" name="bankCd" type="hidden" value="">
                    <input id="accontNo" name="accontNo" type="hidden" value="">
                </div>
                <!--
                <div class="form-group">
                    <label style="margin-bottom:.2rem">은행 *</label>
                    <select id="bankCd" name="bankCd" class="form-control required" name="account">
                        <option disabled selected hidden>선택</option>
                        <option value="01">하나은행</option>
                        <option value="02">국민은행</option>
                        <option value="03">우리은행</option>
                        <option value="04">신한은행</option>
                        <option value="05">기업은행</option>
                        <option value="06">농협</option>
                        <option value="07">산업은행</option>
                        <option value="08">수협중앙회</option>
                        <option value="09">한국시티은행</option>
                        <option value="10">SC제일은행</option>
                        <option value="11">우체국</option>
                        <option value="12">케이뱅크</option>
                        <option value="13">카카오뱅크</option>
                        <option value="14">산림조합</option>
                        <option value="15">저축은행</option>
                        <option value="16">새마을금고</option>
                        <option value="17">신협</option>
                        <option value="18">대구은행</option>
                        <option value="19">부산은행</option>
                        <option value="20">경남은행</option>
                        <option value="21">광주은행</option>
                        <option value="22">전북은행</option>
                        <option value="23">제주은행</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>계좌번호 *</label>
                    <input id="accontNo" name="accontNo"  placeholder="(-) 빼고 숫자만 입력해주세요." type="text" class="form-control required">
                </div>
            </div>
            <div class="col-lg-4">
                <div class="text-center">
                    <div style="margin-top: 20px">
                    </div>
                </div>
            </div>
            -->
            <div class="form-group">
                <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">앱 로그인 비밀번호 (숫자 4자리를 입력하세요)</label>
                <div class="col-lg-12 text-center">
                    <div class="form-group" style="display: inline-flex;margin-top:10px">
                        <input type="number" id="password1" onkeyup="passwordSet(this,'','2',event)" maxlength="1" oninput="maxLengthCheck(this)" style="width: 40px;height: 45px;margin: 0 10px;border: 0;font-size: 20px;border-bottom: 2px solid;text-align: center;"/>
                        <input type="number" id="password2" onkeyup="passwordSet(this,'1','3',event)" maxlength="1" oninput="maxLengthCheck(this)" style="width: 40px;height: 45px;margin: 0 10px;border: 0;font-size: 20px;border-bottom: 2px solid;text-align: center;"/>
                        <input type="number" id="password3" onkeyup="passwordSet(this,'2','4',event)" maxlength="1" oninput="maxLengthCheck(this)" style="width: 40px;height: 45px;margin: 0 10px;border: 0;font-size: 20px;border-bottom: 2px solid;text-align: center;"/>
                        <input type="number" id="password4" onkeyup="passwordSet(this,'3','OK',event)" maxlength="1" oninput="maxLengthCheck(this)" style="width: 40px;height: 45px;margin: 0 10px;border: 0;font-size: 20px;border-bottom: 2px solid;text-align: center;"/>
                        <input id="appPassword" name="appPassword" type="hidden">
                    </div>
                </div>
                <!--
                <input id="appPassword" name="appPassword" type="number" pattern="[0-9]*" maxlength="4" inputmode="numeric" oninput="maxLengthCheck(this)" placeholder="숫자 4자리를 입력해주세요." class="form-control required" style="-webkit-text-security:disc;">
                <label class="font-bold" style="margin-bottom:.2rem">앱 로그인 비밀번호 확인 *</label>
                <input id="appPassword_2" name="appPassword_2" type="number" pattern="[0-9]*" maxlength="4" inputmode="numeric" oninput="maxLengthCheck(this)" placeholder="숫자 4자리를 다시한번 입력해주세요." class="form-control required" style="-webkit-text-security:disc;">
                -->
            </div>
            <div class="form-group">
                <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">관리자전용(계약서관리) 비밀번호 *</label>
                <input id="memberPassword" name="memberPassword" type="password" minlength="6" maxlength="12"  placeholder="6-12자리의 비밀번호를 입력해주세요." class="form-control required" style="height: 45px;">
                <label class="font-bold" style="margin-bottom:.2rem;font-size: 15px;">관리자전용(계약서관리) 비밀번호 확인 *</label>
                <input id="memberPassword_2" name="memberPassword_2" type="password" minlength="6" maxlength="12" placeholder="6-12자리의 비밀번호를 다시한번 입력해주세요." class="form-control required" style="height: 45px;">
            </div>
            <div id="join" style="width: 100%;height: 50px;text-align: center;background: #ffc107;color: #fff;line-height: 50px;font-size: 18px;font-weight: bold;margin-top: 30px;">
                가입하기
            </div>
                <div style="text-align: center;margin-top: 25px">고객센터 031-986-5527</div>
        </div>
        </form>
    </div>
</div>

    <div id="daumPost" class="modal" style="display: none">
        <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
    </div>

    <!-- function -->
    <script>
    async function join() {
        // if (MyValidator.validate($('#joinForm'), true) !== null) {
        //     return;
        // }
        if (!$('#form').valid()) {
            return false;
        };

        if($('#password1').val() == '' || $('#password2').val() == '' || $('#password3').val() =='' || $('#password4').val() ==''){
            $('#password1').focus();
            swal({
                title: '앱 로그인 비밀번호를 모두 입력하세요.',
                showCancelButton: false,
                confirmButtonText: '확인',
                customClass: 'custom-small-title'
            });
            return false;
        }else{
            $('#appPassword').val($('#password1').val()+$('#password2').val()+$('#password3').val()+$('#password4').val());
        }

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
            appPassword         : $('#appPassword').val(),        //'앱비밀번호'
            //appPassword         : CryptoJS.SHA512($('#appPassword').val()).toString(),      //'앱비밀번호'
            memberPassword    : CryptoJS.SHA512($('#memberPassword').val()).toString(), //'계약서관리비밀번호'
        };

        const response = await MyAjax.execute('${CONTEXT_PATH}/login/joinProcess.json', memberVO,  {
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
        console.log(response);

        swal({
            title: '가입 완료',
            text: '',
            type: 'success',
            timer: 1000,
            showConfirmButton: false,
        }, function() {
            MyCommon.goLink('/main/main.view')
        });
    }

    function maxLengthCheck(object){
        if (object.value.length > object.maxLength){
            object.value = object.value.slice(0, object.maxLength);
        }
    }
    async function passwordSet(obj,prevObj,nextObj,event){
        //백스페이스 눌렀을 경우 (지우기)
        if(event.keyCode == 8){
            if(prevObj != '') {
                $('#password' + prevObj).focus();
            }
        }else {
            if (nextObj == 'OK') {
                if($('#password1').val() == '' || $('#password2').val() == '' || $('#password3').val() =='' || $('#password4').val() ==''){
                    $('#password1').focus();
                    swal({
                        title: '앱 로그인 비밀번호를 모두 입력하세요.',
                        showCancelButton: false,
                        confirmButtonText: '확인',
                        customClass: 'custom-small-title'
                    });
                    return false;
                }else{
                    $('#appPassword').val($('#password1').val()+$('#password2').val()+$('#password3').val()+$('#password4').val());
                }
            } else {
                if ($(obj).val().length == 1) {
                    $('#password' + nextObj).focus();
                }
            }
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
    </script>

    <!-- global -->
    <script>
    var layerId = '';
    </script>

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

    <!-- Plugin 실행 -->
    <script src="${CommonCode.PATH_PLUGIN}/crypto/crypto-js.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Steps -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/steps/jquery.steps.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Jquery Validate -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/validate/jquery.validate.min.js?${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Input Mask-->
    <script src="${CommonCode.PATH_PLUGIN}/common/input-mask.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- 다음 주소 API -->
    <script defer src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script>
    $.validator.addMethod('bizcoRegNo', function (value) {
        return /^((\d{3}-\d{2}-\d{5}))$/.test(value);
    });

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
                name: {required: true},
                telNo: {required: true},
                nationIdNo: {required: false},
                bankCd: {required: false},
                accontNo: {required: false},
                bizcoNm: {required: true},
                bizcoRegNo: {required: true, bizcoRegNo: true, rangelength:[12,12]},
                // zipNo: {required: true},
                addrOffice: {required: true},
                addrOfficeDtl: {required: true},
                memberPassword: {required: true},
                memberPassword_2: {equalTo: "#memberPassword"},
            },
            messages: {
                name: {required: '이름을 입력해주세요.'},
                telNo: {required: '연락처를 유효하지 않습니다..'},
                bankCd: {required: '은행을 선택해주세요.'},
                accontNo: {required: '계좌번호를 입력해주세요.'},
                bizcoNm: {required: '상호를 입력해주세요.'},
                bizcoRegNo: {required: '사업자등록번호를 입력해주세요.', bizcoRegNo: '사업자등록번호를 입력해주세요.', rangelength: '사업자등록번호를 입력해주세요.'},
                // zipNo: {required: '우편번호를 입력해주세요.'},
                addrOffice: {required: '주소를 입력해주세요.'},
                addrOfficeDtl: {required: '상세주소를 입력해주세요.'},
                memberPassword: {required: '계정 관리 비밀번호를 입력해주세요.'},
                memberPassword_2: {required: '계정 관리 비밀번호 확인을 입력해주세요.', equalTo: '계정 관리 비밀번호가 같지 않습니다.'},
            }
        });
    });
    </script>

    <!-- ready -->
    <script data-for="ready">
    jQuery(($) => {
        $('#join').on('click', (event) => {
            event.preventDefault();
            join();
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
