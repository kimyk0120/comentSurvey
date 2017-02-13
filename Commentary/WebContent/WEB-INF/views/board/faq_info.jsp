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

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">
	
	$(function() {
		$('.formSelect').sSelect();
	});
	
	
	function faq_edit() {
		document.mainform.action = "faq_edit.do";
		document.mainform.submit();
	}
	
	function faq_delete() {
		if(confirm("삭제하시겠습니까?")) {
			document.mainform.action = "faq_delete.do";
			document.mainform.submit();
		}
	}
	
	function go_list() {
		document.mainform.action = "faq_list.do";
		document.mainform.submit();
	}
		
</script>
</head>
<body>

<div id="wrapper">

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="f_seq" name="f_seq" value="${info.faq_seq }" />

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container" class="colum1">

		<div class="contents">

			<h2>FAQ</h2>

			<div class="shadow-box" style="padding-top:20px">

			<table class="talbe-view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:85%" />
				</colgroup>
				<tbody>
					<tr>
						<th>질문</th>
						<td class="padding-cell" style="height:200px;word-break:break-all">
							${info.qstn }
						</td>
					</tr>
					<tr>
						<th>답변</th>
						<td class="padding-cell" style="height:400px;word-break:break-all">
							${info.answ }
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="btn-block text-center mt20">
				<c:if test="${srch.auth_no eq 1 }">
					<a href="javascript:faq_delete()" class="btn-red"><span>삭제</span></a>
					<a href="javascript:faq_edit()" class="btn-blue"><span>수정</span></a>
				</c:if>
				<a href="javascript:go_list()" class="btn-orange"><span>리스트</span></a>
			</div>
			
		</div><!--// layer-content -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</div>
</body>
</html>