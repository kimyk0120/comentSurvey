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
<title>회원 등록</title>
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

	function user_save() {
		var e1 = $("#em1").val();
		var e2 = $("#em2").val();
		var e3 = $("#em3").val();
		var p1 = $("#ph1").val();
		var p2 = $("#ph2").val();
		var p3 = $("#ph3").val();
		
		if(e1 != '') {
			if(e2 != '') {
				$('#email').val(e1+"@"+e2);
			} else if(e3 != '') {
				$('#email').val(e1+"@"+e3);
			}
		}
		
		if(p1 != '' && p2 != '' && p3 != '') {
			$('#phone').val(p1+"-"+p2+"-"+p3);
		}
		
		if( $('#name').val() == "" || $('#name').val() == null) {
			alert("성명을 입력하세요");
			$('#name').focus();
			return;
		}
		else if( $('#phone').val() == "" || $('#phone').val() == null) {
			alert("연락처를 입력하세요");
			$('#ph2').focus();
			return;
		}
		else if( $('#email').val() == "" || $('#email').val() == null) {
			alert("이메일을 입력하세요");
			$('#em1').focus();
			return;
		}
		/* else if( $('#branch_code').val() == "" || $('#branch_code').val() == null) {
			alert("지점을 선택하세요");
			$('#branch_code').focus();
			return;
		} */
		else {
			
			$.ajax({ 
				   url: "email_check.do", 
				   type: "POST", 
				   data: {"em" : $("#email").val()},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   
					   if(msg == "Y") {
						    document.mainform.action = "new_user_save.do";
							document.mainform.submit();
					   }
					   else if(msg == "N"){
						   alert("동일한 아이디가 존재합니다. 다시 입력해주세요");
						   $("#em1").focus();
						   return false;
					   }
					   
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
			
		}
	}
	
	function email_select() {
		var e = document.getElementById("em2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email").style.display = "inline";
			$('#em3').val("");
		} else {
			document.getElementById("div_email").style.display = "none";
		}
			
	}
	
	$(document).ready(function() {
		var em2 = "<c:out value="${info.em2}"/>";
		
		var e = document.getElementById("em2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email").style.display = "inline";
			$('#em3').val(em2);
		} else {
			document.getElementById("div_email").style.display = "none";
		}
		
		var ph1 = "<c:out value="${info.ph1}"/>";
		if(ph1 != null && ph1 != '') {
			$("#ph1").val(ph1).change(); 
		}
		
	});
	
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
<input type="hidden" id="email" name="email"/>
<input type="hidden" id="phone" name="phone"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp" flush="false" />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp" flush="false" />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">회원생성</h2>
				<h3 class="mb0">신규회원</h3>
			</div>

			<table class="talbe-view">
				<colgroup>
					<col style="width:20%" />
					<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>이메일 (아이디)</th>
						<td>
							<input type="text" id="em1" name="em1" value="${info.em1 }" style="width:150px" />
							<span class="txt-symbol">@</span>
							<select class="formSelect" style="width:150px" id="em2" name="em2" onchange="email_select()">
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
								<input type="text" id="em3" name="em3" style="width:150px" />
							</div>
						</td>
					</tr>
					<tr>
						<th>성명</th>
						<td><input type="text" id="name" name="name" style="width:120px" /></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<select class="formSelect" style="width:60px" id="ph1" name="ph1">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph2" name="ph2" value="${info.ph2 }" style="width:40px" maxlength="4"/>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph3" name="ph3" value="${info.ph3 }" style="width:40px" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th>소속지점</th>
						<td>
							<select class="formSelect" style="width:150px" title="" id="branch_code" name="branch_code">
								<option value="" selected="selected">선택</option>
								<c:forEach items="${b_list}" var="b">
									<option value="${b.branch_code}" <c:if test="${info.branch_code eq b.branch_code}">selected="selected"</c:if>>${b.branch_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="btn-block">
				<a href="javascript:user_save()"><span>저장</span></a>
				<a href="javascript:history.back()"><span>취소</span></a>
			</div><!--// contents -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>

</form>

</body>
</html>