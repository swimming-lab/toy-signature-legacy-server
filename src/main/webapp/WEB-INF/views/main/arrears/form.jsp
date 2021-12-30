<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES">
    <div class="ibox-title topFixed">
        <a href="javascript:MyCommon.goBack()"><i class="fa fa-arrow-left fa-2x"></i></a>
        <h5 style="font-size: 18px;font-family: yg-jalnan;">체불신고</h5>
    </div>
    <div class="wrapper wrapper-content animated fadeIn" style="margin:35px 15px 0 15px">
        <div class="widget red-bg p-sm-0 text-left">
            <h3 class="font-bold" style="letter-spacing: 1.5px">
                체불신고를 하면 계약서 작성 시,<br>
                 체불 이력이 있는 업체일 경우<br>
                주의 알림을 받으실 수 있습니다.
            </h3>
        </div>
        <div>
            <div class="text-right"><a id="list" class="btn btn-danger btn-rounded btn-outline" href="#">체불신고 현황보기</a></div>
            <form id="form">
                <div class="form-group">
                    1. 체불자이름 (필수)
                    <input id="arrearsNm" name="arrearsNm" type="text" class="form-control" placeholder="체불자 이름을 입력하세요" required="true" value="${arrearsVO.arrearsNm}" maxlength="30" required>
                </div>
                <div class="form-group">
                    2. 상호 (필수)
                    <input id="bizcoNm" name="bizcoNm" type="text" class="form-control" placeholder="상호명을 입력하세요" required="true" value="${arrearsVO.bizcoNm}" maxlength="30" required>
                </div>
                <div class="form-group">
                    3. 사업자등록번호 (필수)
                    <input id="bizcoRegNo" name="bizcoRegNo" type="tel" class="form-control" placeholder="숫자만 입력하세요" maxlength="12" value="${arrearsVO.bizcoRegNo}" required>
                </div>
                <div class="form-group">
                    4. 체불기간 (필수)
                    <div style="display: inline-flex">
                        <input id="workStartDy" type="tel" class="form-control" placeholder="년/월/일" maxlength="11" style="width: 50%" value="${arrearsVO.workStartDy}">
                        <input id="workEndDy" type="tel" class="form-control" placeholder="년/월/일" maxlength="11" style="width: 50%" value="${arrearsVO.workEndDy}">
                    </div>
                </div>
                <div class="form-group">
                    5. 회사전화 (필수)
                    <input id="officeNo" name="officeNo" type="tel" class="form-control" placeholder="연락처" maxlength="14" value="${arrearsVO.officeNo}" required>
                </div>
                <div class="form-group">
                    6. 연락처 (선택)
                    <input id="telNo" type="tel" class="form-control" placeholder="체불자 연락처를 입력하세요" maxlength="13" value="${arrearsVO.telNo}">
                    <input id="addTelNo" type="tel" class="form-control" placeholder="추가 연락처가 있다면 입력하세요" maxlength="13" value="${arrearsVO.addTelNo}">
                </div>
                <div class="form-group">
                    7. 피해금액 (필수)
                    <input id="arrearsAmt" type="tel" class="form-control" placeholder="피해금액을 입력해주세요" value="${arrearsVO.arrearsAmt}" maxlength="13" required>
                </div>
                <div class="form-group">
                    8. 현장명 (필수)
                    <input id="workNm" name="workNm" type="text" class="form-control" placeholder="현장명을 입력하세요" required="true" value="${arrearsVO.workNm}" maxlength="30" required>
                </div>
                <div class="form-group">
                    9. 현장소재지 (필수)
                    <input id="workLocNm" name="workLocNm" type="text" class="form-control" placeholder="현장소재지를 입력하세요" required="true" value="${arrearsVO.workLocNm}" maxlength="30" required>
                </div>
                <div class="form-group">
                    10. 그 외 상세 내용 (선택)
                    <textarea id="arrearsConts" type="text" class="form-control" placeholder="입력항목에 없는 내용은 여기에 입력해주세요" maxlength="120" rows="4">${arrearsVO.arrearsConts}</textarea>
                </div>
                <c:choose>
                    <c:when test="${formType == CommonCode.ARREARS_FORM_TYPE_NEW}">
                        <button id="save" type="button" class="btn btn-danger block full-width m-b">신고하기</button>
                    </c:when>
                    <c:otherwise>
                        <button id="update" type="button" class="btn btn-danger block full-width m-b">수정하기</button>
                    </c:otherwise>
                </c:choose>
            </form>
        </div>
    </div>

    <div>
        <input id="arrearsId"type="hidden" value="${arrearsVO.arrearsId}">
    </div>

    <my:footer/>
    <!-- Jquery Validate -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/validate/jquery.validate.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Input Mask-->
    <script src="${CommonCode.PATH_PLUGIN}/common/input-mask.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>

    <!-- global -->
    <script>
    var id = '';
    </script>
    <!-- ready -->
    <script data-for="ready">
        jQuery(($) => {
            $('#save').on('click', (event) => {
                event.preventDefault();
                save();
            });

            $('#update').on('click', (event) => {
                event.preventDefault();
                update();
            });

            $('#list').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/arrears/list.view');
            });

            // 전화번호 입력 클릭 시 주소록 앱 호출
            $('#telNo, #addTelNo').on('click', (event) => {
                if (MyCommon.isApp()) {
                    swal({
                        title: '주소록을 호출하겠습니까?',
                        showCancelButton: true,
                        cancelButtonText: '취소',
                        confirmButtonText: '확인',
                        customClass: 'custom-small-title'
                    }, function (isConfirm) {
                        console.log(isConfirm);
                        if (isConfirm) {
                            id = event.currentTarget.id;
                            MyCommon.goContact();
                        } else {
                            id = event.currentTarget.id;
                            $('#' + id).focus();
                        }
                    });
                }
            });

            new InputMask().Initialize(document.querySelectorAll("#telNo"), {mask: InputMaskDefaultMask.Phone});
            new InputMask().Initialize(document.querySelectorAll("#addTelNo"), {mask: InputMaskDefaultMask.Phone});
            new InputMask().Initialize(document.querySelectorAll("#bizcoRegNo"), {mask: InputMaskDefaultMask.Biz});
            new InputMask().Initialize(document.querySelectorAll("#workStartDy"), {mask: InputMaskDefaultMask.DateKo});
            new InputMask().Initialize(document.querySelectorAll("#workEndDy"), {mask: InputMaskDefaultMask.DateKo});
        });
    </script>

    <!-- function -->
    <script>
        async function save() {
            if (!$('#form').valid()) {
                return false;
            }
            const arrearsVO = {
                arrearsNm: $('#arrearsNm').val(),
                bizcoNm: $('#bizcoNm').val(),
                bizcoRegNo: $('#bizcoRegNo').val(),
                workStartDy: $('#workStartDy').val(),
                workEndDy: $('#workEndDy').val(),
                officeNo: $('#officeNo').val(),
                telNo: $('#telNo').val(),
                addTelNo: $('#addTelNo').val(),
                arrearsAmt: $('#arrearsAmt').val(),
                workNm: $('#workNm').val(),
                workLocNm: $('#workLocNm').val(),
                arrearsConts: $('#arrearsConts').val(),
            };

            const response = await MyAjax.execute('${CONTEXT_PATH}/arrears/save.json', arrearsVO, {
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
                title: '체불신고가 접수되었습니다.',
                type: 'success',
                timer: 1000,
                showConfirmButton: false,
            }, function() {
                MyCommon.goLink('/main/main.view')
            });
        }

        async function update() {
            if (!$('#form').valid()) {
                return false;
            }

            const arrearsVO = {
                arrearsId: $('#arrearsId').val(),
                arrearsNm: $('#arrearsNm').val(),
                bizcoNm: $('#bizcoNm').val(),
                bizcoRegNo: $('#bizcoRegNo').val(),
                workStartDy: $('#workStartDy').val(),
                workEndDy: $('#workEndDy').val(),
                officeNo: $('#officeNo').val(),
                telNo: $('#telNo').val(),
                addTelNo: $('#addTelNo').val(),
                arrearsAmt: $('#arrearsAmt').val(),
                workNm: $('#workNm').val(),
                workLocNm: $('#workLocNm').val(),
                arrearsConts: $('#arrearsConts').val(),
            };

            const response = await MyAjax.execute('${CONTEXT_PATH}/arrears/save.json', arrearsVO, {
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
                title: '체불신고가 수정되었습니다.',
                type: 'success',
                timer: 1000,
                showConfirmButton: false,
            }, function() {
                history.back();
                // MyCommon.goLink('/main/main.view')
            });
        }

        function setPhoneNumber(phone) {
            $('#' + id).val(MyCommon.formatPhoneNumber(phone));
        }
    </script>

    <!-- plugin -->
    <script>
    $('#form').validate({
        invalidHandler: function (form, validator) {
            if (validator.numberOfInvalids()) {
                validator.errorList[0].element.focus();
            }
        },
        errorPlacement: function(error, element) {
            // if (element.attr("name") == "insuranceYn")
            //     $(".insuranceYn").after(error);
            // else if (element.attr("name") == "routineYn")
            //     $(".routineYn").after(error);
            // else
                element.before(error);
        },
        rules: {
            arrearsNm: {required: true},
            bizcoNm: {required: true},
            bizcoRegNo: {required: true},
            workStartDy: {required: false},
            workEndDy: {required: false},
            officeNo: {required: true},
            telNo: {required: false},
            addTelNo: {required: false},
            arrearsAmt: {required: true},
            workNm: {required: true},
            workLocNm: {required: true},
            arrearsConts: {required: false},
        },
        messages: {
            arrearsNm: {required: '체불자 이름을 입력해주세요.'},
            bizcoNm: {required: '상호명을 입력해주세요.'},
            bizcoRegNo: {required: '사업자등록번호 입력해주세요.'},
            officeNo: {required: '회사전화를 입력해주세요.'},
            workNm: {required: '현장명을 입력해주세요.'},
            workLocNm: {required: '현장소재지를 입력해주세요.'},
        }
    });
    </script>
</my:html>
