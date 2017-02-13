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
		
	});

	$(function() {
		$('.formSelect').sSelect();
	});
	
	function user_list() {
		document.mainform.target = "_self";
		document.mainform.action = "user_list.do";
		document.mainform.submit();
	}
	
	function user_edit() {
		document.mainform.target = "_self";
		document.mainform.action = "user_edit.do";
		document.mainform.submit();
	}
	
	function new_pass() {
		
		var em = "<c:out value="${info.email}"/>";
		var id = "<c:out value="${info.id}"/>";
		
		if(confirm(em+"메일로 임시번호를 발송합니다. \n진행하시겠습니까?")) {
			$.ajax({ 
				   url: "new_pass.do", 
				   type: "POST", 
				   data: {"ID" : id, "email" : em},
				   dataType:"text",
				   cache: false,
				   beforeSend: function() { $("#wait").css("display", "block"); },
				   success: function(msg){
					   alert(msg);
					   $("#wait").css("display", "none");
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
			}); 
		}
	}
	
</script>
</head>
<body>
<div id="wrapper">

<form id="mainform" name="mainform" action="" method="post">
	<input type="hidden" id="user_id" name="user_id" value="${info.id}"/>
	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container" class="colum1"><!-- 왼쪽에 사용자 정보가 있을 경우 클래스 colum2 삽입 -->

		<div class="contents">

			<h2>사용자 정보</h2>
			
			<div class="shadow-box">				
			<div id="wait" style="display:none;width:69px;height:89px;border:1px solid black;position:absolute;top:50%;left:50%;padding:2px;"><img src='image/demo_wait.gif' width="64" height="64" />Loading..</div>
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
						<tr>
							<th>이름</th>
							<td>${info.nm }</td>
						</tr>
						<tr>
							<th>지역</th>
							<td>
								<c:choose>
									<c:when test="${info.auth_no eq '1'}" >
										문화체육관광부
									</c:when>
									<c:otherwise>
										${info.sido_cd_nm } <span class="txt-symbol">,</span> ${info.gugun_cd_nm }
									</c:otherwise>
								</c:choose> 
							</td>
						</tr>
						<tr>
							<th>권한</th>
							<td> ${info.auth_nm } <c:if test="${info.cnsm_org_yn eq 'Y'}"> (위탁기관임) </c:if> </td>
						</tr>
						<tr>
							<th>이메일</th>
							<td> ${info.email}</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td> ${info.phone}</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td> ${info.reg_dt}</td>
						</tr>
						
					</tbody>
				</table>


				<div class="btn-block text-center mt20">
				<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
					<c:if test="${auth eq 1}">
						<div class="abr" style="margin-right:5px"><a href="javascript:new_pass();" class="btn-red" title="비밀번호 초기화"><span>비밀번호 초기화</span></a></div>
					</c:if>
					<a href="javascript:user_edit()" class="btn-blue"><span>수정</span></a>
					<a href="javascript:user_list()" class="btn-orange"><span>리스트</span></a>
				</div>

			</div><!-- // shadow-box -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</div>


</body>
</html>

