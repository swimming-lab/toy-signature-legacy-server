<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES">
    <div class="ibox-title topFixed">
        <a href="javascript:MyCommon.goBack();"><i class="fa fa-arrow-left fa-2x"></i></a>
        <h5 style="font-size: 18px;font-family: yg-jalnan;">뒤로가기</h5>
    </div>
    <div id="scrollx" style="overflow-x: auto;margin-top:58px">
        <div id="contractView" style="display: none"></div>
        <div id="contractImage" style="border: 2px solid;width: 650px;height:100%;margin: 0 auto;background-color: #fff;">
            <div style="width: 80%;text-align: center;font-size: 30px;font-weight: bold;display: inline-block;line-height: 80px;vertical-align: top">
                건설기계임대차 표준계약서
                <span style="font-size:20px">(작업확인서)</span>
            </div>
            <div style="display: inline-block;text-align: center">
                <div>
                    <img src="/resources/publish/img/FTC_logo.jpg" width="100"/>
                </div>
                <div style="font-size: 11px;margin-top:-5px">표준약관 제100059호</div>
            </div>
            <div style="border-top: 2px solid;border-bottom:2px solid;padding: 10px;">
                <div style="font-size: 17px;font-weight: bold;">1.목적물의 표시
                    <span style="font-size: 12px"> - 가. 건설기계</span>
                </div>
                <table width="100%" border="1" align="center">
                    <tr align="center">
                        <td width="26%">건설기계명</td>
                        <td width="20%">등록번호</td>
                        <td width="20%">형식</td>
                        <td width="17%">보험(공제)가입현황</td>
                        <td width="17%">정기검사여부</td>
                    </tr>
                    <tr align="center" height="50">
                        <td>${contractVO.equipNm}</td>
                        <td>${contractVO.registNo}</td>
                        <td>${contractVO.equipModel}</td>
                        <c:choose>
                            <c:when test="${contractVO.insuranceYn == 'Y'}">
                                <td>가입</td>
                            </c:when>
                            <c:otherwise>
                                <td>미가입</td>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${contractVO.routineYn == 'Y'}">
                                <td>가입</td>
                            </c:when>
                            <c:otherwise>
                                <td>미가입</td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                </table>
                <div style="font-size: 12px;font-weight: bold;margin-top:5px">나. 현장</div>
                <table width="100%" border="1" align="center">
                    <tr align="center">
                        <td width="27%">현장명</td>
                        <td width="37%">현장소재지</td>
                        <td width="18%">발급자(원청사)</td>
                        <td width="18%">건설업체(임차인)</td>
                    </tr>
                    <tr align="center" height="50">
                        <td>${contractVO.workNm}</td>
                        <td>${contractVO.workLocNm}</td>
                        <td>${contractVO.issuerNm}</td>
                        <td>${contractVO.builderNm}</td>
                    </tr>
                </table>
                <div style="margin-top:10px">
                    <div style="font-size: 17px;font-weight: bold;">2.사용기간</div>
                    <div style="padding-left:18px;font-size: 15px">
                            ${fn:split(contractVO.workDy, '/')[0]}년
                        <span style="font-size: 17px">${fn:split(contractVO.workDy, '/')[1]}</span>
                        월
                        <span style="font-size: 17px">${fn:split(contractVO.workDy, '/')[2]}</span>
                        일

                        <span style="font-size: 17px">${fn:split(contractVO.workStartTime, ':')[0]}</span>
                        시
                        <span style="font-size: 17px">${fn:split(contractVO.workStartTime, ':')[1]}</span>
                        분 ~
                        <span style="font-size: 17px">${fn:split(contractVO.workEndTime, ':')[0]}</span>
                        시
                        <span style="font-size: 17px">${fn:split(contractVO.workEndTime, ':')[1]}</span>
                        분까지(
                        <span style="font-size: 17px">${koCompareTime}</span>
                        )
                    </div>
                </div>
                <div style="margin-top:10px">
                    <div style="font-size: 17px;font-weight: bold;">3.사용금액 :
                        <c:choose>
                            <c:when test="${not empty contractVO.useAmt}">
                                <span style="font-size:16px;font-weight: normal;">당금 ${koAmt}원(<fmt:formatNumber value="${contractVO.useAmt}" pattern="#,###" />원)</span>
                            </c:when>
                            <c:otherwise>
                                <span style="font-size:16px;font-weight: normal;">입력안함</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <table width="100%" border="1" align="center">
                        <tr height="80">
                            <td width="10%" align="center">작 업
                                <br>
                                내 용
                            </td>
                            <td style="padding:5px">
                                    ${contractVO.workConts}
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="margin-top:10px">
                    <div style="font-size: 17px;font-weight: bold;">4.지급시기
                        <span style="font-size:16px;font-weight: normal;">(제6조 제2항이 적용되지 않는 경우 적용)</span>
                    </div>
                    <div style="font-size:11px;">대여기간이 1개월 초과하는 경우에는 매월 종료하는 날부터
                        <span style="font-size: 15px">${contractVO.paydayOverNo}</span>
                        일 이내,
                        대여기간이 1개월 이하인 경우에는 그 기간이 종료하는 날부터
                        <span style="font-size: 15px">${contractVO.paydayInNo}</span>
                        일 이내
                    </div>
                </div>
            </div>
            <div>
                <div style="font-size:11px;padding: 8px 50px;letter-spacing: 0.3px;">
                    건설기계임대인과 건설기계임차인은 합의에 따라 붙임서류에 의하여 계약을 체결하고, 신의에 따라 성실히 계약상의 의무를 이행할 것을 확약하며, 이 계약의 증거로 계약서를 2통 작성하여 서명, 날인 후 각 1부씩 보관한다.
                    <br>
                    ※ 붙임서류 : 1.건설기계임대차 표준계약 일반조건 1부, 2.건설기계임대차 계약 특수조건 1부(필요시)
                </div>
                <div style="text-align: center;font-size: 17px;font-weight: bold;letter-spacing: 1px">계약 및 작업일 : ${fn:split(contractVO.workDy, '/')[0]}년 ${fn:split(contractVO.workDy, '/')[1]}월 ${fn:split(contractVO.workDy, '/')[2]}일</div>
                <div style="padding:10px">
                    <div style="font-size: 17px;font-weight: bold;">※ 임대인
                        <span style="font-size: 16px">(건설기계 사업자)</span>
                    </div>
                    <table width="100%" border="1" align="center">
                        <tr align="center">
                            <c:choose>
                                <c:when test="${viewBizcoYn == 'N'}">
                                    <td width="15%">상호</td>
                                    <td colspan="3" class="text-left" style="padding-left:7px">${memberVO.bizcoNm}</td>
                                </c:when>
                                <c:otherwise>
                                    <td width="15%">상호</td>
                                    <td width="35%">${memberVO.bizcoNm}</td>
                                    <td width="15%">사업자등록번호</td>
                                    <td width="35%">${memberVO.bizcoRegNo}</td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                        <tr align="center">
                            <td width="15%">성명</td>
                            <td width="35%">${memberVO.name} (조종사 : ${contractVO.agentNm})</td>
                            <td width="15%">연락처</td>
                            <td width="35%">${memberVO.telNo}</td>
                        </tr>
                        <tr align="center">
                            <td width="15%">주소</td>
                            <td colspan="3" align="left" style="padding-left:7px">${memberVO.addrOffice} ${memberVO.addrOfficeDtl}</td>
                        </tr>
                    </table>
                    <div style="font-size: 17px;font-weight: bold;margin-top:5px">※ 임차인
                        <span style="font-size: 16px">(건설업자 및 현장)</span>
                    </div>
                    <table width="100%" border="1" align="center">
                        <tr align="center">
                            <td width="15%">상호</td>
                            <td width="35%">${contractHireVO.bizcoNm}</td>
                            <td width="15%">사업자등록번호</td>
                            <td width="35%">${contractHireVO.bizcoRegNo}</td>
                        </tr>
                        <tr align="center">
                            <td width="15%">성명/연락처</td>
                            <td width="35%">${contractHireVO.name} <c:if test="${contractHireVO.telNo != null && contractHireVO.telNo != ''}">(${contractHireVO.telNo})</c:if></td>
                            <td width="15%">현장대리인</td>
                            <td width="35%">${contractHireVO.workAgentNm} (${contractHireVO.workAgentTelNo})</td>
                        </tr>
                        <tr align="center">
                            <td width="15%">주소</td>
                            <td colspan="3" align="left" style="padding-left:7px">${contractHireVO.addrOffice} ${contractHireVO.addrOfficeDtl}</td>
                        </tr>
                    </table>
                    <div style="text-align: center;font-size: 17px;vertical-align: bottom;margin-top: 10px;">
                        현장대리인 : ${contractHireVO.workAgentNm}
                        <span>
                        <!--이미지는 샘플로 넣은거니 맞춰서 넣으면 되요-->
                        <img src="${contractSignVO.signature}" width="130">
                    </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="contractNo" type="hidden" value="${contractVO.contractNo}">
    <c:choose>
        <c:when test="${contractVO.contractSt == CommonCode.CONTRACT_ST_ING}">
            <div style="position: fixed;bottom: 0;width: 100%;display: inline-flex;padding:0 30px;">
                <button id="update" type="button" class="btn btn-warning block  m-b">계약서 수정</button>
                <button id="complete" type="button" class="btn btn-success block  m-b" style="margin-left: 30px">확정 및 계약서 문자전송</button>
            </div>
        </c:when>
        <c:otherwise>
            <div id="test" style="position: fixed;bottom: 0;width: 100%;display: inline-flex;padding:0 10px;">
                <button id="copy" type="button" class="btn btn-warning block m-b">계약서 복사&작성</button>
                <button onclick="contractSave()" type="button" class="btn btn-warning block m-b" style="margin-left: 10px;">휴대폰에 저장</button>
                <button id="sms" type="button" class="btn btn-success block m-b" style="margin-left: 10px">문자전송</button>
            </div>
        </c:otherwise>
    </c:choose>

    <script data-for="ready">
    jQuery(($) => {
        $('#update').on('click', (event) => {
            event.preventDefault();
            MyCommon.goLink('/contract/updateForm.view?contractNo=' + $('#contractNo').val());
            return false;
        });

        $('#complete').on('click', (event) => {
            event.preventDefault();
            complete();
        });

        $('#sms').on('click', (event) => {
            event.preventDefault();
            MyCommon.goLink('/contract/sms.view?contractNo=' + $('#contractNo').val());
            return false;
        });

        $('#copy').on('click', (event) => {
            event.preventDefault();
            MyCommon.goLink('/contract/insertForm.view?contractNo=' + $('#contractNo').val());
            return false;
        });
        //이미지 처리
        MyCommon.loadingBar(true);
        $('html').scrollTop(0);
        $('#scrollx').css({'overflowX': 'visible'});
        $('#contractImage').css('width','650px');
        html2canvas($("#contractImage"), {
            onrendered: async function(canvas) {
                imgPath = canvas.toDataURL("image/png");
                $('#contractImage').hide();
                $('#contractView').show();
                $('#contractView').html("<img id='contract' style='width:100%' src='"+imgPath+"'>");
                MyCommon.loadingBar(false);
            }
        });

    });
    </script>
    <script>
    async function complete() {

        const param = {
            contractNo: $('#contractNo').val(),
            imgPath: $("#contract").attr("src")
        }

        const response = await MyAjax.execute('${CONTEXT_PATH}/contract/complete.json', param, {
            autoResultFunctionTF: false,
            type: "POST"
        });
        if (!_.startsWith(response.code, 'S')) {
            swal({
                title: response.message,
                showCancelButton: false,
                confirmButtonText: '확인',
                customClass: 'custom-small-title'
            }, () => {
                if (response.code == 'F033') {
                    window.location.reload();
                }
            });
            return;
        }
        MyCommon.goLink('/contract/sms.view?contractNo=' + response.contractNo);
    }

    function contractSave() {
        // var blob = dataURLtoBlob($("#contract").attr("src"));
        var file = $("#contract").attr("src");
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

    function dataURLtoBlob(dataurl) {
        var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1],
            bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
        while(n--){
            u8arr[n] = bstr.charCodeAt(n);
        }
        return new Blob([u8arr], {type:mime});
    }
    </script>

    <!-- File Saver -->
    <script src="${CommonCode.PATH_PLUGIN}/htmlToImage/FileSaver.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <script src="${CommonCode.PATH_PLUGIN}/htmlToImage/html2canvas.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>
</my:html>
