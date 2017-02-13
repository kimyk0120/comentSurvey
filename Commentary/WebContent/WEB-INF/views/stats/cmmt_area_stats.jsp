<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@ page import="java.util.Date" %>
    
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
		
		var sido = "<c:out value="${srch.srch_sido_cd}"/>";
		var gugun = "<c:out value="${srch.srch_gugun_cd}"/>";
		
		if(sido != null && sido != '') {
			
		$("#srch_sido_cd").val(sido).attr("selected","selected");
		
			$.ajax({ 
				   url: "srch_gugun.do", 
				   type: "POST", 
				   data: {"s_sido" : sido},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var str = "";
					   var tmp = msg.split('|');
					   str = str + "<select class=\"formSelect\" id=\"srch_gugun_cd\" name=\"srch_gugun_cd\" style=\"width:150px;\" title=\"구군찾기\">";
						   /* str=str+"<option value=\"\">선택</option>"; */
					   if(msg != "") {
						   for(var i = 0; i < tmp.length ; i++) {
							   var tmp_sub = tmp[i].split(",");
		     				   str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
						   }
					   } else {
						   str=str+"<option value=\"\">전체</option>";
					   }
					   str = str+"</select>";
					   document.getElementById("gugun_div").innerHTML=str;
					   
					   if(gugun != null && gugun != '') {
						   $("#srch_gugun_cd").val(gugun).attr("selected","selected");
					   }
					   $('.formSelect').sSelect();
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
		}
		
	});
	
	$(function() {
		$('.formSelect').sSelect();
		$('#tabs').tabs();
	});
	
	function go_srch() {
		
		var si = $("select[name=srch_sido_cd]").val();
		var gu = $("select[name=srch_gugun_cd]").val();
		
		if(si == "" && gu == "") {
			alert("지역을 선택해주세요");
			return;
		} else {
			document.mainform.target = "_self";
			document.mainform.action = "cmmt_area_stats.do";
			document.mainform.submit();
		}
	}
	
	function excel_down(prt) {
		$('#excel_prt').val(prt);
		document.mainform.target = "_self";
		document.mainform.action = "stats_excel_down.do";
		document.mainform.submit();
	}
		
	function get_gugun() {
			
		var s_sido = $("select[name=srch_sido_cd]").val();
		
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var str = "<select class=\"formSelect\" id=\"srch_gugun_cd\" name=\"srch_gugun_cd\" style=\"width:150px;\" title=\"구군찾기\">";
				   str=str+"<option value=\"\">전체</option>";
				   if(msg != "" && msg != null) {
					   var tmp = msg.split('|');
					   
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	        				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
				   		}
				   }
				   str = str+"</select>";
				   document.getElementById("gugun_div").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
		}
	
	function main_info() {
		window.location.href="main_info.do?top=9&left=9";
	}
	
