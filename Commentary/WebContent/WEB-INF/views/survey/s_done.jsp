<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>survey_result</title>
<link rel="shortcut icon" type="image/png" href=""/>
<link rel="stylesheet" href="/surveySrc/css/style.css">
<link rel="stylesheet" href="/surveySrc/css/survey_style.css">
<link rel="stylesheet" href="/surveySrc/css/re_style.css">
<script type="text/javascript" src="/surveySrc/js/jquery-1.11.3.min.js"></script>
    <!-- alertify -->
<link rel="stylesheet" href="/surveySrc/css/alertify.css">
<!-- jquery UI -->
<script src="/surveySrc/js/jquery-ui.js"></script>
<link rel="stylesheet" href="/surveySrc/css/jquery-ui.css">
<!-- font-awesome -->
<link rel="stylesheet" href="/surveySrc/css/font-awesome.min.css">
<style type="text/css">
.doneMsgTop{
 	text-align: center;
 	margin-top: 3em;
 	margin-right: 0px;
}
</style>
</head>
<body>
    <div class="bg"></div>
    <div id="sr_header">
        <h1 id="logo">
            <img src="/surveySrc/img/logo.png" alt="logo" class="fl">
            <p class="fl">문화관광해설사<br/>
            인력관리 시스템</p>
        </h1>        
    </div>
    <div id="sr_contents">
        <div class="clear"></div>
        <c:choose>
        	<c:when test="${stdtChkYn eq 'N'}">
   		        <h1 class="doneMsgTop">설문이 종료되었습니다.</h1>
        	</c:when>
        	<c:otherwise>
		        <h1 class="doneMsgTop">답변이 완료되었습니다.</h1>
        	</c:otherwise>
        </c:choose>
        <h2 class="doneMsgTop">감사합니다.</h2>
    </div>
</body>
</html>