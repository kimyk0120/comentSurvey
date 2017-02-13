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
		
		/*var y = "<c:out value="${now_ym}" />";
		
		 if(y.substring(0, 4) != null && y.substring(0, 4) != '') {
			$("#srch_yy").val(y.substring(0, 4)).change(); 
		}
		if(y.substring(5, 7) != null && y.substring(5, 7) != '') {
			$("#srch_mm").val(y.substring(5, 7)).change(); 
		} */

		var prt = "<c:out value="${srch.srch_dt_prt}" />";
		$("#srch_dt_prt").val(prt).change(); 		
		
		var str = "<c:out value="${srch.srch_str_ym}" />";
		var end = "<c:out value="${srch.srch_end_ym}" />";
		
		if(prt == "1") {
			$("#srch_mm1").css("display","inline-block");
			$("#srch_mm2").css("display","inline-block");
			$("#srch_yy1").css("display","none");
			$("#srch_yy2").css("display","none");
			if(str != "")  $("#str_ym1").val(str).change(); 
			if(end != "") $("#end_ym1").val(end).change(); 
		} else if(prt == "2") {
			$("#srch_mm1").css("display","none");
			$("#srch_mm2").css("display","none");
			$("#srch_yy1").css("display","inline-block");
			$("#srch_yy2").css("display","inline-block");
			if(str != "") $("#str_ym2").val(str.substring(0, 4)).change(); 
			if(end != "") $("#end_ym2").val(end.substring(0, 4)).change(); 
		} 
		
	});
	
	function ym_change() {
		
		var prt = $("select[name=srch_dt_prt]").val();
		
		if(prt == "1") {
			$("#srch_mm1").css("display","inline-block");
			$("#srch_mm2").css("display","inline-block");
			$("#srch_yy1").css("display","none");
			$("#srch_yy2").css("display","none");
		} else if(prt == "2") {
			$("#srch_mm1").css("display","none");
			$("#srch_mm2").css("display","none");
			$("#srch_yy1").css("display","inline-block");
			$("#srch_yy2").css("display","inline-block");
		} 
	}
	
	$(function() {
		$('.formSelect').sSelect();
		$('#tabs').tabs();
	});
	
	function go_srch() {
		
		var prt = $("select[name=srch_dt_prt]").val();
		var str1 = $("select[name=str_ym1]").val();
		var end1 = $("select[name=end_ym1]").val();
		var str2 = $("select[name=str_ym2]").val();
		var end2 = $("select[name=end_ym2]").val();
		
		if(prt == "1") {
			$('#srch_str_ym').val(str1);
			$('#srch_end_ym').val(end1);
		} else if(prt == "2") {
			$('#srch_str_ym').val(str2+'-01');
			$('#srch_end_ym').val(end2+'-12');
		} 
		
		if( $('#srch_str_ym').val() > $('#srch_end_ym').val()  ){
			alert("시작값이 종료값보다 클 수 없습니다.");
			return;
		}
		else {
			document.mainform.target = "_self";
			document.mainform.action = "cmmt_arrg_stats.do";
			document.mainform.submit();
		}
	}
	
	function excel_down() {
		var prt = $("select[name=srch_dt_prt]").val();
		var str1 = $("select[name=str_ym1]").val();
		var end1 = $("select[name=end_ym1]").val();
		var str2 = $("select[name=str_ym2]").val();
		var end2 = $("select[name=end_ym2]").val();
		
		if(prt == "1") {
			$('#srch_str_ym').val(str1);
			$('#srch_end_ym').val(end1);
		} else if(prt == "2") {
			$('#srch_str_ym').val(str2+'-01');
			$('#srch_end_ym').val(end2+'-12');
		} 
		
		if( $('#srch_str_ym').val() > $('#srch_end_ym').val()  ){
			alert("시작값이 종료값보다 클 수 없습니다.");
			return;
		}
		else {
			document.mainform.target = "_self";
			document.mainform.action = "stats_arrg_excel_down.do";
			document.mainform.submit();
		}
	}
	
	function main_info() {
		window.location.href="main_info.do?top=9&left=9";
	}
	
