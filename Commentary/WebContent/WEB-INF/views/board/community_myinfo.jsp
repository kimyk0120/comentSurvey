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

$(document).ready(function(){
	  var fileTarget = $('.filebox .upload-hidden');

	  fileTarget.on('change', function(){  // 값이 변경되면
	    if(window.FileReader){  // modern browser
	      var filename = $(this)[0].files[0].name;
	    } 
	    else {  // old IE
	      var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
	    }
	    
	    // 추출한 파일명 삽입
	    $(this).siblings('.upload-name').val(filename);
	  });
	}); 
	
	function file_down(nm, org_nm) { 
		$('#fileName').val(nm);
		$('#orgFileName').val(org_nm);
		$('#filePath').val("files/community");
		document.mainform2.action = "file_down.do";
		document.mainform2.submit();
	}
	
	function board_save() {
		if(confirm("저장하시겠습니까? 제출은 별도로 진행하셔야 합니다.")) {
			document.mainform.action = "comm_mysave.do";
			document.mainform.submit();
		}
	}
	
	function board_submit() {
		if(confirm("제출하시겠습니까?")) {
			$('#submit_yn').val("Y");
			document.mainform.action = "comm_mysave.do";
			document.mainform.submit();
		}
	}
	
	function go_list() {
		document.mainform.action = "community_list.do";
		document.mainform.submit();
	}
		
</script>

<style type="text/css">
.talbe-view2 {border-top:1px solid #dcdcdc}
.talbe-view2 th, .talbe-view2 td {font-family:'notokr-regular','맑은 고딕', Arial;height:30px;border-bottom:1px solid #dcdcdc}
.talbe-view2 th {background:#efefef}
.talbe-view2 td {padding:0 2px 0 5px;}

.filebox input[type="file"] {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip:rect(0,0,0,0);
  border: 0;
}

.filebox label {
  display: inline-block;
  padding: 4px 20px;
  color: #999;
  font-size: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #fdfdfd;
  cursor: pointer;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
}

/* named upload */
.filebox .upload-name {
  width:70%;
  display: inline-block;
  padding: 2px 10px;  /* label의 패딩값과 일치 */
  font-size: inherit;
  font-family: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  -webkit-appearance: none; /* 네이티브 외형 감추기 */
  -moz-appearance: none;
  appearance: none;
}

</style>

</head>
<body>

<div id="wrapper">

<form id="mainform2" name="mainform2" action="" method="post">
<input type="hidden" id="fileName" name="fileName" />
<input type="hidden" id="filePath" name="filePath" />
<input type="hidden" id="orgFileName" name="orgFileName" />
</form>

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
<form id="mainform" name="mainform" method="post" enctype="multipart/form-data">
<input type="hidden" id="comm_seq" name="comm_seq" value="${c_info.comm_seq }" />			
<input type="hidden" id="sido_cd" name="sido_cd" value="${c_info.sido_cd}" />
<input type="hidden" id="submit_yn" name="submit_yn"/>
<input type="hidden" id="srch_title" name="srch_title" value="${srch.srch_title }" />
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }" />
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }" />
<input type="hidden" id="srch_nm" name="srch_nm" value="${srch.srch_nm}" />
			<table class="talbe-view2" style="margin-top:10px">
				<colgroup>
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:30%" />
				</colgroup>
				<tbody>
					<tr>
						<th>답변일자 </th>
						<td>
							${c_info.reg_dt}
						</td>
						<th>제출일자 </th>
						<td>
							${c_info.submit_dt}
						</td>
					</tr>
					<tr>
						<th>내용 </th>
						<td colspan="3">
							<textarea id="cntn" name="cntn" style="width:98%; height:300px;" 
							<c:if test="${c_info.submit_yn eq 'Y' or info.open_yn eq 'N'}">readonly="readonly"</c:if>
							>${c_info.cntn }</textarea>
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
							<c:choose>
								<c:when test="${c_info.submit_yn eq 'Y' or info.open_yn eq 'N'}">
									<a href="javascript:file_down('${c_info.file_nm}','${c_info.org_file_nm}')" class="attach-file">${c_info.org_file_nm}</a>
								</c:when>
								<c:otherwise>
									<div class="filebox" width="98%">
									  <input class="upload-name" disabled="disabled" value="${c_info.org_file_nm}"/>
									  <label for="ex_filename">업로드</label> 
									  <input type="file" id="ex_filename" name="ex_filename" class="upload-hidden" value=""/>
									</div>
								</c:otherwise>
							</c:choose>
							
						</td>
					</tr>
					
				</tbody>
			</table>
	
			
			<div class="btn-block text-center mt20" style="margin-bottom:40px">
				<c:if test="${c_info.submit_yn ne 'Y'}">
					<a href="javascript:board_submit()" class="btn-red"><span>제출</span></a>
					<a href="javascript:board_save()" class="btn-blue"><span>저장</span></a>
				</c:if>					
				<a href="javascript:go_list()" class="btn-orange" style="float:right"><span>리스트</span></a>
			</div>
		</form>		
				
		</div><!--// layer-content -->

		</div><!--// contents -->
	</div><!--// container -->

</div>
</body>
</html>