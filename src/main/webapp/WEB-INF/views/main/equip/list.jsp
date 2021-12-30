<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES" handlebars="YES">
    <div id="wrapper">
        <div class="ibox-title topFixed">
            <a href="javascript:MyCommon.goBack()"><i class="fa fa-arrow-left fa-2x"></i></a>
            <h5 style="font-size: 18px;font-family: yg-jalnan;">장비 관리</h5>
        </div>

        <div class="topFixed-body">
            <div class="wrapper wrapper-content animated fadeInRight" style="padding:20px 10px 40px">
                <div id="listLayer" class="row">
                </div>
                <div class="row">
                    <div class="col-lg-4">
                        <div class="widget gray-bg text-center" style="border-radius: 10px; padding: 10px 30px 10px; margin-bottom: 5px;">
                            <div id="add" data-toggle="modal" data-target="#insertModal" class="m-b-md" style="margin-bottom: 150px;">
                                <i class="fa fa-plus fa-3x" style="color:#676a6c; font-size:30px"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 등록 -->
                <div class="modal inmodal fade" id="insertModal" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
                    <div class="modal-dialog modal-sm "><!--modal-dialog-centered-->
                        <div class="modal-content">
                            <!--div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title">장비등록</h4>
                            </div-->
                            <div class="modal-body">
                                <form id="insertForm">
                                    <div class="form-group">
                                        <label class="font-bold">장비 *</label>
                                        <select id="equipCd" name="equipCd" onchange="equipSelfCheck('#equipCd','#modelNm')" class="form-control required" name="account" required style="height:40px">
                                            <option disabled selected hidden>선택</option>
                                            <c:forEach var="equipVO" items="${comEquipMstVO}" varStatus="status">
                                                <option value="${equipVO.equipCd}">${equipVO.equipNm}(${equipVO.equipModel})</option>
                                            </c:forEach>
                                        </select>
                                        <input id="modelNm" name="modelNm" type="text" placeholder="모델명을 입력해주세요." style="display: none" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label class="font-bold">차량번호 *</label>
                                        <input id="registNo" name="registNo" type="text" placeholder="차량번호를 입력해주세요." class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label class="insuranceYn font-bold">보험가입여부 *</label>
                                        <div class="i-checks">
                                            <label class="">
                                                <div class="iradio_square-yellow" style="position: relative;">
                                                    <input id="insuranceYn_Y" name="insuranceYn" type="radio" style="position: absolute; opacity: 0;" value="Y" required>
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
                                                    <input id="insuranceYn_N" name="insuranceYn" type="radio" style="position: absolute; opacity: 0;" value="N" required>
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
                                        <label class="routineYn font-bold">정기검사여부 *</label>
                                        <div class="i-checks">
                                            <label class="">
                                                <div class="iradio_square-yellow" style="position: relative;">
                                                    <input id="routineYn_Y" name="routineYn" type="radio" style="position: absolute; opacity: 0;" value="Y" required>
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
                                                    <input id="routineYn_N" name="routineYn" type="radio" style="position: absolute; opacity: 0;" value="N" required>
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
                                <button type="button" class="btn btn-white" data-dismiss="modal">취소</button>
                                <button id="insert" type="button" class="btn btn-warning">등록</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 수정 -->
                <div class="modal inmodal fade" id="updateModal" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
                    <div class="modal-dialog modal-sm "><!--modal-dialog-centered-->
                        <div class="modal-content">
                            <!--div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title">장비등록</h4>
                            </div-->
                            <div class="modal-body">
                                <form id="updateForm">
                                    <div class="form-group">
                                        <input id="u_seq" type="hidden" class="form-control">
                                        <label class="font-bold">장비 *</label>
                                        <select id="u_equipCd" name="u_equipCd" onchange="equipSelfCheck('#u_equipCd','#u_modelNm')" class="form-control required" name="account" required style="height:40px">
                                            <option disabled selected hidden>선택</option>
                                            <c:forEach var="equipVO" items="${comEquipMstVO}" varStatus="status">
                                                <option value="${equipVO.equipCd}">${equipVO.equipNm}(${equipVO.equipModel})</option>
                                            </c:forEach>
                                        </select>
                                        <input id="u_modelNm" name="u_modelNm" type="text" placeholder="모델명을 입력해주세요." style="display: none" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label class="font-bold">차량번호 *</label>
                                        <input id="u_registNo" name="u_registNo" type="text" placeholder="차량번호를 입력해주세요." class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label class="u_insuranceYn font-bold">보험가입여부 *</label>
                                        <div class="i-checks">
                                            <label class="">
                                                <div class="iradio_square-yellow" style="position: relative;">
                                                    <input id="u_insuranceYn_Y" name="u_insuranceYn" type="radio" style="position: absolute; opacity: 0;" value="Y" required>
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
                                                    <input id="u_insuranceYn_N" name="u_insuranceYn" type="radio" style="position: absolute; opacity: 0;" value="N" required>
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
                                        <label class="u_routineYn font-bold">정기검사여부 *</label>
                                        <div class="i-checks">
                                            <label class="">
                                                <div class="iradio_square-yellow" style="position: relative;">
                                                    <input id="u_routineYn_Y" name="u_routineYn" type="radio" style="position: absolute; opacity: 0;" value="Y" required>
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
                                                    <input id="u_routineYn_N" name="u_routineYn" type="radio" style="position: absolute; opacity: 0;" value="N" required>
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
                                <button type="button" class="btn btn-white" data-dismiss="modal">취소</button>
                                <button id="update" type="button" class="btn btn-warning">수정</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>

    <!-- global -->
    <script>
    var layerId = '';
    </script>

    <!-- ready -->
    <script data-for="ready">
        jQuery(($) => {
            $('#insert').on('click', (event) => {
                event.preventDefault();
                insertEquip();
            });

            $('#update').on('click', (event) => {
                event.preventDefault();
                updateEquip();
            });

            $('#remove').on('click', (event) => {
                event.preventDefault();
                removeEquip();
            });

            getEquipList();

            // swal({
            //     title: '등록 완료',
            //     text: '',
            //     type: 'success',
            //     timer: 1000,
            //     showConfirmButton: false,
            // });
        });
    </script>
    <script>
    async function getEquipList() {
        const response = await MyAjax.execute('${CONTEXT_PATH}/equip/list.json', {}, {
            autoResultFunctionTF: false,
            type: "POST"
        });
        MyHandlebars.drawDynamicHtml($('#listLayer'), 'html', 'listHandlebar', response);
        initEventBinding();
    }

    async function insertEquip() {
        if (!$('#insertForm').valid()) {
            return false;
        };

        const params = {
            equipCd: $("#equipCd option:selected").val(),
            equipModel: $("#equipCd option:selected").text().match(/\((.*)\)/).pop(),
            equipNm: $("#equipCd option:selected").text().split('(')[0],
            registNo: $('#registNo').val(),
            insuranceYn: $(':input:radio[name=insuranceYn]:checked').val(),
            routineYn: $(':input:radio[name=routineYn]:checked').val(),
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

        $('#insertModal').modal('hide');
        params.seq = response.seq;
        MyHandlebars.drawDynamicHtml($('#listLayer'), 'append', 'listHandlebar', [params]);
        initEventBinding();
        swal({
            title: '등록 완료',
            type: 'success',
            timer: 1000,
            showConfirmButton: false,
        });
    }

    async function updateEquip() {
        if (!$('#updateForm').valid()) {
            return false;
        };

        const params = {
            equipCd: $("#u_equipCd option:selected").val(),
            equipModel: $("#u_equipCd option:selected").text().match(/\((.*)\)/).pop(),
            equipNm: $("#u_equipCd option:selected").text().split('(')[0],
            registNo: $('#u_registNo').val(),
            seq: $('#u_seq').val(),
            insuranceYn: $(':input:radio[name=u_insuranceYn]:checked').val(),
            routineYn: $(':input:radio[name=u_routineYn]:checked').val(),
        };
        //직접입력인 경우 Model명 입력창 정보로 변경
        if(params.equipModel =='직접입력'){
            params.equipModel = $('#u_modelNm').val();
        }
        const response = await MyAjax.execute('${CONTEXT_PATH}/equip/update.json', params, {
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

        $('#updateModal').modal('hide');
        MyHandlebars.drawDynamicHtml($('#' + params.seq), 'html', 'updateHandlebar', params);
        initEventBinding();
        swal({
            title: '수정 완료',
            type: 'success',
            timer: 1000,
            showConfirmButton: false,
        });
    }

    async function removeEquip(equipVO) {
        const params = {
            seq: equipVO.seq
        };

        const response = await MyAjax.execute('${CONTEXT_PATH}/equip/remove.json', params, {
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
            });
            return;
        }

        swal({
            title: '삭제 완료',
            type: 'success',
            timer: 1000,
            showConfirmButton: false,
        });

        $('#' + equipVO.seq).remove();
        // $('#' + equipVO.seq).addClass('animated fadeOut');
        // setTimeout(() => {
        //     $('#' + equipVO.seq).remove();
        // }, 1000);
    }

    function initInsertModal() {
        $('#equipCd option:eq(0)').prop('selected', true);
        $('#registNo').val('');
        $('#insertModal .i-checks').iCheck('uncheck');
    }

    function initUpdateModal() {
        $('#u_equipCd option:eq(0)').prop('selected', true);
        $('#u_registNo').val('');
        $('#u_seq').val('');
        $('#updateModal .i-checks').iCheck('uncheck');
    }

    function bindingUpdateModal(equipVO) {
        $('#u_equipCd').val(equipVO.equipCd).prop('selected', true);
        if($("#u_equipCd option:selected").text().match(/\((.*)\)/).pop() == '직접입력'){
            $('#u_modelNm').show();
            $('#u_modelNm').val(equipVO.equipModel);
        }else{
            $('#u_modelNm').hide();
            $('#u_modelNm').val('');
        }
        $('#u_registNo').val(equipVO.registNo);
        $('#u_seq').val(equipVO.seq);
        if (equipVO.insuranceYn == 'Y') {
            $('#u_insuranceYn_Y').iCheck('check');
        } else {
            $('#u_insuranceYn_N').iCheck('check');
        }
        if (equipVO.routineYn == 'Y') {
            $('#u_routineYn_Y').iCheck('check');
        } else {
            $('#u_routineYn_N').iCheck('check');
        }
    }

    function initEventBinding() {
        $('#listLayer .update').on('click', (event) => {
            event.preventDefault();
            const equipVO = JSON.parse(event.currentTarget.getAttribute('data-json'));
            bindingUpdateModal(equipVO);
        });

        $('#listLayer .remove').on('click', (event) => {
            event.preventDefault();
            const equipVO = JSON.parse(event.currentTarget.getAttribute('data-json'));
            console.log(equipVO.seq);
            setIsLayer(true);
            layerId = 'removeAlert';

            swal({
                title: '삭제하겠습니까?',
                type: 'warning',
                showCancelButton: true,
                cancelButtonText: '취소',
                confirmButtonColor: "#DD6B55",
                confirmButtonText: '삭제',
                closeOnConfirm: false
            }, function (isConfirm) {
                if (isConfirm) {
                    removeEquip(equipVO);
                }
                setIsLayer(false);
                layerId = '';
            });
        });
    }

    // android bridge : closeLayer
    function closeLayer() {
        if (layerId == 'removeAlert') {
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

    <!-- iCheck -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/iCheck/icheck.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Jquery Validate -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/validate/jquery.validate.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>

    <!-- plugin 실행 -->
    <script>
    // icheck
    $('.i-checks').iCheck({
        radioClass: 'iradio_square-yellow'
    });

    // insert validate
    $('#insertForm').validate({
        invalidHandler: function (form, validator) {
            if (validator.numberOfInvalids()) {
                validator.errorList[0].element.focus();
            }
        },
        errorPlacement: function(error, element) {
            if (element.attr("name") == "insuranceYn")
                $(".insuranceYn").after(error);
            else if (element.attr("name") == "routineYn")
                $(".routineYn").after(error);
            else
                element.before(error);
        },
        rules: {
            equipCd: {required: true},
            registNo: {required: true},
            insuranceYn: {required: true},
            routineYn: {required: true},
        },
        messages: {
            equipCd: {required: '장비를 선택해주세요.'},
            registNo: {required: '차량번호를 입력해주세요.'},
            insuranceYn: {required: '항목을 선택해주세요.'},
            routineYn: {required: '항목을 선택해주세요.'},
        }
    });

    // update validate
    $('#updateForm').validate({
        invalidHandler: function (form, validator) {
            if (validator.numberOfInvalids()) {
                validator.errorList[0].element.focus();
            }
        },
        errorPlacement: function(error, element) {
            if (element.attr("name") == "u_insuranceYn")
                $(".u_insuranceYn").after(error);
            else if (element.attr("name") == "u_routineYn")
                $(".u_routineYn").after(error);
            else
                element.before(error);
        },
        rules: {
            equipCd: {required: true},
            registNo: {required: true},
            insuranceYn: {required: true},
            routineYn: {required: true},
        },
        messages: {
            equipCd: {required: '장비를 선택해주세요.'},
            registNo: {required: '차량번호를 입력해주세요.'},
            insuranceYn: {required: '항목을 선택해주세요.'},
            routineYn: {required: '항목을 선택해주세요.'},
        }
    });

    // modal trigger
    $('#insertModal').on('show.bs.modal', function (e) {
        setIsLayer(true);
        layerId = 'insertModal';
    });
    $('#updateModal').on('show.bs.modal', function (e) {
        setIsLayer(true);
        layerId = 'updateModal';
    });
    $('#insertModal').on('hidden.bs.modal', function (e) {
        initInsertModal();
        setIsLayer(false);
        layerId = '';
    });
    $('#updateModal').on('hidden.bs.modal', function (e) {
        initUpdateModal();
        setIsLayer(false);
        layerId = '';
    });
    </script>

    <!-- 핸들바 -->
    <script id="listHandlebar" type="text/x-handlebars-template">
    {{#each this}}
    <div class="col-lg-4" id="{{seq}}">
        <div class="widget white-bg" style="border-radius: 10px; padding: 20px 30px 10px; margin-bottom: 5px;">
            <h2 style="font-weight: bold;">{{equipNm}}</h2>
            <ul class="list-unstyled m-t-md">
                <li>
                    <label style="margin-bottom: .0rem;">차량번호 : {{registNo}}</label> </li>
                <li>
                    <label style="margin-bottom: .0rem;">등록번호 : {{equipModel}}</label>
                </li>
                <li>
                    <label style="margin-bottom: .0rem;">보험가입여부 : {{#if_eq insuranceYn "Y"}}예{{else}}아니요{{/if_eq}}</label>
                </li>
                <li>
                    <label style="margin-bottom: .0rem;">정기검사여부 : {{#if_eq routineYn "Y"}}예{{else}}아니요{{/if_eq}}</label>
                </li>
            </ul>
            <div class="text-center">
                <button class="update" data-json="{{objectToJson this}}" type="button" data-toggle="modal" data-target="#updateModal" class="btn btn-w-m btn-link" style="font-weight: bold; width: 49%">수정</button>
                <button class="remove" data-json="{{objectToJson this}}" type="button" class="btn btn-w-m btn-link" style="font-weight: bold; width: 49%">삭제</button>
            </div>
        </div>
    </div>
    {{/each}}
    </script>

    <script id="updateHandlebar" type="text/x-handlebars-template">
        <div class="widget white-bg" style="border-radius: 10px; padding: 20px 30px 10px; margin-bottom: 5px;">
            <h2 style="font-weight: bold;">{{equipNm}}</h2>
            <ul class="list-unstyled m-t-md">
                <li>
                    <label style="margin-bottom: .0rem;">차량번호 : {{registNo}}</label> </li>
                <li>
                    <label style="margin-bottom: .0rem;">등록번호 : {{equipModel}}</label>
                </li>
                <li>
                    <label style="margin-bottom: .0rem;">보험가입여부 : {{#if_eq insuranceYn "Y"}}예{{else}}아니요{{/if_eq}}</label>
                </li>
                <li>
                    <label style="margin-bottom: .0rem;">정기검사여부 : {{#if_eq routineYn "Y"}}예{{else}}아니요{{/if_eq}}</label>
                </li>
            </ul>
            <div class="text-center">
                <button class="update" data-json="{{objectToJson this}}" type="button" data-toggle="modal" data-target="#updateModal" class="btn btn-w-m btn-link" style="font-weight: bold; width: 49%">수정</button>
                <button class="remove" data-json="{{objectToJson this}}" type="button" class="btn btn-w-m btn-link" style="font-weight: bold; width: 49%">삭제</button>
            </div>
        </div>
    </script>
</my:html>
