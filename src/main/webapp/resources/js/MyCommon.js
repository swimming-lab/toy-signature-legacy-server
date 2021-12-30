;
// noinspection DuplicatedCode
const MyCommon = {
    isEmpty: (obj) => {
        if (obj === undefined || obj === null || obj === '' || obj.length === 0) {
            return true;
        }
        if (typeof obj === 'object') {
            return $.isEmptyObject(obj);
        }
        return false;
    },
    isNotEmpty: (obj) => {
        return !MyCommon.isEmpty(obj);
    },
    // 재요청시 XSS가 중복으로 처리되어 &, # 등의 문자가 중복 필터처리 된다. 때문에 값을 원본으로 변환하여 .text(value), .val(value) 로 처리한다.
    unescapeXss: (input) => {
        return $('<textarea></textarea>').html(input).text();
    },
    defaultLinkOptions: {
        center: 'screen',
        // createNew : true,
        height: $(window).outerHeight() * 0.85,
        left: 0,
        location: false, // 메뉴아이콘 출력
        menubar: false, // 메뉴 바 사용
        name: null,
        onUnload: null,
        resizable: true, // 사이즈 변경 사용
        scrollbars: true, // 스크롤 바 사용
        status: false, // 하단 상태바 출력
        toolbar: false, // 도구창 사용
        top: 0,
        width: $(window).outerWidth() * 0.80
    },
    goLink: (url, isNewWindow, paramOption) => {
        // option은 다음 경로에서 확인 https://github.com/mkdynamic/jquery-popupwindow
        let tempUrl = _.trim(url);
        if (MyCommon.isEmpty(tempUrl) || tempUrl === '#' || tempUrl === 'null') {
            alert('준비중입니다.');
            return;
        }
        if (!_.startsWith(tempUrl, 'http') && !_.startsWith(tempUrl, CONTEXT_PATH)) {
            tempUrl = CONTEXT_PATH + tempUrl;
        }

        const options = MyCommon.getOptions(MyCommon.defaultLinkOptions, paramOption);

        // url 앞에 http가 있으면 새창으로 띄운다.
        if (isNewWindow === 'L') { // 이동
            location.href = tempUrl;
        } else if (isNewWindow === 'W') { // 팝업
            $.popupWindow(tempUrl, options);
        } else if (isNewWindow === 'T') { // 탭
            options['location'] = true;
            options['menubar'] = true;
            options['status'] = true;
            options['toolbar'] = true;
            $.popupWindow(tempUrl, options);
        } else { // default
            if (_.startsWith(tempUrl, 'http')) { // 탭
                options['location'] = true;
                options['menubar'] = true;
                options['status'] = true;
                options['toolbar'] = true;
                $.popupWindow(tempUrl, options);
            } else { // 이동
                location.href = tempUrl;
            }
        }
    },
    goWindow: (url, paramOption) => {
        MyCommon.goLink(url, 'W', paramOption);
    },
    goTab: (url) => {
        MyCommon.goLink(url, 'T');
    },
    getLabelFromSelectTag: (selectObj, value) => {
        return $(selectObj).children('option[value="' + value + '"]').text();
    },
    getLabelFromRadioCheckboxTag: (radioCheckboxObj, value) => {
        let result = "";
        $(radioCheckboxObj).each((index, element) => {
            if ($(element).val() === value) {
                result = $(element).data('label');
                }
            }
        );
        return result;
    },
    // 사용법 <img src="" onerror="MyCommon.setNoImg(this);" />
    setNoImg: (obj, paramnoImgPath) => {
        let noImgPath = _.trim(paramnoImgPath);
        if (MyCommon.isEmpty(noImgPath)) {
            noImgPath = CONTEXT_PATH + '/resources/images/no-image-available.png';
        }
        $(obj).removeAttr('onerror').attr('data-original-src', $(obj).attr('src')).attr('src', noImgPath).addClass('noImg');
    },
    getOptions: (defaultOption, userOptions) => {
        const tempOptions = _.clone(defaultOption);
        if (userOptions) {
            for (const key in userOptions) {
                tempOptions[key] = userOptions[key];
            }
        }
        return tempOptions;
    },
    getFileExtension: (filename) => {
        return filename.slice((filename.lastIndexOf(".") - 1 >>> 0) + 2);
    },
    submitFormGET: (url, param, target) => {
        const $form = $('<form method="GET"></form>');
        $form.attr('action', url);
        target && $form.attr('target', target);
        for (const key in param) {
            $form.append('<input type="hidden" name="' + key + '" value="' + param[key] + '" >');
        }
        $(document.body).append($form[0]);
        $form[0].submit();
    },
    submitFormPOST: (url, param, target) => {
        const $form = $('<form method="POST"></form>');
        $form.attr('action', url);
        target && $form.attr('target', target);
        for (const key in param) {
            $form.append('<input type="hidden" name="' + key + '" value="' + param[key] + '" >');
        }
        $(document.body).append($form[0]);
        $form[0].submit();
    },
    isLocalhost: (url) => {
        url = url || document.domain;
        return _.endsWith(url, "localhost");
    },
    isApp: () => {
        return (navigator.userAgent.indexOf('signatureapp_Android') > -1);
    },
    goBack: () => {
        if (MyCommon.isApp()) {
            MyCommon.goLink('signatureapp://goBack');
        } else {
            window.history.back();
        }
    },
    goContact: () => {
        if (MyCommon.isApp()) {
            MyCommon.goLink('signatureapp://goContact');
        }
    },
    formatPhoneNumber: (phone) => {
        //Filter only numbers from the input
        let cleaned = ('' + phone).replace(/\D/g, '');

        //Check if the input is of correct length
        let match = cleaned.match(/^(\d{3})(\d{4})(\d{4})$/);

        if (match) {
            return '' + match[1] + '-' + match[2] + '-' + match[3]
        } else {
            return phone;
        }
    },
    loadingBar: (display) => {
        if (display) {
            $("#overlay").fadeIn(300);
        } else {
            $("#overlay").fadeOut(300);
        }
    },
};


