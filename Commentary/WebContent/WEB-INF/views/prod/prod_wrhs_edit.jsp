<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
        
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="X-UA-Compatible" content="requiresActiveX=true" />
<title>입고 등록</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">
	
	$(function() {
		$('.formSelect').sSelect();
	});

	
	$(document).ready(function() {
		
		var p_cust = "<c:out value="${info.pchs_cust_no}"/>";
		$('#pchs_cust_no').val(p_cust).change();
		var p_cd = "<c:out value="${info.prod_code}"/>";
		$('#prod_code').val(p_cd).change();
		
		$.datepicker.regional['ko'] = {
	            closeText: '닫기',
	            prevText: '이전달',
	            nextText: '다음달',
	            currentText: '오늘',
	            monthNames: ['1월','2월','3월','4월','5월','6월',
	            '7월','8월','9월','10월','11월','12월'],
	            monthNamesShort: ['1월','2월','3월','4월','5월','6월',
	            '7월','8월','9월','10월','11월','12월'],
	            dayNames: ['일','월','화','수','목','금','토'],
	            dayNamesShort: ['일','월','화','수','목','금','토'],
	            dayNamesMin: ['일','월','화','수','목','금','토'],
	            buttonImageOnly: false,
	            weekHeader: 'Wk',
	            dateFormat: 'yy-mm-dd',
	            firstDay: 0,
	            isRTL: false,
	            duration:200,
	            showAnim:'show',
	            showMonthAfterYear: true
	          //  minDate: +0
        };
	      $.datepicker.setDefaults($.datepicker.regional['ko']);
	      
		$( '#odr_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		$( '#pay_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		
	});
	

	function wrhs_save() {
		document.mainform.action = "prod_wrhs_save.do";
		document.mainform.submit();
	}
	
	function moveUrl(t, l, url ) {
		mainform.top.value=t;
		mainform.left.value=l;
		location.href = url+"?top="+t+"&left="+l;
		//document.mainform.action = url;
		//document.mainform.submit();
	}
	
	function cmaComma(obj) {
		var strNum = /^[/,/,0-9]*$/; // 숫자와 , 만 가능
		var str = "" + obj.value.replace(/,/gi,''); // 콤마 제거  
	    var regx = new RegExp(/(-?\d+)(\d{3})/);  
		
		if (!strNum.test(obj.value)) {
	        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
	        obj.focus();
	        return false;
	    }
	    
		var q = mainform.qty.value;
		if (str != null && str != "" && q != null && q != "") {
			var a = parseInt(str) * parseInt(q); 
			a = a.toString();
			a = a.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			mainform.amt.value= a;
		}

		while(regx.test(str)){  
	        str = str.replace(regx,"$1,$2");  
	    }  
        obj.value = str;
	    
		
	}
	
	function get_amt(obj) {
		var p = mainform.unit_price.value;
		var q = mainform.qty.value;
		
		var strNum = /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
		var str = "" + p.replace(/,/gi,''); // 콤마 제거  
		
		if (!strNum.test(obj.value)) {
	        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
	        obj.focus();
	        return false;
	    }
		
		if (p != null && p != "" && q != null && q != "") {
			var a = parseInt(str) * parseInt(q); 
			a = a.toString();
			a = a.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			mainform.amt.value= a;
		}
		
	}
	
	function comma(obj) {
		var strNum = /^[/,/,0-9]*$/;
		var str = "" + obj.value.replace(/,/gi,''); // 콤마 제거  
	    var regx = new RegExp(/(-?\d+)(\d{3})/);  
		
		if (!strNum.test(obj.value)) {
	        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
	        obj.focus();
	        return false;
	    }

		while(regx.test(str)){  
	        str = str.replace(regx,"$1,$2");  
	    }  
        obj.value = str;
	    
	}
	
</script>
</head>
<body>

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="w_no" name="w_no" value="${info.wrhs_no}"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />
		
		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">입고등록</h2>
			</div>

			<table class="talbe-view">
				<colgroup>
					<col style="width:30%" />
					<col style="width:70%" />
				</colgroup>
				<tbody>
					<tr>
						<th>신청일자</th>
						<td>
							<span class="set-date">
								<input type="text" id="odr_dt" name="odr_dt" style="width:80px;" value="${info.odr_dt }"/>
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="시작일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
					</tr>
					<tr>
						<th>품목명</th>
						<td>
							<select class="formSelect" style="width:150px;" title="" id="prod_code" name="prod_code">
								<option value="" selected="selected">구분</option>
								<c:forEach items="${p_list}" var="p" > 
									<option value="${p.prod_code }">${p.prod_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>거래처</th>
						<td>
							<select class="formSelect" style="width:150px;" title="" id="pchs_cust_no" name="pchs_cust_no">
								<option value="" selected="selected">구분</option>
								<c:forEach items="${c_list}" var="c" > 
									<option value="${c.pchs_cust_no}">${c.pchs_cust_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>출고단가</th>
						<td>
							<c:set var="price"><fmt:formatNumber pattern="#,###" value="${info.unit_price}" /> </c:set>
							<input type="text" id="unit_price" name="unit_price" value="${price}" style="width:120px" onkeyup="javascript:cmaComma(this)" /> <span>\</span>
						</td>
					</tr>
					<tr>
						<th>수량</th>
						<td>
							<input type="text" id="qty" name="qty" style="width:100px" value="${info.qty }" onkeyup="javascript:get_amt(this);"/>
						</td>
					</tr>
					<tr>
						<th>금액</th>
						<td>
							<c:set var="amtt"><fmt:formatNumber pattern="#,###" value="${info.amt}" /> </c:set>
							<input type="text" id="amt" name="amt" style="width:120px" value="${amtt}" readonly="readonly" />  <span>\</span>
						</td>
					</tr>
					<tr>
						<th>지급액</th>
						<td>
							<c:set var="p_amt"><fmt:formatNumber pattern="#,###" value="${info.pay}" /> </c:set>
							<input type="text" id="pay" name="pay" style="width:120px" value="${p_amt }" onkeyup="javascript:comma(this);"/>  <span>\</span>
						</td>
					</tr>
					<tr>
						<th>지급일</th>
						<td>
							<span class="set-date">
								<input type="text" id="pay_dt" name="pay_dt" style="width:80px;" value="${info.pay_dt }"/>
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="시작일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">
				<a href="javascript:wrhs_save()"><span>저장</span></a>
				<a href="javascript:history.back()" class="btn-gray"><span>취소</span></a>
			</div><!--// btn-block -->
			
		</div><!--// layer-content -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</body>
</html>