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
<title>교육기관 등록</title>
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

	function edu_inst_save() {
		
		var e1 = $("#em1").val();
		var e2 = $("#em2").val();
		var e3 = $("#em3").val();
		var p1 = $("#ph1").val();
		var p2 = $("#ph2").val();
		var p3 = $("#ph3").val();
		var mp1 = $("#m_ph1").val();
		var mp2 = $("#m_ph2").val();
		var mp3 = $("#m_ph3").val();
		
		if(e1 != '') {
			if(e2 != '') {
				mainform.email.value=e1+"@"+e2;
			} else if(e3 != '') {
				mainform.email.value=e1+"@"+e3;
			}
		}
		
		if(p1 != '' && p2 != '' && p3 != '') {
			mainform.chrg_phone.value=p1+"-"+p2+"-"+p3;
		}
		if(mp1 != '' && mp2 != '' && mp3 != '') {
			mainform.main_phone.value=mp1+"-"+mp2+"-"+mp3;
		}
		
		document.mainform.action = "edu_inst_save.do";
		document.mainform.submit();
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
				   var str = "<select class=\"formSelect\" id=\"gugun_code\" name=\"gugun_code\" style=\"width:100px;\" title=\"\">";
				   str=str+"<option value=\"\">선택</option>";
				   if(msg != "" && msg != null) {
					   var tmp = msg.split('|');
					   
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	        				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
				   		}
				   }
				   str = str+"</select>";
				   document.getElementById("gugun_div").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
	}
	
	function email_select() {
		var e = document.getElementById("em2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email").style.display = "inline";
			$('#email3').val("");
		} else {
			document.getElementById("div_email").style.display = "none";
		}
			
	}
	
	function srch_main_teacher(){
		var srchTm = $('#tch_srch').val();
		
		$.ajax({ 
		   url: "srch_teacher.do", 
		   type: "POST", 
		   data: {"srch_teacher" : srchTm},
		   dataType:"text",
		   cache: false,
		   success: function(msg){
			  
			     var tmp = msg.split('|');
			     var str = "<select class=\"formSelect\" id=\"teacher_code\" name=\"teacher_code\" style=\"width:180px;\">";
			     	str = str + "<option value=\"\">선택</option>";
			     for(var i = 0; i < tmp.length ; i++) {
					   var tmp_sub = tmp[i].split(",");
         				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   
				   str = str+"</select>";
				   document.getElementById("div_tch").innerHTML=str;
				   
				   $('.formSelect').sSelect();
				  
		   }
		   , error: function (xhr, ajaxOptions, thrownError) {
		      }
		}); 
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
<input type="hidden" id="srch_inst_group" name="srch_inst_group" value="${srch.srch_inst_group}"/>
<input type="hidden" id="srch_edu_inst" name="srch_edu_inst" value="${srch.srch_edu_inst}"/>
<input type="hidden" id="srch_phone" name="srch_phone" value="${srch.srch_phone}"/>
<input type="hidden" id="srch_sido" name="srch_sido" value="${srch.srch_sido}"/>
<input type="hidden" id="srch_gugun" name="srch_gugun" value="${srch.srch_gugun}"/>
<input type="hidden" id="main_phone" name="main_phone"/>
<input type="hidden" id="chrg_phone" name="chrg_phone"/>
<input type="hidden" id="email" name="email"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">교육기관 등록</h2>
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
						<th>교육기관명</th>
						<td><input type="text" id="edu_inst_nm" name="edu_inst_nm" style="width:150px" /></td>
						<th>교육기관그룹</th>
						<td>
							<select class="formSelect" style="width:150px" title="" id="edu_inst_group_code" name="edu_inst_group_code">
								<option value="">선택</option>
								<c:forEach items="${e_list}" var="e">
									<option value="${e.edu_inst_group_code}">${e.edu_inst_group_code_nm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>지역</th>
						<td colspan="3">
							<select class="formSelect" id="sido_code" name="sido_code" style="width:100px;" title="" onchange="get_gugun()">
								<option value="">시도</option>
								<c:forEach items="${s_list}" var="s">
									<option value="${s.sido_code}">${s.sido_code_nm}</option>
								</c:forEach>
							</select>
							<div id="gugun_div" style="display:inline;">
								<select class="formSelect" style="width:100px;" title="">
									<option value="">구군</option>
								</select>
							</div>
							<input type="text" id="address" name="address" placeholder="나머지 주소를 입력하세요" style="width:200px" /></td>
					</tr>
					<tr>
						<th>참여강사</th>
						<td colspan="3">
							<input type="text" id="tch_srch" name="tch_srch" onkeyup="javascript:srch_main_teacher()" placeholder="강사명 검색" style="width:120px"/>
							<div id="div_tch" style="display:inline;">
							</div>
						</td>
					</tr>
					<tr>
						<th>지점</th>
						<td><select class="formSelect" style="width:150px" title="" id="branch_code" name="branch_code">
								<option value="">선택</option>
								<c:forEach items="${b_list}" var="b">
									<option value="${b.branch_code}">${b.branch_name}</option>
								</c:forEach>
							</select>
						</td>
						<th>홈페이지</th>
						<td><input type="text" id="homepage" name="homepage" style="width:150px" /></td>
					</tr>
					<tr>
						<th>담당자직위</th>
						<td><input type="text" id="chrg_pstn" name="chrg_pstn" style="width:80px" /></td>
						<th>담당자명</th>
						<td><input type="text" id="chrg_name" name="chrg_name" style="width:80px" /></td>
					</tr>
					<tr>
						<th>담당자연락처</th>
						<td colspan="3">
							<select class="formSelect" style="width:80px" title="" id="ph1" name="ph1">
								<option value="010" selected="selected">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							<span class="txt-symbol">-</span><input type="text" id="ph2" name="ph2" style="width:80px" maxlength="4"/>
							<span class="txt-symbol">-</span><input type="text" id="ph3" name="ph3" style="width:80px" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th>대표이메일</th>
						<td colspan="3">
							<input type="text" id="em1" name="em1" style="width:120px" />
							<span class="txt-symbol">@</span>
							<select class="formSelect" style="width:150px" id="em2" name="em2" onchange="email_select()">
								<option value="">직접입력</option>
								<option value="naver.com">naver.com</option>
								<option value="nate.com">nate.com</option>
								<option value="empal.com">empal.com</option>
								<option value="daum.net">daum.net</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="google.com">google.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="hotmail.com">hotmail.com</option>
							</select>
							<div id="div_email"  style="display:inline;">
								<input type="text" id="em3" name="em3" style="width:120px" />
							</div>
						</td>
					</tr>
					<tr>
						<th>대표전화</th>
						<td colspan="3">
							<input type="text" id="m_ph1" name="m_ph1" style="width:80px" maxlength="4"/>
							<span class="txt-symbol">-</span><input type="text" id="m_ph2" name="m_ph2" style="width:80px" maxlength="4"/>
							<span class="txt-symbol">-</span><input type="text" id="m_ph3" name="m_ph3" style="width:80px" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td colspan="3"><input type="text" id="zipcode" name="zipcode" style="width:120px" /></td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3"><textarea id="bigo" name="bigo" style="height:80px;width:500px;padding:5px;margin:2px" ></textarea></td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">
				<a href="javascript:edu_inst_save();" ><span>저장</span></a>
				<a href="javascript:history.back();" class="btn-negative"><span>취소</span></a>
			</div><!--// btn-block -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>
</form>

</body>
</html>