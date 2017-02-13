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
<title>고객 상세정보</title>
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
		/* var em2 = "<c:out value="${info.em2}"/>";
		
		var e = document.getElementById("em2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email").style.display = "inline";
			$('#em3').val(em2);
		} else {
			document.getElementById("div_email").style.display = "none";
		} */
		
		var ph1 = "<c:out value="${info.ph1}"/>";
		if(ph1 != null && ph1 != '') {
			$("#ph1").val(ph1).attr("selected","selected"); 
		}
		
		var sido = "<c:out value="${info.sido_code}"/>";
		var gugun = "<c:out value="${info.gugun_code}"/>";
		
		if(sido != null && sido != '') {
			
			$("#sido_code").val(sido).attr("selected","selected");
		
			$.ajax({ 
				   url: "srch_gugun.do", 
				   type: "POST", 
				   data: {"s_sido" : sido},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "<select class=\"formSelect\" id=\"gugun_code\" name=\"gugun_code\" style=\"width:120px;\" title=\"\">";
					   str=str+"<option value=\"\">선택</option>";
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	     				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   str = str+"</select>";
					   document.getElementById("gugun_div").innerHTML=str;
					   
					   if(gugun != null && gugun != '') {
						   $("#gugun_code").val(gugun).attr("selected","selected"); 
					   }
					   $('.formSelect').sSelect();
					   
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
		}
		
	});
	
	
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
				   
				   var str = "<select class=\"formSelect\" id=\"gugun_code\" name=\"gugun_code\" style=\"width:120px;\" title=\"\">";
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
	
	/* function email_select() {
		var e = document.getElementById("em2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email").style.display = "inline";
			$('#em3').val("");
		} else {
			document.getElementById("div_email").style.display = "none";
		}
			
	} */
		
	
	function cust_save() {
		/* var e1 = $("#em1").val();
		var e2 = $("#em2").val();
		var e3 = $("#em3").val(); */
		var p1 = $("#ph1").val();
		var p2 = $("#ph2").val();
		var p3 = $("#ph3").val();
		
		/* if(e1 != '') {
			if(e2 != '') {
				mainform.email.value=e1+"@"+e2;
			} else if(e3 != '') {
				mainform.email.value=e1+"@"+e3;
			}
		} */
		
		if(p1 != '' && p2 != '' && p3 != '') {
			mainform.phone.value=p1+"-"+p2+"-"+p3;
		}
		
		var nm = $('#cust_nm').val();
		var si = $('#sido_code').val();
		var gu = $('#gugun_code').val();
		
		if(nm == "" || nm == null) {
			alert("성함을 입력하세요.");
			$('#cust_nm').focus();
			return;
		} else if(si == "" || si == null) {
			alert("시도를 선택하세요.");
			return;
		} else if(gu == "" || gu == null) {
			alert("구군을 선택하세요.");
			return;
		} else if( (p1 == "" || p1 == null) || (p2 == "" || p2 == null) || (p3 == "" || p3 == null)) {
			alert("연락처를 입력하세요.");
			$('#ph2').focus();
			return;
		} 
		else {
			
			document.mainform.action = "arrg_cust_save.do";
			document.mainform.submit();
		}
	}
	
	function moveUrl(t, l, url ) {
		mainform.top.value=t;
		mainform.left.value=l;
		location.href = url+"?top="+t+"&left="+l;
	}
	
</script>
</head>
<body>

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="c_no" name="c_no" value="${info.cust_no}"/>
<input type="hidden" id="srch_sido" name="srch_sido" value="${srch.srch_sido}"/>
<input type="hidden" id="srch_gugun" name="srch_gugun" value="${srch.srch_gugun}"/>
<input type="hidden" id="srch_cust_name" name="srch_cust_name" value="${srch.srch_cust_name}"/>
<input type="hidden" id="srch_phone" name="srch_phone" value="${srch.srch_phone}"/>
<input type="hidden" id="phone" name="phone"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

<div id="wrapper">

<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">고객 등록</h2>
				<%-- <h3 class="mb0">${info.cust_nm} 고객</h3> --%>
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
						<th>고객명</th>
						<td colspan="3">
							<input type="text" id="cust_nm" name="cust_nm" style="width:80px" />
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">
							<select class="formSelect" id="sido_code" name="sido_code" style="width:120px;" onchange="get_gugun()">
								<option value="">시도</option>
								<c:set var="si" value="${info.sido_code}" />
								<c:forEach items="${s_list}" var="s">
									<option value="${s.sido_code}" >${s.sido_code_nm}</option>
								</c:forEach>
							</select> 
							<div id="gugun_div"  style="display:inline;">
								<select class="formSelect" style="width:120px;" id="gugun_code" name="gugun_code">
									<option value="">구군</option>
								</select>
							</div>
							<input type="text" id="address" name="address" placeholder="나머지 주소를 입력하세요" />
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td colspan="3">
							<select class="formSelect" style="width:60px" id="ph1" name="ph1">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph2" name="ph2" style="width:40px" maxlength="4"/>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph3" name="ph3" style="width:40px" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th>가족수</th>
						<td><input type="text" id="fmly_cnt" name="fmly_cnt" style="width:60px" /> 명</td>
						<th>평수</th>
						<td><input type="text" id="house_space" name="house_space" style="width:60px" /> 평</td>
					</tr>
					<tr>
						<th>거주형태</th>
						<td>
							<select class="formSelect" style="width:80px" id="live_prt" name="live_prt">
								<option value="아파트">아파트</option>
								<option value="다세대">다세대</option>
								<option value="빌라">빌라</option>
								<option value="주택">주택</option>
								<option value="복층">복층</option>
								<option value="기타">기타</option>
							</select>
						</td>
						<th>거주년수</th>
						<td><input type="text" id="live_prd" name="live_prd" style="width:60px" /> 년</td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3"><textarea id="bigo" name="bigo" style="height:120px;width:95%;padding:5px;margin:2px"></textarea></td>
					</tr>
				</tbody>
			</table>
			
			<div class="btn-block">
				<a href="javascript:cust_save()"><span>저장</span></a>
				<a href="javascript:history.back()" class="btn-gray"><span>취소</span></a>
			</div><!--// contents -->
			
		</div><!--// layer-content -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</body>
</html>