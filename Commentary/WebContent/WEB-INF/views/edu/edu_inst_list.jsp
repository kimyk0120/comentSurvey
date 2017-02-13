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
<title>교육기관 관리</title>
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
					   
					   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:120px;margin-right:20px;\" title=\"\">";
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
		document.mainform.action = "edu_inst_list.do";
		document.mainform.submit();
	}
	
	function edu_create() {
		document.mainform.action = "edu_create.do";
		document.mainform.submit();
	}
	
	function src_inst() {
		document.mainform.action = "edu_inst_list.do";
		document.mainform.submit();
	}
	
	function checkEnterKey(){
		if(event.keyCode==13){src_inst();}
	}
	
	$(function() {
	    $("#srch_str_dt").datepicker({
	    });
	    $("#srch_end_dt").datepicker({
	    });
	     
	  });
	
	function inst_info(s_no) {
		mainform.inst_cd.value = s_no;
		document.mainform.action = "edu_inst_info.do";
		document.mainform.submit();
	}
	
	function edu_inst_add() {
		document.mainform.action = "edu_inst_create.do";
		document.mainform.submit();
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
				   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:120px;margin-right:20px;\" title=\"\">";
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
<input type="hidden" id="inst_cd" name="inst_cd"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

		<div class="contents">

			<div class="contents-top">
				<h2>교육기관</h2>
				<div class="btn-block">
					<a href="javascript:edu_inst_add()"><span>교육기관등록</span></a>
				</div>
			</div>

			<div class="search-block">
				<div class="search-row">
					<span class="txt-label" style="min-width:0px">지역</span>
					<select class="formSelect" id="srch_sido" name="srch_sido" style="width:120px;" title="" onchange="get_gugun()">
						<option value="">시도</option>
						<c:forEach items="${s_list}" var="s">
							<option value="${s.sido_code}">${s.sido_code_nm}</option>
						</c:forEach>
					</select>
					<span class="txt-symbol" style="width:5px">,</span>
					<div id="srch_gugun_div" style="display:inline;">
						<select class="formSelect" style="width:120px;margin-right:20px;" title="">
							<option value="">구군</option>
						</select>
					</div>
					<select class="formSelect" id="srch_inst_group" name="srch_inst_group" style="width:120px;margin-right:20px;" title="">
						<option value="" selected="selected">기관그룹</option>
						<c:forEach items="${e_list}" var="e" varStatus="status">
							<option value="${e.edu_inst_group_code }">${e.edu_inst_group_code_nm }</option>	
						</c:forEach>
					</select>
					<input type="text" id="srch_edu_inst" name="srch_edu_inst" placeholder="교육기관명 검색" value="${srch.srch_edu_inst}" class="readonly" onKeyDown="javascript:checkEnterKey()"/>
					<input type="text" id="srch_phone" name="srch_phone" placeholder="연락처 검색" value="${srch.srch_phone}"  class="readonly" onKeyDown="javascript:checkEnterKey()"/>
				</div><!-- // search-row -->
				<div class="btn-block">
					<a href="javascript:src_inst()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->

			<table class="talbe-list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:25%" />
					<col style="width:20%" />
					<col style="width:18%" />
					<col style="width:12%"/>
					<col style="width:20%"/>
				</colgroup>
				<thead>
					<tr>
						<th>No</th>
						<th>교육기관명</th>
						<th>지역</th>
						<th>교육기관그룹</th>
						<th>강좌누적수</th>
						<th>연락처</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
					<tr>
						<td>${c.row_num}</td>
						<td><a href="javascript:inst_info('${c.edu_inst_code}')">${c.edu_inst_nm}</a></td>
						<td class="text-left">${c.sido_code_nm} ${c.gugun_code_nm}</td>
						<td>${c.edu_inst_group_code_nm}</td>
						<td>${c.rnk}</td>
						<td>${c.main_phone}</td>
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