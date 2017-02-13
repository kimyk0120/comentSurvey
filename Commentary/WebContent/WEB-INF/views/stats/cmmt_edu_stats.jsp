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
<script type="text/javascript">

	$(document).ready(function() {
		
		var ym = "<c:out value="${srch.srch_ym}" />";
		if(ym != "")  $("#srch_ym").val(ym).change(); 
		
	});
	
	
	$(function() {
		$('.formSelect').sSelect();
		$('#tabs').tabs();
	});
	
	function go_srch() {
		
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_edu_stats.do";
		document.mainform.submit();
	}
	
	function excel_down() {
		
		document.mainform.target = "_self";
		document.mainform.action = "stats_edu_excel_down.do";
		document.mainform.submit();
	}
	
	function main_info() {
		window.location.href="main_info.do?top=9&left=9";
	}
	
</script>
</head>
<body>
<div id="wrapper">
	
	<form id="mainform" name="mainform" action="" method="post">
	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container" class="main"><!-- 메인 페이지에 클래스 main 삽입 -->

		<div class="user-info">
			<div class="shadow-box">
				<div class="comment">안녕하세요.</div>
				<div class="view-content">
					<div class="user-photo">
						<c:set value="<%=session.getAttribute(\"prflImg\") %>" var="prfl" />
						<c:choose>
							<c:when test="${fn:length(prfl) gt 0 }">
								<img src="files/image/${prfl}" class="person" style="max-height:70px;width:inherit" alt="프로필 사진"/>
							</c:when>
							<c:otherwise>
								<div class="photo"><img src="image/user_default_70.png" alt="<%=session.getAttribute("UserNm") %>" /></div>
								<div class="cover"><a href="#a"><img src="image/user_cover_70.png" alt="<%=session.getAttribute("UserNm") %>" /></a></div><!-- 클릭했을 때 사용자 정보로 이동하지 않으면 a 태그 삭제 -->
							</c:otherwise>
						</c:choose>
					</div>
					<p class="name"><strong><%=session.getAttribute("UserNm") %></strong> 님</p>
					<c:set value="<%=session.getAttribute(\"sidoCdNm\") %>" var="sNm" />
					<p>
						<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
						<c:choose>
							<c:when test="${auth eq 1 }">
								관리자
							</c:when>
							<c:when test="${sNm eq 'null'}"></c:when>
							<c:otherwise>
								${sNm}
							</c:otherwise>
						</c:choose>
					</p>
				</div>
			</div><!--// shadow-box -->

			<div class="shadow-box">
				<div class="btn">
					<a href="javascript:main_info()"><span class="text1">문화관광해설사</span><span class="text2">관 리 시 스 템</span><span class="text3">안내</span></a>
				</div>
			</div><!--// shadow-box -->

		</div><!--// user-info -->

		<div class="contents">
		
			<div class="set-period">
				<span class="txt-symbol">기준년도</span>
					<select class="formSelect" id="srch_ym" name="srch_ym" style="width:100px;" title="">
						<c:forEach items="${y_list}" var="y">
							<option value="${y.yyyy}">${y.yy}</option>
						</c:forEach>
					</select>
				
				<a href="javascript:go_srch()"><img src="image/magnifier13.png" style="height:18px;margin-left:10px" alt="검색"/><span class="text-hidden">검색</span> </a>
			</div>
			
			<div class="col2 clearfix" style="margin-top:20px">
				<div class="shadow-box float-left" style="width:98%">
					<div class="top-bar">
						<h2>지역별 문화관광해설사 보수교육 실시 현황</h2>
						<div class="btn-box"><a href="javascript:excel_down()" class="btn-excel" title="엑셀 다운로드"><span class="text-hidden">다운</span></a></div>
					</div>
					<div class="view-content" style="min-height:0px">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:15%" />
								<col style="width:25%" />
								<col style="width:20%" />
								<col style="width:20%" />
							</colgroup>
							<thead>
								<tr>
									<th style="border-right:1px solid #FFF;">구분</th>
									<th colspan="4" style="border-right:1px solid #FFF;"> ${srch.srch_ym}년도  보수교육 실시 현황</th>
								</tr>
								<tr>
									<th style="background:#f0f3ff;border-right:1px solid #FFF;">지역</th>
									<th style="background:#f0f3ff;border-right:1px solid #FFF;">보수교육 실시여부(실시/미실시)</th>
									<th style="background:#f0f3ff;border-right:1px solid #FFF;">보수교육실시 기관명</th>
									<th style="background:#f0f3ff;border-right:1px solid #FFF;">보수교육 실시 시기</th>
									<th style="background:#f0f3ff;">보수교육참여인원</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="view-content" style="overflow: auto;height: 550px; width: 100%;">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:15%" />
								<col style="width:25%" />
								<col style="width:20%" />
								<col style="width:20%" />
							</colgroup>
							<tbody>
								<c:forEach items="${e_list}" var="e" varStatus="status">
									<tr>
										<td>${e.sido_cd_nm }</td>
										<td>${e.edu_yn }</td>
										<td>${e.edu_place }</td>
										<td>${e.edu_tm }</td>
										<td>${e.edu_cnt }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div><!-- // shadow-box -->
			</div>

		</div><!--// contents -->
	</div><!--// container -->
	</form>
</div>


</body>
</html>


