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
<title>지점 수정</title>
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
		
		var sido = "<c:out value="${info.sido_code}"/>";
		var gugun = "<c:out value="${info.gugun_code}"/>";
		
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
	      
	      $( '#fst_cntr_dt' ).datepicker({
				changeYear:true, //년 셀렉트 박스 유무
				changeMonth:true,//달력 셀ㄹ렉트 박스 유무
				showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
				dateFormat:"yy-mm-dd"
		});
	      $( '#open_dt' ).datepicker({
				changeYear:true, //년 셀렉트 박스 유무
				changeMonth:true,//달력 셀ㄹ렉트 박스 유무
				showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
				dateFormat:"yy-mm-dd"
		});
	      $( '#re_cntr_dt' ).datepicker({
				changeYear:true, //년 셀렉트 박스 유무
				changeMonth:true,//달력 셀ㄹ렉트 박스 유무
				showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
				dateFormat:"yy-mm-dd"
		});
	      $( '#expr_dt' ).datepicker({
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

	function branch_save() {
		
		var p1 = $("#ph1").val();
		var p2 = $("#ph2").val();
		var p3 = $("#ph3").val();
		
		if(p1 != '' && p2 != '' && p3 != '') {
			mainform.phone.value=p1+"-"+p2+"-"+p3;
		}
		
			
		if ($("#branch_name").val() == "" || $("#branch_name").val() == null) {
			alert("지점명을 입력하세요.");
		    $("#branch_name").focus();
		} else {
		    document.mainform.action = "branch_update.do";
		    document.mainform.submit();
				   
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
	
	function cmaComma(obj) {
		var strNum = /^[/,/,0-9]*$/;
		
		if (!strNum.test(obj.value)) {
	        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
	        obj.focus();
	        return false;
	    }
	}
	
	function cmaComma2(obj) {
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
	    
	    var jAmt = $('#join_amt').val();
	    var eAmt = $('#edu_amt').val();
	    var gAmt = $('#grnt_amt').val();
	    
	    if(jAmt != null ) jAmt = jAmt.replace(/[^\d]+/g, '');
		if(eAmt != null ) eAmt = eAmt.replace(/[^\d]+/g, '');
		if(gAmt != null ) gAmt = gAmt.replace(/[^\d]+/g, '');
		
		
		if(jAmt == "") jAmt = "0";
		if(eAmt == "") eAmt = "0";
		if(gAmt == "") gAmt = "0";
		
		var a = parseInt(jAmt) + parseInt(eAmt) + parseInt(gAmt);
		
		while(regx.test(a)){  
	        a = a.toString().replace(regx,"$1,$2");  
	    } 
	    $('#join_tot_amt').val(a);
	    
	}
	
	function moveUrl(t, l, url ) {
		mainform.top.value=t;
		mainform.left.value=l;
		location.href = url+"?top="+t+"&left="+l;
		//document.mainform.action = url;
		//document.mainform.submit();
	}
	
	
</script>
</head>
<body>
<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="phone" name="phone" />
<input type="hidden" id="branch_code" name="branch_code" value="${info.branch_code }"/>
<input type="hidden" id="branch_manager_id" name="branch_manager_id" value="${info.branch_manager_id }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp" flush="false" />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp" flush="false" />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">지점 수정</h2>
				<h3 class="mb0">${info.branch_name }</h3>
			</div>

			<table class="talbe-view">
				<colgroup>
					<col style="width:10%" />
					<col style="width:40%" />
					<col style="width:10%" />
					<col style="width:40%" />
				</colgroup>
				<tbody>
					<tr>
						<th>지점코드</th>
						<td>${info.branch_code }</td>
						<th>이메일(아이디)</th>
						<td>${info.branch_manager_id }</td>
					</tr>
					<tr>
						<th>지점명</th>
						<td colspan="3"><input type="text" id="branch_name" name="branch_name" value="${info.branch_name }" style="width:400px"/></td>
					</tr>
					<tr>
						<th>지점장</th>
						<td><input type="text" id="branch_manager_name" name="branch_manager_name" value="${info.branch_manager_name }"/></td>
						<th>생년월일</th>
						<td><input type="text" id="manager_birth" name="manager_birth" value="${info.manager_birth }"/></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td colspan="3">
							<input type="text" id="ph1" name="ph1" value="${info.ph1 }" style="width:40px" maxlength="4"/>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph2" name="ph2" value="${info.ph2 }" style="width:40px" maxlength="4"/>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph3" name="ph3" value="${info.ph3 }" style="width:40px" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">
							<select class="formSelect" id="sido_code" name="sido_code" style="width:100px;" onchange="get_gugun()">
								<option value="">시도</option>
								<c:set var="si" value="${info.sido_code}" />
								<c:forEach items="${s_list}" var="s">
									<option value="${s.sido_code}" <c:if test="${si eq s.sido_code}">selected="selected"</c:if> >${s.sido_code_nm}</option>
								</c:forEach>
							</select> 
							<div id="gugun_div"  style="display:inline;">
								<select class="formSelect" style="width:100px;" id="gugun_code" name="gugun_code">
									<option value="">구군</option>
								</select>
							</div>
							<input type="text" id="address" name="address" value="${info.address }" placeholder="나머지 주소를 입력하세요" />
						</td>
					</tr>
					<tr>
						<th>최초계약일</th>
						<td>
							<span class="set-date">
								<input type="text" id="fst_cntr_dt" name="fst_cntr_dt" value="${info.fst_cntr_dt }" style="width:80px;" />
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="최초계약일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
						<th>계약기간</th>
						<td><input type="text" id="cntr_prd" name="cntr_prd" value="${info.cntr_prd }" placeholder="숫자만 입력하세요" onkeyup="cmaComma(this);" style="width:80px;"/>년</td> 
					</tr>
					<tr>
						<th>개점일</th>
						<td>
							<span class="set-date">
								<input type="text" id="open_dt" name="open_dt" value="${info.open_dt }" style="width:80px;" />
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="개점일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
						<th>재계약횟수</th>
						<td><input type="text" id="re_cntr_cnt" name="re_cntr_cnt" value="${info.re_cntr_cnt }" style="width:80px;" /></td>
					</tr>
					<tr>
						<th>재계약일</th>
						<td>
							<span class="set-date">
								<input type="text" id="re_cntr_dt" name="re_cntr_dt" value="${info.re_cntr_dt }" style="width:80px;" />
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="재계약일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
						<th>만료일</th>
						<td>
							<span class="set-date">
								<input type="text" id="expr_dt" name="expr_dt" value="${info.expr_dt }" style="width:80px;" />
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="만료일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
					</tr>
					<tr>
						<th>가맹금</th>
						<td>
							<c:set var="jTotAmt"><fmt:formatNumber pattern="#,###" value="${info.join_tot_amt}" /> </c:set>
							<input type="text" id="join_tot_amt" name="join_tot_amt" value="${jTotAmt}" style="width:80px" readonly="readonly"/> 원
						</td>
						<th>가맹비</th>
						<td>
							<c:set var="jAmt"><fmt:formatNumber pattern="#,###" value="${info.join_amt}" /> </c:set>
							<input type="text" id="join_amt" name="join_amt" value="${jAmt}" style="width:60px" onkeyup="cmaComma2(this);"/> 원
						</td>
					</tr>
					<tr>
						<th>교육비</th>
						<td>
							<c:set var="eAmt"><fmt:formatNumber pattern="#,###" value="${info.edu_amt}" /> </c:set>
							<input type="text" id="edu_amt" name="edu_amt" value="${eAmt}" style="width:60px" onkeyup="cmaComma2(this);"/> 원
						</td>
						<th>보증금</th>
						<td>
							<c:set var="gAmt"><fmt:formatNumber pattern="#,###" value="${info.grnt_amt}" /> </c:set>
							<input type="text" id="grnt_amt" name="grnt_amt" value="${gAmt}" style="width:60px" onkeyup="cmaComma2(this);"/> 원
						</td>
					</tr>
					<tr>
						<th>로열티(월정료)</th>
						<td>
							<c:set var="rAmt"><fmt:formatNumber pattern="#,###" value="${info.royal_amt}" /> </c:set>
							<input type="text" id="royal_amt" name="royal_amt" value="${rAmt}" style="width:60px" onkeyup="cmaComma2(this);"/> 원
						</td>
						<th>납부일</th>
						<td>
							<span class="set-date">
								<input type="text" id="pay_dt" name="pay_dt" value="" style="width:80px;" />
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="납부일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
					</tr>
					<tr>
						<th>사업자등록번호</th>
						<td><input type="text" id="resist_no" name="resist_no" value="${info.resist_no }" /></td>
						<th>상호</th>
						<td><input type="text" id="shop_name" name="shop_name" value="${info.shop_name }" /></td>
					</tr>
					<tr>
						<th>대표자</th>
						<td><input type="text" id="rpst_name" name="rpst_name" value="${info.rpst_name }" /></td>
						<th>사업장주소</th>
						<td><input type="text" id="shop_address" name="shop_address" value="${info.shop_address }" /></td>
					</tr>
					<tr>
						<th>사업장전화번호</th>
						<td><input type="text" id="shop_phone" name="shop_phone" value="${info.shop_phone }" /></td>
						<th>FAX</th>
						<td><input type="text" id="shop_fax" name="shop_fax" value="${info.shop_fax }" /></td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3" class="padding-cell">
							<textarea id="bigo" name="bigo" style="width:95%; height:300px" >${info.bigo }</textarea>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="btn-block">
				<a href="javascript:branch_save()"><span>저장</span></a>
				<a href="javascript:history.back()" class="btn-gray"><span>취소</span></a>
			</div><!--// contents -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>

</form>

</body>
</html>