</script>
</head>
<body>
<div id="wrapper">
	
	<form id="mainform" name="mainform" action="" method="post">
	<input type="hidden" id="excel_prt" name="excel_prt" />
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
				<span class="txt-symbol">시도</span>
					<select class="formSelect" id="srch_sido_cd" name="srch_sido_cd" style="width:150px;" title="시도찾기" onchange="get_gugun()">
						<option value="00">전체</option>
						<c:forEach items="${s_list}" var="s">
							<option value="${s.sido_cd}">${s.sido_cd_nm}</option>
						</c:forEach>
					</select>
				<span class="txt-symbol">구군</span>
					<div id="gugun_div" style="display:inline;">
						<select class="formSelect" id="srch_gugun_cd" name="srch_gugun_cd" style="width:150px;" title="구군찾기" >
							<option value="">전체</option>
						</select>
					</div>
				<a href="javascript:go_srch()"><img src="image/magnifier13.png" style="height:18px;margin-left:10px" alt="검색"/><span class="text-hidden">검색</span> </a>
			</div>
		
			<div class="col2 clearfix">
				<div class="shadow-box float-left" style="width:48%">
					<div class="top-bar">
						<h2>문화관광해설사 성별/연령별 현황  (${a_list[0].sido_cd_nm})</h2>
						<div class="btn-box"><a href="javascript:excel_down('1')" class="btn-excel" title="엑셀 다운로드"><span class="text-hidden">다운</span></a></div>
					</div>
					<div class="view-content">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:40%" />
								<col style="width:40%" />
							</colgroup>
							<thead>
								<tr>
									<th rowspan="2" style="border-right:1px solid #fff">연령별</th>
									<th colspan="2">성별</th>
								</tr>
								<tr>
									<th style="background:#f0f3ff;border-right:1px solid #fff">여성</th>
									<th style="background:#f0f3ff;">남성</th>
								</tr>
							</thead>
							<tbody>
								  <c:set var="f10" value="0"/>
				                  <c:set var="f20" value="0"/>
				                  <c:set var="f30" value="0"/>
				                  <c:set var="f40" value="0"/>
				                  <c:set var="f50" value="0"/>
				                  <c:set var="f60" value="0"/>
				                  <c:set var="f70" value="0"/>
				                  <c:set var="ftot" value="0"/>
								  <c:set var="m10" value="0"/>
				                  <c:set var="m20" value="0"/>
				                  <c:set var="m30" value="0"/>
				                  <c:set var="m40" value="0"/>
				                  <c:set var="m50" value="0"/>
				                  <c:set var="m60" value="0"/>
				                  <c:set var="m70" value="0"/>
				                  <c:set var="mtot" value="0"/>
				                  <c:set var="now"><fmt:formatDate value="<%=new Date() %>" pattern="yyyy" /></c:set>
								<c:forEach items="${a_list}" var="a" varStatus="status">
									<c:set var="ages" value="${now - fn:substring(a.ages,0,4)}"/>
									<c:if test="${ages lt 20 and cmmt_cnt eq 'F'}"> <c:set var="f10" value="${f10+1}"/></c:if>
									<c:if test="${ages ge 20 and ages lt 30 and a.cmmt_cnt eq 'F'}"> <c:set var="f20" value="${f20+1}"/></c:if>
									<c:if test="${ages ge 30 and ages lt 40 and a.cmmt_cnt eq 'F'}"> <c:set var="f30" value="${f30+1}"/></c:if>
									<c:if test="${ages ge 40 and ages lt 50 and a.cmmt_cnt eq 'F'}"> <c:set var="f40" value="${f40+1}"/></c:if>
									<c:if test="${ages ge 50 and ages lt 60 and a.cmmt_cnt eq 'F'}"> <c:set var="f50" value="${f50+1}"/></c:if>
									<c:if test="${ages ge 60 and ages lt 70 and a.cmmt_cnt eq 'F'}"> <c:set var="f60" value="${f60+1}"/></c:if>
									<c:if test="${ages ge 70 and a.cmmt_cnt eq 'F'}"> <c:set var="f70" value="${f70+1}"/></c:if>
									<c:if test="${a.cmmt_cnt eq 'F'}"> <c:set var="ftot" value="${ftot+1}"/></c:if>
									<c:if test="${ages lt 20 and a.cmmt_cnt eq 'M'}"> <c:set var="m10" value="${m10+1}"/></c:if>
									<c:if test="${ages ge 20 and ages lt 30 and a.cmmt_cnt eq 'M'}"> <c:set var="m20" value="${m20+1}"/></c:if>
									<c:if test="${ages ge 30 and ages lt 40 and a.cmmt_cnt eq 'M'}"> <c:set var="m30" value="${m30+1}"/></c:if>
									<c:if test="${ages ge 40 and ages lt 50 and a.cmmt_cnt eq 'M'}"> <c:set var="m40" value="${m40+1}"/></c:if>
									<c:if test="${ages ge 50 and ages lt 60 and a.cmmt_cnt eq 'M'}"> <c:set var="m50" value="${m50+1}"/></c:if>
									<c:if test="${ages ge 60 and ages lt 70 and a.cmmt_cnt eq 'M'}"> <c:set var="m60" value="${m60+1}"/></c:if>
									<c:if test="${ages ge 70 and a.cmmt_cnt eq 'M'}"> <c:set var="m70" value="${m70+1}"/></c:if>
									<c:if test="${a.cmmt_cnt eq 'M'}"> <c:set var="mtot" value="${mtot+1}"/></c:if>
								</c:forEach>
								<tr>
									<th>20대 미만 </th>
									<td>${f10}</td>
									<td>${m10 }</td>
								</tr>
								<tr>
									<th>20대</th>
									<td>${f20}</td>
									<td>${m20}</td>
								</tr>
								<tr>
									<th>30대</th>
									<td>${f30}</td>
									<td>${m30}</td>
								</tr>
								<tr>
									<th>40대</th>
									<td>${f40}</td>
									<td>${m40 }</td>
								</tr>
								<tr>
									<th>50대</th>
									<td>${f50}</td>
									<td>${m50 }</td>
								</tr>
								<tr>
									<th>60대</th>
									<td>${f60}</td>
									<td>${m60 }</td>
								</tr>
								<tr>
									<th>70대 이상</th>
									<td>${f70}</td>
									<td>${m70 }</td>
								</tr>
								<tr>
									<th style="background:#d4daf3;border-right:1px solid #fff;border-top:1px solid #fff">총계</th>
									<td style="border-right:1px solid #fff;border-top:1px solid #fff">${ftot}</td>
									<td style="border-top:1px solid #fff">${mtot}</td>
								</tr>
							
								<%-- <c:forEach items="${a_list}" var="a" varStatus="status">
									<tr>
										<c:choose>
											<c:when test="${status.index+1 eq (fn:length(a_list))}">
												<th style="background:#d4daf3;border-right:1px solid #fff;border-top:1px solid #fff">${a.ages }</th>
												<td style="border-right:1px solid #fff;border-top:1px solid #fff">${a.female_cnt }</td>
												<td style="border-top:1px solid #fff">${a.male_cnt }</td>
											</c:when>
											<c:otherwise>
												<th>${a.ages }</th>
												<td>${a.female_cnt }</td>
												<td>${a.male_cnt }</td>
											</c:otherwise>
										</c:choose>
									</tr>
								</c:forEach> --%>
							</tbody>
						</table>
					</div>
				</div><!-- // shadow-box -->

				<div class="shadow-box float-right" style="width:48%">
					<div class="top-bar">
						<h2>문화관광해설사 성별/연령별 현황 (${a_list2[0].gugun_cd_nm})</h2>
						<div class="btn-box"><a href="javascript:excel_down('2')" class="btn-excel" title="엑셀 다운로드"><span class="text-hidden">다운</span></a></div>
					</div>
					<div class="view-content">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:40%" />
								<col style="width:40%" />
							</colgroup>
							<thead>
								<tr>
									<th rowspan="2" style="border-right:1px solid #fff">연령별</th>
									<th colspan="2">성별</th>
								</tr>
								<tr>
									<th style="background:#f0f3ff;border-right:1px solid #fff">여성</th>
									<th style="background:#f0f3ff;">남성</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="ff10" value="0"/>
				                  <c:set var="ff20" value="0"/>
				                  <c:set var="ff30" value="0"/>
				                  <c:set var="ff40" value="0"/>
				                  <c:set var="ff50" value="0"/>
				                  <c:set var="ff60" value="0"/>
				                  <c:set var="ff70" value="0"/>
				                  <c:set var="fftot" value="0"/>
								  <c:set var="mm10" value="0"/>
				                  <c:set var="mm20" value="0"/>
				                  <c:set var="mm30" value="0"/>
				                  <c:set var="mm40" value="0"/>
				                  <c:set var="mm50" value="0"/>
				                  <c:set var="mm60" value="0"/>
				                  <c:set var="mm70" value="0"/>
				                  <c:set var="mmtot" value="0"/>
				                  <c:set var="now"><fmt:formatDate value="<%=new Date() %>" pattern="yyyy" /></c:set>
								<c:forEach items="${a_list2}" var="a" varStatus="status">
									<c:set var="ages" value="${now - fn:substring(a.ages,0,4)}"/>
									<c:if test="${ages lt 20 and cmmt_cnt eq 'F'}"> <c:set var="ff10" value="${ff10+1}"/></c:if>
									<c:if test="${ages ge 20 and ages lt 30 and a.cmmt_cnt eq 'F'}"> <c:set var="ff20" value="${ff20+1}"/></c:if>
									<c:if test="${ages ge 30 and ages lt 40 and a.cmmt_cnt eq 'F'}"> <c:set var="ff30" value="${ff30+1}"/></c:if>
									<c:if test="${ages ge 40 and ages lt 50 and a.cmmt_cnt eq 'F'}"> <c:set var="ff40" value="${ff40+1}"/></c:if>
									<c:if test="${ages ge 50 and ages lt 60 and a.cmmt_cnt eq 'F'}"> <c:set var="ff50" value="${ff50+1}"/></c:if>
									<c:if test="${ages ge 60 and ages lt 70 and a.cmmt_cnt eq 'F'}"> <c:set var="ff60" value="${ff60+1}"/></c:if>
									<c:if test="${ages ge 70 and a.cmmt_cnt eq 'F'}"> <c:set var="f70" value="${ff70+1}"/></c:if>
									<c:if test="${a.cmmt_cnt eq 'F'}"> <c:set var="fftot" value="${fftot+1}"/></c:if>
									<c:if test="${ages lt 20 and a.cmmt_cnt eq 'M'}"> <c:set var="mm10" value="${mm10+1}"/></c:if>
									<c:if test="${ages ge 20 and ages lt 30 and a.cmmt_cnt eq 'M'}"> <c:set var="mm20" value="${mm20+1}"/></c:if>
									<c:if test="${ages ge 30 and ages lt 40 and a.cmmt_cnt eq 'M'}"> <c:set var="mm30" value="${mm30+1}"/></c:if>
									<c:if test="${ages ge 40 and ages lt 50 and a.cmmt_cnt eq 'M'}"> <c:set var="mm40" value="${mm40+1}"/></c:if>
									<c:if test="${ages ge 50 and ages lt 60 and a.cmmt_cnt eq 'M'}"> <c:set var="mm50" value="${mm50+1}"/></c:if>
									<c:if test="${ages ge 60 and ages lt 70 and a.cmmt_cnt eq 'M'}"> <c:set var="mm60" value="${mm60+1}"/></c:if>
									<c:if test="${ages ge 70 and a.cmmt_cnt eq 'M'}"> <c:set var="mm70" value="${mm70+1}"/></c:if>
									<c:if test="${a.cmmt_cnt eq 'M'}"> <c:set var="mmtot" value="${mmtot+1}"/></c:if>
								</c:forEach>
								<tr>
									<th>20대 미만 </th>
									<td>${ff10}</td>
									<td>${mm10 }</td>
								</tr>
								<tr>
									<th>20대</th>
									<td>${ff20}</td>
									<td>${mm20}</td>
								</tr>
								<tr>
									<th>30대</th>
									<td>${ff30}</td>
									<td>${mm30}</td>
								</tr>
								<tr>
									<th>40대</th>
									<td>${ff40}</td>
									<td>${mm40 }</td>
								</tr>
								<tr>
									<th>50대</th>
									<td>${ff50}</td>
									<td>${mm50 }</td>
								</tr>
								<tr>
									<th>60대</th>
									<td>${ff60}</td>
									<td>${mm60 }</td>
								</tr>
								<tr>
									<th>70대 이상</th>
									<td>${ff70}</td>
									<td>${mm70 }</td>
								</tr>
								<tr>
									<th style="background:#d4daf3;border-right:1px solid #fff;border-top:1px solid #fff">총계</th>
									<td style="border-right:1px solid #fff;border-top:1px solid #fff">${fftot}</td>
									<td style="border-top:1px solid #fff">${mmtot}</td>
								</tr>
								<%-- <c:forEach items="${a_list2}" var="a" varStatus="status">
									<tr>
										<c:choose>
											<c:when test="${status.index+1 eq (fn:length(a_list))}">
												<th style="background:#d4daf3;border-right:1px solid #fff;border-top:1px solid #fff">${a.ages }</th>
												<td style="border-right:1px solid #fff;border-top:1px solid #fff">${a.female_cnt }</td>
												<td style="border-top:1px solid #fff">${a.male_cnt }</td>
											</c:when>
											<c:otherwise>
												<th>${a.ages }</th>
												<td>${a.female_cnt }</td>
												<td>${a.male_cnt }</td>
											</c:otherwise>
										</c:choose>
									</tr>
								</c:forEach> --%>
							</tbody>
						</table>
					</div>
				</div><!-- // shadow-box -->
			</div><!-- // col2 -->

		</div><!--// contents -->
	</div><!--// container -->
	</form>
</div>


</body>
</html>