//금액에 , 찍기
function numchk(num) {
    num = new String(num);
    num = num.replace(/,/gi,"");
    return numchk1(num);
}

function numchk1(num) {
    var sign="";

    if(isNaN(num)) {
        alert("숫자만 입력할 수 있습니다.");
        return 0;
    }

    if(num == 0) {
        return num;
    }

    if(num < 0) {
        num = num * (-1);
        sign = "-";
    } else {
        num = num * 1;
    }

    num = new String(num)
    var temp = "";
    var pos = 3;
    num_len = num.length;

    while(num_len > 0) {
        num_len = num_len - pos;

        if(num_len < 0) {
            pos = num_len + pos;
            num_len = 0;
        }

        temp = ","+num.substr(num_len,pos) + temp;
    }

    return sign + temp.substr(1);
}

// 금액 숫자를 한글로
function num_han(num) {
    if(num == "1") return "일";
    else if(num == "2") return "이";
    else if(num == "3") return "삼";
    else if(num == "4") return "사";
    else if(num == "5") return "오";
    else if(num == "6") return "육";
    else if(num == "7") return "칠";
    else if(num == "8") return "팔";
    else if(num == "9") return "구";
    else if(num == "십") return "십";
    else if(num == "백") return "백";
    else if(num == "천") return "천";
    else if(num == "만") return "만 ";
    else if(num == "억") return "억 ";
    else if(num == "조") return "조 ";
    else if(num == "0") return "";
}

function NUM_HAN(num, mode, return_input) {
    if(num == "" || num == "0") {
        if(mode == "3") {
            return_input.value = "";
        }

        return;
    }

    num = new String(num);
    num = num.replace(/,/gi,"");
    var len = num.length;
    var temp1 = "";
    var temp2 = "";

    if(len/4 > 3 && len/4 <= 4) {
        if(len%4 == 0) {
            temp1 = ciphers_han(num.substring(0,4)) + "조" + ciphers_han(num.substring(4,8)) + "억" + ciphers_han(num.substring(8,12)) + "만" + ciphers_han(num.substring(12,16));
        } else {
            temp1 = ciphers_han(num.substring(0,len%4)) + "조" + ciphers_han(num.substring(len%4,len%4+4)) + "억" + ciphers_han(num.substring(len%4+4,len%4+8)) + "만" + ciphers_han(num.substring(len%4+8,len%4+12));
        }
    } else if(len/4 > 2 && len/4 <= 3) {
        if(len%4 == 0) {
            temp1 = ciphers_han(num.substring(0,4)) + "억" + ciphers_han(num.substring(4,8)) + "만" + ciphers_han(num.substring(8,12));
        } else {
            temp1 = ciphers_han(num.substring(0,len%4)) + "억" + ciphers_han(num.substring(len%4,len%4+4)) + "만" + ciphers_han(num.substring(len%4+4,len%4+8));
        }
    } else if(len/4 > 1 && len/4 <= 2) {
        if(len%4 == 0) {
            temp1 = ciphers_han(num.substring(0,4)) + "만" + ciphers_han(num.substring(4,len));
        } else {
            temp1 = ciphers_han(num.substring(0,len%4)) + "만" + ciphers_han(num.substring(len%4,len));
        }
    } else if(len/4 <= 1) {
        temp1 = ciphers_han(num.substring(0,len));
    }

    for(var i=0; i<temp1.length; i++) {
        temp2 = temp2 + num_han(temp1.substring(i, i+1));
    }

    temp3 = new String(temp2);
    temp3 = temp3.replace(/억 만/gi,"억 ");
    temp3 = temp3.replace(/조 억/gi,"조 ");

    if(mode == 1) {
        alert(temp3 + " 원");
    } else if(mode == 2) {
        return temp3;
    } else if(mode == 3) {
        return_input.value = "( 금 " + temp3 + " 원 )";
    }
}

function ciphers_han(num) {
    var len = num.length;
    var temp = "";

    if(len == 1) {
        temp = num;
    } else if(len == 2) {
        temp = num.substring(0,1) + "십" + num.substring(1,2);
    } else if(len == 3) {
        temp = num.substring(0,1) + "백" + num.substring(1,2) + "십" + num.substring(2,3);
    } else if(len == 4) {
        temp = num.substring(0,1) + "천" + num.substring(1,2) + "백" + num.substring(2,3) + "십" + num.substring(3,4);
    }

    num = new String(temp);
    num = num.replace(/0십/gi,"");
    num = num.replace(/0백/gi,"");
    num = num.replace(/0천/gi,"");

    return num;
}

function moncom(mon) {
    var factor = mon.length % 3;
    var su = (mon.length - factor) / 3;
    var com = mon.substring(0,factor);

    for(var i=0; i < su ; i++) {
        if((factor == 0) && (i == 0)) {
            com += mon.substring(factor+(3*i), factor+3+(3*i));
        } else {
            com += "," ;
            com += mon.substring(factor+(3*i), factor+3+(3*i));
        }
    }

    document.write(com);
}
//maxlength 체크
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
        object.value = object.value.slice(0, object.maxLength);
    }
}