<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE HTML>
<html>
	<head>
		<title> :: PRIDE IN SUSTINVEST :: </title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
		<script type="text/javascript" src="./js/jquery.js"></script>
		<script type="text/javascript" src="./js/common.js"></script>
		<script src="./js/jquery-1.10.2.js" type="text/javascript"></script>
		  <script src="./js/jquery-ui.js" type="text/javascript"></script>
		
	<script type="text/javascript">
	function board_save() {
		if( confirm("저장 하시겠습니까?") ) {
			
			document.mainform.action = "file_save2.do";
			document.mainform.submit();
		}
	}
		
		function file_down(fileNm, filePath) { 
			fileform.fileName.value=fileNm;
			fileform.filePath.value=filePath;
			document.fileform.action = "file_down.do";
			document.fileform.submit();
			
		}
		
		function file_del(edu_proc, seq) {
			if( confirm("삭제 하시겠습니까?") ) {
				fileform.eduProcNo.value=edu_proc;
				fileform.seq.value=seq;
				document.fileform.action = "file_del.do";
				document.fileform.submit();
			}
		}
		</script>	
  
	</head>
	<body>
    <form id="mainform" name="mainform" method="post" enctype="multipart/form-data">
    <input type="hidden" name="edu_proc_no" value="TC001_01">
		<div class="wrap">
			<div class="content_top">			
				<div class="clear"> </div>
	        </div>
				<div class="content_middle" align="center">
				
				<table>
					<tr>
						<td>실습일지</td>
						<td>
			            <input type="file" name="fileName1" multiple="multiple" size="100">
			            </td>
			            <td>
			            
			            </td>
					</tr>
					<tr>
						<td>강의평가</td>
						<td>
			            <input type="file" name="fileName2" multiple="multiple" size="100">
			            </td>
			            <td>
			            <input type="submit" value="Upload" onclick="javascript:board_save()">
			            </td>
					</tr>
				</table>
				</div>
		</div>
    </form>
    <form id="fileform" name="fileform" method="post" >
    	<input type="hidden" name="fileName" value="">
    	<input type="hidden" name="filePath" value="">
    	<input type="hidden" name="eduProcNo" value="">
    	<input type="hidden" name="seq" value="">
	    <div class="news">
			<div class="news_desc2">
				<table class="company_search2">
					<tr>
						<th width=15%>파일명</th>
						<th width=20%>삭제</th>
					</tr>
					<c:forEach items="${list}" var="c"> 
						<tr>
<%-- 							<td align="center"><a href="./file_down.do?fileName=${c.file_org_nm}&filePath=${c.file_path}" >${c.file_org_nm}</a></td> --%>
							<td align="center"><a href="javascript:file_down('${c.file_org_nm}','${c.file_path}')">${c.file_org_nm}</a></td>
							<td align="center"><input type="submit" value="삭제" onclick="javascript:file_del('${c.edu_proc_no}','${c.file_seq}')"></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</form>
	</body>
</html>