</script>
</head>
<body>
<div id="wrapper">
	
	<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="srch_str_ym" name="srch_str_ym" />
<input type="hidden" id="srch_end_ym" name="srch_end_ym" />
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
				<span class="txt-symbol">검색기준</span>
					<select class="formSelect" id="srch_dt_prt" name="srch_dt_prt" style="width:80px;" title="" onchange="javascript:ym_change()">
						<option value="1">월</option>
						<option value="2">년</option>
					</select>
			
				<span class="txt-symbol">시작</span>
				<div id="srch_mm1" style="display:inline-block">
					<select class="formSelect" id="str_ym1" name="str_ym1" style="width:100px;" title="">
						<c:forEach items="${m_list}" var="m">
							<option value="${m.ym}">${m.yymm}</option>
						</c:forEach>
					</select>
				</div>
				<div id="srch_yy1" style="display:inline-block">
					<select class="formSelect" id="str_ym2" name="str_ym2" style="width:100px;" title="">
						<c:forEach items="${y_list}" var="y">
							<option value="${y.yyyy}">${y.yy}</option>
						</c:forEach>
					</select>
				</div>
				<span class="txt-symbol">종료</span>
				<div id="srch_mm2" style="display:inline-block">
					<select class="formSelect" id="end_ym1" name="end_ym1" style="width:100px;" title="">
						<c:forEach items="${m_list}" var="m">
							<option value="${m.ym}">${m.yymm}</option>
						</c:forEach>
					</select>
				</div>
				<div id="srch_yy2" style="display:inline-block">
					<select class="formSelect" id="end_ym2" name="end_ym2" style="width:100px;" title="">
						<c:forEach items="${y_list}" var="y">
							<option value="${y.yyyy}">${y.yy}</option>
						</c:forEach>
					</select>
				</div>
				<a href="javascript:go_srch()"><img src="image/magnifier13.png" style="height:18px;margin-left:10px" alt="검색"/><span class="text-hidden">검색</span> </a>
			</div>
			
			<div class="col2 clearfix" style="margin-top:20px">
				<div class="shadow-box float-left" style="width:98%">
					<div class="top-bar">
						<h2>지역별 문화관광해설사 배치 현황</h2>
						<div class="btn-box"><a href="javascript:excel_down()" class="btn-excel" title="엑셀 다운로드"><span class="text-hidden">다운</span></a></div>
					</div>
					<div class="view-content" style="width:98%;min-height:0px">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:16%" />
								<col style="width:16%" />
								<col style="width:16%" />
								<col style="width:16%" />
								<col style="width:16%" />
							</colgroup>
							<thead>
								<tr>
									<th style="border-right:1px solid #fff">구분</th>
									<th colspan="5" style="border-right:1px solid #fff">문화관광해설사 배치현황</th>
								</tr>
								<tr>
									<th style="background:#f0f3ff;border-right:1px solid #fff">지역</th>
									<th style="background:#f0f3ff;border-right:1px solid #fff">해설사 1인당 월평균 배치일수</th>
									<th style="background:#f0f3ff;border-right:1px solid #fff">해설사 1인당 일일평균 활동시간</th>
									<th style="background:#f0f3ff;border-right:1px solid #fff">해설사 1인당 월 평균 활동시간</th>
									<th style="background:#f0f3ff;border-right:1px solid #fff">해설사 일일 최소활동시간</th>
									<th style="background:#f0f3ff;">해설사 일일 최대활동시간</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="view-content" style="overflow: auto;height:450px; width: 100%;">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:16%" />
								<col style="width:16%" />
								<col style="width:16%" />
								<col style="width:16%" />
								<col style="width:16%" />
							</colgroup>
							<tbody>
								<c:forEach items="${w_list}" var="w" varStatus="status">
									<tr>
										<td>${w.sido_cd_nm }</td>
										<td>${w.cmntor_mon_cnt }</td>
										<td>${w.cmntor_dly_tm }</td>
										<td>${w.cmntor_mon_work }</td>
										<td>${w.cmntor_min_work }</td>
										<td>${w.cmntor_max_work }</td>
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


