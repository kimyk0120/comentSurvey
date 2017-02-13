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
<title>문화관광해설사 관리시스템</title>
<link href="common/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>
<jsp:useBean id="now" class="java.util.Date" />

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />


<script type="text/javascript">

	$(document).ready(function() {
		var em2 = "<c:out value="${info.em2}"/>";
		
		var e = document.getElementById("email2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email").style.display = "inline";
			$('#email3').val(em2);
		} else {
			document.getElementById("div_email").style.display = "none";
		}
		
		/* var auth = "<c:out value="${info.auth_no}"/>";
		if(auth != null && auth != '') $("#auth_no").val(auth).change(); */
		
		var sido = "<c:out value="${info.sido_cd}"/>";
		var gugun = "<c:out value="${info.gugun_cd}"/>";
		
		if(sido != null && sido != '') {
			
			$("#sido_cd").val(sido).change();
		
			$.ajax({ 
				   url: "srch_gugun.do", 
				   type: "POST", 
				   data: {"s_sido" : sido},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   if(msg != "") {
						   var tmp = msg.split('|');
						   
						   var str = "<select class=\"formSelect\" id=\"gugun_cd\" name=\"gugun_cd\" style=\"width:150px;\" title=\"\">";
						   str=str+"<option value=\"\">선택</option>";
						   for(var i = 0; i < tmp.length ; i++) {
							    var tmp_sub = tmp[i].split(",");
		     					str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
						   }
						   str = str+"</select>";
						   document.getElementById("gugun_div").innerHTML=str;
						   
						   if(gugun != null && gugun != '') {
							   $("#gugun_cd").val(gugun).change(); 
						   }
						   $('.formSelect').sSelect();
					   }
					   
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
		}
		
	});

	$(function() {
		$('.formSelect').sSelect();
	});
	
	function email_select() {
		var e = document.getElementById("email2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email").style.display = "inline";
			$('#email3').val("");
		} else {
			document.getElementById("div_email").style.display = "none";
		}
			
	}
	
	function get_gugun() {
		
		var s_sido = $("select[name=sido_cd]").val();
		
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var str = "<select class=\"formSelect\" id=\"gugun_cd\" name=\"gugun_cd\" style=\"width:150px;\" title=\"\">";
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
	
	function user_save() {
		
		var ph1 = mainform.ph1.value;
		var ph2 = mainform.ph2.value;
		var ph3 = mainform.ph3.value;
		
		if(ph1 != '' && ph2 != '' && ph3 != '') {
			mainform.phone.value=ph1+"-"+ph2+"-"+ph3;
		}
		
		var e1 = mainform.email1.value;
		var e2 = mainform.email2.value;
		var e3 = mainform.email3.value;
		
		if(e1 != '') {
			if(e2 != '') {
				mainform.email.value=e1+"@"+e2;
			} else if(e3 != '') {
				mainform.email.value=e1+"@"+e3;
			}
		}
		
		if( $('#pw').val() != $('#pw2').val() ) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#pw2").focus();
			return;
		} else if($('#nm').val() == "" ) {
			alert("이름을 입력하여 주십시요.");
			$("#nm").focus();
			return;
		} else if($('#phone').val() == "" ) {
			alert("연락처를 입력하여 주십시요.");
			$("#ph1").focus();
			return;
		} else if($('#email').val() == "" ) {
			alert("이메일을 입력하여 주십시요.");
			$("#email1").focus();
			return;
		} else {
			document.mainform.target = "_self";
			document.mainform.action = "user_update.do";
			document.mainform.submit();
		}
	}
	
	function user_info() {
		
		document.mainform.target = "_self";
		document.mainform.action = "user_info.do";
		document.mainform.submit();
	}
	
	function pw_ok() {
		var p1 = $("#pw").val();
		var p2 = $("#pw2").val();
		
		if(p1 == p2) {
			document.getElementById("pw_comment1").style.display = "none";
			document.getElementById("pw_comment2").style.display = "inline-block";
			document.getElementById("div_pw_ok").className = "success";
		}
		else {
			document.getElementById("pw_comment1").style.display = "inline-block";
			document.getElementById("pw_comment2").style.display = "none";
			document.getElementById("div_pw_ok").className = "fail";
		}
	} 
	
