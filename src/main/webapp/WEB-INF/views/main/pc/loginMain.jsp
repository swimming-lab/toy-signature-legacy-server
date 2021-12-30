<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES" pcVersion="YES" handlebars="YES" ajaxPage="YES">

    <div class="loginColumns animated fadeInDown">
        <div class="row">

            <div class="col-md-6" style="text-align: center">
                <div>
                    <img src="/resources/publish/img/logo.png" style="width: 34%; margin-left: 10%"/>
                </div>
                <br>
                <h3>전자임대차 표준계약서 작업일보</h3>
                <p>계약서 관리 시스템</p>
                <p>임대인 선택 후 계정관리 패스워드로 로그인 해주세요.</p>
            </div>

            <div class="col-md-6">
                <div class="ibox-content">
                    <div class="row">
                        <div class="ibox-content" style="width: 100%; border-style: none;">
                            <div style="font-size: 19px;font-weight: bold;">임대인을 검색 후 선택해 주세요.</div>
                            <p>
                                <b><u>임대인 상호명</u></b>이나 <b><u>임대인명</u></b>을 입력해주세요.
                            </p>

                            <div class="input-group">
                                <form id="searchForm" style="width: 77%">
                                    <input id="search" type="text" placeholder="검색어를 입력해 주세요." class="input form-control" required style="height: 50px">
                                </form>
                                <span class="input-group-append">
                                    <button id="submit" type="button" class="btn btn btn-warning"><i class="fa fa-search"></i>검색</button>
                                </span>
                            </div>

                            <div class="clients-list" style="display: none">
                                <ul class="nav nav-tabs">
                                    <li>
                                        <a class="nav-link active" data-toggle="tab" href="#tab-1">
                                            <i class="fa fa-user"></i>
                                            검색결과
                                        </a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane active" style="height: 100%">
                                        <!--div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 100%;"-->
                                        <div class="full-height-scroll" style="overflow: hidden; width: auto; height: 100%;">
                                            <div class="table-responsive">
                                                <table class="table table-striped table-hover">
                                                    <tbody id="searchBody">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <!--div class="slimScrollBar"
                                             style="background: rgb(0, 0, 0); width: 7px; position: absolute; top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 324.91px;"></div>
                                        <div class="slimScrollRail"
                                             style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px;"></div-->
                                        <!--/div-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <p class="m-t">
                    </p>
                </div>
            </div>
        </div>
        <hr/>
        <div class="row">
            <div class="col-md-6">
                Genius developer Company
            </div>
            <div class="col-md-6 text-right">
                <small>고객센터 031-986-5527</small>
            </div>
        </div>
    </div>



    <!-- Sweet alert -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/sweetalert/sweetalert.min.js${CommonCode.RESOUCE_VERSION}"></script>
    <!-- Jquery Validate -->
    <script src="${CommonCode.PATH_PUBLISH}/js/plugins/validate/jquery.validate.min.js${CommonCode.RESOUCE_VERSION}"></script>

    <!-- ready -->
    <script data-for="ready">
    jQuery(($) => {
        if (MyCookie.getCookie("signature_search") != null) {
            $('#search').val(MyCookie.getCookie("signature_search"))
        }

        $('#submit').on('click', (event) => {
            event.preventDefault();
            if (!$('#searchForm').valid()) {
                swal({
                    title: '검색어를 입력해주세요.',
                    showCancelButton: false,
                    confirmButtonText: '확인',
                    customClass: 'custom-small-title'
                });
                return false;
            };
            MyAjaxPage.init();
            getMemberSearch(MyAjaxPage.HTML);
            MyAjaxPage.on(getMemberSearch);
        });
    });
    </script>

    <!-- function -->
    <script>
    async function getMemberSearch(handlebarType) {
        if (handlebarType == MyAjaxPage.APPEND && !MyAjaxPage.isNext()) {
            MyAjaxPage.off();
            return;
        }

        const param = {
            search: $('#search').val(),
            offset: MyAjaxPage.offset,
            limit: MyAjaxPage.limit
        };
        const response = await MyAjax.execute('${CONTEXT_PATH}/member/search.json', param, {
            autoResultFunctionTF: false,
            type: "POST"
        });

        $('.clients-list').show();
        if (response.length > 0) {
            MyAjaxPage.next(response.length);
            MyHandlebars.drawDynamicHtml($('#searchBody'), handlebarType, 'searchList', response);

            $('table tr').on('click', (event) => {
                event.preventDefault();
                customerId = $(event.currentTarget).attr('data-id');
                MyCommon.goLink('/pc/login/password.view?customerId=' + customerId);
            });

            // 최근 검색어 쿠키에 저장
            MyCookie.setCookie("signature_search", $('#search').val(), 30);
        } else if (handlebarType == MyAjaxPage.APPEND) {
            MyAjaxPage.next(false);
        } else {
            MyAjaxPage.next(false);
            MyHandlebars.drawDynamicHtml($('#searchBody'), handlebarType, 'empty', response);
        }
    }
    </script>

    <!-- plugin -->
    <script>
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
    </script>

    <!-- 검색결과 핸들바 -->
    <script id="searchList" type="text/x-handlebars-template">
    {{#each this}}
    <tr data-id="{{customerId}}">
        <td style="height:80px;font-size: 15px">
            <div style="font-weight: 600;margin-bottom:8px;font-size: 16px">{{bizcoNm}} ({{bizcoRegNo}})</div>
            <div>{{name}} <span style="float:right"><i class="fa fa-phone"></i> {{telNo}}</span></div>
        </td>
    </tr>
    {{/each}}
    </script>
    <script id="empty" type="text/x-handlebars-template">
    <div class="text-center">검색 결과가 없습니다. 앱에서 신규 가입을 해주세요.</div>
    <div class="col-lg text-center" style="margin-bottom: 20px;" >

    </div>
    </script>
</my:html>




