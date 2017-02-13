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
			
		$("#chkAll").click(function(){
			//$(".seqs:enabled").attr("checked",$(this).is(":checked"));
			
			if($("#chkAll").prop("checked")) {
				$(".seqs").prop("checked",true);
			} else {
				$(".seqs").prop("checked",false);
			}
		});
		
		$(".seqs").click(function(){
			if($(".seqs:checked").size() == $(".seqs").size()){
				$("#chkAll:enabled").attr("checked", true);
			}
			else {
				$("#chkAll:enabled").attr("checked", false);		
			}
		});
	});
	
	function file_down(nm, org_nm) { 
		$('#fileName').val(nm);
		$('#orgFileName').val(org_nm);
		$('#filePath').val("files/community");
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
	
	function comm_edit() {
		document.mainform.action = "community_edit.do";
		document.mainform.submit();
	}
	
	function comm_delete() {
		if(confirm("삭제하시겠습니까?")) {
			document.mainform.action = "community_delete.do";
			document.mainform.submit();
		}
	}
	
	function go_list() {
		document.mainform.action = "community_list.do";
		document.mainform.submit();
	}

	function comm_close() {
		if(confirm("종료하시겠습니까?")) {
			document.mainform.action = "community_close.do";
			document.mainform.submit();
		}
	}
	
	function mail_send() { 
		$.ajax({ 
			   url: "comm_mail_send.do", 
			   type: "POST", 
			   data: $("#mainform").serialize(),
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				  alert(msg);
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
	}
		
</script>

<style type="text/css">

.input03 { font-size: 13px; border:1px solid #e7e7e7; line-height:160%; padding:20px; width:93%; height:250px;}

input[type=checkbox] {
        width:14px;height:20px;position:absolute;opacity:0;left:0;top:0
}
input[type=checkbox] + label{
    display:inline-block;width:auto;height:18px;padding-left:20px;color:#bbb;background:url(image/bg_check.png) no-repeat 0 0;
} 
input[type=checkbox] + label:hover {background-position:0 -20px;color:#999}
input[type="checkbox"]:checked + label, input[type="checkbox"]:hover:checked + label, input[type="checkbox"]:focus:checked + label {background-position:0 -20px;color:#999}

.talbe-view2 {border-top:1px dashed #aaa}
.talbe-view2 th, .talbe-view2 td {font-family:'notokr-regular','맑은 고딕', Arial;height:30px;border:1px dashed #aaa}
.talbe-view2 th {background:#efefef}
.talbe-view2 td {padding:5px;text-align:center}

.table-outline {margin-top:20px;padding:5px;}

</style>

</head>
<body>

<div id="wrapper">

<form id="mainform2" name="mainform2" action="" method="post">
<input type="hidden" id="fileName" name="fileName" />
<input type="hidden" id="filePath" name="filePath" />
<input type="hidden" id="orgFileName" name="orgFileName" />
</form>

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="comm_seq" name="comm_seq" value="${info.comm_seq }" />
<input type="hidden" id="srch_title" name="srch_title" value="${srch.srch_title }" />
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }" />
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }" />
<input type="hidden" id="srch_nm" name="srch_nm" value="${srch.srch_nm}" />

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
					<tr>
						<th>제목</th>
						<td>${info.title}</td>
					</tr>
					<tr>
						<th>내용</th>
						<td style="text-align:left;padding:10px">
							${info.cntn}
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>
							<a href="javascript:file_down('${info.file_nm}','${info.org_file_nm}')" class="attach-file">${info.org_file_nm}</a>
						 </td>
					</tr>
				</tbody>
			</table>
			
			<div class="table-outline">
			<table class="talbe-view2" >
				<colgroup>
					<col style="width:10%" />
					<col style="width:55%" />
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:5%" />
				</colgroup>
				<tbody>
					<tr>
						<th>시도</th>
						<th>내용</th>
						<th>첨부</th>
						<th>답변일자</th>
						<th><input type="checkbox" name="chkAll" id="chkAll" value="" /><p><label for="chkAll">메일</label></p></th>
					</tr>
					<c:forEach items="${list}" var="c" varStatus="status">
						<tr>
							<td>${c.sido_cd_nm}</td>
							<td class="padding-cell" style="height:50px;word-break:break-all">${c.cntn}</td>
							<td><a href="javascript:file_down('${c.file_nm}','${c.org_file_nm}')" class="attach-file">${c.org_file_nm}</a></td>
							<td>${c.submit_dt}</td>
							<td>
								<c:if test="${c.submit_yn ne 'Y'}">
									<input type="checkbox" class="seqs" name="sido_${c.sido_cd}" id="${c.sido_cd}" value="${c.sido_cd}" />
									<label for="${c.sido_cd}"></label>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>	
			
			<div class="btn-block text-center mt20">
				<c:choose>
					<c:when test="${info.cnt eq 0}">
						<a href="javascript:comm_delete();" class="btn-red" style="float:left"><span>삭제</span></a>
						<a href="javascript:comm_edit();" class="btn-blue"><span>수정</span></a>
					</c:when>
					<c:otherwise>
						<a href="javascript:comm_close();" class="btn-blue" style="float:left"><span>종료</span></a>
					</c:otherwise>
				</c:choose>
				<a href="javascript:go_list();" class="btn-orange"><span>리스트</span></a>

				<a href="javascript:mail_send();" class="btn-green" style="float:right"><span>메일발송</span></a>
			</div>
			
		</div><!--// layer-content -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</div>
</body>
</html>