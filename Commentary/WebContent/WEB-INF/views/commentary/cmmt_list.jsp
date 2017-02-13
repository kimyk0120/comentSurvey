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
<jsp:useBean id="now" class="java.util.Date" />

<script type="text/javascript">

	$(document).ready(function() {
		
		var sido = "<c:out value="${srch.srch_sido}"/>";
		var gugun = "<c:out value="${srch.srch_gugun}"/>";
		var auth = "<c:out value="${srch.auth_no}"/>";
		
		if(sido != null && sido != '' && auth != "3") {
			$("#srch_sido").val(sido).attr("selected","selected");
			$.ajax({ 
				   url: "srch_gugun.do", 
				   type: "POST", 
				   data: {"s_sido" : sido},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:150px;\" title=\"\" tabindex=\"2\">";
					   str=str+"<option value=\"\">전체</option>";
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	     				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   str = str+"</select>";
					   document.getElementById("gugun_div").innerHTML=str;
					   
					   if(gugun != null && gugun != '') {
						   $("#srch_gugun").val(gugun).attr("selected","selected"); 
					   }
					   $('.formSelect').sSelect();
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
		}
		
		var yn = "<c:out value="${srch.srch_act_yn}"/>";
		
		$('input:radio[name="srch_act_yn"]').filter('[value="${srch.srch_act_yn}"]').attr('checked', true);
		
	});


	$(function() {
		$('.formSelect').sSelect();
	});
	
	function cmmt_create() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_create.do";
		document.mainform.submit();
	}
	
	function cmmt_info(c_no) {
		$('#c_no').val(c_no);
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_info.do";
		document.mainform.submit();
	}
	
	function go_page(no) {
		mainform.pageNum.value = no;
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_list.do";
		document.mainform.submit();
	}
	
	function srch_cmmt(prt,odr) {
		$('#order_prt').val(prt);
		$('#srch_order').val(odr);
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_list.do";
		document.mainform.submit();
	}
	
	function excel_down() {
		
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_list_excel_down.do";
		document.mainform.submit();
		
		/* $.ajax({ 
			   url: "cmmt_list_excel_down.do", 
			   type: "POST",
			   data: $("#mainform").serialize(),
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   colsole.log("msg : " + msg);
			   }
		   		, error: function (xhr, ajaxOptions, thrownError) {
		      }
		});  */
	}
	
	function checkEnterKey(){
		if(event.keyCode==13){srch_cmmt();}
	}
	
	function get_gugun() {
		
		var s_sido = $("select[name=srch_sido]").val();
		
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:150px;\" title=\"\">";
				   str=str+"<option value=\"\">전체</option>";
				   var tmp = msg.split('|');
				   if(msg != "") {
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
	/* 
	function act_change() {
		var yn =  $(':radio[name="act_yn"]:checked').val();
		if(yn == "N") {
			document.getElementById("act_prt").style.display = "inline-block";
		}
		else {
			document.getElementById("act_prt").style.display = "none";
		}
	} 
	 */
</script>

<style type="text/css">

	.search-block .item-block dl:first-child {width:45%;}
	.search-block .item-block dl:last-child {width:52%;}
	
</style>

</head>
<body>
<div id="wrapper">

	<!-- 접근성 : skip navi -->
	<dl id="skip-navi">
		<dt class="hidden"><strong>바로가기 메뉴</strong></dt>
		<dd><a href="#gnb" class="accessibility">주요메뉴 바로가기</a></dd>
		<dd><a href="#container" class="accessibility">본문 바로가기</a></dd>
	</dl>
	<!-- //skip navi -->
	
<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="c_no" name="c_no"/>
<input type="hidden" id="pageNum" name="pageNum"/>
<input type="hidden" id="order_prt" name="order_prt" value="${srch.order_prt }"/>
<input type="hidden" id="srch_order" name="srch_order" value="${srch.srch_order }" />
	<jsp:include page="../main/topMenu.jsp"  />
	

	<div id="container" class="colum1"><!-- 왼쪽에 사용자 정보가 없을 경우 클래스 colum1 삽입 -->

		<div class="contents">

			<h2>문화관광해설사 조회</h2>

			<div class="shadow-box">

				<div class="search-block">
				<c:if test="${srch.auth_no eq 1 or srch.auth_no eq 2 or srch.auth_no eq 5}">
					<div class="search-row">
						<label for="srch_sido_cd">지역선택</label>
							<c:if test="${srch.auth_no eq 1 or srch.auth_no eq 5}">
								<select class="formSelect" id="srch_sido" name="srch_sido" style="width:150px;margin-right:7px" title="" onchange="get_gugun()" tabindex="1">
									<option value="">전체</option>
									<c:forEach items="${s_list}" var="s">
										<option value="${s.sido_cd}">${s.sido_cd_nm}</option>
									</c:forEach>
								</select>
							</c:if>
						<div id="gugun_div" style="display:inline;">
							<!-- <select class="formSelect" style="width:150px;" title="" tabindex="2">
								<option value="">전체</option>
							</select> -->
						</div>
					</div><!-- // search-row -->
				</c:if>

					<div class="item-block clearfix" <c:if test="${srch.auth_no eq 3}"> style="margin:20px 0" </c:if>>
						<dl class="float-left">
							<dt>검색항목</dt>
							<dd>
								<ul>
									<li><label><span>성 명</span><input type="text" name="srch_nm" id="srch_nm" value="${srch.srch_nm }" style="width:80px;" onkeydown="javascript:checkEnterKey()" tabindex="3"/></label></li>
									<c:if test="${srch.auth_no eq 1 or srch.auth_no eq 2 or srch.auth_no eq 5}">
										<li><label><span>지자체</span><input type="text" name="srch_area" id="srch_area" value="${srch.srch_area }" style="width:80px;" onkeydown="javascript:checkEnterKey()" tabindex="4"/></label></li>
									</c:if>
								</ul>
							</dd>
						</dl>
					<dl class="float-left">	
						<dt>관리구분</dt>
						<dd>
							<div class="pos-relative" style="display:inline"><input type="radio" name="srch_act_yn" id="act_yn_radio0" value="" checked="checked" tabindex="5"/><label for="act_yn_radio0">전체</label></div>
							<div class="pos-relative" style="display:inline"><input type="radio" name="srch_act_yn" id="act_yn_radio1" value="Y" tabindex="6"/><label for="act_yn_radio1">활동중</label></div>
							<div class="pos-relative" style="display:inline"><input type="radio" name="srch_act_yn" id="act_yn_radio2" value="N" tabindex="7"/><label for="act_yn_radio2">미활동</label></div>
							<!-- <div id="act_prt" style="display:none;">
								<div class="pos-relative" style="display:inline"><input type="radio" name="act_prt_cd" id="act_prt_radio1" value="02" /><label for="act_prt_radio1">휴직</label></div>
								<div class="pos-relative" style="display:inline"><input type="radio" name="act_prt_cd" id="act_prt_radio2" value="03" /><label for="act_prt_radio2">정지</label></div>
								<div class="pos-relative" style="display:inline"><input type="radio" name="act_prt_cd" id="act_prt_radio3" value="04" /><label for="act_prt_radio3">박탈</label></div>
							</div> -->
						</dd>
					</dl>
						<!-- <dl class="float-left">
							<dt>활동기간</dt>
							<dd>
								<div class="set-period normal">
									<span class="set-date">
										<input type="text" id="" name="" value="날짜 선택" placeholder="날짜 선택" style="width:65px;" class="calendar" />
									</span>
									<span class="txt-symbol">~</span>
									<span class="set-date mr7">
										<input type="text" id="" name="" value="날짜 선택" placeholder="날짜 선택" style="width:65px;" class="calendar" />
									</span>
								</div>
							</dd>
						</dl> -->
					</div><!-- // item-block -->

					<!-- <dl class="check-block clearfix">
						<dt>관리구분</dt>
						<dd class="all"><div class="pos-relative"><input type="checkbox" name="" id="checkbox0" value="" checked /><label for="checkbox0">전체</label></div>
						</dd>
						<dd>
							<ul>
								<li><div class="pos-relative"><input type="checkbox" name="" id="checkbox18" value="" /><label for="checkbox18">문화관광해설사</label></div></li>
								<li><div class="pos-relative"><input type="checkbox" name="" id="checkbox19" value="" /><label for="checkbox19">정지</label></div></li>
								<li><div class="pos-relative"><input type="checkbox" name="" id="checkbox20" value="" /><label for="checkbox20">자격박탈</label></div></li>
							</ul>
						</dd>
					</dl>// check-block -->

					<div class="btn-block">
						<a href="javascript:srch_cmmt('1')" class="btn-search3" tabindex="8"><span>검색</span></a>
					</div>
					
				</div><!-- //search-block -->

				<div class="btn-block text-right mb10">
					<c:if test="${srch.auth_no eq 1 or srch.auth_no eq 2 or srch.auth_no eq 3}">
						<a href="javascript:cmmt_create()" class="btn-blue" tabindex="9"><span>신규 등록</span></a>
						<div class="abl"><a href="javascript:excel_down();" class="btn-green ico-down" tabindex="10"><span>엑셀다운</span></a></div>
					</c:if>
				</div>
				<table class="talbe-list">
					<colgroup>
						<col style="width:7%" />
						<col style="width:20%" />
						<col style="width:8%" />
						<col style="width:18%" />
						<col style="width:10%" />
						<col style="width:12%" />
						<col style="width:15%" />
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr>
							<th>NO</th>
							<c:choose>
							<c:when test="${srch.srch_order eq '1' }">
								<th onclick="javascript:srch_cmmt('2','2')" style="cursor:pointer">성명 ▲</th>
							</c:when>
							<c:when test="${srch.srch_order eq '2' }">
								<th onclick="javascript:srch_cmmt('2','1')" style="cursor:pointer">성명 ▼</th>
							</c:when>
							<c:otherwise><th onclick="javascript:srch_cmmt('2','1')" style="cursor:pointer">성명 </th></c:otherwise>
							</c:choose>
							<th>성별/나이</th>
							<th>지자체</th>
							<th>배치장소</th>
							<th>연락처</th>
							<th>언어</th>
							<th>관리구분</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="c" varStatus="status">
							<tr onclick="javascript:cmmt_info('${c.cmntor_no}')">
								<td><a href="javascript:cmmt_info('${c.cmntor_no}')" tabindex="${status.index+11}">${c.row_num}</a></td>
								<td>${c.name} / ${c.eng_name} ${c.eng_name2}</td>
								<td>${c.gender} 
									/
									<c:if test="${fn:substring(c.birth_dt,0,2) eq '19' or fn:substring(c.birth_dt,0,2) eq '20' }">
										<c:set var="yyyy" value="${fn:substring(c.birth_dt,0,4)}" />
										<c:set var="now"><fmt:formatDate value="<%=new Date() %>" pattern="yyyy" /></c:set>
										${now-yyyy}
									</c:if>
								</td>
								<td>${c.sido_cd_nm} ${c.gugun_cd_nm}</td>
								<td>${c.arrg_place }</td>
								<td>
									<c:if test="${fn:length(c.hand_ph3) gt 1 }">
										***-****-${c.hand_ph3}
									</c:if>
								</td>
								<td>${c.lang_nm }</td>
								<td>
									<c:choose>
										<c:when test="${c.act_yn eq 'Y' }"> 활동중 </c:when>
										<c:when test="${c.act_yn eq 'N' }">
											비활동중 
											<c:if test="${fn:length(c.act_prt_nm) gt 0}">(${c.act_prt_nm }) </c:if>
										</c:when>
									
									</c:choose>
								</td>
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
					   		<li><a class="no-bg" href="javascript:go_page('1')" tabindex="22">&lt;&lt;</a></li>
					   		<li><a class="no-bg" href="javascript:go_page('${(numPageGroup-2)*pageGroupSize+1 }')" tabindex="23">&lt;</a></li>
					   </c:if>
					
					   <c:forEach var="i" begin="${startPage}" end="${endPage}" varStatus="status">
					       <li>
					           <c:choose>
					               <c:when test="${currentPage == i}">
					               		<a href="javascript:go_page('${i}')" class="no-bg on" tabindex="${status.index+31}">${i}</a>
					               </c:when>
					               <c:otherwise>
							       		<a href="javascript:go_page('${i}')" class="no-bg" tabindex="${status.index+31}">${i}</a>
					               </c:otherwise>
							   </c:choose>    		
					       </li>
					   </c:forEach>
					   <c:if test="${numPageGroup < pageGroupCount}">
					   		<li><a class="no-bg" href="javascript:go_page('${numPageGroup*pageGroupSize+1}')" tabindex="41">&gt;</a></li>
					   		<li><a class="no-bg" href="javascript:go_page('<fmt:formatNumber value="${count/pageSize+1}" type="number" maxFractionDigits="0"/>')" tabindex="42">&gt;&gt;</a></li>
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