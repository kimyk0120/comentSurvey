<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.net.URLEncoder" %>
<c:set var="name" value="${filename}" />
<%
		String name = pageContext.getAttribute("name").toString();

		name = new String(name.getBytes("KSC5601"), "8859_1");

		response.setContentType("application/vnd.ms-excel"); 
		response.setHeader("Content-Disposition", "attachment; filename="+name+".xls"); 
	    response.setHeader("Content-Description", "JSP Generated Data");
%>

<html>
<head>
<title>엑셀파일변환</title>
</head>
<form name="mainform" id="mainform">
<table border="1">
	<colgroup>
		<col style="width:14%;" />
		<col style="width:14%;"  />
		<col style="width:4%" />
		<col style="width:4%" />
		<col style="width:4%;" />
		<col style="width:4%" />
		<col style="width:4%" />
		<col style="width:4%;" />
		<col style="width:4%" />
		<col style="width:4%" />
		<col style="width:4%;" />
		<col style="width:4%" />
		<col style="width:4%" />
		<col style="width:4%;" />
		<col style="width:4%" />
		<col style="width:4%" />
		<col style="width:4%;" />
		<col style="width:4%" />
		<col style="width:4%" />
		<col style="width:4%;" />
	</colgroup>
	<thead>
		<tr>
			<th rowspan="2">
				<c:choose>
					<c:when test="${srch.srch_prt eq '1'}">교육기관</c:when>
					<c:when test="${srch.srch_prt eq '2'}">강사</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
				명
			</th>
			<th rowspan="2">지역</th>
			<th colspan="3">${fn:substring(srch.srch_yymm,0,4)}년 ${fn:substring(srch.srch_yymm,5,7)}월</th>
			<th colspan="3">
				<c:set var="m1" value="${fn:substring(srch.srch_yymm,5,7) -1}" />
				<c:choose>
					<c:when test="${m1 lt 1}">
						${fn:substring(srch.srch_yymm,0,4) -1}년 ${fn:substring(srch.srch_yymm,5,7) +11}월
					</c:when>
					<c:otherwise>
						${fn:substring(srch.srch_yymm,0,4)}년 ${fn:substring(srch.srch_yymm,5,7)-1}월
					</c:otherwise>
				</c:choose>
			</th>
			<th colspan="3">
				<c:set var="m2" value="${fn:substring(srch.srch_yymm,5,7) -2}" />
				<c:choose>
					<c:when test="${m2 lt 1}">
						${fn:substring(srch.srch_yymm,0,4) -1}년 ${fn:substring(srch.srch_yymm,5,7) +10}월
					</c:when>
					<c:otherwise>
						${fn:substring(srch.srch_yymm,0,4)}년 ${fn:substring(srch.srch_yymm,5,7)-2}월
					</c:otherwise>
				</c:choose>
			</th>
			<th colspan="3">
				<c:set var="m3" value="${fn:substring(srch.srch_yymm,5,7) -3}" />
				<c:choose>
					<c:when test="${m3 lt 1}">
						${fn:substring(srch.srch_yymm,0,4) -1}년 ${fn:substring(srch.srch_yymm,5,7) +9}월
					</c:when>
					<c:otherwise>
						${fn:substring(srch.srch_yymm,0,4)}년 ${fn:substring(srch.srch_yymm,5,7)-3}월
					</c:otherwise>
				</c:choose>
			</th>
			<th colspan="3">
				<c:set var="m4" value="${fn:substring(srch.srch_yymm,5,7) -4}" />
				<c:choose>
					<c:when test="${m4 lt 1}">
						${fn:substring(srch.srch_yymm,0,4) -1}년 ${fn:substring(srch.srch_yymm,5,7) +8}월
					</c:when>
					<c:otherwise>
						${fn:substring(srch.srch_yymm,0,4)}년 ${fn:substring(srch.srch_yymm,5,7)-4}월
					</c:otherwise>
				</c:choose>
			</th>
			<th colspan="3">
				<c:set var="m5" value="${fn:substring(srch.srch_yymm,5,7) -5}" />
				<c:choose>
					<c:when test="${m5 lt 1}">
						${fn:substring(srch.srch_yymm,0,4) -1}년 ${fn:substring(srch.srch_yymm,5,7) +7}월
					</c:when>
					<c:otherwise>
						${fn:substring(srch.srch_yymm,0,4)}년 ${fn:substring(srch.srch_yymm,5,7)-5}월
					</c:otherwise>
				</c:choose>
			</th>
		</tr>
	<tr style="height:50px;">
		<th style="">횟수</th>
		<th style="padding:0px;b">수강생</th>
		<th style="padding:0px;">검정률</th>
		<th style="">횟수</th>
		<th style="padding:0px;">수강생</th>
		<th style="padding:0px;">검정률</th>
		<th style="">횟수</th>
		<th style="padding:0px;">수강생</th>
		<th style="padding:0px;">검정률</th>
		<th style="">횟수</th>
		<th style="padding:0px;">수강생</th>
		<th style="padding:0px;">검정률</th>
		<th style="">횟수</th>
		<th style="padding:0px;">수강생</th>
		<th style="padding:0px;">검정률</th>
		<th style="">횟수</th>
		<th style="padding:0px;">수강생</th>
		<th style="padding:0px">검정률</th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${list}" var="c" varStatus="status">
	<tr>
		<td style="padding:0px 2px">
			<c:choose>
				<c:when test="${srch.srch_prt eq '1'}">${c.edu_inst_nm}</c:when>
				<c:when test="${srch.srch_prt eq '2'}">${c.teacher_nm}</c:when>
				<c:otherwise></c:otherwise>
			</c:choose>
		</td>
		<td style="padding:0px">${c.sido_code_nm} ${c.gugun_code_nm}</td>
		<td style="padding:0px;">${c.cnt1}</td>
		<td style="padding:0px;">${c.st_cnt1}</td>
		<td style="padding:0px;">${c.ex_cnt1}%</td>
		<td style="padding:0px;">${c.cnt2}</td>
		<td style="padding:0px;">${c.st_cnt2}</td>
		<td style="padding:0px;">${c.ex_cnt2}%</td>
		<td style="padding:0px;">${c.cnt3}</td>
		<td style="padding:0px;">${c.st_cnt3}</td>
		<td style="padding:0px;">${c.ex_cnt3}%</td>
		<td style="padding:0px;">${c.cnt4}</td>
		<td style="padding:0px;">${c.st_cnt4}</td>
		<td style="padding:0px;">${c.ex_cnt4}%</td>
		<td style="padding:0px;">${c.cnt5}</td>
		<td style="padding:0px;">${c.st_cnt5}</td>
		<td style="padding:0px;">${c.ex_cnt5}%</td>
		<td style="padding:0px;">${c.cnt6}</td>
		<td style="padding:0px;">${c.st_cnt6}</td>
		<td style="padding:0px;">${c.ex_cnt6}%</td>
	</tr>
	</c:forEach>
	</tbody>
</table>
</form>
</html>
	