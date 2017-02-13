function formatNum(amount, num){
	if(amount==null) return 0;
	amount = amount ? amount : 0;
	amount = amount.toString().replace(/[^0-9]/g,"");
	if(amount=="") return 0;
	
	var str = new Array();
	var chk = 0;
	if(parseInt(amount) < 0){
		chk=1;
		amount = parseInt(amount)*-1;
	}
	var price = String(amount);	
	for(var i=1; i<=price.length;i++){
		if(i%num){
			str[price.length-i] = price.charAt(price.length-i);
		}else{
			str[price.length-i] = ',' + price.charAt(price.length-i);
		}
	}
	if(chk){
		return '-' + str.join('').replace(/^,/,'');
	}
	else {
		return str.join('').replace(/^,/,'');
	}
}

//문자열 자르기 
function getByteCutStr(str, len) {
	var _len = getByteLength(str);
	if(_len > len){
		str = str.substring(0,getLengthIdx(str,len))+'...';
	}
	return str;
}

//문자열길이체크
function getByteLength(str) {
    var byteLength = 0;
    for (var inx = 0; inx < str.length; inx++) {
        var oneChar = escape(str.charAt(inx));
        if (oneChar.length == 1) {
            byteLength++;
        } else if (oneChar.indexOf("%u") != -1) {
            byteLength += 2;
        } else if (oneChar.indexOf("%") != -1) {
            byteLength += oneChar.length / 3;
        }
    }
    return byteLength;
}

function getLengthIdx(str, len) {
    var byteLength = 0;
    var idx = str.length;
    for (var i = 0; i < str.length; i++) {
        var oneChar = escape(str.charAt(i));
        if (oneChar.length == 1) {
            byteLength++;
        } else if (oneChar.indexOf("%u") != -1) {
            byteLength += 2;
        } else if (oneChar.indexOf("%") != -1) {
            byteLength += oneChar.length / 3;
        }
        if(len < byteLength){
        	return i;
        }
    }
    return idx;
}

function showLoader(){
	$.blockUI({
		message: "<div style='position:absolute;padding-top:300px;'><img src='/js/images/ajax-loader.gif'></div>"
	});	
}

function popLayer(id){
	$.blockUI({
		message: id
	});	
}

function hideLoader(){
	$.unblockUI();
}

function closePopUp(){
	$.unblockUI();
}

function openWindow(url,name,scroll,width,height)
{
	var body = document.body;
	var left = (body.clientWidth / 2) - parseInt(width/2);
	var top = (body.clientHeight / 2) - parseInt(height/2);
	var winopen = window.open(url,name, 'toolbar=no, location=no, titlebar=no, scrollbars='+scroll+',width='+width+',height='+height+',left=' + left + ',top=' + top);
	if(winopen==null){
		//alert('팝업이 차단되어 있습니다.\n\n팝업 차단을 허용해 주세요.');
	}
	else {
		winopen.focus();
	}
	return winopen;
}

function validateEmail(email) {
	email = email.replace(/ /,"");
	if(email.length < 1) return false;
	var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	if( !emailReg.test(email) ) {
		return false;
	} else {
		return true;
	}
}
function validateDate( year, month, day ){
	if( year < 0 || month <= 0 || day <= 0 ){
		return false;
	} 
	var extra = false;
	if( year % 400 == 0 ){
		extra = true;
	}else if( year % 100 == 0 ){
		extra = false;
	}else if( year % 4 == 0 ){
		extra = true;
	}
	 
	switch( month ){
	case 1:
	case 3:
	case 5:
	case 7:
	case 8:
	case 10:
	case 12:
		if( month > 31 )
		return false;
		else
		return true;
	case 4:
	case 6:
	case 9:
	case 11:
		if( day > 30 )
		return false;
		else
		return true;
	case 2:
		if( extra ){
			if( day > 29 )
				return false;
			else
				return true;
		}else{
			if( day > 28 )
			return false;
			else 
			return true;
		}
	default:
		return false;
	}
}

//쿠키삭제
function DelCookie(cKey) {
    var date = new Date(); // 오늘 날짜 
    var validity = -1;
    date.setDate(date.getDate() + validity);
    document.cookie = cKey + "=;expires=" + date.toGMTString();
}

//쿠키확인
function GetCookie(cKey) {
    var allcookies = document.cookie;
    var cookies = allcookies.split("; ");
    for (var i = 0; i < cookies.length; i++) {
        var keyValues = cookies[i].split("=");
        if (keyValues[0] == cKey) {
            return unescape(keyValues[1]);
        }
    }
    return "";
}


