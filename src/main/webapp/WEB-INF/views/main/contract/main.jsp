<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES">
    <main role="main" class="flex-shrink-0">
        <div class="middle-box text-center loginscreen animated fadeInDown">
            <div>
                <div>
                    <h2 class="logo-name"></h2>
                </div>

                <h2>전자임대차<br>표준계약서</h2>
                <div>이미지 영역</div>
                <button id="new" type="button" class="btn btn-primary block full-width m-b">새로작성</button>
                <button id="load" type="button" class="btn btn-primary block full-width m-b">불러오기</button>
            </div>
        </div>
    </main>

    <my:footer/>

    <script data-for="ready">
        jQuery(($) => {
            $('#new').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/contract/insertForm.view');
                return false;
            });

            $('#load').on('click', (event) => {
                event.preventDefault();
                MyCommon.goLink('/contract/load.view');
                return false;
            });
        });
    </script>
</my:html>
