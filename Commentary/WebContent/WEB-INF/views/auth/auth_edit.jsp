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
	
	function auth_info() {
		document.mainform.target = "_self";
		document.mainform.action = "auth_info.do";
		document.mainform.submit();
	}
	
	function auth_save() {
		
		if($('#auth_nm').val() == "" ) {
			alert("권한명을 입력하여 주십시요.");
			$("#auth_nm").focus();
			return;
		} else if($('#auth_expl').val() == "" ) {
			alert("권한설명을 입력하여 주십시요.");
			$("#auth_expl").focus();
			return;
		} else {
		
			document.mainform.target = "_self";
			document.mainform.action = "auth_update.do";
			document.mainform.submit();
		}
	}
	
	
</script>
</head>
<body>
<div id="wrapper">

<form id="mainform" name="mainform" action="" method="post">
	<input type="hidden" id="a_no" name="a_no" value="${info.auth_no}"/>
	<jsp:include page="../main/topMenu.jsp"  />
	

	<div id="container" class="colum1"><!-- 왼쪽에 사용자 정보가 있을 경우 클래스 colum2 삽입 -->

		<div class="contents">

			<h2>권한 정보</h2>
			
			<div class="shadow-box">				


				<table class="talbe-view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:85%" />
					</colgroup>
					<tbody>
						<tr>
							<th>권한명</th>
							<td>
								<div class="item-block">
									<input type="text" name="auth_nm" id="auth_nm" value="${info.auth_nm }" title="권한명" />
								</div>
							</td>
						</tr>
						<tr>
							<th>권한설명</th>
							<td style="height:100px">
								<div class="item-block">
									<textarea name="auth_expl" id="auth_expl" style="height:85px;width:95%">${info.auth_expl }</textarea>
								</div>
							</td> 
						</tr>
						<c:forEach items="${list}" var="c" varStatus="status">
							<tr>
								<c:if test="${status.index eq 0}" >
									<th rowspan="${fn:length(list)}">권한부여</th>
								</c:if>
								<td>
									<div class="lng-block">
										<div class="pos-relative">
											<input type="checkbox" name="menu_${c.menu_id}" id="menu_${c.menu_id}" value="Y" <c:if test="${c.read_yn eq 'Y'}" > checked="checked"</c:if> />
												<label for="menu_${c.menu_id}">${c.menu_nm}</label>
										</div>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>


				<div class="btn-block text-center mt20">
					<a href="javascript:auth_save()" class="btn-blue"><span>저장</span></a>
					<a href="javascript:auth_info()" class="btn-orange"><span>취소</span></a>
				</div>

			</div><!-- // shadow-box -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</div>


</body>
</html>

