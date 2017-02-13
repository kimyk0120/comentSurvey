<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.net.URLEncoder" %>
<c:set var="name" value="주소정보" />
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
		<col style="width:25%;" />
		<col style="width:25%;"  />
		<col style="width:25%" />
		<col style="width:25%;" />
	</colgroup>
	<thead>
		<tr>
			<th>이름</th>
			<th>시구군</th>
			<th>상세주소</th>
			<th>연락처</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${list}" var="c" varStatus="status">
	<tr>
		<td style="padding:0px">${c.student_name}</td>
		<td style="padding:0px">${c.sido_code_nm} ${c.gugun_code_nm}</td>
		<td style="padding:0px;">${c.address}</td>
		<td style="padding:0px;">${c.phone}</td>
	</tr>
	</c:forEach>
	</tbody>
</table>
</form>
</html>
	