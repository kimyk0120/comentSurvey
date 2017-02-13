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
<title>교육계획 l 교육통합관리</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">

	$(document).ready(function() {
		
		var top =  <%=request.getParameter("top") %>;
		var left =  <%=request.getParameter("left") %>;
		
		if(top == null || top == "") top = 0;
		if(left == null || left == "") left = 0;
		
		mainform.top.value=top;
		mainform.left.value=left;
		
		var srchStat = "<c:out value="${srch.srch_stat}"/>";
		var srchLecture = "<c:out value="${srch.srch_lecture_prt}"/>";
		var srchEduInst = "<c:out value="${srch.srch_edu_inst}"/>";
		
		if(srchStat != null && srchStat != '') {
			$("#srch_stat").val(srchStat).attr("selected","selected"); 
		}
		if(srchLecture != null && srchLecture != '') {
			$("#srch_lecture_prt").val(srchLecture).attr("selected","selected"); 
		}
		if(srchEduInst != null && srchEduInst != '') {
			$("#srch_edu_inst").val(srchEduInst).attr("selected","selected"); 
		}
		
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
		
	});
	
	$(function() {
		$('.formSelect').sSelect();
		
		/* $("#srch_str_dt").datepicker({
	    });
	    $("#srch_end_dt").datepicker({
	    }); */
	    
	     
	  });
	
	
	function go_page(no) {
		
		mainform.pageNum.value = no;
		document.mainform.target = "_self";
		document.mainform.action = "edu_plan_list.do";
		document.mainform.submit();
	}
	
	function edu_create() {
		document.mainform.target = "_self";
		document.mainform.action = "edu_create.do";
		document.mainform.submit();
	}
	
	function src_edu_proc() {
		mainform.pageNum.value = "1";
		document.mainform.target = "_self";
		document.mainform.action = "edu_plan_list.do";
		document.mainform.submit();
	}
	
	function checkEnterKey(){
		if(event.keyCode==13){src_edu_proc();}
	}
	
	function edu_info(seq) {
		mainform.e_seq.value = seq;
		document.mainform.target = "_self";
		document.mainform.action = "edu_info.do";
		document.mainform.submit();
	}
	
	function get_gugun() {
		
		///var e = document.getElementById("srch_sido");
		//var s_sido = e.options[e.selectedIndex].value;
		var s_sido = $("select[name=srch_sido]").val();
		
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:120px;\" title=\"\">";
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
		document.mainform.target = "_self";
		location.href = url+"?top="+t+"&left="+l;
	//	document.mainform.submit();
	}
	
</script>
</head>
<body id="contents">
<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="pageNum" name="pageNum" value="${srch.pageNum }"/>
<input type="hidden" id="page" name="page" value="edu_plan_list.do"/>
<input type="hidden" id="e_seq" name="e_seq"/>
<input type="hidden" id="top" name="top" />
<input type="hidden" id="left" name="left" />
<div id="wrapper">
	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />


		<div class="contents">

			<div class="contents-top">
				<h2>교육계획   </h2>
				<div class="btn-block">
					<a href="javascript:edu_create()"><span>교육등록</span></a>
				</div>
			</div>

			<div class="search-block">
				<div class="search-row">
					<select class="formSelect" style="width:150px;margin-right:58px" title="" id="srch_stat" name="srch_stat">
						<option value="" selected="selected">상태</option>
						<option value="1">강의전</option>
						<option value="2">강의중</option>
						<option value="3">강의완료</option>
						<option value="4">폐강</option>
					</select>
					<span class="txt-label">강의기간</span>
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
				<div class="search-row">
					<select class="formSelect" id="srch_lecture_prt" name="srch_lecture_prt" style="width:150px;margin-right:58px" title="">
						<option value="" selected="selected">강의종류</option>
						<c:forEach items="${l_list}" var="l" varStatus="status">
							<option value="${l.lecture_code }">${l.lecture_nm }</option>	
						</c:forEach>
					</select>
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
					<input type="text" id="srch_edu_inst" name="srch_edu_inst" placeholder="교육기관명 검색" value="${srch.srch_edu_inst}" class="readonly" style="margin-left:20px" onKeyDown="javascript:checkEnterKey()"/>
				</div><!-- // search-row -->
				<div class="btn-block">
					<a href="javascript:src_edu_proc()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->

			<table class="talbe-list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:18%" />
					<col style="width:18%" />
					<col style="width:12%"/>
					<col style="width:24%"/>
					<col style="width:6%"/>
					<col style="width:7%"/>
				</colgroup>
				<thead>
					<tr>
						<th>No</th>
						<th>강의종류</th>
						<th class="text-left">지역</th>
						<th class="text-left">교육기관</th>
						<th>상태</th>
						<th>강의기간</th>
						<th>인원</th>
						<th>승인</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
					<tr <c:if test="${c.lecture_prt ne '폐강'}"> onclick="javascript:edu_info('${c.edu_proc_seq}')" </c:if> > 
						<td>${c.row_num}</td>
						<td>${c.lecture_nm}</td>
						<td class="text-left">${c.sido_code_nm} ${c.gugun_code_nm}</td>
						<td class="text-left">${c.edu_inst_nm}</td>
						<td>${c.lecture_prt}</td>
						<td>${c.start_dt} ~ ${c.end_dt}</td>
						<td>${c.stdt_cnt}</td>
						<td>
							<c:choose>
								<c:when test="${c.appr_yn eq 'Y'}">
									<span style="color:#000000;font-weight:bold">승인완료</span>
								</c:when>
								<c:otherwise>
									<span class="point-color-r">승인전</span>
								</c:otherwise>
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
				   		<li><a class="no-bg"  href="javascript:go_page('${numPageGroup*pageGroupSize+1}')">&gt;&gt;</a></li>
				   		<li><a class="no-bg"  href="javascript:go_page('<fmt:formatNumber value="${count/pageSize+1}" type="number" maxFractionDigits="0"/>')">&gt;</a></li>
				   </c:if>
				</c:if>
			</ul>
		</div>

		</div><!--// contents -->
	</div><!--// container -->

	</form>	

</body>
</html>