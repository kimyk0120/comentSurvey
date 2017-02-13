<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
  <%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%>
 
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
	
	function file_down(nm, org_nm) { 
		$('#fileName').val(nm);
		$('#orgFileName').val(org_nm);
		$('#filePath').val("files/board");
		document.mainform2.action = "file_down.do";
		document.mainform2.submit();
		/* 
		$.ajax({ 
			   url: "file_download.do", 
			   type: "POST", 
			   data: {"fileName" : nm, "orgFileName" : org_nm, "filePath" : "files/board"},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			});  */
	}
	
	function board_edit() {
		document.mainform.action = "board_edit.do";
		document.mainform.submit();
	}
	
	function board_delete() {
		if(confirm("삭제하시겠습니까?")) {
			document.mainform.action = "board_delete.do";
			document.mainform.submit();
		}
	}
	
	function go_list() {
		document.mainform.action = "board_list.do";
		document.mainform.submit();
	}
		
</script>
</head>
<body>

<div id="wrapper">

<form id="mainform2" name="mainform2" action="" method="post">
<input type="hidden" id="fileName" name="fileName" />
<input type="hidden" id="filePath" name="filePath" />
<input type="hidden" id="orgFileName" name="orgFileName" />
</form>

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="b_seq" name="b_seq" value="${info.board_seq }" />

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container" class="colum1">

		<div class="contents">

			<h2>공지사항</h2>

			<div class="shadow-box" style="padding-top:20px">

			<table class="talbe-view">
				<colgroup>
					<col style="width:20%" />
					<col style="width:80%" />
				</colgroup>
				<tbody>
					<%-- <tr>
						<th>전체공개</th>
						<td><c:choose><c:when test="${info.open_yn eq 'Y'}">공개</c:when><c:otherwise>미공개</c:otherwise></c:choose></td>
					</tr> --%>
					<tr>
						<th>열람가능지역</th>
						<td>${info.sido_cd_nm }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${info.title }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td class="padding-cell" style="height:500px;word-break:break-all">
							${info.cntn }
						</td>
					</tr>
					<c:forEach items="${f_list}" var="c" varStatus="status">
					<tr>
						<c:if test="${status.index eq 0 }" >
						<th rowspan="${fn:length(f_list) }">첨부파일</th>
						</c:if>
						<td>
							<a href="javascript:file_down('${c.file_nm}','${c.org_file_nm}')" class="attach-file">${c.org_file_nm}</a>
						 </td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div class="btn-block text-center mt20">
				<c:if test="${srch.user_id eq info.id }">
					<a href="javascript:board_delete()" class="btn-red"><span>삭제</span></a>
					<a href="javascript:board_edit()" class="btn-blue"><span>수정</span></a>
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