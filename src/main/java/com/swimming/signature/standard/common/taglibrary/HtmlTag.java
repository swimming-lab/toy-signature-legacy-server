package com.github.bestheroz.standard.common.taglibrary;

import com.github.bestheroz.standard.common.constant.CommonCode;
import com.github.bestheroz.standard.common.exception.BusinessException;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;

import javax.servlet.jsp.tagext.TagSupport;
import java.text.MessageFormat;


@Slf4j
@Data
public class HtmlTag extends TagSupport {
    private static final long serialVersionUID = 491839523317391051L;
    private final StringBuilder sb = new StringBuilder();

    private String title;
    /**
     * Plugin JS, CSS
     */
    private String cookie;
    private String datetimePicker;
    private String fileDownloader;
    private String icon;
    private String handlebars;
    private String maxLength;
    private String modal;
    private String numberFormatter;
    private String paging;
    private String progressBar;
    private String popup;
    private String scrollUp;
    private String table;
    private String textEditor;
    private String validator;
    private String signaturePad;
    private String step;
    private String form;
    private String navigationBar;
    private String ajaxPage;
    private String pcVersion;

    @Override
    public int doStartTag() {
        try {
            this.sb.setLength(0);
            this.sb.append("<!DOCTYPE html>");
            this.sb.append("<html lang=\"ko\">");
            this.sb.append("<head>");
            this.sb.append("<title>");
            if (StringUtils.isEmpty(this.title)) {
                this.sb.append("전자임대차 표준계약서");
            } else {
                this.sb.append(this.title);
            }
            this.sb.append("</title>");
            this.sb.append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, user-scalable=no, shrink-to-fit=no\">");
            this.sb.append("<meta http-equiv=\"Content-Type\" charset=\"UTF-8\" content=\"text/html; charset=utf-8\" />");
            this.sb.append("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\" />");
            this.sb.append("<link rel=\"shortcut icon\" href=\"data:image/x-icon;,\" type=\"image/x-icon\"> ");


            // ## CSS ##
            // - 부트스트랩 css 호출 순서 중요함
            // common
            this.makeLinkTag(CommonCode.PATH_PUBLISH + "/css/bootstrap.min.css" + CommonCode.RESOUCE_VERSION);
            this.makeLinkTag(CommonCode.PATH_PUBLISH + "/font-awesome/css/font-awesome.css" + CommonCode.RESOUCE_VERSION);
            this.makeLinkTag(CommonCode.PATH_PUBLISH + "/css/plugins/iCheck/custom.css" + CommonCode.RESOUCE_VERSION);
            this.makeLinkTag(CommonCode.PATH_PUBLISH + "/css/plugins/iCheck/yellow.css" + CommonCode.RESOUCE_VERSION);
            // join.html(순서가 중요해서 여기있음)
            if (StringUtils.equals(this.step, CommonCode.YES)) {
                this.makeLinkTag(CommonCode.PATH_PUBLISH + "/css/plugins/steps/jquery.steps.css" + CommonCode.RESOUCE_VERSION);
            }
            this.makeLinkTag(CommonCode.PATH_PUBLISH + "/css/plugins/sweetalert/sweetalert.css" + CommonCode.RESOUCE_VERSION);
            // form.html
            if (StringUtils.equals(this.form, CommonCode.YES)) {
                this.makeLinkTag(CommonCode.PATH_PUBLISH + "/css/plugins/datapicker/datepicker3.css" + CommonCode.RESOUCE_VERSION);
                this.makeLinkTag(CommonCode.PATH_PUBLISH + "/css/plugins/jasny/jasny-bootstrap.min.css" + CommonCode.RESOUCE_VERSION);
            }
            // common
            this.makeLinkTag(CommonCode.PATH_PUBLISH + "/css/animate.css" + CommonCode.RESOUCE_VERSION);
            this.makeLinkTag(CommonCode.PATH_PUBLISH + "/css/style.css" + CommonCode.RESOUCE_VERSION);
            this.makeLinkTag(CommonCode.PATH_PUBLISH + "/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" + CommonCode.RESOUCE_VERSION);
            // signature-pad css
            if (StringUtils.equals(this.signaturePad, CommonCode.YES)) {
                this.makeLinkTag(CommonCode.PATH_PLUGIN + "/signature-pad/signature-pad.css" + CommonCode.RESOUCE_VERSION);
                this.makeLinkTag(CommonCode.PATH_PLUGIN + "/jquery-signature-pad/jquery.signaturepad.css" + CommonCode.RESOUCE_VERSION);
            }
//            this.makeLinkTag("https://cdnjs.cloudflare.com/ajax/libs/pace/1.0.2/themes/black/pace-theme-corner-indicator.min.css");

            // ## JS ##
            // - 부트스트랩 js 호출 순서 중요함
            this.makeScriptTag(CommonCode.PATH_PUBLISH + "/js/jquery-3.1.1.min.js" + CommonCode.RESOUCE_VERSION);
            this.makeScriptTag(CommonCode.PATH_PUBLISH + "/js/popper.min.js" + CommonCode.RESOUCE_VERSION);
            this.makeScriptTag(CommonCode.PATH_PUBLISH + "/js/bootstrap.js" + CommonCode.RESOUCE_VERSION);
            this.makeScriptTag(CommonCode.PATH_PUBLISH + "/js/plugins/metisMenu/jquery.metisMenu.js" + CommonCode.RESOUCE_VERSION);
            this.makeScriptTag(CommonCode.PATH_PUBLISH + "/js/plugins/slimscroll/jquery.slimscroll.min.js" + CommonCode.RESOUCE_VERSION);
            this.makeScriptTag(CommonCode.PATH_PUBLISH + "/js/inspinia.js" + CommonCode.RESOUCE_VERSION);
            this.makeScriptTag(CommonCode.PATH_PUBLISH + "/js/plugins/pace/pace.min.js" + CommonCode.RESOUCE_VERSION);

            this.makeScriptTag(CommonCode.PATH_PLUGIN + "/common/lodash.min.js" + CommonCode.RESOUCE_VERSION);
            this.makeScriptTag(CommonCode.PATH_PLUGIN + "/common/moment.min.js" + CommonCode.RESOUCE_VERSION);
            this.makeScriptTag(CommonCode.PATH_PLUGIN + "/common/moment_ko.js" + CommonCode.RESOUCE_VERSION);

            // ## JS ##
//            this.makeScriptTag(CommonCode.PATH_PUBLISH + "/js/bootstrap.js");
//            this.makeScriptTag(CommonCode.PATH_PUBLISH + "/js/jquery-3.1.1.min.js");
//            this.makeScriptTag(CommonCode.PATH_PLUGIN + "/common/lodash.min.js");

            this.sb.append("<script>");
            this.sb.append(MessageFormat.format("const CONTEXT_PATH = ''{0}'';", CommonCode.CONTEXT_PATH));
            this.sb.append("</script>");
            this.makeScriptTag(CommonCode.PATH_JS + "/MyCommon.js" + CommonCode.RESOUCE_VERSION);
            this.makeScriptTag(CommonCode.PATH_JS + "/MyKeyup.js" + CommonCode.RESOUCE_VERSION);
            this.makeScriptTag(CommonCode.PATH_JS + "/MyAjax.js" + CommonCode.RESOUCE_VERSION);

            if (StringUtils.equals(this.cookie, CommonCode.YES)) {
                this.makeScriptTag(CommonCode.PATH_JS + "/MyCookie.js" + CommonCode.RESOUCE_VERSION);
            }
            if (StringUtils.equals(this.handlebars, CommonCode.YES)) {
                this.makeScriptTag(CommonCode.PATH_PLUGIN + "/common/handlebars.min.js" + CommonCode.RESOUCE_VERSION);
                this.makeScriptTag(CommonCode.PATH_JS + "/MyHandlebars.js" + CommonCode.RESOUCE_VERSION);
            }
            if (StringUtils.equals(this.modal, CommonCode.YES)) {
                this.makeScriptTag(CommonCode.PATH_JS + "/MyModal.js" + CommonCode.RESOUCE_VERSION);
            }
            if (StringUtils.equals(this.ajaxPage, CommonCode.YES)) {
                this.makeScriptTag(CommonCode.PATH_JS + "/MyAjaxPage.js" + CommonCode.RESOUCE_VERSION);
            }
            if (StringUtils.equals(this.fileDownloader, CommonCode.YES)) {
                this.makeScriptTag("https://cdn.jsdelivr.net/npm/jquery-file-download@1.4.6/src/Scripts/jquery.fileDownload.js");
            }
//            if (StringUtils.equals(this.numberFormatter, CommonCode.YES)) {
//                this.makeScriptTag("https://cdn.jsdelivr.net/npm/jquery-number@2.1.6/jquery.number.min.js");
//            }
//            if (StringUtils.equals(this.paging, CommonCode.YES)) {
//                this.makeScriptTag(CommonCode.PATH_JS + "/MyPaging.js");
//            }
//            if (!StringUtils.equals(this.scrollUp, CommonCode.NO)) {
//                this.makeLinkTag(CommonCode.PATH_CSS + "/MyScrollUp.css");
//                this.makeScriptTag("https://cdnjs.cloudflare.com/ajax/libs/scrollup/2.4.1/jquery.scrollUp.min.js");
//                this.makeScriptTag(CommonCode.PATH_JS + "/MyScrollUp.js");
//            }

            this.sb.append("</head>");
            if (StringUtils.equals(this.pcVersion, CommonCode.YES)) {
                this.sb.append("<body class=\"gray-bg\">");
            } else if (StringUtils.equals(this.ajaxPage, CommonCode.YES)) {
                this.sb.append("<body>");
            } else {
                this.sb.append("<body class=\"full-height-layout\">");
            }

            this.pageContext.getOut().print(this.sb.toString());
            return EVAL_BODY_INCLUDE;
        } catch (final Throwable e) {
            log.warn(ExceptionUtils.getStackTrace(e));
            throw new BusinessException(e);
        }
    }

    @Override
    public int doEndTag() {
        try {
            if (StringUtils.isNotEmpty(this.navigationBar)) {
                this.sb.setLength(0);
                this.sb.append("<div style=\"position: fixed;bottom: 0px;width: 100%;border-top: 1px solid #c7c2c2;\"> ");
                this.sb.append("<ul class=\"footerBar\">");
                this.sb.append("<li onclick=\"MyCommon.goLink('/main/main.view')\">");
                this.sb.append("<div class=\"footerIcon "+(this.navigationBar.equals("1")==true? "selected":"") +"\" style=\"font-size: 25px;margin-bottom: -4px;\">");
                this.sb.append("<i class=\"fa fa-home\"></i>");
                this.sb.append("</div>");
                this.sb.append("<div class=\"footerTxt "+(this.navigationBar.equals("1")==true? "selected":"") +"\">홈</div>");
                this.sb.append("</li>");
                this.sb.append("<li onclick=\"MyCommon.goLink('/contract/list.view')\">");
                this.sb.append("<div class=\"footerIcon "+(this.navigationBar.equals("2")==true? "selected":"") +"\">");
                this.sb.append("<i class=\"fa fa-file-text-o\"></i>");
                this.sb.append("</div>");
                this.sb.append("<div class=\"footerTxt "+(this.navigationBar.equals("2")==true? "selected":"") +"\">계약서관리</div>");
                this.sb.append("</li>");
                this.sb.append("<li onclick=\"MyCommon.goLink('/member/mypage.view')\">");
                this.sb.append("<div class=\"footerIcon "+(this.navigationBar.equals("3")==true? "selected":"") +"\">");
                this.sb.append("<i class=\"fa fa-user-o\" aria-hidden=\"true\"></i>");
                this.sb.append("</div>");
                this.sb.append("<div class=\"footerTxt "+(this.navigationBar.equals("3")==true? "selected":"") +"\">내정보</div>");
                this.sb.append("</li>");
                this.sb.append("</ul>");
                this.sb.append("</div>");
                this.pageContext.getOut().print(this.sb.toString());
            }

            // ajax 로딩바 추가
            this.sb.setLength(0);
            this.sb.append("<div id=\"overlay\">");
            this.sb.append("<div class=\"cv-spinner\">");
            this.sb.append("<span class=\"spinner\"></span>");
            this.sb.append("</div>");
            this.sb.append("</div>");
            this.pageContext.getOut().print(this.sb.toString());

            this.pageContext.getOut().print("</body></html>");
            return SKIP_PAGE;
        } catch (final Throwable e) {
            log.warn(ExceptionUtils.getStackTrace(e));
            throw new BusinessException(e);
        }
    }

    private void makeScriptTag(final String path) {
        this.sb.append("<script src=\"").append(path).append("\"></script>");
    }

    private void makeLinkTag(final String path) {
        this.sb.append("<link rel=\"stylesheet\" href=\"").append(path).append("\" />");
    }
}
