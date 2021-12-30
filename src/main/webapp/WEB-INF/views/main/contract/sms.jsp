<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES">
    <div  style="padding: 20px 0 ">
        <div class="text-center animated fadeIn">
            <div>
                <h2 style="font-family: yg-jalnan">계약서 전송이력</h2>
                <div style="margin-bottom: -8px">
                    <table align="center"  border="0">
                        <tr>
                            <td colspan="2">추가로 계약서를 전송할 휴대폰번호 입력하세요.</td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top">
                                <form id="smsForm">
                                <input id="tel" name="tel" type="tel" class="form-control" style="border-color: #f8ac59;width: 220px" maxlength="13" placeholder="전송할 핸드폰번호를 입력하세요." required>
                                </form>
                            </td>
                            <td>
                                <button id="sendSms" type="button" class="btn btn-warning m-b">문자 전송</button>
                            </td>
                        </tr>
                    </table>
                </div>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>전송일시</th>
                        <th>휴대폰 번호</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="sendVO" items="${contractSendHstVO}" varStatus="status">
                        <fmt:parseDate value="${sendVO.sendDt}" pattern="yyyy-MM-dd'T'HH:mm" var="dateTime" />
                        <fmt:formatDate var="parsedDateTime" pattern="yyyy-MM-dd HH:mm" value="${dateTime}" />
                        <tr>
                            <td>${parsedDateTime}</td>
                            <td>${sendVO.mobTelNo}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <button id="new" type="button" class="btn btn-outline btn-warning">계약서 추가작성</button>
                <c:choose>
                    <c:when test="${mode != null && mode == 'direct'}">
                        <button id="main" type="button" class="btn btn-outline btn-info" onclick="MyCommon.goLink('/login/main.view');">첫화면으로</button>
                    </c:when>
                    <c:otherwise>
                        <button id="main" type="button" class="btn btn-outline btn-info" onclick="MyCommon.goLink('/main/main.view');">메인으로</button>
                    </c:otherwise>
                </c:choose>
                <button onclick="contractSave()" type="button" class="btn btn-outline btn-success">휴대폰에 계약서저장</button>
            </div>
        </div>
    </div>

    <div>
        <input id="contractNo" type="hidden" value="${contractVO.contractNo}">
        <input id="imgPath" type="hidden" value="${contractImgVO.imgPath}">
    </div>

    <my:footer/>

    <!-- Input Mask-->
    <script src="${CommonCode.PATH_PLUGIN}/common/input-mask.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- File Saver -->
    <script src="${CommonCode.PATH_PLUGIN}/htmlToImage/FileSaver.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Jquery Validate -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/validate/jquery.validate.min.js${CommonCode.RESOUCE_VERSION}"></script>

    <!-- ready -->
    <script data-for="ready">
    jQuery(($) => {
        $('#new').on('click', (event) => {
            event.preventDefault();
            MyCommon.goLink('/contract/insertForm.view');
            return false;
        });

        $('#main').on('click', (event) => {
            event.preventDefault();
            MyCommon.goLink('/main/main.view');
            return false;
        });

        $('#sendSms').on('click', (event) => {
            event.preventDefault();
            sendValid();
        });

        /*
        $('#save').on('click', (event) => {
            event.preventDefault();
            const contractNo = $('#contractNo').val();
            var blob = dataURLtoBlob($('#imgPath').val());
            saveAs(blob, '임대차계약서_' + contractNo + '_' + '${contractVO.workDy}' + '.png');
        });
*/
        // 전화번호 입력 클릭 시 주소록 앱 호출
        $('#tel').on('click', (event) => {
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
                        MyCommon.goContact();
                    } else {
                        $('#tel').focus();
                    }
                });
            }
        });

        new InputMask().Initialize(document.querySelectorAll("#tel"), {mask: InputMaskDefaultMask.Phone});
    });
    </script>

    <!-- functions -->
    <script>
    function contractSave() {
        // var blob = dataURLtoBlob($("#contract").attr("src"));
        var file = $("#imgPath").val();
        // var url = URL.createObjectURL(blob);
        var fileName = '임대차계약서_' + ${contractVO.contractNo} + '_' + '${contractVO.workDy}' + '.png';

        downloadURI(file, fileName);
    }

    function downloadURI(uri, name) {
        var link = document.createElement("a");
        link.download = name;
        link.href = uri;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        delete link;
    }

    async function sendValid() {
        if (!$('#smsForm').valid()) {
            swal({
                title: '핸드폰 번호를 입력해주세요.',
                showCancelButton: false,
                confirmButtonText: '확인',
            });
            return false;
        }

        const param = {
            contractNo: $('#contractNo').val(),
            mobTelNo: $('#tel').val(),
        }

        swal({
            title: param.mobTelNo + '\n입력하신 번호로 문자가 전송됩니다.',
            showCancelButton: true,
            cancelButtonText: '취소',
            confirmButtonText: '확인',
            customClass: 'custom-small-title'
        }, function (isConfirm) {
            console.log(isConfirm);
            if (isConfirm) {
                send(param);
            }
        });
    }

    async function send(param) {
        const response = await MyAjax.execute('${CONTEXT_PATH}/contract/addSendSms.json', param, {
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
            title: '추가 문자 전송 완료',
            type: 'success',
            timer: 1000,
            showConfirmButton: false,
        }, function() {
            location.reload();
        });
    }

    function dataURLtoBlob(dataurl) {
        var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1],
            bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
        while(n--){
            u8arr[n] = bstr.charCodeAt(n);
        }
        return new Blob([u8arr], {type:mime});
    }

    function setPhoneNumber(phone) {
        $('#tel').val(MyCommon.formatPhoneNumber(phone));
    }
    </script>

    <!-- plugin -->
    <script>
    $('#smsForm').validate({
        invalidHandler: function (form, validator) {
            if (validator.numberOfInvalids()) {
                validator.errorList[0].element.focus();
            }
        },
        errorPlacement: function(error, element) {
        },
        rules: {
            tel: {required: true},
        },
        messages: {
            tel: {required: '핸드폰 번호를 입력해주세요.'},
        }
    });
    </script>
</my:html>
