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
<title>수강생 상세정보</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
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

	function edu_stdt_edit() {
		document.mainform.action = "stdt_edit.do";
		document.mainform.submit();
	}
	
	function go_list() {
		document.mainform.action = "stdt_list.do";
		document.mainform.submit();
		
	}
	
	function moveUrl(t, l, url ) {
		mainform.top.value=t;
		mainform.left.value=l;
		location.href = url+"?top="+t+"&left="+l;
		//document.mainform.action = url;
		//document.mainform.submit();
	}
	
	
</script>
</head>
<body>
<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="pageNum" name="pageNum"  value="${srch.pageNum}"/>
<input type="hidden" id="stdt_no" name="stdt_no" value="${info.student_no }"/>
<input type="hidden" id="srch_lecture" name="srch_lecture" value="${srch.srch_lecture }"/>
<input type="hidden" id="srch_student_name" name="srch_student_name" value="${srch.srch_student_name }"/>
<input type="hidden" id="srch_phone" name="srch_phone" value="${srch.srch_phone }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp" flush="false" />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp" flush="false" />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">수강생 상세정보</h2>
				<h3 class="mb0">${info.student_name }</h3>
			</div>

			<table class="talbe-view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>성명</th>
						<td>${info.student_name }</td>
						<th rowspan="3">사진</th>
						<td rowspan="3" class="inner">
							<c:if test="${fn:length(info.image_path) gt 0 }">
								<img src="files/image/${info.image_path}" class="person" />
							</c:if>
						</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>${info.resist_no}</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>${info.phone }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${info.sido_code_nm } ${info.gugun_code_nm } ${info.address } </td>
					</tr>
					<tr>
						<th>이메일</th>
						<td colspan="3">${info.email }</td>
					</tr>
					
				</tbody>
			</table>
			
			<dl class="table-dl mt35">
				<dt>자격</dt>
				<dd>
					<table class="talbe-inner">
						<colgroup>
							<col style="width:25%" />
							<col style="width:25%" />
							<col style="width:25%" />
							<col style="width:25%" />
						</colgroup>
						<thead>
							<tr>
								<th>자격명</th>
								<th>자격번호</th>
								<th>교육기관</th>
								<th>취득일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${s_list}" var="s" varStatus="status">
								<tr>
									<td>${s.lecture_nm }</td>
									<td>${s.qlfc_no }</td>
									<td>${s.edu_inst_nm }</td>
									<td>${s.qlfc_issue_dt }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</dd>
			</dl>
			
			
			<div class="btn-block">
				<a href="javascript:edu_stdt_edit()"><span>수정</span></a>
				<a href="javascript:go_list()" class="btn-gray"><span>리스트</span></a>
			</div><!--// contents -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>

</form>

</body>
</html>