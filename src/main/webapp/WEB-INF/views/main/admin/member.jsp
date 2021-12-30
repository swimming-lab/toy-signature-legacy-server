<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES" handlebars="YES" navigationBar="0" ajaxPage="YES">
    <div id="wrapper">
        <div class="ibox-title topFixed">
            <a href="javascript:MyCommon.goBack()"><i class="fa fa-arrow-left fa-2x"></i></a>
            <h5 style="font-size: 18px;font-family: yg-jalnan;">회원 관리</h5>
        </div>
        <div class="topFixed-body">
            <div class="wrapper wrapper-content animated fadeIn">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox ">
                            <div class="ibox-content">
                                <div class="form-group row">
                                    <div class="col-sm-10">
                                        <div class="input-group m-b">
                                            <p>
                                                상호, 성명, 연락처 중 입력하신 정보에 해당되는 회원이 검색됩니다.
                                            </p>
                                            <div class="input-group-prepend">
                                                <button id="range" data-range="3" data-toggle="dropdown" class="btn btn-white dropdown-toggle" type="button">최근 3개월</button>
                                                <ul class="dropdown-menu">
                                                    <li>
                                                        <a href="#" data-range="1">최근 1개월</a>
                                                    </li>
                                                    <li>
                                                        <a href="#" data-range="3">최근 3개월</a>
                                                    </li>
                                                    <li>
                                                        <a href="#" data-range="6">최근 6개월</a>
                                                    </li>
                                                    <li>
                                                        <a href="#" data-range="12">최근 1년</a>
                                                    </li>
                                                    <li>
                                                        <a href="#" data-range="0">전체</a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <input id="search" type="text" placeholder="" class="input form-control">
                                            <span class="input-group-append">
                                            <button id="submit" type="button" class="btn btn btn-danger"><i class="fa fa-search"></i>검색</button>
                                        </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="listLayer" class="row">
                </div>
            </div>
        </div>
    </div>

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
        $('#submit').on('click', (event) => {
            event.preventDefault();
            MyAjaxPage.init();
            getMemberList(MyAjaxPage.HTML);
        });

        $('.dropdown-menu li a').on('click', (event) => {
            event.preventDefault();

            const range = event.currentTarget.getAttribute('data-range');
            const text = event.currentTarget.text;

            $('#range').text(text);
            $('#range').attr('data-range', range);
        });

        getMemberList(MyAjaxPage.HTML);
        MyAjaxPage.on(getMemberList);
    });
    </script>

    <!-- function -->
    <script>
    async function getMemberList(handlebarType) {
        if (handlebarType == MyAjaxPage.APPEND && !MyAjaxPage.isNext()) {
            MyAjaxPage.off();
            return;
        } else {
            MyHandlebars.drawDynamicHtml($('#listLayer'), handlebarType, 'listHandlebar', {});
        }

        const param = {
            search: $('#search').val(),
            range: $('#range').attr('data-range'),
            offset: MyAjaxPage.offset,
            limit: MyAjaxPage.limit
        };
        const response = await MyAjax.execute('${CONTEXT_PATH}/admin/memberList.json', param, {
            autoResultFunctionTF: false,
            type: "POST"
        });
        console.log(response);

        if (response.length > 0) {
            MyAjaxPage.next(response.length);
            MyHandlebars.drawDynamicHtml($('#listLayer'), handlebarType, 'listHandlebar', response);

            clickEventBinding();
        } else if (handlebarType == MyAjaxPage.APPEND) {
            MyAjaxPage.next(false);
        } else {
            MyAjaxPage.next(false);
            MyHandlebars.drawDynamicHtml($('#listLayer'), handlebarType, 'empty', response);
        }
    }

    async function removeMember(memberVO) {
        const params = {
            customerId: memberVO.customerId
        };

        const response = await MyAjax.execute('${CONTEXT_PATH}/admin/removeMember.json', params, {
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
            title: '삭제 완료',
            type: 'success',
            timer: 1000,
            showConfirmButton: false,
        }, () => {
            window.location.reload();
        });
    }

    function clickEventBinding() {
        $('#listLayer .update').on('click', (event) => {
            event.preventDefault();
            const memberVO = JSON.parse(event.currentTarget.getAttribute('data-json'));

            if (memberVO.memberSt == '${CommonCode.MEMBER_ST_REMOVE}') {
                swal({
                    title: '삭제된 회원은 수정할 수 없습니다.',
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                });
                return;
            }

            MyCommon.goLink('/admin/memberInfo.view?customerId=' + memberVO.customerId);
        });

        $('#listLayer .remove').on('click', (event) => {
            event.preventDefault();
            const memberVO = JSON.parse(event.currentTarget.getAttribute('data-json'));

            if (memberVO.memberSt == '${CommonCode.MEMBER_ST_REMOVE}') {
                swal({
                    title: '이미 삭제되었습니다.',
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                });
                return;
            }

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
                    removeMember(memberVO);
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
    </script>

    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>

    <!-- 핸들바 -->
    <script id="listHandlebar" type="text/x-handlebars-template">
    {{#each this}}
    <div class="col-lg-4">
        <div class="ibox">
            <div class="ibox-title">
                <h5 style="float: left">
                    {{bizcoNm}} (가입일 : {{getYYYYMMDDHHMM regDt}})
                </h5>
                {{#if_eq memberSt "9"}}
                <span class="label label-danger float-right">삭제</span>
                {{/if_eq}}
            </div>
            <div class="ibox-content">
                <div>이름 : {{name}}</div>
                <div>사업자등록번호 : {{bizcoRegNo}}</div>
                <div>연락처 : {{telNo}}</div>
                <br>
                <div class="text-center">
                    <button class="update" data-json="{{objectToJson this}}" type="button" class="btn btn-w-m btn-link" style="font-weight: bold; width: 49%">수정</button>
                    <button class="remove" data-json="{{objectToJson this}}" type="button" class="btn btn-w-m btn-link" style="font-weight: bold; width: 49%">삭제</button>
                </div>
            </div>
        </div>
    </div>
    {{/each}}
    </script>

    <script id="empty" type="text/x-handlebars-template">
    <div class="col-lg-4" data-json="{{objectToJson this}}">
        <div class="ibox">
            <div class="text-center">검색 결과가 없습니다.</div>
        </div>
    </div>
    </script>
</my:html>
