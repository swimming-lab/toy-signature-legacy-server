package com.github.bestheroz.standard.common.util;

import com.github.bestheroz.main.web.member.MemberVO;
import com.github.bestheroz.main.web.tablevo.mbr_arrears_lst.TableMbrArrearsLstVO;
import com.github.bestheroz.main.web.tablevo.mbr_info_mst.TableMbrInfoMstVO;
import lombok.experimental.UtilityClass;

import javax.mail.*;
import javax.mail.internet.*;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

/**
 * 카페24 문자 전송 모듈
 */
@UtilityClass
public class SmtpUtils {
//    @Resource
//    private TemplateEngine templateEngine;

    private final static String USER       = "genius.developer.company@gmail.com";   // gmail 계정
    private final static String PASSWORD   = "pass@word1";           // 패스워드
    private final static String CHARSET    = "UTF-8";                  // 인코딩


    public static void sendGmail(String receiver, String subject, String template) {
        // SMTP 서버 정보를 설정한다.
        Properties prop = new Properties();
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.port", "587");

//        prop.put("mail.smtp.host", "smtp.gmail.com");
//        prop.put("mail.smtp.port", 465);
//        prop.put("mail.smtp.auth", "true");
//        prop.put("mail.smtp.ssl.enable", "true");
//        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USER, PASSWORD);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USER));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
            message.setSubject(subject, CHARSET);
//            message.setText(text, CHARSET);

            // html 사용을 위한 Multipart 사용
            Multipart mp = new MimeMultipart();
            MimeBodyPart htmlPart = new MimeBodyPart();
            htmlPart.setContent(template, "text/html; charset=" + CHARSET);
            mp.addBodyPart(htmlPart);
            message.setContent(mp);

            // send the message
            Transport.send(message); ////전송
            System.out.println("message sent successfully...");
        } catch (AddressException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public String getArrearsSubject() {
        return "체불신고가 접수 되었습니다.";
    }

    public String getArrearsTemplate(final TableMbrArrearsLstVO arrearsVO) {
        Date date = arrearsVO.getRegDt().toDate();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");

        System.out.println(SessionUtils.getMemberVO().getName());
        System.out.println(sdf.format(date));
        System.out.println(arrearsVO.getWorkStartDy());
        System.out.println(arrearsVO.getWorkEndDy());
        System.out.println(arrearsVO.getArrearsNm());
        System.out.println(arrearsVO.getBizcoNm());
        System.out.println(arrearsVO.getBizcoRegNo());
        System.out.println(NumberFormat.getInstance().format(arrearsVO.getArrearsAmt()));
        System.out.println(arrearsVO.getWorkNm());
        System.out.println(arrearsVO.getWorkLocNm());
        System.out.println(arrearsVO.getArrearsConts());


        String template = String.format("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n" +
                "<html xmlns=\"http://www.w3.org/1999/xhtml\">\n" +
                "<head>\n" +
                "    <meta name=\"viewport\" content=\"width=device-width\" />\n" +
                "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n" +
                "    <title>전자임대차 표준계약서</title>\n" +
                "</head>\n" +
                "\n" +
                "<body style=\"background-color: #f6f6f6;\">\n" +
                "\n" +
                "<table style=\"background-color: #f6f6f6;width: 100%%;\">\n" +
                "    <tr>\n" +
                "        <td></td>\n" +
                "        <td  width=\"600\">\n" +
                "            <div >\n" +
                "                <table style=\"background: #fff;border: 1px solid #e9e9e9;border-radius: 3px;\" width=\"100%%\" cellpadding=\"0\" cellspacing=\"0\">\n" +
                "                    <tr>\n" +
                "                        <td style=\"background: #f8ac59;font-size: 20px;color: #fff;font-weight: 500;padding: 20px;text-align: center;border-radius: 3px 3px 0 0;\">\n" +
                "                            체불신고가 접수 되었습니다.\n" +
                "                        </td>\n" +
                "                    </tr>\n" +
                "                    <tr>\n" +
                "                        <td style=\"padding: 20px;\">\n" +
                "                            <table width=\"100%%\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 14px\">\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        <strong>%s님</strong>께서 작성하신 체불신고가 접수 되었습니다.\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 신고일시 : %s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 작업일 : %s ~ %s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 체불자 이름 : %s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 상호명 : %s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 사업자등록번호 : %s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 피해금액 : %s원\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 현장명 : %s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 현장소재지 : %s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 그외 상세내용 <br>%s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\" align=\"center\">\n" +
                "                                        <a href=\"#\" style=\"text-decoration: none;color: #FFF;background-color: #f8ac59;border: solid #f8ac59;border-width: 5px 10px;line-height: 2;font-weight: bold;text-align: center;cursor: pointer;display: inline-block;border-radius: 5px;text-transform: capitalize;\">\n" +
                "                                            체불신청내역 확인\n" +
                "                                        </a>\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\" align=\"center\">\n" +
                "                                        건설기계임대차 표준계약서\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                            </table>\n" +
                "                        </td>\n" +
                "                    </tr>\n" +
                "                </table>\n" +
                "            </div>\n" +
                "        </td>\n" +
                "        <td></td>\n" +
                "    </tr>\n" +
                "</table>\n" +
                "\n" +
                "</body>\n" +
                "</html>\n",
            SessionUtils.getMemberVO().getName(),
            sdf.format(date),
            arrearsVO.getWorkStartDy(),
            arrearsVO.getWorkEndDy(),
            arrearsVO.getArrearsNm(),
            arrearsVO.getBizcoNm(),
            arrearsVO.getBizcoRegNo(),
            NumberFormat.getInstance().format(arrearsVO.getArrearsAmt()),
            arrearsVO.getWorkNm(),
            arrearsVO.getWorkLocNm(),
            arrearsVO.getArrearsConts()
        );

        return template;
    }

    public String getResetMemberPasswordSubject() {
        return "계정관리 비밀번호 초기화 요청";
    }

    public String getResetMemberPasswordTemplate(final MemberVO memberVO) {
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");

        System.out.println(memberVO.getBizcoNm());
        System.out.println(sdf.format(date));
        System.out.println(memberVO.getBizcoNm());
        System.out.println(memberVO.getBizcoRegNo());
        System.out.println(memberVO.getName());
        System.out.println(memberVO.getTelNo());

        String template = String.format("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n" +
                "<html xmlns=\"http://www.w3.org/1999/xhtml\">\n" +
                "<head>\n" +
                "    <meta name=\"viewport\" content=\"width=device-width\" />\n" +
                "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n" +
                "    <title>전자임대차 표준계약서</title>\n" +
                "</head>\n" +
                "\n" +
                "<body style=\"background-color: #f6f6f6;\">\n" +
                "\n" +
                "<table style=\"background-color: #f6f6f6;width: 100%%;\">\n" +
                "    <tr>\n" +
                "        <td></td>\n" +
                "        <td  width=\"600\">\n" +
                "            <div >\n" +
                "                <table style=\"background: #fff;border: 1px solid #e9e9e9;border-radius: 3px;\" width=\"100%%\" cellpadding=\"0\" cellspacing=\"0\">\n" +
                "                    <tr>\n" +
                "                        <td style=\"background: #f8ac59;font-size: 20px;color: #fff;font-weight: 500;padding: 20px;text-align: center;border-radius: 3px 3px 0 0;\">\n" +
                "                            계정관리 비밀번호 초기화 요청\n" +
                "                        </td>\n" +
                "                    </tr>\n" +
                "                    <tr>\n" +
                "                        <td style=\"padding: 20px;\">\n" +
                "                            <table width=\"100%%\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 14px\">\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        <strong>%s님</strong>께서 계정관리 비밀번호 초기화를 요청하였습니다.\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 요청일시 : %s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 상호명 : %s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 사업자등록번호 : %s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 성명 : %s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\">\n" +
                "                                        • 연락처 : %s\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\" align=\"center\">\n" +
                "                                        <a href=\"#\" style=\"text-decoration: none;color: #FFF;background-color: #f8ac59;border: solid #f8ac59;border-width: 5px 10px;line-height: 2;font-weight: bold;text-align: center;cursor: pointer;display: inline-block;border-radius: 5px;text-transform: capitalize;\">\n" +
                "                                            회원관리 화면 이동\n" +
                "                                        </a>\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                                <tr>\n" +
                "                                    <td style=\"padding: 0 0 20px;\" align=\"center\">\n" +
                "                                        건설기계임대차 표준계약서\n" +
                "                                    </td>\n" +
                "                                </tr>\n" +
                "                            </table>\n" +
                "                        </td>\n" +
                "                    </tr>\n" +
                "                </table>\n" +
                "            </div>\n" +
                "        </td>\n" +
                "        <td></td>\n" +
                "    </tr>\n" +
                "</table>\n" +
                "\n" +
                "</body>\n" +
                "</html>\n",
            memberVO.getBizcoNm(),
            sdf.format(date),
            memberVO.getBizcoNm(),
            memberVO.getBizcoRegNo(),
            memberVO.getName(),
            memberVO.getTelNo()
        );

        return template;
    }

    public String getResetAppPasswordSubject() {
        return "앱 로그인 비밀번호 초기화 요청";
    }

    public String getResetAppPasswordTemplate(final TableMbrInfoMstVO memberVO) {
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");

        System.out.println(memberVO.getBizcoNm());
        System.out.println(sdf.format(date));
        System.out.println(memberVO.getBizcoNm());
        System.out.println(memberVO.getBizcoRegNo());
        System.out.println(memberVO.getName());
        System.out.println(memberVO.getTelNo());

        String template = String.format("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n" +
                        "<html xmlns=\"http://www.w3.org/1999/xhtml\">\n" +
                        "<head>\n" +
                        "    <meta name=\"viewport\" content=\"width=device-width\" />\n" +
                        "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n" +
                        "    <title>전자임대차 표준계약서</title>\n" +
                        "</head>\n" +
                        "\n" +
                        "<body style=\"background-color: #f6f6f6;\">\n" +
                        "\n" +
                        "<table style=\"background-color: #f6f6f6;width: 100%%;\">\n" +
                        "    <tr>\n" +
                        "        <td></td>\n" +
                        "        <td  width=\"600\">\n" +
                        "            <div >\n" +
                        "                <table style=\"background: #fff;border: 1px solid #e9e9e9;border-radius: 3px;\" width=\"100%%\" cellpadding=\"0\" cellspacing=\"0\">\n" +
                        "                    <tr>\n" +
                        "                        <td style=\"background: #f8ac59;font-size: 20px;color: #fff;font-weight: 500;padding: 20px;text-align: center;border-radius: 3px 3px 0 0;\">\n" +
                        "                            계정관리 비밀번호 초기화 요청\n" +
                        "                        </td>\n" +
                        "                    </tr>\n" +
                        "                    <tr>\n" +
                        "                        <td style=\"padding: 20px;\">\n" +
                        "                            <table width=\"100%%\" cellpadding=\"0\" cellspacing=\"0\" style=\"font-size: 14px\">\n" +
                        "                                <tr>\n" +
                        "                                    <td style=\"padding: 0 0 20px;\">\n" +
                        "                                        <strong>%s님</strong>께서 앱 로그인 비밀번호 초기화를 요청하였습니다.\n" +
                        "                                    </td>\n" +
                        "                                </tr>\n" +
                        "                                <tr>\n" +
                        "                                    <td style=\"padding: 0 0 20px;\">\n" +
                        "                                        • 요청일시 : %s\n" +
                        "                                    </td>\n" +
                        "                                </tr>\n" +
                        "                                <tr>\n" +
                        "                                    <td style=\"padding: 0 0 20px;\">\n" +
                        "                                        • 상호명 : %s\n" +
                        "                                    </td>\n" +
                        "                                </tr>\n" +
                        "                                <tr>\n" +
                        "                                    <td style=\"padding: 0 0 20px;\">\n" +
                        "                                        • 사업자등록번호 : %s\n" +
                        "                                    </td>\n" +
                        "                                </tr>\n" +
                        "                                <tr>\n" +
                        "                                    <td style=\"padding: 0 0 20px;\">\n" +
                        "                                        • 성명 : %s\n" +
                        "                                    </td>\n" +
                        "                                </tr>\n" +
                        "                                <tr>\n" +
                        "                                    <td style=\"padding: 0 0 20px;\">\n" +
                        "                                        • 연락처 : %s\n" +
                        "                                    </td>\n" +
                        "                                </tr>\n" +
                        "\n" +
                        "                                <tr>\n" +
                        "                                    <td style=\"padding: 0 0 20px;\" align=\"center\">\n" +
                        "                                        <a href=\"#\" style=\"text-decoration: none;color: #FFF;background-color: #f8ac59;border: solid #f8ac59;border-width: 5px 10px;line-height: 2;font-weight: bold;text-align: center;cursor: pointer;display: inline-block;border-radius: 5px;text-transform: capitalize;\">\n" +
                        "                                            회원관리 화면 이동\n" +
                        "                                        </a>\n" +
                        "                                    </td>\n" +
                        "                                </tr>\n" +
                        "                                <tr>\n" +
                        "                                    <td style=\"padding: 0 0 20px;\" align=\"center\">\n" +
                        "                                        건설기계임대차 표준계약서\n" +
                        "                                    </td>\n" +
                        "                                </tr>\n" +
                        "                            </table>\n" +
                        "                        </td>\n" +
                        "                    </tr>\n" +
                        "                </table>\n" +
                        "            </div>\n" +
                        "        </td>\n" +
                        "        <td></td>\n" +
                        "    </tr>\n" +
                        "</table>\n" +
                        "\n" +
                        "</body>\n" +
                        "</html>\n",
                memberVO.getBizcoNm(),
                sdf.format(date),
                memberVO.getBizcoNm(),
                memberVO.getBizcoRegNo(),
                memberVO.getName(),
                memberVO.getTelNo()
        );

        return template;
    }

//    public String build(String message) {
//        Context context = new Context();
//        context.setVariable("message", message);
//        return templateEngine.process("/email/", context);
//    }
}
