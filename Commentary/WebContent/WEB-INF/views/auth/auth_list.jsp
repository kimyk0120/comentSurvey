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
	$(function() {
		$('.formSelect').sSelect();
	});
	
	function auth_create() {
		
		document.mainform.target = "_self";
		document.mainform.action = "auth_create.do";
		<%-- document.mainform.action = "auth_create.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>; --%>
		document.mainform.submit();
	}
	
	function auth_info(a_no) {
		
		$('#a_no').val(a_no);
		
		document.mainform.target = "_self";
		document.mainform.action = "auth_info.do";
		document.mainform.submit();
	}
	
	function srch_auth() {
		document.mainform.target = "_self";
		document.mainform.action = "auth_list.do";
		document.mainform.submit();
	}
	
</script>
</head>
<body>
<div id="wrapper">
	
<form id="mainform" name="mainform" action="" method="post">
	<jsp:include page="../main/topMenu.jsp"  />
	
<input type="hidden" id="a_no" name="a_no"/>

	<div id="container" class="colum1"><!-- 왼쪽에 사용자 정보가 없을 경우 클래스 colum1 삽입 -->

		<div class="contents">

			<h2>권한 조회</h2>

			<div class="shadow-box">

				<div class="search-block">

					<div class="item-block clearfix">
						<dl class="float-left">
							<dt>검색항목</dt>
							<dd>
								<ul>
									<li><label><span>권한명</span><input type="text" name="srch_nm" id="srch_nm" value="${srch.srch_nm }" style="width:80px;" title="검색 권한명"/></label></li>
								</ul>
							</dd>
						</dl>
					</div><!-- // item-block -->

					<div class="btn-block" style="margin-top:-25px">
						<a href="javascript:srch_auth();" class="btn-search2"><span style="padding-top:0px">검색</span></a>
					</div>
					
				</div><!-- //search-block -->

				<!-- <div class="btn-block text-right mb10">
					<a href="javascript:auth_create()" class="btn-blue"><span>권한 등록</span></a>
				</div> -->

				<table class="talbe-list">
					<colgroup>
						<col style="width:10%" />
						<col style="width:*" />
						<col style="width:20%" />
						<col style="width:20%" />
					</colgroup>
					<thead>
						<tr>
							<th>No</th>
							<th>권한명</th>
							<th>권한부여 인원수</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="c" varStatus="status">
							<tr onclick="javascript:auth_info('${c.auth_no}')">
								<td>${c.row_num}</td>
								<td>${c.auth_nm}</td>
								<td>${c.auth_cnt}</td>
								<td>${c.rgst_dt }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<ul class="paging">
					<c:if test="${count > 0}">
					   <c:set var="pageCount" value="${count / pageSize + ( count % pageSize == 0 ? 0 : 1)}"/>
					   <c:set var="startPage" value="${pageGroupSize*(numPageGroup-1)+1}"/>
					   <c:set var="endPage" value="${startPage + pageGroupSize-1}"/>
					   <c:if test="${endPage > pageCount}" ><c:set var="endPage" value="${pageCount}" /></c:if>
					          
					   <c:if test="${numPageGroup > 1}">
					   		<li><a class="no-bg" href="javascript:go_page('1')">&lt;&lt;</a></li>
					   		<li><a class="no-bg" href="javascript:go_page('${(numPageGroup-2)*pageGroupSize+1 }')">&lt;</a></li>
					   </c:if>
					
					   <c:forEach var="i" begin="${startPage}" end="${endPage}">
					       <li>
					           <c:choose>
					               <c:when test="${currentPage == i}">
					               		<a href="javascript:go_page('${i}')" class="no-bg on">${i}</a>
					               </c:when>
					               <c:otherwise>
							       		<a href="javascript:go_page('${i}')" class="no-bg">${i}</a>
					               </c:otherwise>
							   </c:choose>    		
					       </li>
					   </c:forEach>
					   <c:if test="${numPageGroup < pageGroupCount}">
					   		<li><a class="no-bg" href="javascript:go_page('${numPageGroup*pageGroupSize+1}')">&gt;</a></li>
					   		<li><a class="no-bg" href="javascript:go_page('<fmt:formatNumber value="${count/pageSize}" type="number" maxFractionDigits="0"/>')">&gt;&gt;</a></li>
					   </c:if>
					</c:if>
				</ul>

			</div><!-- // shadow-box -->

		</div><!--// contents -->
	</div><!--// container -->
	</form>
</div>


</body>
</html>