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
<title>출고 등록</title>
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
		
		var sido = "<c:out value="${srch.sido_code}"/>";
		var gugun = "<c:out value="${srch.gugun_code}"/>";
		
		if(sido != null && sido != '') {
			
			$("#sido_code").val(sido).change();
		
			$.ajax({ 
				   url: "srch_gugun.do", 
				   type: "POST", 
				   data: {"s_sido" : sido},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "<select class=\"formSelect\" id=\"gugun_code\" name=\"gugun_code\" style=\"width:100px;\" title=\"\">";
					   str=str+"<option value=\"\">선택</option>";
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	     				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   str = str+"</select>";
					   document.getElementById("gugun_div").innerHTML=str;
					   
					   if(gugun != null && gugun != '') {
						   $("#gugun_code").val(gugun).change(); 
					   }
					   $('.formSelect').sSelect();
					   
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
		}
		
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
	      
		$( '#appl_date' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		$( '#cllc_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		$( '#dlvr_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		
		
		var auth = "<c:out value="${srch.auth}"/>";
		
		if(auth == '002') {
			$("#dlvr_objt_code").val('B01'); 
		}
	});

	function dlvr_save() {
		document.mainform.action = "prod_dlvr_save.do";
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
	
	function get_price() {
		var au = "<c:out value="${srch.auth}" />"; 
		
		var p = $("#prod_code option:selected").val();
		
		if(au == '001') {	
			var d = $("#dlvr_objt option:selected").val();
			mainform.dlvr_objt_code.value=d;
		}
			
		if(p != null && p!= "" && mainform.dlvr_objt_code.value != null && mainform.dlvr_objt_code.value != "") {
			$.ajax({ 
				   url: "get_price.do", 
				   type: "POST", 
				   data: {"p_code" : p, "d_code" : mainform.dlvr_objt_code.value},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   
					   if(msg != null && msg != "") {
					   	$('#unit_price').val(msg);
					   }
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				});
		}
			
			
		if(au == '001') {	
			if( d == "B02") {
				var str = "<select class=\"formSelect\" style=\"width:100px;\" id=\"cust_objt_no\" name=\"cust_objt_no\">";
				<c:forEach items="${b_list}" var="b">
					str = str + "<option value=\"" + "<c:out value="${b.branch_code}"/>" +"\">" + "<c:out value="${b.branch_name}"/>" +"</option>";
				</c:forEach>
				str = str + "</select>";
				document.getElementById("div_srch_cust").innerHTML=str;
				$('.formSelect').sSelect();
			
			} else {
				var str = "<input type=\"text\" id=\"srch_c\" name=\"srch_c\" onkeyup=\"javascript:srch_cust()\" placeholder=\"강사명 검색\" style=\"width:120px\"/><div id=\"div_c\" style=\"display:inline;\"></div>";
				document.getElementById("div_srch_cust").innerHTML=str;
			}
		}
	}
	
	function get_amt(obj) {
		var p = mainform.unit_price.value;
		var q = mainform.qty.value;
		
		var strNum = /^[/,/,0-9]*$/; // 숫자와 , 만 가능
		
		if (!strNum.test(obj.value)) {
	        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
	        obj.focus();
	        return false;
	    }
		
		var regx = new RegExp(/(-?\d+)(\d{3})/);
		
		if (p != null && p != "" && q != null && q != "") {
			var a = parseInt(p) * parseInt(q); 
			a = a.toString();
			a = a.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			mainform.amt.value= a;
		}
	}
	
	function get_tot_amt(obj) {
		var p = mainform.unit_price.value;
		var q = mainform.dlvr_qty.value;
		
		var strNum = /^[/,/,0-9]*$/; // 숫자와 , 만 가능
		
		if (!strNum.test(obj.value)) {
	        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
	        obj.focus();
	        return false;
	    }
		
		var regx = new RegExp(/(-?\d+)(\d{3})/);
		
		if (p != null && p != "" && q != null && q != "") {
			var a = parseInt(p) * parseInt(q); 
			a = a.toString();
			a = a.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			mainform.tot_amt.value= a;
		}
	}
	
	function srch_cust(){
		
		var c = $('#srch_c').val();
		var p = $("#dlvr_objt option:selected").val();
		if(p == null || p == "") {
			alert("출고분류를 먼저 선택해주세요");
			$("#dlvr_objt").focus();
			return false;
		} else {
		
			$.ajax({ 
			   url: "srch_cust.do", 
			   type: "POST", 
			   data: {"dlvr_objt" : p, "srch_name" : c},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				  
				     var tmp = msg.split('|');
				     var str = "<select class=\"formSelect\" id=\"cust_objt_no\" name=\"cust_objt_no\" style=\"width:180px;\">";
				     	str = str + "<option value=\"\">선택</option>";
				     for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split("`");
	         				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
						   }
						   
					   str = str+"</select>";
					   document.getElementById("div_c").innerHTML=str;
					   
					   $('.formSelect').sSelect();
					  
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
		}
	}
	
	function get_gugun() {
		
		var e = document.getElementById("sido_code");
		var s_sido = e.options[e.selectedIndex].value;
				
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var tmp = msg.split('|');
				   
				   var str = "<select class=\"formSelect\" id=\"gugun_code\" name=\"gugun_code\" style=\"width:100px;\" title=\"\">";
				   for(var i = 0; i < tmp.length ; i++) {
					   var tmp_sub = tmp[i].split(",");
	    				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
				   }
				   str = str+"</select>";
				   document.getElementById("gugun_div").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
	}
	
</script>
</head>
<body>

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="d_no" name="d_no" value="${info.dlvr_no}"/>
<input type="hidden" id="dlvr_objt_code" name="dlvr_objt_code" />
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />
		
		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">출고등록</h2>
			</div>

			<table class="talbe-view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>신청일자</th>
						<td colspan="3">
							<span class="set-date">
								<input type="text" id="appl_date" name="appl_date" style="width:65px;" />
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="시작일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
					</tr>
					<tr>
						<th>품목명</th>
						<td colspan="3">
							<select class="formSelect" style="width:150px;" title="" id="prod_code" name="prod_code" onchange="javascript:get_price()">
								<option value="" selected="selected">구분</option>
								<c:forEach items="${p_list}" var="p" > 
									<option value="${p.prod_code }">${p.prod_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>출고분류</th>
						<td>
							<c:choose>
								<c:when test="${srch.auth eq '001' }" >
									<select class="formSelect" style="width:150px;" title="" id="dlvr_objt" name="dlvr_objt" onchange="javascript:get_price()">
										<option value="" selected="selected">구분</option>
										<c:forEach items="${d_list}" var="d" > 
											<option value="${d.dlvr_objt_code }">${d.dlvr_objt_code_nm}</option>
										</c:forEach>
									</select>
								</c:when>
							</c:choose>
						</td>
						<th>인수자</th>
						<td>
							<c:choose>
								<c:when test="${srch.auth eq '001' }" >
									<div id ="div_srch_cust" style="display:inline;">
										<input type="text" id="srch_c" name="srch_c" onkeyup="javascript:srch_cust()" placeholder="강사명 검색" style="width:80px"/>
											<div id="div_c" style="display:inline;">
											</div>
									</div>
								</c:when>
								<c:otherwise>
									${srch.user_name}
									<input type="hidden" id="cust_objt_no" name="cust_objt_no" value="${srch.teacher_code }" />
								</c:otherwise>
							</c:choose>
							
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">
							<select class="formSelect" id="sido_code" name="sido_code" style="width:100px;" onchange="get_gugun()">
								<option value="">시도</option>
								<c:forEach items="${s_list}" var="s">
									<option value="${s.sido_code}">${s.sido_code_nm}</option>
								</c:forEach>
							</select> 
							<div id="gugun_div"  style="display:inline;">
								<select class="formSelect" style="width:100px;" id="gugun_code" name="gugun_code">
									<option value="">구군</option>
								</select>
							</div>
							<input type="text" id="address" name="address" value="${srch.address }" placeholder="나머지 주소를 입력하세요" />
						</td>
					</tr>
					<tr>
						<th>출고단가</th>
						<td>
							<input type="text" id="unit_price" name="unit_price" placeholder="" style="width:80px" 
							<c:if test="${srch.auth ne '001' }" >readonly="readonly" </c:if>
							/> <span>\</span>
						</td>
						<th>판매분류</th>
						<td>
							<select class="formSelect" style="width:100px;" title="" id="dlvr_prt_code" name="dlvr_prt_code" >
								<option value="C01" >현금</option>
								<option value="C02" >계산서</option>
								<option value="C03" >세금계산서</option>
								<c:if test="${srch.auth eq '001' }" >
									<option value="C04" >기증</option>
									<option value="C05" >반납</option>
									<option value="C06" >파손</option>
									<option value="C07" >분실</option>
									<option value="C08" >쿠폰</option>
									<option value="C09" >기타</option>
								</c:if>
							</select>
						</td>
					</tr>
					<tr>
						<th>수량</th>
						<td>
							<input type="text" id="qty" name="qty" placeholder="" style="width:80px" onkeyup="javascript:get_amt(this);"/>
						</td>
						<th>금액</th>
						<td>
							<input type="text" id="amt" name="amt" style="width:80px" readonly="readonly" />  <span>\</span>
						</td>
					</tr>
					<c:if test="${srch.auth eq '001' }" >
					<tr>
						<th>출고수량</th>
						<td>
							<input type="text" id="dlvr_qty" name="dlvr_qty" placeholder="" style="width:80px" onkeyup="javascript:get_tot_amt(this);"/>
						</td>
						<th>출고금액</th>
						<td>
							<input type="text" id="tot_amt" name="tot_amt" style="width:80px" readonly="readonly" />  <span>\</span>
						</td>
					</tr>
					<tr>
						<th>부가세</th>
						<td>
							<input type="text" id="vat" name="vat" placeholder="" style="width:80px"/>
						</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<th>입금액</th>
						<td>
							<input type="text" id="cllc_amt" name="cllc_amt" style="width:80px" />  <span>\</span>
						</td>
						<th>입금일</th>
						<td>
							<span class="set-date">
								<input type="text" id="cllc_dt" name="cllc_dt" style="width:65px;" />
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="시작일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
					</tr>
					<tr>
						<th>출고여부</th>
						<td>
							<select class="formSelect" style="width:100px;" title="" id="cmpl_yn" name="cmpl_yn" >
								<option value="N" >미발송</option>
								<option value="Y" >발송완료</option>
							</select>
						</td>
						<th>출고일</th>
						<td>
							<span class="set-date">
								<input type="text" id="dlvr_dt" name="dlvr_dt" style="width:65px;" />
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="시작일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
					</tr>
					</c:if>
				</tbody>
			</table>

			<div class="btn-block">
				<a href="javascript:dlvr_save()"><span>저장</span></a>
				<a href="javascript:history.back()" class="btn-gray"><span>취소</span></a>
			</div><!--// btn-block -->
			
		</div><!--// layer-content -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</body>
</html>