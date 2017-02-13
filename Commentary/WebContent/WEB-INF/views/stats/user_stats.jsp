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
			document.mainform.action = "user_stats.do";
			document.mainform.submit();
		}
	}
	
	function down_cmmt() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_excel_down.do";
		document.mainform.submit();
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
					<a href="#a"><span class="text1">문화관광해설사</span><span class="text2">관 리 시 스 템</span><span class="text3">안내</span></a>
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
			
			<div class="col2 clearfix">
				<div class="shadow-box float-left">
					<div class="top-bar">
						<h2>방문자수</h2>
						<!-- <div class="btn-box"><a href="#a" class="btn-more" title="더보기"><span class="text-hidden">더보기</span></a></div> -->
					</div>
					<div class="section">
						<div class="criteria">
							<!-- <p>00:00 기준</p> -->
						</div>
						<p class="index"><span>${info.visit_user_cnt }</span>명</p>
					</div>
				</div><!-- // shadow-box -->

				<div class="shadow-box float-right">
					<div class="top-bar">
						<h2>방문횟수</h2>
						<!-- <div class="btn-box"><a href="#a" class="btn-more" title="더보기"><span class="text-hidden">더보기</span></a></div> -->
					</div>
					<div class="section">
						<div class="criteria">
							<!-- <p>00:00 기준</p> -->
						</div>
						<p class="index"><span>${info.visit_tot_cnt }</span>회</p>
					</div>
				</div><!-- // shadow-box -->
			</div>
			
			
			<div class="shadow-box">
				<div class="top-bar">
					<h2>인기페이지</h2>
				</div>
				<table class="talbe-list">
					<colgroup>
						<col style="width:12%" />
						<col style="width:*" />
						<col style="width:12%"/>
					</colgroup>
					<thead>
						<tr>
							<th>순위</th>
							<th>페이지url</th>
							<th>접속횟수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${u_list}" var="c" varStatus="status">
						<tr>
							<td>${c.rnk}</td>
							<td>${c.ip_info}</td>
							<td>${c.visit_url}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div><!-- // shadow-box -->
			
			<div class="shadow-box">

				<div class="search-block">
					<div class="search-row" style="display:inline;margin-right:20px">
						<label for="sido_cd">지역선택</label>
								<select class="formSelect" id="sido_cd" name="sido_cd" style="width:150px;margin-right:7px" title="">
									<option value="">선택</option>
									<option value="A">서울특별시</option>
									<option value="B">부산광역시</option>
									<option value="C">대구광역시</option>
									<option value="D">인천광역시</option>
									<option value="E">광주광역시</option>
									<option value="F">대전광역시</option>
									<option value="G">울산광역시</option>
									<option value="H">세종특별자치시</option>
									<option value="I">경기도</option>
									<option value="J">강원도</option>
									<option value="K">충청북도</option>
									<option value="L">충청남도</option>
									<option value="M">전라북도</option>
									<option value="N">전라남도</option>
									<option value="O">경상북도</option>
									<option value="P">경상남도</option>
									<option value="Q">제주특별자치도</option>
								</select>
					</div><!-- // search-row -->
					<div class="btn-block" style="display:inline;">
						<a href="javascript:down_cmmt()" class="btn-search2"><span>다운로드</span></a>
					</div>
					
				</div><!-- //search-block -->


		</div><!--// contents -->
	</div><!--// container -->
	</div>
	</form>
</div>


</body>
</html>


