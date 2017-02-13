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
	$(function() {
		$('.formSelect').sSelect();
	});
	
	$(document).ready(function() {
		
		var sido = "<c:out value="${srch.srch_sido}"/>";
		var gugun = "<c:out value="${srch.srch_gugun}"/>";
		
		if(sido != null && sido != '') {
			
		$("#srch_sido").val(sido).change();
		
			$.ajax({ 
				   url: "srch_gugun.do", 
				   type: "POST", 
				   data: {"s_sido" : sido},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:150px;\" title=\"\" tabindex=\"5\">";
					   str=str+"<option value=\"\">전체</option>";
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	     				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   str = str+"</select>";
					   document.getElementById("gugun_div").innerHTML=str;
					   
					   $('.formSelect').sSelect();
					   if(gugun != null && gugun != '') {
						   $("#srch_gugun").val(gugun).change(); 
					   }
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
		}
		
		var srch = "<c:out value="${srch.srch_id}"/>";
		$("#srch_id").val(srch).change();
		
		var au = "<c:out value="${srch.srch_auth}"/>";
		$("#srch_auth").val(au).change();
		
	});
	
	function user_create() {
		
		document.mainform.target = "_self";
		document.mainform.action = "user_create.do";
		document.mainform.submit();
	}
	
	function srch_user() {
		
		document.mainform.target = "_self";
		document.mainform.action = "user_list.do";
		document.mainform.submit();
	}
	
	function auth_info(id) {
		$('#user_id').val(id);
		document.mainform.target = "_self";
		document.mainform.action = "user_info.do";
		document.mainform.submit();
	}
	
	function go_page(no) {
		
		$('#pageNum').val(no);
		document.mainform.target = "_self";
		document.mainform.action = "user_list.do";
		document.mainform.submit();
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
				   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:150px;\" title=\"\" tabindex=\"5\">";
				   var tmp = msg.split('|');
				   if(msg != "") {
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	        				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
				   		}
				   } else {
					   str = str+"<option value=\"\">선택</option>";
				   }
				   str = str+"</select>";
				   document.getElementById("gugun_div").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
	}
	
</script>
</head>
<body>
<div id="wrapper">
	
<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="pageNum" name="pageNum"/>
<input type="hidden" id="user_id" name="user_id"/>

	<jsp:include page="../main/topMenu.jsp"  />
	

	<div id="container" class="colum1"><!-- 왼쪽에 사용자 정보가 없을 경우 클래스 colum1 삽입 -->

		<div class="contents">

			<h2>이용자 조회</h2>

			<div class="shadow-box">

				<div class="search-block">

					<div class="item-block clearfix">
						<dl class="float-left">
							<dt>검색항목</dt>
							<dd>
								<select class="formSelect" id="srch_id" name="srch_id" style="width:80px;" title="검색조건 구분 아이디 사용자명 연락처"  tabindex="1">
								<option value="1">아이디</option>
								<option value="2">사용자명</option>
								<option value="3">연락처</option>
								</select>
								<ul style="display:inline-flex"> 
									<li><input type="text" name="srch_nm" id="srch_nm" value="${srch.srch_nm }" style="width:180px;" tabindex="2" title="검색항목"/></li>
								</ul>
							</dd>
							<dt>사용자구분</dt>
							<dd>
								<select class="formSelect" id="srch_auth" name="srch_auth" style="width:100px;" title="검색조건 사용자구분"  tabindex="3">
									<option value="">전체</option>
									<option value="1">관리자</option>
									<option value="2">지자체(시도)</option>
									<option value="3">지자체(시군구)</option>
									<option value="4">해설사</option>
								</select>
							</dd>
						</dl>
					</div><!-- // item-block -->
					
					<div class="search-row">
						<label for="srch_sido_cd">지역선택</label>
								<select class="formSelect" id="srch_sido" name="srch_sido" style="width:150px;margin-right:7px" title="" onchange="get_gugun()" tabindex="4">
									<option value="">전체</option>
									<c:forEach items="${s_list}" var="s">
										<option value="${s.sido_cd}">${s.sido_cd_nm}</option>
									</c:forEach>
								</select>
						<div id="gugun_div" style="display:inline;">
							<select class="formSelect" style="width:150px;" title="" tabindex="5">
								<option value="">전체</option>
							</select>
						</div>
					</div><!-- // search-row -->

					<div class="btn-block" style="margin-top:-25px">
						<a href="javascript:srch_user()" class="btn-search2" tabindex="6"><span style="padding-top:0px">검색</span></a>
					</div>
					
				</div><!-- //search-block -->

				<div class="btn-block text-right mb10">
					<a href="javascript:user_create()" class="btn-blue" tabindex="5"><span>이용자 등록</span></a>
				</div>

				<table class="talbe-list">
					<colgroup>
						<col style="width:5%" />
						<col style="width:20%" />
						<col style="width:10%" />
						<col style="width:20%" />
						<col style="width:15%" />
						<col style="width:15%" />
						<col style="width:15%" />
					</colgroup>
					<thead>
						<tr>
							<th>No</th>
							<th>아이디</th>
							<th>이름</th>
							<th>지역</th>
							<th>연락처</th>
							<th>사용자구분</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="c" varStatus="status">
							<tr onclick="javascript:auth_info('${c.id}')" tabindex="${status.index+7}">
								<td>${c.row_num}</td>
								<td>${c.id}</td>
								<td>${c.nm}</td>
								<td>${c.sido_cd_nm} ${c.gugun_cd_nm }</td>
								<td>
									<c:if test="${fn:length(c.ph3) gt 1 }">
										***-****-${c.ph3}
									</c:if>
								</td>
								<td> ${c.auth_nm} <c:if test="${c.cnsm_org_yn eq 'Y'}"><font style="color:#4b5b9d;font-weight:bold"> (위탁)</font> </c:if> </td>
								<td>${c.reg_dt }</td>
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
					
					   <c:forEach var="i" begin="${startPage}" end="${endPage}" varStatus="status">
					       <li>
					           <c:choose>
					               <c:when test="${currentPage == i}">
					               		<a href="javascript:go_page('${i}')" class="no-bg on" tabindex="${status.index+16}">${i}</a>
					               </c:when>
					               <c:otherwise>
							       		<a href="javascript:go_page('${i}')" class="no-bg" tabindex="${status.index+16}">${i}</a>
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