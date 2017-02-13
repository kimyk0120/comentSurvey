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
<title>통계</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">


	$(document).ready(function() {
		
		var srchInstGroup = "<c:out value="${srch.srch_inst_group}"/>";
		
		if(srchInstGroup != null && srchInstGroup != '') {
			$("#srch_inst_group").val(srchInstGroup).attr("selected","selected"); 
		}
		
		
	});
	
	$(function() {
		$('.formSelect').sSelect();
	});
	
	
	function src_stats() {
		
		var s_yy = $('#srch_yy').val();
		var s_mm = $('#srch_mm').val();
		
		if(s_yy == null || s_yy == "") {
			alert("년도를 선택하세요.");
			return;
		}
		else if(s_mm == null || s_mm == "") {
			alert("월을 선택하세요.");
			return;
		}
		else {
			mainform.srch_yymm.value=s_yy+"-"+s_mm;		
			document.mainform.action = "arrg_strg_stats.do";
			document.mainform.submit();
		}
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
<input type="hidden" id="srch_yymm" name="srch_yymm"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

		<div class="contents">

			<div class="contents-top">
				<h2>통계</h2>
			</div>

			<div class="search-block">
				<div class="search-row">
					<span class="txt-label" style="min-width:0px">구분</span>
					<select class="formSelect" id="srch_prt" name="srch_prt" style="width:100px;" >
						<option value="1">지역</option>
						<option value="2">지점</option>
						<option value="3">컨설턴트</option>
					</select>
					<span class="txt-label" style="min-width:0px">기준년월</span>
					<select class="formSelect" id="srch_yy" name="srch_yy" style="width:100px;margin-right:17px" title="">
						<c:set var="yy" value="${fn:substring(srch.srch_yymm,0,4)}" />
								<c:forEach items="${y_list}" var="y">
									<option value="${y.yyyy}" <c:if test="${yy eq y.yyyy}"> selected="selected"</c:if>>${y.yyyy}년</option>
								</c:forEach>
					</select>
					<select class="formSelect" id="srch_mm" name="srch_mm" style="width:100px;margin-right:17px" title="">
					<c:set var="mm" value="${fn:substring(srch.srch_yymm,5,7)}" />
						<option value="01" <c:if test="${mm eq '01'}"> selected="selected"</c:if>>1월</option>
						<option value="02" <c:if test="${mm eq '02'}"> selected="selected"</c:if>>2월</option>
						<option value="03" <c:if test="${mm eq '03'}"> selected="selected"</c:if>>3월</option>
						<option value="04" <c:if test="${mm eq '04'}"> selected="selected"</c:if>>4월</option>
						<option value="05" <c:if test="${mm eq '05'}"> selected="selected"</c:if>>5월</option>
						<option value="06" <c:if test="${mm eq '06'}"> selected="selected"</c:if>>6월</option>
						<option value="07" <c:if test="${mm eq '07'}"> selected="selected"</c:if>>7월</option>
						<option value="08" <c:if test="${mm eq '08'}"> selected="selected"</c:if>>8월</option>
						<option value="09" <c:if test="${mm eq '09'}"> selected="selected"</c:if>>9월</option>
						<option value="10" <c:if test="${mm eq '10'}"> selected="selected"</c:if>>10월</option>
						<option value="11" <c:if test="${mm eq '11'}"> selected="selected"</c:if>>11월</option>
						<option value="12" <c:if test="${mm eq '12'}"> selected="selected"</c:if>>12월</option>
					</select>
				</div><!-- // search-row -->
				<div class="btn-block">
					<a href="javascript:src_stats()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->

			<table class="talbe-list">
				<colgroup>
					<col style="width:16%;border-right:1px solid #dedede" />
					<col style="width:4%" />
					<col style="width:10%;border-right:1px solid #dedede" />
					<col style="width:4%" />
					<col style="width:10%;border-right:1px solid #dedede" />
					<col style="width:4%" />
					<col style="width:10%;border-right:1px solid #dedede" />
					<col style="width:4%" />
					<col style="width:10%;border-right:1px solid #dedede" />
					<col style="width:4%" />
					<col style="width:10%;border-right:1px solid #dedede" />
					<col style="width:4%" />
					<col style="width:10%;border-right:1px solid #dedede" />
				</colgroup>
				<thead>
					<tr>
						<th rowspan="2">
							<c:choose>
								<c:when test="${srch.srch_prt eq '1'}">지역</c:when>
								<c:when test="${srch.srch_prt eq '2'}">지점</c:when>
								<c:when test="${srch.srch_prt eq '3'}">컨설턴트</c:when>
							</c:choose>
						</th>
						<th colspan="2">${fn:substring(srch.srch_yymm,0,4)}년 ${fn:substring(srch.srch_yymm,5,7)}월</th>
						<th colspan="2">
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
						<th colspan="2">
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
						<th colspan="2">
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
						<th colspan="2">
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
						<th colspan="2">
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
					<tr style="height:50px">
						<th>건수</th>
						<th>금액</th>
						<th>건수</th>
						<th>금액</th>
						<th>건수</th>
						<th>금액</th>
						<th>건수</th>
						<th>금액</th>
						<th>건수</th>
						<th>금액</th>
						<th>건수</th>
						<th>금액</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
					<tr>
						<td style="padding:0px 2px">${c.name}</td>
						<td style="padding:0px">${c.cnt1}</td>
						<td style="padding:0px"><fmt:formatNumber value="${c.sum1}" /></td>
						<td style="padding:0px">${c.cnt2}</td>
						<td style="padding:0px"><fmt:formatNumber value="${c.sum2}" /></td>
						<td style="padding:0px">${c.cnt3}</td>
						<td style="padding:0px"><fmt:formatNumber value="${c.sum3}" /></td>
						<td style="padding:0px">${c.cnt4}</td>
						<td style="padding:0px"><fmt:formatNumber value="${c.sum4}" /></td>
						<td style="padding:0px">${c.cnt5}</td>
						<td style="padding:0px"><fmt:formatNumber value="${c.sum5}" /></td>
						<td style="padding:0px">${c.cnt6}</td>
						<td style="padding:0px"><fmt:formatNumber value="${c.sum6}" /></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
			
		</div>
	</form>	

		</div><!--// contents -->
	</div><!--// container -->


</body>
</html>