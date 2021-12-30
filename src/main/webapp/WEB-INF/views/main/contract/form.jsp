<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>


<my:html cookie="YES" signaturePad="YES" handlebars="YES" modal="YES" form="YES">
    <div id="wrapper" style="height: auto !important;">
        <div class="ibox-title topFixed">
            <a href="javascript:MyCommon.goBack()"><i class="fa fa-arrow-left fa-2x"></i></a>
            <c:choose>
                <c:when test="${formType == CommonCode.FORM_TYPE_READ_ONLY}">
                    <h5 style="font-size: 18px;font-family: yg-jalnan;">계약서 보기</h5>
                </c:when>
                <c:otherwise>
                    <h5 style="font-size: 18px;font-family: yg-jalnan;">계약서 작성</h5>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="topFixed-body" style="margin-top:45px">
            <!-- 계약서 메인 -->
            <div class="wrapper wrapper-content animated fadeIn full-width">
                <form id="contractForm">
                <div class="row" >
                    <div class="col-lg-12">
                        <div class="ibox">
                            <div class="ibox-title text-left">
                                <h5>1. 목적물의 표시
                                    <small>가.건설기계, 나.현장</small>
                                </h5>
                                <div class="ibox-tools">
                                    <a class="collapse-link">
                                        <i class="fa fa-chevron-up"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content" style="padding-top:5px">
                                <!-- 건설기계 로드 -->
                                <div class="form-group row has-warning" >
                                    <c:choose>
                                        <c:when test="${mode != null && mode == 'direct'}">
                                        <label class="col-sm-2 col-form-label font-bold" style="font-size:15px"><i class="fa fa-chevron-circle-right"></i> 건설기계를 입력하세요.</label>
                                        <div class="col-sm-10">
                                            <table width="100%" border="0">
                                                <tr>
                                                    <td>장비</td>
                                                    <td class="has-warning">
                                                        <select id="direct_equipCd" name="direct_equipCd" onchange="equipSelfCheck('#direct_equipCd','#direct_modelNm')" class="form-control required" required style="height:40px">
                                                            <option disabled selected hidden>외부장비를 선택하세요</option>
                                                            <c:forEach var="equipVO" items="${comEquipMstVO}" varStatus="status">
                                                                <option value="${equipVO.equipCd}" <c:if test="${equipVO.equipCd == contractVO.equipCd}">selected="selected"</c:if> >${equipVO.equipNm}(${equipVO.equipModel})</option>
                                                            </c:forEach>
                                                        </select>
                                                        <input id="direct_modelNm" name="direct_modelNm" type="text" placeholder="모델명을 입력해주세요." style="display: none" class="form-control" value="${contractVO.equipModel}" required>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>차량번호</td>
                                                    <td class="has-warning">
                                                        <input id="registNo" name="registNo" type="text" placeholder="차량번호를 입력해주세요." class="form-control" value="${contractVO.registNo}" required>
                                                    </td>
                                                </tr>
                                            </table>
                                            <input id="equipModel" name="equipModel" type="hidden"  disabled value="${contractVO.equipModel}" style="background: #fff;border: 0;width: 70px;">
                                            <input id="equipCd" name="equipCd" type="hidden" value="${contractVO.equipCd}">
                                            <input id="insuranceYn" name="insuranceYn" type="hidden" value="Y">
                                            <input id="routineYn" name="routineYn" type="hidden" value="Y">
                                        </div>
                                        </c:when>
                                        <c:otherwise>
                                            <label class="col-sm-2 col-form-label font-bold" style="font-size:15px"><i class="fa fa-chevron-circle-right"></i> 건설기계를 선택하세요.</label>
                                            <div class="col-sm-10">
                                                <c:set var="equipIndex" value="0"/>
                                                <table width="100%" border="0">
                                                    <tr>
                                                        <td colspan="2">
                                                            <select id="equipSelect" class="form-control m-b" required>
                                                                <c:forEach var="equipVO" items="${equipVOList}" varStatus="status">
                                                                    <option value="${fn:escapeXml(Gson.toJson(equipVO))}"<c:if test="${contractVO.registNo == equipVO.registNo}">selected="selected"<c:set var="equipIndex" value="${status.index}" /></c:if>>${equipVO.equipNm}(${equipVO.equipModel}) ${equipVO.registNo}</option>
                                                                </c:forEach>
                                                                <option value="NEW">[보유 건설기계 추가등록]</option>
                                                                <option value="ETC">[타장비 직접입력]</option>
                                                            </select>
                                                            <div style="text-align: center;margin-top:-12px">
                                                                <input id="registNo" name="registNo" type="hidden" disabled value="${equipVOList[equipIndex].registNo}" required style="background: #fff;border: 0;width: 70px;">
                                                                <input id="equipModel" name="equipModel" type="hidden"  disabled value="${equipVOList[equipIndex].equipModel}" required style="background: #fff;border: 0;width: 70px;">
                                                                <input id="equipCd" name="equipCd" type="hidden" value="${equipVOList[equipIndex].equipCd}" required>
                                                                <input id="insuranceYn" name="insuranceYn" type="hidden" value="${equipVOList[equipIndex].insuranceYn}" required>
                                                                <input id="routineYn" name="routineYn" type="hidden" value="${equipVOList[equipIndex].routineYn}" required>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="font-bold" style="font-size: 15px"><i class="fa fa-chevron-circle-right"></i> 현장정보를 입력하세요.</div>
                                <div class="row">
                                    <div class="col-sm-10" style="margin-top:6px">
                                        <table width="100%" border="0">
                                            <tr>
                                                <td>현장명</td>
                                                <td class="has-warning"><input id="workNm" name="workNm" type="text" class="form-control" value="${contractVO.workNm}" placeholder="예)oo지구 oo건설-1A" required></td>
                                            </tr>
                                            <tr>
                                                <td>현장소재지</td>
                                                <td class="has-warning"><input id="workLocNm" name="workLocNm" type="text" class="form-control" value="${contractVO.workLocNm}" placeholder="예)도/시 구/군/면/동" required></td>
                                            </tr>
                                            <tr>
                                                <td>건설업체<div style="font-size: 11px;margin-top: -5px;">(임차인)</div></td>
                                                <td class="has-warning"><input id="builderNm" name="builderNm" type="text" class="form-control" value="${contractVO.builderNm}" placeholder="건설업체명을 입력하세요" required></td>
                                            </tr>
                                            <tr>
                                                <td>발급자<div style="font-size: 11px;margin-top: -5px;">(원청사)</div></td>
                                                <td><input id="issuerNm" name="issuerNm" type="text" class="form-control" value="${contractVO.issuerNm}" placeholder="발주자명을 입력하세요" required></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox">
                            <div class="ibox-title text-left">
                                <h5>2. 작업일시/사용금액/지급시기</h5>
                                <div class="ibox-tools">
                                    <a class="collapse-link">
                                        <i class="fa fa-chevron-up"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <table width="100%" border="0">
                                    <tr>
                                        <td width="19%" align="center" style="font-size: 13px"><i class="fa fa-calendar"></i> 작업일</td>
                                        <td width="32%">
                                            <div id="data_1">
                                                <div class="input-group date">
                                                    <input id="workDy" name="workDy" type="text" class="form-control input-group-addon" style="padding:3px;height: 35px;background-color: #fff;" value="${formType != CommonCode.FORM_TYPE_NEW ? contractVO.workDy : ''}" required readonly>
                                                </div>
                                            </div>
                                        </td>
                                        <td width="15%" align="center" style="font-size: 13px"><i class="fa fa-clock-o"></i> 시간</td>
                                        <td style="display: inline-flex;">
                                            <div >
                                                <input id="workStartTime" name="workStartTime" type="tel" style="padding:3px;height: 35px;text-align: center;" class="form-control" maxlength="5" value="${formType != CommonCode.FORM_TYPE_NEW ? contractVO.workStartTime : '08:00'}" required>
                                            </div>&nbsp;&nbsp;
                                            <div >
                                                <input id="workEndTime" name="workEndTime" type="tel" style="padding:3px;height: 35px;text-align: center;" class="form-control" maxlength="5" value="${formType != CommonCode.FORM_TYPE_NEW ? contractVO.workEndTime : '17:00'}" required>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" border="0">
                                    <tr>
                                        <td colspan="2">
                                            <div class="form-group row has-warning" style="display: ''">
                                                <div class="col-sm-2" style="font-size: 15px;margin-top: 6px"><i class="fa fa-chevron-circle-right"></i> 작업내용</div>
                                                <div class="col-sm-10">
                                                    <textarea id="workConts" name="workConts" type="text" class="form-control" required>${contractVO.workConts}</textarea>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <button class="btn btn-outline btn-success" type="button" onclick="stephideView('.step2hideView')">[선택사항]사용금액, 지급시기 입력하기</button>
                                        </td>
                                    </tr>
                                    <tr class="step2hideView" style="display: none">
                                        <td width="20%">사용금액</td>
                                        <td style="padding-top:15px">
                                            <div class="input-group-append">
                                                <input id="useAmt" name="useAmt" type="tel" numberOnly class="form-control" value="${contractVO.useAmt}" nkeypress="NUM_HAN(this.value, 3, document.getElementById('EMONEY_HAN'))" onkeyup="this.value=numchk(this.value);NUM_HAN(this.value, 3, document.getElementById('EMONEY_HAN'))" required>
                                                <span class="input-group-addon">원</span>
                                            </div>
                                            <span><input type="text" id="EMONEY_HAN" readonly style="border:0;width: 100%"></span>
                                        </td>
                                    </tr>
                                    <tr class="step2hideView" style="display: none">
                                        <td colspan="2">
                                            <div class="row" >
                                                <div class="col-sm-2 font-bold">지급시기(제6조 제2항이 적용되지 않는 경우)</div>
                                                <div class="col-sm-10">
                                                    <span class="form-text">
                                                        대여기간이 1개월 초과하는 경우에는 매월 종료하는 날부터
                                                        <input id="paydayOverNo" name="paydayOverNo" type="tel" value="${contractVO.paydayOverNo}" style="width: 30px" maxlength="2" oninput="maxLengthCheck(this)" required>일 이내
                                                        대여기간이 1개월 이하인 경우에는 그 기간이 종료하는 날부터
                                                        <input id="paydayInNo" name="paydayInNo" type="tel" value="${contractVO.paydayInNo}" style="width: 30px" maxlength="2" oninput="maxLengthCheck(this)" required>일 이내
                                                    </span>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox">
                            <div class="ibox-title text-left">
                                <h5>3. 장비 조종사/임차인</h5>
                                <div class="ibox-tools">
                                    <a class="collapse-link">
                                        <i class="fa fa-chevron-up"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content" >
                                <table width="100%" border="0">
                                    <tr class="memberHideView" style="display: none">
                                        <td>상호</td>
                                        <td>
                                            <input id="member_bizcoNm" type="text" readonly style="border:0;width: 100%" value="${memberVO.bizcoNm}">
                                        </td>
                                    </tr>
                                    <tr class="memberHideView" style="display: none">
                                        <td style="letter-spacing: -0.5px;">사업자등록번호</td>
                                        <td>
                                            <input id="member_bizcoRegNo" type="text" readonly style="border:0;width: 100%" value="${memberVO.bizcoRegNo}">
                                        </td>
                                    </tr>
                                    <tr class="memberHideView" style="display: none">
                                        <td>성명</td>
                                        <td>
                                            <input id="member_name" type="text" readonly style="border:0;width: 100%"  value="${memberVO.name}">
                                        </td>
                                    </tr>
                                    <tr class="memberHideView" style="display: none">
                                        <td>주민등록번호</td>
                                        <td>
                                            <input id="member_nationIdNo" type="text" readonly style="border:0;width: 100%" value="${memberVO.nationIdNo}">
                                        </td>
                                    </tr>
                                    <tr class="memberHideView" style="display: none">
                                        <td>연락처</td>
                                        <td>
                                            <input id="member_telNo" type="text" readonly style="border:0;width: 100%" value="${memberVO.telNo}">
                                        </td>
                                    </tr>
                                    <tr class="memberHideView" style="display: none">
                                        <td colspan="2">주소</td>
                                    </tr>
                                    <tr class="memberHideView" style="display: none">
                                        <td colspan="2">
                                            <textarea type="text" readonly style="border:0;width: 100%">${memberVO.zipNo} ${memberVO.addrOffice} ${memberVO.addrOfficeDtl}</textarea>
                                            <input id="member_zipNo" type="hidden" value="${memberVO.zipNo}">
                                            <input id="member_addrOffice" type="hidden" value="${memberVO.addrOffice}">
                                            <input id="member_addrOfficeDtl" type="hidden" value="${memberVO.addrOfficeDtl}">
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" border="0">
                                    <tr>
                                        <td width="35%" style="font-size: 15px"><i class="fa fa-chevron-circle-right"></i>  장비 조종사</td>
                                        <td class="has-warning">
                                            <input id="agentNm" name="agentNm" type="text" class="form-control" value="${contractVO.agentNm}" placeholder="조종사 이름을 입력하세요" >
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" border="0">
                                    <tr>
                                        <td colspan="2">
                                            <div class="form-group row">
                                                <label class="col-sm-2 col-form-label" style="font-size: 15px"><i class="fa fa-chevron-circle-right"></i> 임차인(현장 대리인) 서명</label>
                                                <div class="col-sm-10">
                                                    <div class="social-feed-box" <c:if test="${contractVO.signature == null}">style="display: none"</c:if>>
                                                        <div class="social-body">
                                                            <img id="signature" src="${contractVO.signature}" class="img-fluid">
                                                        </div>
                                                        <button type="button" onclick="signatureReWrite()">서명 다시하기</button>
                                                    </div>
                                                    <div id="signature-pad" class="m-signature-pad" <c:if test="${contractVO.signature != null}">style="display:none"</c:if>>
                                                        <div class="m-signature-pad--body">
                                                            <canvas>${contractVO.signature}</canvas>
                                                        </div>
                                                        <div class="m-signature-pad--footer">
                                                            <div class="description">사인해주세요</div>
                                                            <button type="button" class="button clear" data-action="clear">지우기</button>
                                                            <!--button type="button" class="button save" data-action="save">입력완료</button-->
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-size: 15px" width="44%"><i class="fa fa-chevron-circle-right"></i>  현장대리인성명</td>
                                        <td class="has-warning">
                                            <input id="workAgentNm" name="workAgentNm" type="text" class="form-control" value="${contractVO.workAgentNm}" placeholder="현장대리인을 입력하세요">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-size: 15px"><i class="fa fa-chevron-circle-right"></i>  현장대리인연락처</td>
                                        <td class="has-warning">
                                            <input id="workAgentTelNo" name="workAgentTelNo" type="tel" class="form-control" value="${contractVO.workAgentTelNo}" placeholder="현장대리인연락처를 입력하세요" maxlength="13" required>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center"><div style="color:#dc3545"><span class="badge badge-danger">중요</span> 위 연락처로 전자계약서가 자동 전송됩니다.</div></td>
                                    </tr>
                                </table>
                                <table width="100%" border="0" style="margin-top: 10px">
                                    <tr>
                                        <td colspan="2" align="center">
                                            <button class="btn btn-outline btn-success" type="button" onclick="stephideView('.step3hideView')" style="margin:10px 0">[선택사항]임차인 정보 등록하기</button>
                                        </td>
                                    </tr>
                                    <tr class="step3hideView" style="display: none">
                                        <td colspan="2" style="font-size: 15px;padding:10px 0"><i class="fa fa-chevron-circle-right"></i> 임차인(건설업자 및 현장)
                                            <button id="searchHire" type="button" class="btn btn-w-m btn-warning" style="font-size: 12px;height: 30px;float: right"><i class="fa fa-upload"></i> 이전입력정보 불러오기</button>
                                        </td>
                                    </tr>
                                    <tr class="step3hideView" style="display: none">
                                        <td >성명</td>
                                        <td>
                                            <input id="hire_name" name="hire_name" type="text" class="form-control" value="${contractVO.name}" placeholder="대표자명을 입력하세요" required>
                                        </td>
                                    </tr>
                                    <tr class="step3hideView" style="display: none">
                                        <td>상호</td>
                                        <td>
                                            <input id="hire_bizcoNm" name="hire_bizcoNm" type="text" class="form-control" value="${contractVO.bizcoNm}" placeholder="상호명을 입력하세요">
                                        </td>
                                    </tr>
                                    <tr class="step3hideView" style="display: none">
                                        <td>사업자등록번호</td>
                                        <td>
                                            <input id="hire_bizcoRegNo" name="hire_bizcoRegNo" type="tel" class="form-control" value="${contractVO.bizcoRegNo}" placeholder="숫자만 입력하세요" maxlength="12">
                                        </td>
                                    </tr>
                                    <tr class="step3hideView" style="display: none">
                                        <td>회사전화</td>
                                        <td>
                                            <input id="hire_telNo" name="hire_telNo" type="tel" class="form-control" value="${contractVO.telNo}" placeholder="회사전화를 입력하세요" required>
                                        </td>
                                    </tr>
                                    <tr class="step3hideView" style="display: none">
                                        <td colspan="2">
                                            <div class="row">
                                                <label class="col-sm-2 col-form-label">사업장 주소</label>
                                                <div class="col-sm-10">
                                                    <div class="input-group" style="margin-bottom: 5px">
                                                        <input id="hire_zipNo" name="hire_zipNo" type="tel" class="form-control" value="${contractVO.zipNo}" >
                                                        <div id="postSearch" class="input-group-append">
                                                            <span class="input-group-addon">우편번호 검색</span>
                                                        </div>
                                                    </div>
                                                    <input id="hire_addrOffice" name="hire_addrOffice" type="text" class="form-control" value="${contractVO.addrOffice}" style="margin-bottom: 5px">
                                                    <input id="hire_addrOfficeDtl" name="hire_addrOfficeDtl" type="text" value="${contractVO.addrOfficeDtl}" class="form-control">
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox">
                            <div class="ibox-title text-left">
                                <h5>4. 건설기계 임대차 표준계약 일반조건</h5>
                                <div class="i-checks" style="text-align: center;margin-top:10px;font-size: 15px"><label class=""> <div class="iradio_square-green" style="position: relative;font-size: 0"><input type="checkbox" value="option1" name="agree" id="agree" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins></div> <i></i> 약관동의 </label>
                                    <span id="termsShow">[약관보기]</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row" style="margin: 0 20px;font-size: 15px">
                    <c:choose>
                        <c:when test="${formType == CommonCode.FORM_TYPE_READ_ONLY}">
                            <button id="next" type="button" class="btn btn-warning btn-rounded btn-block" style="padding:10px"><i class="fa fa-info-circle"></i> 계약서 보기</button>
                        </c:when>
                        <c:otherwise>
                            <button id="save" type="button" class="btn btn-warning btn-rounded btn-block" style="padding:10px"><i class="fa fa-info-circle"></i> 계약서 작성완료</button>
                        </c:otherwise>
                    </c:choose>
                </div>
                </form>
            </div>
        </div>
    </div>

    <div>
        <c:if test="${contractVO != null}">
            <input id="contractVO" type="hidden" value="${fn:escapeXml(Gson.toJson(contractVO))}">
        </c:if>
    </div>

    <div class="modal inmodal fade" id="insertModal" data-backdrop="static" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-sm ">
            <div class="modal-content">
                <div class="modal-body">
                    <form id="insertEquipForm">
                        <div class="form-group">
                            <label style="font-size: 15px;" class="font-bold">장비 *</label>
                            <select id="add_equipCd" name="add_equipCd" onchange="equipSelfCheck('#add_equipCd','#modelNm')" class="form-control required" required style="height:40px">
                                <option disabled selected hidden>선택</option>
                                <c:forEach var="equipVO" items="${comEquipMstVO}" varStatus="status">
                                    <option value="${equipVO.equipCd}">${equipVO.equipNm}(${equipVO.equipModel})</option>
                                </c:forEach>
                            </select>
                            <input id="modelNm" name="modelNm" type="text" placeholder="모델명을 입력해주세요." style="display: none" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label style="font-size: 15px" class="font-bold">차량번호 *</label>
                            <input id="add_registNo" name="add_registNo" type="text" placeholder="차량번호를 입력해주세요." class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label style="font-size: 15px" class="insuranceYn font-bold">보험가입여부 *</label>
                            <div class="i-checks">
                                <label class="">
                                    <div class="iradio_square-yellow" style="position: relative;">
                                        <input id="add_insuranceYn_Y" name="add_insuranceYn" type="radio" style="position: absolute; opacity: 0;" value="Y" required>
                                        <ins class="iCheck-helper"
                                             style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
                                    </div>
                                    <i></i>
                                    <span>
                                        예
                                    </span>
                                </label>
                            </div>
                            <div class="i-checks">
                                <label class="">
                                    <div class="iradio_square-yellow" style="position: relative;">
                                        <input id="add_insuranceYn_N" name="add_insuranceYn" type="radio" style="position: absolute; opacity: 0;" value="N" required>
                                        <ins class="iCheck-helper"
                                             style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
                                    </div>
                                    <i></i>
                                    <span>
                                        아니요
                                    </span>
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label style="font-size: 15px" class="routineYn font-bold">정기검사여부 *</label>
                            <div class="i-checks">
                                <label class="">
                                    <div class="iradio_square-yellow" style="position: relative;">
                                        <input id="add_routineYn_Y" name="add_routineYn" type="radio" style="position: absolute; opacity: 0;" value="Y" required>
                                        <ins class="iCheck-helper"
                                             style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
                                    </div>
                                    <i></i>
                                    <span>
                                        예
                                    </span>
                                </label>
                            </div>
                            <div class="i-checks">
                                <label class="">
                                    <div class="iradio_square-yellow" style="position: relative;">
                                        <input id="add_routineYn_N" name="add_routineYn" type="radio" style="position: absolute; opacity: 0;" value="N" required>
                                        <ins class="iCheck-helper"
                                             style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
                                    </div>
                                    <i></i>
                                    <span>
                                        아니요
                                    </span>
                                </label>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white" data-dismiss="modal" onclick="checkEquipIsSave()">취소</button>
                    <button id="insertEquip" type="button" class="btn btn-warning">등록</button>
                </div>
            </div>
        </div>
    </div>


    <div class="modal inmodal fade" id="etcModal" data-backdrop="static" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-sm ">
            <div class="modal-content">
                <div class="modal-body">
                    <form id="etcEquipForm">
                        <div class="form-group">
                            <label style="font-size: 15px;" class="font-bold">타장비 종류를 선택하세요*</label>
                            <select id="etc_equipCd" name="etc_equipCd" onchange="equipSelfCheck('#etc_equipCd','#etc_modelNm')" class="form-control required" required style="height:40px">
                                <option disabled selected hidden>선택</option>
                                <c:forEach var="equipVO" items="${comEquipMstVO}" varStatus="status">
                                    <option value="${equipVO.equipCd}">${equipVO.equipNm}(${equipVO.equipModel})</option>
                                </c:forEach>
                            </select>
                            <input id="etc_modelNm" name="etc_modelNm" type="text" placeholder="모델명을 입력해주세요." style="display: none" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label style="font-size: 15px" class="font-bold">차량번호 *</label>
                            <input id="etc_registNo" name="etc_registNo" type="text" placeholder="차량번호를 입력해주세요." class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label style="font-size: 15px" class="insuranceYn font-bold">보험가입여부 *</label>
                            <div class="i-checks">
                                <label class="">
                                    <div class="iradio_square-yellow" style="position: relative;">
                                        <input id="etc_insuranceYn_Y" name="etc_insuranceYn" type="radio" style="position: absolute; opacity: 0;" value="Y" required>
                                        <ins class="iCheck-helper"
                                             style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
                                    </div>
                                    <i></i>
                                    <span>
                                        예
                                    </span>
                                </label>
                            </div>
                            <div class="i-checks">
                                <label class="">
                                    <div class="iradio_square-yellow" style="position: relative;">
                                        <input id="etc_insuranceYn_N" name="etc_insuranceYn" type="radio" style="position: absolute; opacity: 0;" value="N" required>
                                        <ins class="iCheck-helper"
                                             style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
                                    </div>
                                    <i></i>
                                    <span>
                                        아니요
                                    </span>
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label style="font-size: 15px" class="routineYn font-bold">정기검사여부 *</label>
                            <div class="i-checks">
                                <label class="">
                                    <div class="iradio_square-yellow" style="position: relative;">
                                        <input id="etc_routineYn_Y" name="etc_routineYn" type="radio" style="position: absolute; opacity: 0;" value="Y" required>
                                        <ins class="iCheck-helper"
                                             style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
                                    </div>
                                    <i></i>
                                    <span>
                                        예
                                    </span>
                                </label>
                            </div>
                            <div class="i-checks">
                                <label class="">
                                    <div class="iradio_square-yellow" style="position: relative;">
                                        <input id="etc_routineYn_N" name="etc_routineYn" type="radio" style="position: absolute; opacity: 0;" value="N" required>
                                        <ins class="iCheck-helper"
                                             style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins>
                                    </div>
                                    <i></i>
                                    <span>
                                        아니요
                                    </span>
                                </label>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white" data-dismiss="modal" onclick="checkEquipIsSave()">취소</button>
                    <button id="etcEquip" type="button" class="btn btn-warning">입력</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal inmodal fade" id="searchHireModal" data-backdrop="static" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-sm ">
            <div class="modal-content">
                <div class="modal-header" style="padding: 16px 16px 0px 16px; text-align: left;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                    <h3>
                        계약서 임차인정보 불러오기
                    </h3>
                    <p>
                        임차인 상호명, 현장대리인명 중 입력하신 정보에 해당되는 임차인 정보가 검색됩니다.
                    </p>
                </div>

                <div class="modal-body" style="padding: 16px;">
                    <div class="input-group">
                        <form id="searchForm" style="width:100%;display:inline-flex">
                            <input id="search" type="text" placeholder="검색어를 입력해 주세요." class="input form-control " required>
                            <span class="input-group-append">
                                <button id="searchButton" type="button" class="btn btn btn-warning"><i class="fa fa-search"></i>검색</button>
                            </span>
                        </form>
                    </div>

                    <div class="clients-list" style="display: none">
                        <!--span class="float-right small text-muted">검색결과 : 1406</span-->
                        <ul class="nav nav-tabs">
                            <li>
                                <a class="nav-link active" data-toggle="tab" href="#tab-1">
                                    <i class="fa fa-user"></i>
                                    검색결과
                                </a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div id="tab-1" class="tab-pane active">
                                <!--div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 100%;"-->
                                <div class="full-height-scroll" style="overflow: hidden; width: auto; height: 100%;">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover">
                                            <tbody id="searchBody">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="slimScrollBar"
                                     style="background: rgb(0, 0, 0); width: 7px; position: absolute; top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 324.91px;"></div>
                                <div class="slimScrollRail"
                                     style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px;"></div>
                                <!--/div-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="modal inmodal fade" id="termsModal" data-backdrop="static" tabindex="-1" style="display: none" role="dialog"  aria-hidden="true">
        <div class="modal-dialog modal-sm ">
            <div class="modal-content">
                <div class="modal-header" style="padding: 16px 16px 0px 16px; text-align: left;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                    <h3>
                        건설기계 임대차 표준계약 일반조건
                    </h3>

                </div>
                <div class="modal-body" style="padding: 16px;">
                    <div style="font-size: 11px;letter-spacing: -0.5px;">
                        <div class="font-bold">제1조(총칙)</div>
                        <div>건설기계임대인(이하 "갑"이라 한다)과 건설기계임차인(이하 "을"이라 한다)은 대등한 입장에서 서로 협력하여 신의에 따라 성실히 계약을 이행한다.</div>
                        <div class="font-bold">제2조(사용기간)</div>
                        <div>사용기간은 계약서에 명시된 일자로 한다. 다만, 사용기간을 연장하고자 하는 경우에는 "갑"과 "을"이 협의하여 연장할 수 있다.</div>
                        <div class="font-bold">제조(건설기계의 가동시간)</div>
                        <div>①건설기계의 가동시간은 1일 8시간, 월 200시간을 기준으로 한다.</div>
                        <div>②"갑"의 귀책사유로 인해 제1항의 가동시간에 미달한 경우에는 연장작업을 제공하거나 대여료에서 이를 공제하고, "을"의 귀책사유로 인해 제1항의 기준시간에 미달하는 경우에는 기준시간을 가동한 것으로 간주한다.</div>
                        <div>③야간작업과 기준시간 초과 작업에 의한 시간당 대여료는 주간작업에 의한 시간당 대여료에 관련법령이 정한 시간당 건설기계 손료 및 건설기계조종사(조수 포함, 이하 같다.)
                            임금을 다음의 산식에 적용하여 산출된 율을 곱하여 산정한 금액으로 하되, 별도 정산 처리한다. 다만, 야간작업시간에 대한 건설기계조종사의 인건비는 근로기준법 제56조 규정에 따른다.</div>
                        <div>
                            <table border="0" align="center" style="font-size: 11px">
                                <tr>
                                    <td rowspan="2">조정율 = </td>
                                    <td style="border-bottom: 1px solid">(시간당기계손료x8)+(건설기계조종사 임금x1.5)</td>
                                </tr>
                                <tr>
                                    <td>(시간당기계손료x8)+(건설기계조종사 임금x1.0)</td>
                                </tr>
                            </table>
                        </div>
                        <div>※건설기계의 시간당 손료:실적공사비 및 표준품셈 관리규정(국토해양부 훈령)에 따라 산출</div>
                        <div>※건설기계 조종사 임금:통계법 제17조에 따라 때한건설협회가 발표</div>
                        <div>④작업시간은 "갑"과 "을"이 서로 확인한 작업일보에 의한다.</div>
                        <div class="font-bold">제4조(대여료 등)</div>
                        <div>①대여료는 계약서에 명시된 금액으로 한다.</div>
                        <div>②제1항의 규정에 의한 대여료에는 건설기계조종사의 급여액, 기계손료(상각비, 정비비 및 관리비)가 포함된 금액으로 한다.</div>
                        <div>③분해, 조립비는 원칙적으로 "을"이 부담하되, 그 금액은 "갑"과 "을"이 합의하여 정한다. 다만,제9조 제2항, 제10조 제2항에 규정된 갑의 책임있는 사유로 건설기계를 대체하거나 계약을 해지하는 경우에는 "갑"이 분해, 조립비를 부담한다.</div>
                        <div>④1개월 이상 임차하는 경우로서 사용기간 중 건설기계의 고장, 천재지변 등으로 1개월 중 5일 이상 가동하지 못하였을 경우 당월 대여료에서 공제한다.</div>
                        <div class="font-bold">제5조(경비 등의 부담)</div>
                        <div>①건설기계 가동에 필요한 유류비 및 운반비는 "을"이 부담하는 것을 원칙으로 하되, 기종별, 현장여건을 고려 "갑"과 "을"이 합의하여 정한다.</div>
                        <div>②건설기계조종사의 숙식제공, 소모품, 수선비 등 그 밖의 소모비용은 "갑"과 "을"이 합의하여 정한 바에 의한다.</div>
                        <div class="font-bold">제6조(대여료 지불조건)</div>
                        <div>①"을"은 건설기계 대여기간이 1개월을 초과하는 경우에는 매월 종료하는 날 부터, 대여기간이 1개월 이하인 경우에는 그 기간이 종료하는 날부터 각각60일 이내의 가능한 짧은 기한으로 정한 지급일까지 "갑"에게 대여료를 지급하여야 한다.</div>
                        <div>②"을"은 "을"에게 건설공사를 도급(하도급을 포함한다)한 자(이하 "병"이라한다)로 부터 준공급을 받은 때에는 대여료를, 기성급을 받은 때에는 건설기계를 임차하여 시공한 분에 상당하는 대여료를 각각 지급받은 날(공사대금을 어음으로 받은 때에는
                            그 어음만기일을 말한다)부터 15일 이내에 "갑"에게 현금으로 지급하여야 한다.</div>
                        <div>③"을"이 대여료를 "갑"에게 지급하지 아니한 다음 각 호의 경우에는 "갑"은 "병"에게 대여료의 직접지급을 요청할 수 있다.</div>
                        <div>1."병"과 "을"이 대여료를 "갑"에게 직접지급 할 수 있다는 뜻과 그 지급의 방법, 저라를 명백히 하여 협의한 경우</div>
                        <div>2."갑"이 "을"을 상대로 "갑"이 시공한 분에 대한 대여료의 지급을 명하는 확정판정을 받은 경우</div>
                        <div>3.국가, 지방자치단체 또는 정부투자기관이 발주한 건설공사 중 "을"이 "갑"이 시공한 분의 대여료를 1회 이상 지체한 경우</div>
                        <div>4."을"의 파산등으로 인하여 "을"이 "갑"의 대여료를 지급할 수 없는 명백한 사유가 있다고 "병"이 인정한 경우</div>
                        <div>④"병"은 다음 각 호의 경우에는 "갑"에게 대여료를 직접 지급하여야 한다.</div>
                        <div>1."병"이 대여료를 "갑"에게 직접 지급하기로 "갑" "을" 및 "병"이 그 뜻과 지급의 방법, 절차를 명백히 하여 합의한 경우</div>
                        <div>2."을"이 제2항의 규정에 의한 대여료의 지급을 2회 이상 지체한 경우로서 "갑"이 "병"에게 대여료의 직접지급을 요청한 경우</div>
                        <div>3."을"의 지급정지, 파산 그밖에 이와 유사한 사유가 있거나 건설업의 등록 등이 취소되어 "을"이 대여료를 지급할 수 없게 된 경우로서 "갑"이 "병"에게 하도급 대금의 직접 지급을 요청한 경우</div>
                        <div>⑤제2항 내지 제4항에서 규정한 사항 이외의 사항에 대ㅐ서는 건설산업기본법 제32조 제4항에 따른다.</div>
                        <div class="font-bold">제7조(전대 및 사용목적 이외의 사용금지)</div>
                        <div>①"을"은 당해 건설기계를 임대차 목적 외로 사용하거나 타인에게 전매할 수 없다.</div>
                        <div>②"갑"은 이 계약으로부터 발생하는 권리 또는 의무를 제3자에게 양도하거나 처분할 수 없다. 다만, 상대방의 서면에 의한 승락을 받았을 때에는 그러하지 아니하다.</div>
                        <div class="font-bold">제8조("갑"의 권리와 의무)</div>
                        <div>①"갑"은 건설기계가 정상적으로 가동될 수 있도록 예방정비를 철저히 하여야 한다.</div>
                        <div>②"갑"은 "을"의 요구가 있는 경우에는 건설기계등록증/보험(공제)가입ㅈㅇ명서/건설기계조종사 면허증 등을 제시하여야 한다.</div>
                        <div>③"갑"은 건설기계가 관련법령에 의하여 의무적으로 보험[자동차보험(건설기계공제)또는 산재보험]에 가입하여야 하거나 정기검사 대상 건설기계인 경우에는 그 사실을 증명할 수 있는 증빙서류를 "을"에게 제시하여야 한다.</div>
                        <div>④"갑"의 건설기계조종사는 "을"의 현장책임자의 지휘, 감동에 따라 작업을 수행한다. 만일, "갑"의 건설기계조종사가 "을"의 현장책임자의 작업지시에 불을하거나 조종미숙, 태만으로 효율적인 작업진행에 지장을 초래된다고 인정되어 "을"이 건설기계조종사
                            교체를 요구할 경우에는 "갑"은 "을"과 협의하여 교체하여야 한다.</div>
                        <div class="font-bold">제9조("을"의 권리와 의무)</div>
                        <div>①"을"은 현장내 지하매설물, 지상위험물 등에 대하여 건설기계조종사에게 작업전 충분히 고지하여야 하며, 건설기계가 안전하게 작업을 진행할 수 있도록 하여야 한다.</div>
                        <div>②"을"은 계약기간 중 "갑"의 건설기계가 정기검사 등에 해당하는 경우에는 "갑"이 그검사 등을 받을 수 있도록 조치하여야 하며, "갑"은 검사기간이 1일을 초과하는 경우 계약조건과 동일한 장비로 대체하여 작업에 지장이 없도록 조치하여야 한다.</div>
                        <div class="font-bold">제10조(계약해제 및 해지)</div>
                        <div>①당사자 일방이 계약조건을 위반하여 계약의 목적을 달성할 수 없다고 인정되는 경우에는 상대방은 서면으로 상당한 기간을 정하여 이행을 하고, 기한 내에 이행하지 아니하는 경우에는 계약을 해제 또는 해지 할 수 있다.</div>
                        <div>②"을"은 "갑"의 건설기계가 5일 이상의 정비를 필요로 하는경우 "갑"과 합의하여 계약을 해지할 수 있다. 다만, 동일한 건설기계를 대체하였을 경우에는 그러하지 아니한다.</div>
                        <div class="font-bold">제11조(분쟁의 해결)</div>
                        <div>①이 계약서에 별도를 규정된 것을 제외하고는 계약에서 발생하는 문제에 관한 분쟁은 "갑"과 "을"이 쌍방의 합의에 의하여 해결한다.</div>
                        <div>②제1항의 합의가 성립하지 못할 때에는 당사자는 건설산업기본법에 의하여 설치된 건설분쟁조정위원회에 조정을 신청하거나 다른 법령에 의하여 설치된 중재기관에 중재를 요청할 수 있다.</div>
                        <div class="font-bold">제12조(기타)</div>
                        <div>본 계약서에 명시하지 않은 사항에 대하여는 일반 상관례 및 제반 법률규정에 따라 처리하기로 한다.</div>
                        <div class="font-bold">제13조(특양사항)</div>
                        <div>기타 이계약에서 정하지 아니한 사항에 대하여는 "갑"과 "을"이 합의하여 별도의 특약을 정할 수 있다.</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 우편번호 검색 -->
    <div id="daumPost" class="modal" style="display: none">
        <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
    </div>

    <!-- Data picker -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/datapicker/bootstrap-datepicker.js${CommonCode.RESOUCE_VERSION}"></script>
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/datapicker/bootstrap-datepicker.ko.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- iCheck -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/iCheck/icheck.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Input Mask-->
    <script src="${CommonCode.PATH_PLUGIN}/common/input-mask.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Signature Pad -->
    <script src="${CommonCode.PATH_PLUGIN}/signature-pad/signature_pad.umd.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- jQuery-number -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/jquery-number/jquery.number.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Jquery Validate -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/validate/jquery.validate.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- 다음 주소 API -->
    <script defer src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <!-- global -->
    <script>
    var offset = 0,
        limit  = 20,
        isMore = true,
        layerId = '';
    </script>

    <!-- ready -->
    <script data-for="ready">
    jQuery(($) => {
        $('html').scrollTop(0);
        const formType = '${formType}';

        //건설업체 작성 시 상호명 자동입력
        $('#builderNm').keyup(function () {
            $('#hire_bizcoNm').val($(this).val());
        });

        // 저장하기
        $('#save').on('click', (event) => {
            event.preventDefault();
            formSave(formType);
        });

        // 완료된 계약서 다음보기
        $('#next').on('click', (event) => {
            event.preventDefault();
            next(formType);
        });

        // 장비 없을 때 등록하기
        $('#insertEquip').on('click', (event) => {
            event.preventDefault();
            insertEquip();
        });

        // 타장비등록
        $('#etcEquip').on('click', (event) => {
            event.preventDefault();
            etcEquip();
        });

        // 다음 우편번호 검색하기
        $('#postSearch').on('click', (event) => {
            event.preventDefault();
            postCodeSearch();
        });

        // 임차인 검색하기
        $('#searchHire').on('click', (event) => {
            event.preventDefault();
            getHireList(false);
            $('#searchHireModal').modal('show');
        });

        // 약관보기
        $('#termsShow').on('click', (event) => {
            event.preventDefault();
            $('#termsModal').modal('show');
        });

        // 검색 레이어 내 검색버튼
        $('#searchButton').on('click', (event) => {
            event.preventDefault();
            getHireList(true);
        });

        // 검색 레이어에서 스크롤 막기(앱에서 인풋 포커스 시 스크롤 내림 현상 막음)
        $('#search').on('focus', (event) => {
            event.preventDefault();
            //$('#searchHireModal').animate({scrollTop : 0}, 400);
            $('#searchHireModal').css({'overflow': 'hidden'});
        });

        // 검색 레이어에서 스크롤 막기 해제
        $('#search').on('focusout', (event) => {
            $('#searchHireModal').css({'overflow': ''});
        });

        // 전화번호 입력 클릭 시 주소록 앱 호출
        $('#workAgentTelNo').on('click', (event) => {
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
                        $('#workAgentTelNo').focus();
                    }
                });
            }
        });

        equipInit(formType);
        signaturePadInit(formType);

        new InputMask().Initialize(document.querySelectorAll("#workStartTime"), {mask: InputMaskDefaultMask.TimeShort});
        new InputMask().Initialize(document.querySelectorAll("#workEndTime"), {mask: InputMaskDefaultMask.TimeShort});
        new InputMask().Initialize(document.querySelectorAll("#hire_bizcoRegNo"), {mask: InputMaskDefaultMask.Biz});
        new InputMask().Initialize(document.querySelectorAll("#workAgentTelNo"), {mask: InputMaskDefaultMask.Phone});
        $("#workEndTime").blur();
    });
    </script>

    <!-- function -->
    <script>
    async function equipInit(formType) {
        // 장비 없을 경우 장비 등록 먼저
        const equipSize = '${fn:length(equipVOList)}';
        if (equipSize == '0' && '${mode}' == '') {
            swal({
                title: '먼저 보유하신 건설기계를 등록해주세요.',
                showCancelButton: false,
                confirmButtonText: '확인',
            }, function () {
                $('#insertModal').modal('show');
            });
        }

        $('#equipSelect').on('change', (event) => {
            if(event.currentTarget.value =='NEW') {
                $('#insertModal').modal('show');
                $('#equipSelect').find("option:eq(0)").prop("selected", true);
                $('#equipSelect').change();
            }else if(event.currentTarget.value =='ETC'){
                $('#etcModal').modal('show');
                $('#equipSelect').find("option:eq(0)").prop("selected", true);
                $('#equipSelect').change();
            }else {
                const equip = JSON.parse(event.currentTarget.value);

                $('#equipCd').val(equip.equipCd);
                $('#equipModel').val(equip.equipModel);
                $('#registNo').val(equip.registNo);
                $('#insuranceYn').val(equip.insuranceYn);
                $('#routineYn').val(equip.routineYn);
            }
        });

        if('${mode}' == 'direct'){
            equipSelfCheck('#direct_equipCd','#direct_modelNm');
        }
    }

    //장비입력이 없을 경우에 장비 입력창에서 닫기 버튼을 누르면 장비등록 페이지로 이동
    async function checkEquipIsSave(){
        const equipSize = '${fn:length(equipVOList)}';
        if (equipSize == '0' && '${mode}' == '') {
            swal({
                title: '보유하신 건설시계를 등록 후\n 계약서 작성이 가능합니다.',
                showCancelButton: false,
                confirmButtonText: '확인',
            }, function () {
                $('#insertModal').modal('show');
            });
        }
    }

    // 계약서 저장
    async function formSave(formType) {

        if (formType == '${CommonCode.FORM_TYPE_READ_ONLY}') {
            swal({
                title: '완료된 계약서는 수정할 수 없습니다.',
                showCancelButton: false,
                confirmButtonText: '확인',
                customClass: 'custom-small-title'
            });
            return false;
        }

        if (!$('#contractForm').valid()) {
            return false;
        };

        // 사인 validation
        if (signaturePad != null) {
            if (signaturePad.isEmpty() && $('.social-feed-box').css('display') == 'none') {
                swal({
                    title: '사인을 해주세요.',
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                });
                return false;
            }
        }

        //다이렉트 모드일 경우 수기입력한 장비정보 셋팅
        if('${mode}' == 'direct'){
            $("#equipCd").val($("#direct_equipCd option:selected").val());
            $("#equipModel").val($("#direct_equipCd option:selected").text().match(/\((.*)\)/).pop());

            if($("#equipModel").val() =='직접입력'){
                $("#equipModel").val($("#direct_modelNm").val());
            }
        }

        if($("input:checkbox[id='agree']").is(":checked") ==false){
            swal({
                title: '약관동의를 체크해주세요',
                showCancelButton: false,
                confirmButtonText: '확인',
                customClass: 'custom-small-title'
            });
            return false;
        }

        const contractMstVO = {
            equipCd: $('#equipCd').val(),
            equipModel: $('#equipModel').val(),
            registNo: $('#registNo').val(),
            insuranceYn: $('#insuranceYn').val(),
            routineYn: $('#routineYn').val(),
            workNm: $('#workNm').val(),
            workLocNm: $('#workLocNm').val(),
            issuerNm: $('#issuerNm').val(),
            builderNm: $('#builderNm').val(),
            workDy: $('#workDy').val(),
            workStartTime: $('#workStartTime').val(),
            workEndTime: $('#workEndTime').val(),
            useAmt: $('#useAmt').val().replace(/\,/g,''),
            workConts: $('#workConts').val(),
            paydayOverNo: $('#paydayOverNo').val(),
            paydayInNo: $('#paydayInNo').val(),
            agentNm: $('#agentNm').val(),
            signature: $('#signature-pad').css('display') == 'block' ? signaturePad.toDataURL() : $('#signature').attr('src')
        };
        const contractHireLstVO = {
            bizcoNm: $('#hire_bizcoNm').val(),
            bizcoRegNo: $('#hire_bizcoRegNo').val(),
            name: $('#hire_name').val(),
            telNo: $('#hire_telNo').val(),
            workAgentNm: $('#workAgentNm').val(),
            workAgentTelNo: $('#workAgentTelNo').val(),
            zipNo: $('#hire_zipNo').val(),
            addrOffice: $('#hire_addrOffice').val(),
            addrOfficeDtl: $('#hire_addrOfficeDtl').val(),
        };

        const contractMstVO_json = JSON.parse(JSON.stringify(contractMstVO));
        const contractHireLstVO_json = JSON.parse(JSON.stringify(contractHireLstVO));
        const param = Object.assign(contractMstVO_json, contractHireLstVO_json);

        var title = '계약서 등록 완료';
        if (formType == '${CommonCode.FORM_TYPE_UPDATE}') {
            param.contractNo = JSON.parse($('#contractVO').val()).contractNo;
            title = '계약서 수정 완료';
        }

        const response = await MyAjax.execute('${CONTEXT_PATH}/contract/formSave.json', param, {
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
            title: title,
            type: 'success',
            timer: 1000,
            showConfirmButton: false,
        }, () => {
            MyCommon.goLink('/contract/info.view?contractNo=' + response.contractNo);
        });
    }

    async function next(formType) {
        if (formType != '${CommonCode.FORM_TYPE_READ_ONLY}') {
            return false;
        }
        MyCommon.goLink('/contract/info.view?contractNo=' + JSON.parse($('#contractVO').val()).contractNo);
    }

    // 임차인 검색
    async function getHireList(isValid) {
        if (!$('#searchForm').valid() && isValid) {
            swal({
                title: '검색어를 입력해주세요.',
                showCancelButton: false,
                confirmButtonText: '확인',
                customClass: 'custom-small-title'
            });
            return false;
        };

        const param = {
            search: $('#search').val()
        };
        const response = await MyAjax.execute('${CONTEXT_PATH}/contract/searchHire.json', param, {
            autoResultFunctionTF: false,
            type: "POST"
        });
        if (response.length > 0) {
            $('.clients-list').show();

            MyHandlebars.drawDynamicHtml($('#searchBody'), 'html', 'searchList', response);
            $('.clients-list table tr').on('click', (event) => {
                event.preventDefault();
                hireVO = JSON.parse($(event.currentTarget).attr('data-json'));
                console.log(hireVO);

                // data binding
                $('#hire_bizcoNm').val(hireVO.bizcoNm);
                $('#hire_bizcoRegNo').val(hireVO.bizcoRegNo);
                $('#hire_name').val(hireVO.name);
                $('#hire_telNo').val(hireVO.telNo);
                $('#workAgentNm').val(hireVO.workAgentNm);
                $('#workAgentTelNo').val(hireVO.workAgentTelNo);
                $('#hire_zipNo').val(hireVO.zipNo);
                $('#hire_addrOffice').val(hireVO.addrOffice);
                $('#hire_addrOfficeDtl').val(hireVO.addrOfficeDtl);
                // MyHandlebars.drawDynamicHtml($('#lesseLayer'), 'html', 'directLayer', hireVO);

                // 팝업 닫기
                $('#searchHireModal').modal('hide');
            });
        } else {
            MyHandlebars.drawDynamicHtml($('#searchBody'), 'html', 'empty', response);
        }
    }
    // 추가 장비입력
    function etcEquip(){
        if (!$('#etcEquipForm').valid()) {
            return false;
        }

        const params = {
            equipCd: $("#etc_equipCd option:selected").val(),
            equipModel: $("#etc_equipCd option:selected").text().match(/\((.*)\)/).pop(),
            equipNm: $("#etc_equipCd option:selected").text().split('(')[0],
            registNo: $('#etc_registNo').val(),
            insuranceYn: $(':input:radio[name=etc_insuranceYn]:checked').val(),
            routineYn: $(':input:radio[name=etc_routineYn]:checked').val(),
        };
        //직접입력인 경우 Model명 입력창 정보로 변경
        if(params.equipModel =='직접입력'){
            params.equipModel = $('#etc_modelNm').val();
        }
        var jsonOption = new Object();
        jsonOption.equipCd = params.equipCd;
        jsonOption.equipModel = params.equipModel;
        jsonOption.equipNm = params.equipNm;
        jsonOption.seq = 99;
        jsonOption.registNo = params.registNo;
        jsonOption.insuranceYn = params.insuranceYn;
        jsonOption.routineYn = params.routineYn;

        $('#equipSelect option:eq(0)').before("<option value='"+JSON.stringify(jsonOption)+"'>"+"[타장비]"+params.equipNm+"("+params.equipModel+")"+params.registNo+"</option>");
        $('#equipSelect').find("option:eq(0)").prop("selected", true);
        $('#equipSelect').change();
        $('#etcModal').modal('hide');

    }

    // 장비 등록
    async function insertEquip() {
        if (!$('#insertEquipForm').valid()) {
            return false;
        }

        const params = {
            equipCd: $("#add_equipCd option:selected").val(),
            equipModel: $("#add_equipCd option:selected").text().match(/\((.*)\)/).pop(),
            equipNm: $("#add_equipCd option:selected").text().split('(')[0],
            registNo: $('#add_registNo').val(),
            insuranceYn: $(':input:radio[name=add_insuranceYn]:checked').val(),
            routineYn: $(':input:radio[name=add_routineYn]:checked').val(),
        };

        //직접입력인 경우 Model명 입력창 정보로 변경
        if(params.equipModel =='직접입력'){
            params.equipModel = $('#modelNm').val();
        }

        const response = await MyAjax.execute('${CONTEXT_PATH}/equip/insert.json', params, {
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
            title: '등록 완료',
            type: 'success',
            timer: 1000,
            showConfirmButton: false,
        }, () => {
            window.location.reload();
        });
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
    // android bridge : setPhoneNumber
    function setPhoneNumber(phone) {
        $('#workAgentTelNo').val(MyCommon.formatPhoneNumber(phone));
    }

    function equipSelfCheck(obj,modelObj){
        //모델명이 직접입력 경우
        if($(obj+" option:selected").text().match(/\((.*)\)/).pop() =='직접입력'){
            $(modelObj).show();
            $(modelObj).focus();
        }else{
            $(modelObj).hide();
        }
    }
    </script>


    <!-- plugin 실행 -->
    <script>
    // datepicker
    $('#data_1 .input-group.date').datepicker({
        format: 'yyyy/mm/dd',
        todayBtn: 'linked',
        keyboardNavigation: false,
        autoclose: true,
        language: 'ko',
        todayHighlight: true,
    }).datepicker('update', new Date());


    // SignaturePad
    var signaturePad = null;
    function signaturePadInit(formType) {
        if (formType == '${CommonCode.FORM_TYPE_NEW}') {
            var wrapper = document.getElementById("signature-pad");
            var clearButton = wrapper.querySelector("[data-action=clear]");
            var canvas = wrapper.querySelector("canvas");
            signaturePad = new SignaturePad(canvas, {
                backgroundColor: 'rgb(255, 255, 255)'
            });
            function resizeCanvas() {
                var ratio =  Math.max(window.devicePixelRatio || 1, 1);
                canvas.width = canvas.offsetWidth * ratio;
                canvas.height = canvas.offsetHeight * ratio;
                canvas.getContext("2d").scale(ratio, ratio);
                signaturePad.clear();
            }
            // window.onresize = resizeCanvas;
            resizeCanvas();
            clearButton.addEventListener("click", function (event) {
                signaturePad.clear();
            });
        }
    }

    // contract form validate
    $('#contractForm').validate({
        invalidHandler: function (form, validator) {
            if (validator.numberOfInvalids()) {
                validator.errorList[0].element.focus();
            }

        },
        errorPlacement: function(error, element) {
            if (element.attr("name") == "useAmt")
                $("#EMONEY_HAN").before(error);
            else if (element.attr("name") == "workDy" || element.attr("name") == "workStartTime" || element.attr("name") == "workEndTime")
                ;
            else
                element.before(error);
        },
        rules: {
            equipCd: {required: true},
            equipModel: {required: true},
            registNo: {required: true},
            insuranceYn: {required: true},
            routineYn: {required: true},
            workNm: {required: true},
            workLocNm: {required: true},
            issuerNm: {required: false},
            builderNm: {required: true},
            workDy: {required: true},
            workStartTime: {required: true},
            workEndTime: {required: true},
            useAmt: {required: false},
            workConts: {required: true},
            paydayOverNo: {required: false},
            paydayInNo: {required: false},
            agentNm: {required: true},
            hire_name: {required: false},
            hire_telNo: {required: false},
            workAgentNm: {required: true},
            workAgentTelNo: {required: true},
        },
        messages: {
            equipCd: {required: '장비를 선택해주세요.'},
            equipModel: {required: '장비를 선택해주세요.'},
            registNo: {required: '장비를 선택해주세요.'},
            insuranceYn: {required: '장비를 선택해주세요.'},
            routineYn: {required: '장비를 선택해주세요.'},
            workNm: {required: '현장명을 입력해주세요.'},
            workLocNm: {required: '현장소재지를 입력해주세요.'},
            builderNm: {required: '건설업체를 입력해주세요.'},
            workDy: {required: '작업일을 입력해주세요.'},
            workStartTime: {required: '작업시간을 입력해주세요.'},
            workEndTime: {required: '작업시간을 입력해주세요.'},
            useAmt: {required: '사용금액을 입력해주세요.'},
            workConts: {required: '작업내용을 입력해주세요.'},
            paydayOverNo: {required: '항목을 입력해주세요.'},
            paydayInNo: {required: '항목을 입력해주세요.'},
            agentNm: {required: '장비 조종사를 입력해주세요.'},
            hire_name: {required: '임차인 성명을 입력하세요.'},
            hire_telNo: {required: '전화번호가 올바르지 않습니다.'},
            workAgentNm: {required: '현장대리인을 입력하세요'},
            workAgentTelNo: {required: '핸드폰번호가 올바르지 않습니다.'},
        }
    });

    // equip form validate
    $('#insertEquipForm').validate({
        invalidHandler: function (form, validator) {
            if (validator.numberOfInvalids()) {
                validator.errorList[0].element.focus();
            }
        },
        errorPlacement: function(error, element) {
            if (element.attr("name") == "add_insuranceYn")
                $(".insuranceYn").after(error);
            else if (element.attr("name") == "add_routineYn")
                $(".routineYn").after(error);
            else
                element.before(error);
        },
        rules: {
            add_equipCd: {required: true},
            add_registNo: {required: true},
            add_insuranceYn: {required: true},
            add_routineYn: {required: true},
        },
        messages: {
            add_equipCd: {required: '장비를 선택해주세요.'},
            add_registNo: {required: '차량번호를 입력해주세요.'},
            add_insuranceYn: {required: '항목을 선택해주세요.'},
            add_routineYn: {required: '항목을 선택해주세요.'},
        }
    });
    // equip form validate
    $('#etcEquipForm').validate({
        invalidHandler: function (form, validator) {
            if (validator.numberOfInvalids()) {
                validator.errorList[0].element.focus();
            }
        },
        errorPlacement: function(error, element) {
            if (element.attr("name") == "etc_insuranceYn")
                $(".insuranceYn").after(error);
            else if (element.attr("name") == "etc_routineYn")
                $(".routineYn").after(error);
            else
                element.before(error);
        },
        rules: {
            etc_equipCd: {required: true},
            etc_registNo: {required: true},
            etc_insuranceYn: {required: true},
            etc_coutineYn: {required: true},
        },
        messages: {
            etc_equipCd: {required: '장비를 선택해주세요.'},
            etc_registNo: {required: '차량번호를 입력해주세요.'},
            etc_insuranceYn: {required: '항목을 선택해주세요.'},
            etc_routineYn: {required: '항목을 선택해주세요.'},
        }
    });
    // iCheck
    $('.i-checks').iCheck({
        radioClass: 'iradio_square-yellow',
        checkboxClass: 'iradio_square-yellow',
    });

    // search form validate
    $('#searchForm').validate({
        invalidHandler: function (form, validator) {
            if (validator.numberOfInvalids()) {
                validator.errorList[0].element.focus();
            }
        },
        errorPlacement: function(error, element) {
        },
        rules: {
            search: {required: true},
        },
        messages: {
            search: {required: '검색어를 입력해주세요.'},
        }
    });

    // modal trigger
    $('#searchHireModal').on('show.bs.modal', function (e) {
        setIsLayer(true);
        layerId = 'searchHireModal';
    });
    $('#termsModal').on('show.bs.modal', function (e) {
        setIsLayer(true);
        layerId = 'termsModal';
    });
    $('#insertModal').on('show.bs.modal', function (e) {
        setIsLayer(true);
        layerId = 'insertModal';
    });
    $('#etcModal').on('show.bs.modal', function (e) {
        setIsLayer(true);
        layerId = 'etcModal';
    });

    $('#daumPost').on('show.bs.modal', function (e) {
        setIsLayer(true);
        layerId = 'daumPost';
    });
    $('#searchHireModal').on('hidden.bs.modal', function (e) {
        setIsLayer(false);
        layerId = '';
    });
    $('#termsModal').on('hidden.bs.modal', function (e) {
        setIsLayer(false);
        layerId = '';
    });
    $('#insertModal').on('hidden.bs.modal', function (e) {
        setIsLayer(false);
        layerId = '';
    });
    $('#etcModal').on('hidden.bs.modal', function (e) {
        setIsLayer(false);
        layerId = '';
    });
    $('#daumPost').on('hidden.bs.modal', function (e) {
        setIsLayer(false);
        layerId = '';
    });
    </script>

    <!-- plugin #다음 우편번호 -->
    <script>
    //서명 다시하기 버튼
    function signatureReWrite(){
        $('.social-feed-box').hide();
        $('#signature-pad').show();
        signaturePadInit('${CommonCode.FORM_TYPE_NEW}');
    }

    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    // function foldDaumPostcode() {
    //     // iframe을 넣은 element를 안보이게 한다.
    //     element_wrap.style.display = 'none';
    // }

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
                document.getElementById('hire_zipNo').value = data.zonecode;
                document.getElementById("hire_addrOffice").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("hire_addrOfficeDtl").focus();

                // element_layer.style.display = 'none';
                MyModal.close($('#daumPost'));
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);
    }

    //페이지이동 (메인에서 이동 했을 경우만 메인 이동, 나머지는 계약서 관리 페이지로 이동)
    // function backLocation(){
    //     if(document.referrer.indexOf('/main/main.view') > 0){
    //         location.href ="/main/main.view";
    //     }else{
    //         location.href ="/contract/list.view";
    //     }
    // }

    function stephideView(obj){
        if($(obj).css('display') == 'none'){
            $(obj).show();
        }else{
            $(obj).hide();
        }
    }
    </script>

    <!-- 핸들바 -->
    <script id="searchList" type="text/x-handlebars-template">
    {{#each this}}
    <tr data-json="{{objectToJson this}}">
        <td>
            <div style="font-weight: 600">계약일 : {{getYYYYMMDD updDt}}</div>
            <div>현장명 : {{workNm}}</div>
            <div>임차인명/상호 : {{name}} / {{bizcoNm}}</div>
            <div>현장대리인 : {{workAgentNm}}({{telNo}})</div>
        </td>
    </tr>
    {{/each}}
    </script>

    <script id="empty" type="text/x-handlebars-template">
    <div class="text-center">검색 결과가 없습니다.</div>
    </script>
</my:html>
