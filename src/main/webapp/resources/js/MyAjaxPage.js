;
const MyAjaxPage = {
    offset: 0,
    limit: 20,
    isNextVal: true,
    HTML: 'html',
    APPEND: 'append',

    init: () => {
        MyAjaxPage.offset = 0;
        MyAjaxPage.limit = 20;
    },
    setOffset: (n) => {
        MyAjaxPage.offset = n;
    },
    setLimit: (n) => {
        MyAjaxPage.limit = n;
    },
    next: (n) => {
        if (typeof n == 'number' && n > 0) {
            MyAjaxPage.offset += n;
            MyAjaxPage.isNextVal = true;
        } else {
            MyAjaxPage.isNextVal = false;
        }
    },
    isNext: () => {
        return MyAjaxPage.isNextVal;
    },
    on: (callback, outerDiv, innerDiv) => {
        if (outerDiv) {
            $(outerDiv).scroll(function(){
                var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
                var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
                var contentH = $(innerDiv).height(); //문서 전체 내용을 갖는 div의 높이

                if(scrollT + scrollH +1 >= contentH) { // 스크롤바가 아래 쪽에 위치할 때
                    // MyAjaxPage.isNextVal = false;
                    if (MyAjaxPage.isNext()) {
                        callback(MyAjaxPage.APPEND);
                    }
                }
            });
        } else {
            $(window).on('scroll', (e) => {
                if ($(window).scrollTop() == $(document).height() - $(window).height()) {
                    // MyAjaxPage.isNextVal = false;
                    if (MyAjaxPage.isNext()) {
                        callback(MyAjaxPage.APPEND);
                    }
                }
            });
        }
    },
    off: (div) => {
        if (div) {
            $(div).off('scroll');
        } else {
            $(window).off('scroll');
        }
    }
};
