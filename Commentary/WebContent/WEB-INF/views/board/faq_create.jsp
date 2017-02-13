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
	
	function faq_save() {
		var qs = $('#qstn').val();
		var an = $('#answ').val();
		
		if(qs == "") {
			alert("질문을 입력하세요");
			return;
		} else if(an == "") {
			alert("답변을 입력하세요");
			return;
		} else {
			if(confirm("저장하시겠습니까?")) {
				document.mainform.action = "faq_save.do";
				document.mainform.submit();
			}
		}
	}
	
	function faq_list() {
		document.mainform.action = "faq_list.do";
		document.mainform.submit();
	}
	
</script>
</head>
<body>

<div id="wrapper">

	<form id="mainform" name="mainform" method="post" action="">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container" class="colum1">

		<div class="contents">

			<h2>FAQ 등록</h2>

			<div class="shadow-box" style="padding-top:20px">

				<table class="talbe-view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:85%" />
					</colgroup>
					<tbody>
						<tr>
							<th>질문</th>
							<td class="padding-cell">
								<textarea id="qstn" name="qstn" style="width:95%; height:200px" ></textarea>
							</td>
						</tr>
						<tr>
							<th>답변</th>
							<td class="padding-cell">
								<textarea id="answ" name="answ" style="width:95%; height:400px" ></textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="btn-block text-center mt20">
					<a href="javascript:faq_save()" class="btn-blue"><span>내역 등록</span></a>
					<a href="javascript:faq_list()" class="btn-orange"><span>취소</span></a>
				</div>
			</div>
			
		</div><!--// layer-content -->

		</div><!--// contents -->
</form>
	</div><!--// container -->
</body>
</html>