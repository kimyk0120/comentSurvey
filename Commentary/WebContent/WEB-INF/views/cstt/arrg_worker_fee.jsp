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
<title>정리수납 고객</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
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
			
			var srchSido = "<c:out value="${srch.srch_sido}"/>";
			var srchGugun = "<c:out value="${srch.srch_gugun}"/>";
			
			if(srchSido != null && srchSido != '') {
				
				$("#srch_sido").val(srchSido).attr("selected","selected"); 
			
				$.ajax({ 
					   url: "srch_gugun.do", 
					   type: "POST", 
					   data: {"s_sido" : srchSido},
					   dataType:"text",
					   cache: false,
					   success: function(msg){
						   var tmp = msg.split('|');
						   
						   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:120px;\" title=\"\">";
						   str=str+"<option value=\"\">선택</option>";
						   for(var i = 0; i < tmp.length ; i++) {
							   var tmp_sub = tmp[i].split(",");
		     				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
						   }
						   str = str+"</select>";
						   document.getElementById("srch_gugun_div").innerHTML=str;
						   
						   if(srchGugun != null && srchGugun != '') {
							   $("#srch_gugun").val(srchGugun).attr("selected","selected"); 
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
	});
	
	
	function go_page(no) {
		
		mainform.pageNum.value = no;
		document.mainform.action = "arrg_worker_fee.do";
		document.mainform.submit();
	}
	
	function src_arrg_strg() {
		document.mainform.action = "arrg_worker_fee.do";
		document.mainform.submit();
	}
	
	function checkEnterKey(){
		if(event.keyCode==13){src_arrg_strg();}
	}
	
	function get_gugun() {
		
		var e = document.getElementById("srch_sido");
		var s_sido = e.options[e.selectedIndex].value;
		
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:100px;\" title=\"\">";
				   str=str+"<option value=\"\">선택</option>";
				   if(msg != "" && msg != null) {
					   var tmp = msg.split('|');
					   
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	        				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
				   		}
				   }
				   str = str+"</select>";
				   document.getElementById("srch_gugun_div").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
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
<input type="hidden" id="arrg_no" name="arrg_no"/>
<input type="hidden" id="c_no" name="c_no"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>


		<div class="contents">

			<div class="contents-top">
				<h2>컨설턴트 수당 조회</h2>
				
			</div>

			<div class="search-block">
				<div class="search-row">
					<span class="txt-label">지역</span>
					<select class="formSelect" id="srch_sido" name="srch_sido" style="width:120px;" title="" onchange="get_gugun()">
						<option value="">시도</option>
						<c:forEach items="${s_list}" var="s">
							<option value="${s.sido_code}">${s.sido_code_nm}</option>
						</c:forEach>
					</select>
					<span class="txt-symbol">,</span>
					<div id="srch_gugun_div" style="display:inline;">
						<select class="formSelect" style="width:120px;" title="">
							<option value="">구군</option>
						</select>
					</div>
					<select class="formSelect" style="width:100px;margin-right:20px" title="" id="srch_prt" name="srch_prt">
						<option value="" selected="selected">구분</option>
						<option value="1" <c:if test="${srch.srch_prt eq '1'}">selected="selected"</c:if>>작업수당</option>
						<option value="2" <c:if test="${srch.srch_prt eq '2'}">selected="selected"</c:if>>견적수당</option>
					</select>
					<input type="text" id="srch_cust_name" name="srch_cust_name" placeholder="고객명 검색" value="${srch.srch_cust_name}" class="readonly" style="margin-left:20px" onKeyDown="javascript:checkEnterKey()"/>
					<input type="text" id="srch_cstt_name" name="srch_cstt_name" placeholder="컨설턴트명 검색" value="${srch.srch_cstt_name}" class="readonly" style="margin-left:20px" onKeyDown="javascript:checkEnterKey()"/>
				</div>
				<div class="search-row">
					<select class="formSelect" id="srch_cancel_yn" name="srch_cancel_yn" style="width:100px;margin-right:20px" title="" >
						<option value="">상태</option>
						<option value="N" <c:if test="${srch.srch_cancel_yn eq 'N'}">selected="selected"</c:if>>계약</option>
						<option value="Y" <c:if test="${srch.srch_cancel_yn eq 'Y'}">selected="selected"</c:if>>미계약</option>
					</select>
					<select class="formSelect" id="srch_cllt" name="srch_cllt" style="width:100px;margin-right:20px" title="" >
						<option value="">수금상태</option>
						<option value="1" <c:if test="${srch.srch_cllt eq '1'}">selected="selected"</c:if>>미수</option>
						<option value="2" <c:if test="${srch.srch_cllt eq '2'}">selected="selected"</c:if>>완료</option>
					</select>
					<span class="set-date">
						<input type="text" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt}" placeholder="시작일" style="width:80px;" />
						<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="시작일 선택" /></span><!-- 달력 선택 버튼 -->
					</span>
					<span class="txt-symbol">~</span>
					<span class="set-date">
						<input type="text" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt}" placeholder="종료일" style="width:80px;" />
						<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="종료일 선택" /></span><!-- 달력 선택 버튼 -->
					</span>
				</div><!-- // search-row -->
				<div class="btn-block">
					<a href="javascript:src_arrg_strg()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->

			<table class="talbe-list">
				<colgroup>
					<col style="width:4%" />
					<col style="width:8%" />
					<col style="width:10%" />
					<col style="width:8%" />
					<col style="width:7%" />
					<col style="width:7%" />
					<col style="width:19%" />
					<col style="width:7%"/>
					<col style="width:10%"/>
					<col style="width:10%"/>
					<col style="width:10%"/>
				</colgroup>
				<thead>
					<tr>
						<th style="padding:0px 5px">No</th>
						<th style="padding:0px 5px">컨설턴트명</th>
						<th style="padding:0px 5px">일자</th>
						<th style="padding:0px 5px">고객명</th>
						<th style="padding:0px 2px">서비스</th>
						<th style="padding:0px 5px">상태</th>
						<th style="padding:0px 5px">지역</th>
						<th style="padding:0px 5px">수금상태</th>
						<th style="padding:0px 5px">총금액</th>
						<th style="padding:0px 5px">견적비용</th>
						<th style="padding:0px 5px">컨설팅비용</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
					<tr>
						<td style="padding:0px 5px">${c.row_num}</td>
						<td style="padding:0px 5px">${c.cstt_name}</td>
						<td style="padding:0px 5px">${c.dt}</td>
						<td style="padding:0px 5px">${c.cust_nm}</td>
						<td style="padding:0px 5px">${c.srvc_prt_code_nm}</td>
						<td style="padding:0px 5px">${c.ctrt_cancel_yn}</td>
						<td style="padding:0px 5px">${c.sido_code_nm} ${c.gugun_code_nm }</td>
						<td style="padding:0px 5px">
							<c:choose>
								<c:when test="${c.tot_work_amt lt c.cllt_amt }">미수</c:when>
								<c:otherwise>완료</c:otherwise>
							</c:choose>
						</td>
						<td style="padding:0px 5px"><fmt:formatNumber value="${c.tot_work_amt}" /></td>
						<td style="padding:0px 5px"><fmt:formatNumber value="${c.estm_fee}" /></td>
						<td style="padding:0px 5px"><fmt:formatNumber value="${c.fee}" /></td>
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