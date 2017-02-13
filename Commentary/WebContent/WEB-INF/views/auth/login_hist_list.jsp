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

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />


<script type="text/javascript">

	$(document).ready(function() {
		
		
		$.datepicker.regional['ko'] = {
	            closeText: '닫기',
	            prevText: '이전달',
	            nextText: '다음달',
	            currentText: '오늘',
	            monthNames: ['1월','2월','3월','4월','5월','6월',
	            '7월','8월','9월','10월','11월','12월'],
	            monthNamesShort: ['1월','2월','3월','4월','5월','6월',
	            '7월','8월','9월','10월','11월','12월'],
	            dayNames: ['일','월','화','수','목','금','토'],
	            dayNamesShort: ['일','월','화','수','목','금','토'],
	            dayNamesMin: ['일','월','화','수','목','금','토'],
	            buttonImageOnly: false,
	            weekHeader: 'Wk',
	            dateFormat: 'yy-mm-dd',
	            firstDay: 0,
	            isRTL: false,
	            duration:200,
	            showAnim:'show',
	            showMonthAfterYear: true
	          //  minDate: +0
	    };
	      $.datepicker.setDefaults($.datepicker.regional['ko']);
		
		$( '#srch_str_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd",//날짜 출력 형식
			onClose: function( selectedDate ) {
				$( '#srch_end_dt' ).datepicker( 'option', 'minDate', selectedDate );
			}
		});
		$( '#srch_end_dt' ).datepicker({
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			changeYear:true, //년 셀렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd",//날짜 출력 형식
			onClose: function( selectedDate ) {
				$( '#srch_str_dt' ).datepicker( 'option', 'maxDate', selectedDate );
			}
		});
		
		var auth = "<c:out value="${srch.srch_auth}" />";
		$("#srch_auth").val(auth).change(); 	
		
		var prt = "<c:out value="${srch.srch_act_prt_cd}" />";
		$("#srch_act_prt_cd").val(prt).change(); 	
		
		var str = "<c:out value="${srch.srch_str_tm}" />";
		var end = "<c:out value="${srch.srch_end_tm}" />";
		
		if(str != "") {
			$("#srch_str_tm1").val(str.substring(0, 2)).change(); 
			$("#srch_str_tm2").val(str.substring(3, 5)).change(); 
		}
		if(end != "") {
			$("#srch_end_tm1").val(end.substring(0, 2)).change(); 
			$("#srch_end_tm2").val(end.substring(3, 5)).change(); 
		}
		
	});

	$(function() {
		$('.formSelect').sSelect();
	});
		
	function srch_login_hist() {
		
		var stm1 = $('#srch_str_tm1').val();
		var stm2 = $('#srch_str_tm2').val();
		var etm1 = $('#srch_end_tm1').val();
		var etm2 = $('#srch_end_tm2').val();
		
		if(stm1 != "" && stm2 != "") {
			$('#srch_str_tm').val(stm1+":"+stm2);
		}
		if(stm1 != "" && stm2 == "") {
			$('#srch_str_tm').val(stm1+":00");
		}
		if(etm1 != "" && etm2 != "") {
			$('#srch_end_tm').val(etm1+":"+etm2);
		}
		if(etm1 != "" && etm2 == "") {
			$('#srch_end_tm').val(etm1+":00");
		}
		
		document.mainform.target = "_self";
		document.mainform.action = "login_hist.do";
		document.mainform.submit();
	}
	
	function go_page(no) {
		
		$('#pageNum').val(no);
		document.mainform.target = "_self";
		document.mainform.action = "login_hist.do";
		document.mainform.submit();
	}
	
