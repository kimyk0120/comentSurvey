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
	
	function auth_list() {
		document.mainform.target = "_self";
		document.mainform.action = "auth_list.do";
		document.mainform.submit();
	}
	
	function auth_edit() {
		document.mainform.target = "_self";
		document.mainform.action = "auth_edit.do";
		document.mainform.submit();
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
								${info.auth_nm }
							</td>
						</tr>
						<tr>
							<th>권한설명</th>
							<td style="height:100px;padding-top:5px;padding-bottom:5px"> ${info.auth_expl } </td>
						</tr>
						<c:forEach items="${list}" var="c" varStatus="status">
							<tr>
								<c:if test="${status.index eq 0}" >
								<th rowspan="${fn:length(list)}">권한부여</th>
								</c:if>
								<td>
									<c:choose>
										<c:when test="${c.read_yn eq 'Y'}"> 
											<span style="font-weight:bold">${c.menu_nm }</span>
										</c:when>
										<c:otherwise>
											<span style="color:#EEEEEE">${c.menu_nm }</span>
										</c:otherwise> 
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>


				<div class="btn-block text-center mt20">
					<!-- <a href="javascript:auth_edit()" class="btn-blue"><span>수정</span></a> -->
					<a href="javascript:auth_list()" class="btn-orange"><span>리스트</span></a>
				</div>

			</div><!-- // shadow-box -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</div>


</body>
</html>

