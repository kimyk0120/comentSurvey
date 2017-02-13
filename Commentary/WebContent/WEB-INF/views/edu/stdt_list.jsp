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
<title>수강생 관리</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">

	$(document).ready(function() {
		
		var srchLecture = "<c:out value="${srch.srch_lecture_prt}"/>";
		
		if(srchLecture != null && srchLecture != '') {
			$("#srch_lecture_prt").val(srchLecture).change(); 
		}
	});
	
	$(function() {
		$('.formSelect').sSelect();
	});
	
	function go_page(no) {
		
		mainform.pageNum.value = no;
		document.mainform.action = "stdt_list.do";
		document.mainform.submit();
	}
	
	function edu_create() {
		document.mainform.action = "edu_create.do";
		document.mainform.submit();
	}
	
	function src_stdt() {
		document.mainform.action = "stdt_list.do";
		document.mainform.submit();
	}
	
	function checkEnterKey(){
		if(event.keyCode==13){src_stdt();}
	}
	
	$(function() {
	    $("#srch_str_dt").datepicker({
	    });
	    $("#srch_end_dt").datepicker({
	    });
	     
	  });
	
	function stdt_info(s_no) {
		mainform.st_no.value = s_no;
		document.mainform.action = "stdt_info.do";
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
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="pageNum" name="pageNum"  value="" />
<input type="hidden" id="st_no" name="st_no"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

		<div class="contents">

			<div class="contents-top">
				<h2>수강생</h2>
				<!-- <div class="btn-block">
					<a href="javascript:edu_create()"><span>교육등록</span></a>
				</div> -->
			</div>

			<div class="search-block">
				<div class="search-row">
					<select class="formSelect" id="srch_lecture_prt" name="srch_lecture_prt" style="width:150px;margin-right:17px" title="">
						<option value="" selected="selected">강의종류</option>
						<c:forEach items="${l_list}" var="l" varStatus="status">
							<option value="${l.lecture_code }">${l.lecture_nm }</option>	
						</c:forEach>
					</select>
					<input type="text" id="srch_student_name" name="srch_student_name" placeholder="수강생명 검색" value="${srch.srch_student_name}" class="readonly" onKeyDown="javascript:checkEnterKey()"/>
					<input type="text" id="srch_phone" name="srch_phone" placeholder="연락처 검색" value="${srch.srch_phone}"  class="readonly" onKeyDown="javascript:checkEnterKey()"/>
				</div><!-- // search-row -->
				<div class="btn-block">
					<a href="javascript:src_stdt()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->

			<table class="talbe-list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:15%" />
					<col style="width:18%" />
					<col style="width:17%"/>
					<col style="width:15%"/>
					<col style="width:20%"/>
				</colgroup>
				<thead>
					<tr>
						<th>No</th>
						<th>성명</th>
						<th>연락처</th>
						<th>지역</th>
						<th>이메일</th>
						<th>교육기관</th>
						<th>보유자격</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
					<tr onclick="javascript:stdt_info('${c.student_no}')">
						<td>${c.row_num}</td>
						<td>${c.student_name}</td>
						<td>${c.phone}</td>
						<td class="text-left">${c.sido_code_nm} ${c.gugun_code_nm}</td>
						<td>${c.email}</td>
						<td>${c.edu_inst_nm}</td>
						<td>${c.lecture_nm}</td>
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
				   		<li><a class="no-bg" href="javascript:go_page('1')">&lt;</a></li>
				   		<li><a class="no-bg" href="javascript:go_page('${(numPageGroup-2)*pageGroupSize+1 }')">&lt;&lt;</a></li>
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
				   		<li><a class="no-bg" href="javascript:go_page('${numPageGroup*pageGroupSize+1}')">&gt;&gt;</a></li>
				   		<li><a class="no-bg" href="javascript:go_page('<fmt:formatNumber value="${count/pageSize+1}" type="number" maxFractionDigits="0"/>')">&gt;</a></li>
				   </c:if>
				</c:if>
			</ul>
		</div>
	</form>	

		</div><!--// contents -->
	</div><!--// container -->


</body>
</html>