</script>
<style type="text/css">
table {width:100%;border-collapse:collapse}
.talbe-list2 {border-top:1px solid #dcdcdc;border-bottom:1px solid #dcdcdc}
.talbe-list2 th {height:33px;background:#efefef;color:#999;border-bottom:1px solid #dcdcdc}
.talbe-list2 td {height:30px;border-bottom:1px solid #dcdcdc;text-align:center;padding:0 10px}
</style>
</head>
<body>
<div id="wrapper">
	
<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="pageNum" name="pageNum"/>
<input type="hidden" id="id" name="id"/>
<input type="hidden" id="srch_str_tm" name="srch_str_tm"/>
<input type="hidden" id="srch_end_tm" name="srch_end_tm"/>

	<jsp:include page="../main/topMenu.jsp"  />
	

	<div id="container" class="colum1"><!-- 왼쪽에 사용자 정보가 없을 경우 클래스 colum1 삽입 -->

		<div class="contents">

			<h2>접속 기록 관리</h2>

			<div class="shadow-box">

				<div class="search-block">

					<div class="item-block clearfix">
						<dl class="float-left">
							<dt>검색항목</dt>
							<dd>
								<ul>
									<li><label><span>성명</span><input type="text" name="srch_nm" id="srch_nm" value="${srch.srch_nm }" style="width:80px;" title="검색 성명"/></label></li>
								</ul>
							</dd>
						</dl>
					</div><!-- // item-block -->
					<div class="item-block clearfix" style="margin-top:20px">
						<dl class="float-left" style="width:45%">
							<dt>접속기간</dt>
							<dd>
								<div class="set-period normal">
									<span class="set-date">
										<input type="text" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }" title="검색 접속기간 시작일" placeholder="날짜 선택" style="width:100px;" class="calendar" />
									</span>
									<span class="txt-symbol">~</span>
									<span class="set-date mr7">
										<input type="text" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_str_dt }" title="검색 접속기간 종료일" placeholder="날짜 선택" style="width:100px;" class="calendar" />
									</span>
								</div>
							</dd>
						</dl>
						<dl class="float-right" style="width:45%">
							<dt>접속시간</dt>
							<dd>
								<select class="formSelect" id="srch_str_tm1" name="srch_str_tm1" style="width:50px;" title="검색 접속시간 시작 시">
									<option value=""></option><option value="01">1</option><option value="02">2</option><option value="03">3</option><option value="04">4</option>
									<option value="05">5</option><option value="06">6</option><option value="07">7</option><option value="08">8</option>
									<option value="09">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>
									<option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option>
									<option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option>
									<option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option>
								</select>
								<span class="txt-symbol">시</span>
								<select class="formSelect" id="srch_str_tm2" name="srch_str_tm2" style="width:50px;" title="검색 접속시간 시작 분">
									<option value=""></option><option value="00">0</option>
									<option value="01">1</option><option value="02">2</option><option value="03">3</option><option value="04">4</option>
									<option value="05">5</option><option value="06">6</option><option value="07">7</option><option value="08">8</option>
									<option value="09">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>
									<option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option>
									<option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option>
									<option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option>
									<option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option>
									<option value="29">29</option><option value="30">30</option><option value="31">31</option><option value="32">32</option>
									<option value="33">33</option><option value="34">34</option><option value="35">35</option><option value="36">36</option>
									<option value="37">37</option><option value="38">38</option><option value="39">39</option><option value="40">40</option>
									<option value="41">41</option><option value="42">42</option><option value="43">43</option><option value="44">44</option>
									<option value="45">45</option><option value="46">46</option><option value="47">47</option><option value="48">48</option>
									<option value="49">49</option><option value="50">50</option><option value="51">51</option><option value="52">52</option>
									<option value="53">53</option><option value="54">54</option><option value="55">55</option><option value="56">56</option>
									<option value="57">57</option><option value="58">58</option><option value="59">59</option>
								</select>
								<span class="txt-symbol">분</span>
								<span class="txt-symbol">~</span>
								<select class="formSelect" id="srch_end_tm1" name="srch_end_tm1" style="width:50px;" title="검색 접속시간 종료 시">
									<option value=""></option><option value="01">1</option><option value="02">2</option><option value="03">3</option><option value="04">4</option>
									<option value="05">5</option><option value="06">6</option><option value="07">7</option><option value="08">8</option>
									<option value="09">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>
									<option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option>
									<option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option>
									<option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option>
								</select>
								<span class="txt-symbol">시</span>
								<select class="formSelect" id="srch_end_tm2" name="srch_end_tm2" style="width:50px;" title="검색 접속시간 종료 분">
									<option value=""></option><option value="00">0</option>
									<option value="01">1</option><option value="02">2</option><option value="03">3</option><option value="04">4</option>
									<option value="05">5</option><option value="06">6</option><option value="07">7</option><option value="08">8</option>
									<option value="09">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>
									<option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option>
									<option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option>
									<option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option>
									<option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option>
									<option value="29">29</option><option value="30">30</option><option value="31">31</option><option value="32">32</option>
									<option value="33">33</option><option value="34">34</option><option value="35">35</option><option value="36">36</option>
									<option value="37">37</option><option value="38">38</option><option value="39">39</option><option value="40">40</option>
									<option value="41">41</option><option value="42">42</option><option value="43">43</option><option value="44">44</option>
									<option value="45">45</option><option value="46">46</option><option value="47">47</option><option value="48">48</option>
									<option value="49">49</option><option value="50">50</option><option value="51">51</option><option value="52">52</option>
									<option value="53">53</option><option value="54">54</option><option value="55">55</option><option value="56">56</option>
									<option value="57">57</option><option value="58">58</option><option value="59">59</option>
								</select>
								<span class="txt-symbol">분</span>
							</dd>
						</dl>
					</div><!-- // item-block -->
					<div class="item-block clearfix">
						<dl class="float-left">
							<dt>권한구분</dt>
							<dd>
								<select class="formSelect" id="srch_auth" name="srch_auth" style="width:120px;" title="권한구분">
									<option value="">전체</option>
									<option value="1">관리자</option>
									<option value="2">지자체</option>
									<option value="4">해설사</option>
									<option value="9">일반인</option>
								</select>
							</dd>
							<dt>접속구분</dt>
							<dd>
								<select class="formSelect" id="srch_act_prt_cd" name="srch_act_prt_cd" style="width:120px;" title="접속구분">
									<option value="">전체</option>
									<option value="11">로그인</option>
									<option value="12">접속url</option>
								</select>
							</dd>
						</dl>
					</div><!-- // item-block -->
					
					<div class="btn-block" style="margin-top:-5px">
						<a href="javascript:srch_login_hist()" class="btn-search3"><span>검색</span></a>
					</div>
					
				</div><!-- //search-block -->


				<table class="talbe-list2">
					<colgroup>
						<col style="width:10%" />
						<col style="width:15%" />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:20%" />
						<col style="width:35%" />
					</colgroup>
					<thead>
						<tr>
							<th>No</th>
							<th>이름</th>
							<th>권한</th>
							<th>구분</th>
							<th>IP</th>
							<th>접속시간</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="c" varStatus="status">
							<tr>
								<td>${c.row_num}</td>
								<td>${c.nm}</td>
								<td>${c.auth_nm}</td>
								<td>
									<c:choose>
										<c:when test="${c.act_prt_cd eq '11'}">로그인</c:when>
										<c:when test="${c.act_prt_cd eq '12'}">접속url</c:when>
									</c:choose>
								</td>
								<td>${c.ip_info}</td>
								<td>${c.reg_tm}</td>
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