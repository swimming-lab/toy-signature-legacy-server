<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>
<c:choose>
    <c:when test="${formType == CommonCode.FORM_TYPE_NEW_LOAD}">
        <c:set var="naviContractType" value=""/>
    </c:when>
    <c:otherwise>
        <c:set var="naviContractType" value="2"/>
    </c:otherwise>
</c:choose>
<my:html cookie="YES" handlebars="YES" ajaxPage="YES" fileDownloader="YES">
    <div id="wrapper">
        <div class="ibox-title topFixed">
            <a href="javascript:MyCommon.goLink('/pc/login/main.view')"><i class="fa fa-arrow-left fa-2x"></i></a>
            <h5 style="font-size: 18px;font-family: yg-jalnan;">전자임대차 표준계약서 관리</h5>
        </div>
        <div class="topFixed-body">
            <div class="wrapper wrapper-content animated fadeIn">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox ">
                            <div class="ibox-content" style="padding-bottom:1px">
                                <div class="form-group row">
                                    <div class="col-sm-10">
                                        <div class="input-group m-b">
                                            <!--h2>
                                                계약서 통합검색
                                            </h2-->
                                            <p>
                                                현장명, 임차인명, 임차인상호명, 현장대리인 연락처 중 입력하신 정보에 해당되는 계약서 정보가 검색됩니다.
                                            </p>
                                            <!--select id="equipSelect" class="form-control m-b">
                                                <option value="">최근 3개월</option>
                                                <option value="">ㄴㅁㅇ</option>
                                                <option value="">ㄴㅁㅇ</option>
                                            </select-->
                                            <br>
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
                                            <button id="submit" type="button" class="btn btn btn-warning"><i class="fa fa-search"></i>검색</button>
                                        </span>
                                        </div>
                                    <c:choose>
                                        <c:when test="${formType == CommonCode.FORM_TYPE_NEW_LOAD}">
                                            <div style="letter-spacing: -0.9px;">
                                                계약서를 선택하면 <u>내용을 복사해서 새로 작성</u>할 수 있습니다.
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="letter-spacing: -0.3px;">
                                                <u>작성하던 계약서를 이어서 작업하고 공유</u> 할 수 있습니다.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <button id="excel" type="button" class="btn btn btn-warning"><i class="fa fa-search"></i>엑셀다운로드</button>

                <div id="listLayer" class="row">
                </div>
            </div>
        </div>
    </div>

    <!-- global -->
    <script>
    const formType = '${formType}';
    </script>

    <!-- ready -->
    <script data-for="ready">
        jQuery(($) => {
            $('#submit').on('click', (event) => {
                event.preventDefault();
                MyAjaxPage.init();
                getContractList(MyAjaxPage.HTML);
            });

            $('.dropdown-menu li a').on('click', (event) => {
                event.preventDefault();

                const range = event.currentTarget.getAttribute('data-range');
                const text = event.currentTarget.text;

                $('#range').text(text);
                $('#range').attr('data-range', range);
            });

            $('#excel').on('click', (event) => {
                event.preventDefault();
                const param = {
                    search: $('#search').val(),
                    range: $('#range').attr('data-range'),
                };
                MyAjax.downloadFile('/pc/main/contractList.xlsx', param, {});
            });

            getContractList(MyAjaxPage.HTML);
            MyAjaxPage.on(getContractList);
        });
    </script>
    <script>
        async function getContractList(handlebarType) {
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
            const response = await MyAjax.execute('${CONTEXT_PATH}/contract/list.json', param, {
                autoResultFunctionTF: false,
                type: "POST"
            });
            console.log(response);

            if (response.length > 0) {
                MyAjaxPage.next(response.length);
                MyHandlebars.drawDynamicHtml($('#listLayer'), handlebarType, 'listHandlebar', response);

                $('#listLayer .col-lg-4').on('click', (event) => {
                    event.preventDefault();

                    const contractVO = JSON.parse(event.currentTarget.getAttribute('data-json'));
                    linkUrl = null;
                    if (formType == '${CommonCode.FORM_TYPE_NEW_LOAD}' && contractVO.contractSt == '${CommonCode.CONTRACT_ST_DONE}') {
                        linkUrl = '/contract/insertForm.view';
                    } else {
                        if (contractVO.contractSt == '${CommonCode.CONTRACT_ST_ING}') {
                            linkUrl = '/contract/updateForm.view';
                        } else {
                            // linkUrl = '/contract/readForm.view';
                            linkUrl = '/contract/info.view';
                        }
                    }

                    MyCommon.goLink(linkUrl + '?contractNo=' + contractVO.contractNo);
                });
            } else if (handlebarType == MyAjaxPage.APPEND) {
                MyAjaxPage.next(false);
            } else {
                MyAjaxPage.next(false);
                MyHandlebars.drawDynamicHtml($('#listLayer'), handlebarType, 'empty', response);
            }
        }
    </script>

    <!-- 핸들바 -->
    <script id="listHandlebar" type="text/x-handlebars-template">
        {{#each this}}
        <div class="col-lg-4" data-json="{{objectToJson this}}">
            <div class="ibox"  <c:if test="${naviContractType == ''}">style="border:2px dotted"</c:if>>
                <div class="ibox-title">
                    {{#if_eq contractSt 1}}
                    <span class="label label-success float-right">작성중</span>
                    {{else}}
                    <span class="label label-warning float-right">완료</span>
                    {{/if_eq}}

                    <h5 style="float: left">
                        계약일 : {{workDy}} <span style="font-size: 13px;font-weight: 500"> ({{workStartTime}}~{{workEndTime}})</span>
                    </h5>
                </div>
                <div class="ibox-content">
                    <h4>{{equipNm}}({{registNo}}) {{#if useAmt }}<span style="float: right">₩{{comma useAmt}}</span>{{/if}} </h4>
                    <div>임차인 : {{bizcoNm}} {{#if_eq name ''}} 미입력{{else}}({{name}}) {{/if_eq}}<span style="float: right">{{telNo}}</span></div>
                    <div>현장대리인 : {{workAgentNm}} <span style="float: right">{{workAgentTelNo}}</span></div>
                    <div>현장명 : {{workNm}}</div>
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
