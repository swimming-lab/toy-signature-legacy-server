<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES" handlebars="YES" ajaxPage="YES">
    <div id="wrapper">
        <div class="ibox-title topFixed">
            <a href="javascript:MyCommon.goBack()"><i class="fa fa-arrow-left fa-2x"></i></a>
            <h5 style="font-size: 18px;font-family: yg-jalnan;">체불신고 리스트</h5>
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
                                            <!--h2>
                                                계약서 통합검색
                                            </h2-->
                                            <p>
                                                상호, 성명, 연락처 중 입력하신 정보에 해당되는 체불신고가 검색됩니다.
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
    var layerId = '';
    </script>

    <!-- ready -->
    <script data-for="ready">
    jQuery(($) => {
        $('#submit').on('click', (event) => {
            event.preventDefault();
            MyAjaxPage.init();
            getArrearsList(MyAjaxPage.HTML);
        });

        $('.dropdown-menu li a').on('click', (event) => {
            event.preventDefault();

            const range = event.currentTarget.getAttribute('data-range');
            const text = event.currentTarget.text;

            $('#range').text(text);
            $('#range').attr('data-range', range);
        });

        getArrearsList(MyAjaxPage.HTML);
        MyAjaxPage.on(getArrearsList);
    });
    </script>

    <!-- function -->
    <script>
    async function getArrearsList(handlebarType) {
        if (handlebarType == MyAjaxPage.APPEND && !MyAjaxPage.isNext()) {
            MyAjaxPage.off();
            return;
        }

        const param = {
            search: $('#search').val(),
            range: $('#range').attr('data-range'),
            offset: MyAjaxPage.offset,
            limit: MyAjaxPage.limit
        };
        const response = await MyAjax.execute('${CONTEXT_PATH}/arrears/list.json', param, {
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

    async function removeArrears(arrearsVO) {
        const params = {
            arrearsId: arrearsVO.arrearsId
        };

        const response = await MyAjax.execute('${CONTEXT_PATH}/arrears/remove.json', params, {
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
        }, () => {
            window.location.reload();
        });
    }

    function clickEventBinding() {
        $('#listLayer .update').on('click', (event) => {
            event.preventDefault();
            const arrearsVO = JSON.parse(event.currentTarget.getAttribute('data-json'));

            if (arrearsVO.procSt == '${CommonCode.ARREARS_ST_REMOVE}') {
                swal({
                    title: '삭제된 체불신고는 수정할 수 없습니다.',
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                });
                return;
            } else if (arrearsVO.procSt != '${CommonCode.ARREARS_ST_WAIT}') {
                swal({
                    title: '완료된 체불신고는 수정할 수 없습니다.',
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                });
                return;
            }

            MyCommon.goLink('/arrears/form.view?arrearsId=' + arrearsVO.arrearsId);
        });

        $('#listLayer .remove').on('click', (event) => {
            event.preventDefault();
            const arrearsVO = JSON.parse(event.currentTarget.getAttribute('data-json'));
            console.log(arrearsVO.seq);

            if (arrearsVO.procSt == '${CommonCode.ARREARS_ST_REMOVE}') {
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
                title: '삭제 하겠습니까?',
                type: 'warning',
                showCancelButton: true,
                cancelButtonText: '취소',
                confirmButtonColor: "#DD6B55",
                confirmButtonText: '삭제',
                closeOnConfirm: false
            }, function (isConfirm) {
                if (isConfirm) {
                    removeArrears(arrearsVO);
                }
                setIsLayer(false);
                layerId = '';
            });
        });
    }

    // android bridge : closeLayer
    function closeLayer() {
        $('.sweet-alert .sa-button-container .cancel').trigger('click');
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
                {{#if_eq procSt 1}}
                <span class="label label-success float-right">승인</span>
                {{else if_eq procSt 2}}
                <span class="label label-danger float-right">거부</span>
                {{else if_eq procSt 3}}
                <span class="label label-danger float-right">삭제</span>
                {{else}}
                <span class="label label-warning float-right">대기</span>
                {{/if_eq}}

                <h5 style="float: left">
                    신고일시 : {{regDt}}
                </h5>
            </div>
            <div class="ibox-content">
                <h4>체불자 : {{bizcoNm}}({{arrearsNm}})</h4>
                <div>사업자등록번호 : {{bizcoRegNo}}</div>
                <div>피해금액 : ₩{{comma arrearsAmt}}</div>
                <div>현장명 : {{workNm}}</div>
                <div>현장소재지 : {{workLocNm}}</div>
                <div>그외 상세내용 : {{arrearsConts}}</div>
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