</script>
</head>
<body>
<div id="wrapper">

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="phone" name="phone" />
<input type="hidden" id="email" name="email" />
<input type="hidden" id="user_id" name="user_id" value="${info.id}"/>

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container" class="colum1">

		<div class="contents">

			<h2>사용자 수정</h2>
			
			<div class="shadow-box">				

				<table class="talbe-view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:85%" />
					</colgroup>
					<tbody>
						<tr>
							<th>아이디</th>
							<td>${info.id }</td>
						</tr>
						<c:set value="<%=session.getAttribute(\"UserId\") %>" var="user" />
						<c:if test="${info.id eq user}">
						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="pw" id="pw" style="width:150px;" title="비밀번호" /></td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td>
								<div id="div_pw_ok" class="fail">
									<input type="password" name="pw2" id="pw2" style="width:150px;" title="비밀번호 확인" onkeyup="javascript:pw_ok();"/>
									<span id="pw_comment1" class="comment" style="display:none;">비밀번호 불일치</span>
									<span id="pw_comment2" class="comment" style="display:none;">비밀번호 일치</span>
								</div>
							</td>
						</tr> 
						</c:if>
						<tr>
							<th>소속</th>
							<td>
								<c:choose>
									<c:when test="${info.auth_no eq '1'}" >
										문화체육관광부
									</c:when>
									<c:otherwise>
										<select class="formSelect" id="sido_cd" name="sido_cd" style="width:150px;" title="" onchange="get_gugun()">
											<option value="">시도</option>
											<c:forEach items="${s_list}" var="s">
												<option value="${s.sido_cd}">${s.sido_cd_nm}</option>
											</c:forEach>
										</select>
										<span class="txt-symbol">,</span>
										<div id="gugun_div" style="display:inline;">
											<select class="formSelect" style="width:150px;" title="">
												<option value="">구군</option>
											</select>
										</div>
									</c:otherwise>
								</c:choose> 
							</td>
						</tr>
						<tr>
							<th>성명</th>
							<td>
								<div class="item-block">
									<input type="text" name="nm" id="nm" value="${info.nm }" style="width:150px;" title="성명"/>
								</div>
							</td>
						</tr>
						<tr>
							<th>권한</th>
							<td>
								${info.auth_nm} <c:if test="${info.cnsm_org_yn eq 'Y'}"> (위탁기관임) </c:if>
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<div class="email-block">
									<input type="text" name="email1" id="email1" value="${info.em1}" title="이메일 아이디" style="width:150px"/>
									<span class="txt-symbol">@</span>
									<!-- <input type="text" name="email2" id="email2" value="" title="이메일 도메인" /> -->
									<select class="formSelect phone-num" style="width:120px" name="email2" id="email2" title="이메일 도메인 선택" onchange="email_select()">
										<option value="">직접입력</option>
										<option value="naver.com" <c:if test="${info.em2 eq 'naver.com'}">selected="selected"</c:if>>naver.com</option>
										<option value="nate.com" <c:if test="${info.em2 eq 'nate.com'}">selected="selected"</c:if>>nate.com</option>
										<option value="empal.com" <c:if test="${info.em2 eq 'empal.com'}">selected="selected"</c:if>>empal.com</option>
										<option value="daum.net" <c:if test="${info.em2 eq 'daum.net'}">selected="selected"</c:if>>daum.net</option>
										<option value="hanmail.net" <c:if test="${info.em2 eq 'hanmail.net'}">selected="selected"</c:if>>hanmail.net</option>
										<option value="google.com" <c:if test="${info.em2 eq 'google.com'}">selected="selected"</c:if>>google.com</option>
										<option value="gmail.com" <c:if test="${info.em2 eq 'gmail.com'}">selected="selected"</c:if>>gmail.com</option>
										<option value="hotmail.com" <c:if test="${info.em2 eq 'hotmail.com'}">selected="selected"</c:if>>hotmail.com</option>
									</select>
									<div id="div_email"  style="display:inline;">
										<input type="text" id="email3" name="email3" style="width:120px" title="이메일 도메인 직접 입력"/>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>
								<div class="phone-block">
									<input type="text" id="ph1" name="ph1" value="${info.ph1 }" title="전화번호 국번" class="row-input" />
									<span class="txt-symbol">-</span>
									<input type="text" id="ph2" name="ph2" value="${info.ph2 }" title="전화번호 앞 3~4 자리" class="row-input" />
									<span class="txt-symbol">-</span>
									<input type="text" id="ph3" name="ph3" value="${info.ph3 }" title="전화번호 뒤 4 자리" class="row-input" />
								</div>
							</td>
						</tr>
						
					</tbody>
				</table>

				<div class="btn-block text-center mt20">
					<a href="javascript:user_save()" class="btn-blue"><span>저장</span></a>
					<a href="javascript:user_info()" class="btn-orange"><span>취소</span></a>
				</div>

			</div><!-- // shadow-box -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</div>


</body>
</html>

