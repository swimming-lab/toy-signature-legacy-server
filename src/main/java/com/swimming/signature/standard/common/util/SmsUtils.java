package com.github.bestheroz.standard.common.util;

import com.github.bestheroz.main.web.contract.ContractVO;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.HttpClients;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.*;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 카페24 문자 전송 모듈
 */
@Slf4j
@UtilityClass
public class SmsUtils {
    /**
     * 카페24 모듈(블로그:https://m.blog.naver.com/todangs/220644831754)
     */
    public static void sendSMS(String rphone, String msg) {
        // 기본값
        final String API_URL    = "https://sslsms.cafe24.com/sms_sender.php";
        final String USER_ID    = "signature20";
        final String SECURE     = "0b026d1ac5f0afb68a0319798bdf279b";
        final String MODE       = "1";
        final String SPHONE_1   = "010";
        final String SPHONE_2   = "3793";
        final String SPHONE_3   = "9144";
//      final String SPHONE_2   = "9266";
//      final String SPHONE_3   = "8883";
//      final String SMS_TYPE   = "S";
        final String SMS_TYPE   = "L";
        final boolean IS_TEST   = false;

        try {
            // 파라미터 셋팅
            String postParams = "";
            postParams += "user_id="     + base64Encode(USER_ID);
            postParams += "&secure="     + base64Encode(SECURE);
            postParams += "&mode="       + base64Encode(MODE);
            postParams += "&sphone1="    + base64Encode(SPHONE_1);
            postParams += "&sphone2="    + base64Encode(SPHONE_2);
            postParams += "&sphone3="    + base64Encode(SPHONE_3);
            postParams += "&smsType="    + base64Encode(SMS_TYPE);
            postParams += "&rphone="     + base64Encode(rphone);
            postParams += "&msg="        + base64Encode(msg);
            if (IS_TEST) {
                postParams += "&testflag=" + base64Encode("Y");
            }

            // 문자 전송
            URL obj = new URL(API_URL);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            con.setRequestProperty("Accept-Charset", "UTF-8");
            con.setRequestProperty("User-Agent", "Mozilla/5.0");
            con.setDoOutput(true);
            OutputStream os = con.getOutputStream();
            os.write(postParams.getBytes());
            os.flush();
            os.close();

            // 응답코드 확인
            int responseCode = con.getResponseCode();
            log.debug("[sms] status: " + responseCode + ", phone: " + rphone + ", msg: " + msg);
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String inputLine;
                StringBuffer buf = new StringBuffer();

                while((inputLine = in.readLine()) != null) {
                    buf.append(inputLine);
                }
                in.close();
                log.debug(buf.toString());
            }

        } catch (ProtocolException e) {
            e.printStackTrace();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * BASE64 Encoder
     * @param str
     * @return
     */
    private String base64Encode(String str) throws java.io.IOException {
        sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
        byte[] strByte = str.getBytes();
        String result = encoder.encode(strByte);
        return result ;
    }

    /**
     * BASE64 Decoder
     * @param str
     * @return
     */
    private String base64Decode(String str)  throws java.io.IOException {
        sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
        byte[] strByte = decoder.decodeBuffer(str);
        String result = new String(strByte);
        return result ;
    }

    public String getContractTemplate(final ContractVO contractVO) {
        Date date = contractVO.getUpdDt().toDate();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");

        String msg = String.format("[전자임대차표준계약서]\n" +
                        "-계약일시 : %s\n" +
                        "-임대인(대리인) : %s(%s)\n" +
                        "-임차인 : %s %s\n" +
                        "-현장대리인 : %s\n" +
                        "-현장명 : %s\n",
                sdf.format(date),
                SessionUtils.getMemberVO().getName(),
                contractVO.getAgentNm(),
                contractVO.getBizcoNm(),
                contractVO.getName(),
                contractVO.getWorkAgentNm(),
                contractVO.getWorkNm());

        // template 샘플
        // String msg = "[전자임대차표준계약서]\n" +
        //                "-계약일시 : 20년6월1일 10시12분\n" +
        //                "-임대인(대리인) : 강희동(권석택)\n" +
        //                "-임차인 : 대림건설 이강진\n" +
        //                "-현장대리인 : 유수영\n" +
        //                "-현장명 :   김포풍무지구 이편한세상 1A\n";

        return msg;
    }

    /**
     * 알리고 SMS 모듈
     * @param rphone
     * @param msg
     * @param image
     */
    public void sendSMS2(String rphone, String msg, String image) {
        try {
            final String encodingType = "utf-8";
            final String boundary = "____boundary____";

            /**************** 문자전송하기 예제 ******************/
            /* "result_code":결과코드,"message":결과문구, */
            /* "msg_id":메세지ID,"error_cnt":에러갯수,"success_cnt":성공갯수 */
            /* 동일내용 > 전송용 입니다.
            /******************** 인증정보 ********************/
            String sms_url = "https://apis.aligo.in/send/"; // 전송요청 URL

            Map<String, String> sms = new HashMap<String, String>();
            sms.put("user_id", "signature"); // SMS 아이디
            sms.put("key", "6czhckr78efi25vpl94jcxtd2rxxvd8e"); //인증키
            /******************** 인증정보 ********************/

            /******************** 전송정보 ********************/
            rphone = rphone.replaceAll("-", "");
            sms.put("msg", msg); // 메세지 내용
            sms.put("receiver", rphone); // 수신번호(,로 여러개 가능)
//            sms.put("destination", "01111111111|담당자"); // 수신인 %고객명% 치환
            sms.put("sender", "0319865527"); // 발신번호
            sms.put("rdate", ""); // 예약일자 - 20161004 : 2016-10-04일기준
            sms.put("rtime", ""); // 예약시간 - 1930 : 오후 7시30분
            sms.put("testmode_yn", ""); // Y 인경우 실제문자 전송X , 자동취소(환불) 처리
            sms.put("title", "[전자임대차표준계약서]"); //  LMS, MMS 제목 (미입력시 본문중 44Byte 또는 엔터 구분자 첫라인)

//            String image = "";
            //image = "/tmp/pic_57f358af08cf7_sms_.jpg"; // MMS 이미지 파일 위치
            /******************** 전송정보 ********************/

            MultipartEntityBuilder builder = MultipartEntityBuilder.create();
            builder.setBoundary(boundary);
            builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
            builder.setCharset(Charset.forName(encodingType));

            for(Iterator<String> i = sms.keySet().iterator(); i.hasNext();) {
                String key = i.next();
                builder.addTextBody(key, sms.get(key)
                        , ContentType.create("Multipart/related", encodingType));
            }

            if (image != null && image.length() > 0) {
                String base64Data = image.split(",")[1];

                byte[] decodedBytes = Base64.getDecoder().decode(base64Data);
                ByteArrayInputStream bis = new ByteArrayInputStream(decodedBytes);
                BufferedImage bufferedImage = ImageIO.read(bis);

                File imageFile = new File("contract_image.png");
                ImageIO.write(bufferedImage, "png", imageFile);

                if (imageFile.exists()) {
                    builder.addPart("image",
                            new FileBody(imageFile, ContentType.create("application/octet-stream"),
                                    URLEncoder.encode(imageFile.getName(), encodingType)));
                }
            }

            HttpEntity entity = builder.build();

            HttpClient client = HttpClients.createDefault();
            HttpPost post = new HttpPost(sms_url);
            post.setEntity(entity);

            HttpResponse res = client.execute(post);

            String result = "";
            if (res != null) {
                BufferedReader in = new BufferedReader(new InputStreamReader(res.getEntity().getContent(), encodingType));
                String buffer = null;
                while((buffer = in.readLine())!=null) {
                    result += buffer;
                }
                in.close();
            }
            log.debug("[sms] result: " + result + ", phone: " + rphone + ", msg: " + msg);
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
