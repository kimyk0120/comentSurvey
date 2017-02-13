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
<title>수료증</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

	<script type="text/javascript">
			
		$(document).ready(function(){
			var m = "<c:out value="${msg}"/>";
			
			if(m != "") {
				alert(m);
			}
			
		});
		
		$(function() {
			$('.formSelect').sSelect();
		});
			
		function login() {
			
			if (mainform.lecture_code.value == "") {
				alert("강좌를 선택해주세요");
				return;
			}
			else if (mainform.cust_nm.value == "") {
				alert("성함을 입력해주세요");
				return;
			}
			else if (mainform.phone.value == "") {
				alert("연락처를 입력해주세요");
				return;
			}
			
			else {
				
				$.ajax({ 
					   url: "cert_check.do", 
					   type: "POST",
					   data: $("#mainform").serialize(),
					   dataType:"text",
					   cache: false,
					   success: function(msg){
						   
						   if(msg == "") {
								alert("입력하신 정보가 없습니다.");
								return;
							}
							else {
					 			$('#cert_print').val(msg);
						 		window.open('', 'popup_post', 'width=800, height=600, resizable=yes, scrollbars=no, status=no');
							    mainform.target = 'popup_post';
							    mainform.action = 'cert_popup_print.do';
							    mainform.submit();
							}
					   
					   }
					   , error: function (xhr, ajaxOptions, thrownError) {
						   alert("status : " + xhr.status);
					       alert("err: " +thrownError);
					   }
				});
			
			}
		}	
		
		function checkEnterKey(){
			if(event.keyCode==13){login();}
		}
		
		</script>
  		
	</head>	
	<body>
	

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="cert_print" name="cert_print" />
<div id="loginWrapper">

	<h1><img src="image/logo_login.png" alt="덤인" /></h1>
	<fieldset>
		<legend>login</legend>
		<label>
			<span>성명</span>
			<select style="width:188px;background-color:#ebebeb;border:0; border-radius:0;height:34px;-webkit-appearance:none;padding:0 15px;color:#999" title="" id="lecture_code" name="lecture_code">
				<option value="" selected="selected">강좌선택</option>
				<c:forEach items="${l_list}" var="l" varStatus="status">
					<option value="${l.lecture_code }">${l.lecture_nm }</option>
				</c:forEach>
			</select>
		</label>
		<label>
			<span>성명</span>
			<input type="text" id="cust_nm" name="cust_nm" placeholder="성명" />
		</label>
		<label>
			<span>비밀번호</span>
			<input type="text" id="phone" name="phone" onKeyDown="javascript:checkEnterKey()" placeholder="연락처(-없이 입력하세요.)"  />
		</label>
		<a href="javascript:login();" class="btn-login"><span>수료증출력</span></a>				
	</fieldset>
</div>				

</form>
	</body>
</html>


