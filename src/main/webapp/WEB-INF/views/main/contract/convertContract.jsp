<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES" validator="YES">
    <script src="https://cdn.rawgit.com/eligrey/FileSaver.js/5ed507ef8aa53d8ecfea96d96bc7214cd2476fd2/FileSaver.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.js"></script>
    <script type="text/javascript">
        function contractSave() {
          html2canvas($("#contractImage"), {
            onrendered: function(canvas) {
              canvas.toBlob(function(blob) {
                //파일명 : 임대차계약서+계약서번호+일자
                saveAs(blob, 'image.png');
              });
            }
          });
        }
    </script>
 <div id="contractImage" style="border: 2px solid;width: 650px;height:920px;margin: 0 auto;background-color: #fff;">
     <div style="width: 80%;text-align: center;font-size: 30px;font-weight: bold;display: inline-block;line-height: 80px;vertical-align: top">
         건설기계임대차 표준계약서<span style="font-size:20px">(작업확인서)</span>
     </div>
     <div style="display: inline-block;text-align: center">
         <div><img src="/resources/publish/img/FTC_logo.jpg" width="100"/></div>
         <div style="font-size: 11px;margin-top:-5px">표준약관 제100059호</div>
     </div>
     <div style="border-top: 2px solid;border-bottom:2px solid;padding: 10px;">
         <div style="font-size: 17px;font-weight: bold;">1.목적물의 표시 <span style="font-size: 12px"> - 가. 건설기계</span></div>
         <table width="100%" border="1" align="center">
             <tr align="center">
                 <td width="26%">건설기계명</td>
                 <td width="20%">등록번호</td>
                 <td width="20%">형식</td>
                 <td width="17%">보험(공제)가입현황</td>
                 <td width="17%">정기검사여부</td>
             </tr>
             <tr align="center" height="50">
                 <td>포크레인</td>
                 <td>43주3421</td>
                 <td>Zddke8sd</td>
                 <td>가입</td>
                 <td>가입</td>
             </tr>
         </table>
         <div style="font-size: 12px;font-weight: bold;margin-top:5px">나. 현장</div>
         <table width="100%" border="1" align="center">
             <tr align="center">
                 <td width="27%">현장명</td>
                 <td width="37%">현장소재지</td>
                 <td width="18%">발급자(원수급인)</td>
                 <td width="18%">건설업자(임차인)</td>
             </tr>
             <tr align="center" height="50">
                 <td>구래동 예미지주상복합</td>
                 <td>경기도 김포시 구래동 김포한강4로 471</td>
                 <td>강희동</td>
                 <td>유수영</td>
             </tr>
         </table>
         <div style="margin-top:10px">
             <div style="font-size: 17px;font-weight: bold;">2.사용기간</div>
             <div style="padding-left:18px;font-size: 15px">
                 2020년 <span style="font-size: 17px">5</span>월  <span style="font-size: 17px">21</span>일 부터
                 2020년 <span style="font-size: 17px">5</span>월 <span style="font-size: 17px">22</span>일까지
                 (<span style="font-size: 17px">2</span>일작업)
                 <span style="font-size: 17px">08</span>시 <span style="font-size: 17px">00</span>분 ~
                 <span style="font-size: 17px">17</span>시 <span style="font-size: 17px">00</span>분까지(<span style="font-size: 17px">8</span>시간)</div>
         </div>
         <div style="margin-top:10px">
             <div style="font-size: 17px;font-weight: bold;">3.사용금액 : <span style="font-size:16px;font-weight: normal;">당금 육십오만원(650,000원)</span></div>
             <table width="100%" border="1" align="center">
                 <tr height="80">
                     <td width="10%" align="center">작 업<br>내 용</td>
                     <td style="padding:5px">
                         아파트 출입구 내 조경 작업 및 컨테이너 철거
                     </td>
                 </tr>
             </table>
         </div>
         <div style="margin-top:10px">
             <div style="font-size: 17px;font-weight: bold;">4.지급시기 <span style="font-size:16px;font-weight: normal;">(제6조 제2항이 적용되지 않는 경우 적용)</span></div>
             <div style="font-size:11px;">대여기간이 1개월 초과하는 경우에는 매월 종료하는 날부터 <span style="font-size: 15px">2</span>일 이내,
                 대여기간이 1개월 이하인 경우에는 그 기간이 종료하는 날부터 <span style="font-size: 15px">3</span>일 이내</div>
         </div>
     </div>
     <div>
         <div style="font-size:11px;padding: 8px 50px;letter-spacing: 0.3px;">
             건설기계임대인과 건설기계임차인은 합의에 따라 붙임서류에 의하여 계약을 체결하고, 신의에 따라 성실히 계약상의 의무를 이행할 것을 확약하며, 이 계약의 증거로 계약서를 2통 작성하여 서명, 날인 후 각 1부씩 보관한다.
             <br>※ 붙임서류 : 1.건설기계임대차 표준계약 일반조건 1부, 2.건설기계임대차 계약 특수조건 1부(필요시)
         </div>
        <div style="text-align: center;font-size: 17px;font-weight: bold;letter-spacing: 1px">계약 및 작업일 : 2020년 5월 24일</div>
        <div style="padding:10px">
            <div style="font-size: 17px;font-weight: bold;">※ 임대인 <span style="font-size: 16px">(건설기계 사업자)</span></div>
            <table width="100%" border="1" align="center">
                <tr align="center">
                    <td width="15%">상호</td>,
                    <td width="35%">가산중기</td>
                    <td width="15%">사업자등록번호</td>
                    <td width="35%">123-456789-10</td>
                </tr>
                <tr align="center">
                    <td width="15%">성명</td>
                    <td width="35%">이강진 (대리인 : 권석택)</td>
                    <td width="15%">연락처</td>
                    <td width="35%">010-1234-1234</td>
                </tr>
                <tr align="center">
                    <td width="15%">주소</td>
                    <td colspan="3" align="left" style="padding-left:7px">경기도 김포시 통진읍 123-123 가산중기</td>
                </tr>
            </table>
            <div style="font-size: 17px;font-weight: bold;margin-top:5px">※ 임차인 <span style="font-size: 16px">(건설업자 및 현장)</span></div>
            <table width="100%" border="1" align="center">
                <tr align="center">
                    <td width="15%">상호</td>
                    <td width="35%">대림건설</td>
                    <td width="15%">사업자등록번호</td>
                    <td width="35%">222-333333-10</td>
                </tr>
                <tr align="center">
                    <td width="15%">성명</td>
                    <td width="35%">강희동</td>
                    <td width="15%">연락처</td>
                    <td width="35%">010-0000-1111</td>
                </tr>
                <tr align="center">
                    <td width="15%">주소</td>
                    <td colspan="3" align="left" style="padding-left:7px">경기도 김포시 구래동 김포한강4로 471 대림건설</td>
                </tr>
            </table>
            <div style="text-align: center;font-size: 17px;vertical-align: bottom;margin-top: 10px;">
                현장대리인 : 강희동
                <span>
                    <!--이미지는 샘플로 넣은거니 맞춰서 넣으면 되요-->
                    <img src="/resources/publish/img/signature_sample.png" width="200">
                </span>
            </div>

        </div>
     </div>
 </div>
    <center style="font-size: 30px">
    <a href="javascript:contractSave()">저장하기</a>
    </center>
</my:html>
