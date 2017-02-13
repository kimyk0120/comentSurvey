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
					   
					   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:100px;\" title=\"\">";
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
	
	$(function() {

		function showModalDialogUrl(url) {
				$.get(url)
					.done(function(html) {
						var $dialog = $(html).appendTo(document.body);
						dialogInitPos($dialog);
						$dialog.fadeIn();

						$dialog.draggable({handler:"div.top-bar > h2"})
							.before('<div class="dim-warp" style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');

						$("div.close > a", $dialog).one("click", function(event) {
							$dialog.add($dialog.prev("div.dim-warp")).remove();
						});
					});
			}

			function showModalDialog($dialog) {
				dialogInitPos($dialog);
				$dialog.fadeIn();

				$dialog.draggable({handle:"div.top-bar > h2"})
					.before('<div class="dim-warp"  style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');

				$("div.btn-close > a", $dialog).one("click", function(event) {
					$dialog.hide()
						.prev("div.dim-warp").remove();
				});
				$("#btn_pop_close", $dialog).one("click", function(event) {
					$dialog.hide()
						.prev("div.dim-warp").remove();
				});
			}
			
			
			
			function dialogInitPos($dialog) {
				var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
					top = Math.floor(($(window).height() - $dialog.height()) / 2);
				$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
			}

			$("#btn_teacher").click(function(event) {
				showModalDialog($("#searchTeacher"));
			});
		});
	
	function go_page(no) {
		
		mainform.pageNum.value = no;
		document.mainform.action = "cstt_list.do";
		document.mainform.submit();
	}
	
	function src_cstt_cust() {
		document.mainform.action = "cstt_list.do";
		document.mainform.submit();
	}
	
	
	function cstt_info(seq) {
		mainform.c_no.value = seq;
		document.mainform.action = "cstt_info.do";
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
	
	function srch_tchr() {
		
		var si = frm_cstt.srch_sido.value;
		var gu = frm_cstt.srch_gugun.value;
		var cstt_nm = frm_cstt.srch_cstt_nm.value;
		var ph = frm_cstt.srch_ph.value;
		
		if(si == "" && gu == "" && cstt_nm == "" && ph == "") {
			alert("하나 이상 조건으로 검색해야 합니다.");
			return;
		}
		else {
			
		 $.ajax({ 
			   url: "srch_new_cstt.do", 
			   type: "POST", 
			   data: {"si" : si, "gu" : gu, "cstt_nm" : cstt_nm, "ph" : ph},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var tmp = msg.split('|');
				   
				   var str = "<table class=\"table-popup full\" style=\"width:650px;margin:0px 20px\"><colgroup><col style=\"width:20%\" /><col style=\"width:30%\" /><col style=\"width:30%\" /><col style=\"width:20%\" /></colgroup><thead><tr><th>성명</th><th>주소</th><th>자격정보</th><th>연락처</th></tr></thead></table>";
				   str = str + "<div class=\"table-scroll\" style=\"height:123px\"><table class=\"table-popup full\" style=\"width:650px;margin:0px 20px\"><colgroup><col style=\"width:20%\" /><col style=\"width:30%\" /><col style=\"width:30%\" /><col style=\"width:20%\" /></colgroup><tbody>";
				   if( tmp == null || tmp == "" ) {
					   str = str+"<tr><td colspan=\"4\">검색결과가 없습니다</td></tr>";
				   }
				   else {
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	        				str = str+"<tr><td><a href=\"javascript:pick_cstt('"+tmp_sub[0]+"','"+tmp_sub[7]+"')\"> "+tmp_sub[1]+"</a></td><td>"+tmp_sub[2]+" "+tmp_sub[3]+"</td><td>"+tmp_sub[4]+" "+tmp_sub[5]+"</td><td>"+tmp_sub[6]+"</td></tr>";
					   }
				   }
				   str = str+"</tbody></table></div>";
				   document.getElementById("div_tch").innerHTML=str;
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			});
		}
	}
	
	function pick_cstt(cd, cstt) {
		if ( confirm("해당 컨설턴트를 등록하시겠습니까?") ) {
			mainform.new_c_no.value= cd;
			mainform.old_c_no.value= cstt;
		//	alert("cd : " + cd + " ; cstt : " + cstt);
			
			document.mainform.action = "cstt_info.do";
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
	
	function none() {
		
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
<input type="hidden" id="new_c_no" name="new_c_no"/>
<input type="hidden" id="c_no" name="c_no"/>
<input type="hidden" id="old_c_no" name="old_c_no"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>


		<div class="contents">

			<div class="contents-top">
				<h2>컨설턴트</h2>
				<div class="btn-block">
					<a href="javascript:none()" id="btn_teacher" ><span>컨설턴트등록</span></a>
				</div>
			</div>

			<div class="search-block">
				<div class="search-row">
					<select class="formSelect" style="width:100px;" title="" id="srch_prt" name="srch_prt">
						<option value="" selected="selected">상태</option>
						<option value="팀장">팀장</option>
						<option value="팀원">팀원</option>
						<option value="인턴">인턴</option>
					</select>
					<span class="txt-label">지역</span>
					<select class="formSelect" id="srch_sido" name="srch_sido" style="width:100px;" title="" onchange="get_gugun()">
						<option value="">시도</option>
						<c:forEach items="${s_list}" var="s">
							<option value="${s.sido_code}">${s.sido_code_nm}</option>
						</c:forEach>
					</select>
					<span class="txt-symbol">,</span>
					<div id="srch_gugun_div" style="display:inline;">
						<select class="formSelect" style="width:100px;" title="">
							<option value="">구군</option>
						</select>
					</div>
					<input type="text" id="srch_cust_name" name="srch_name" placeholder="성명 검색" value="${srch.srch_name}" class="readonly" />
				</div><!-- // search-row -->
				<div class="btn-block">
					<a href="javascript:src_cstt_cust()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->

			<table class="talbe-list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:15%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:30%" />
					<col style="width:8%"/>
					<col style="width:8%"/>
				</colgroup>
				<thead>
					<tr>
						<th style="padding:0px 5px">No</th>
						<th style="padding:0px 5px">컨설턴트명</th>
						<th style="padding:0px 5px">연락처</th>
						<th style="padding:0px 5px">구분</th>
						<th style="padding:0px 5px">정리수납</th>
						<th style="padding:0px 2px">취득지점</th>
						<th style="padding:0px 5px">주소</th>
						<th style="padding:0px 2px">작업횟수</th>
						<th style="padding:0px 5px">등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
					<tr onclick="javascript:cstt_info('${c.cstt_no}')" >
						<td style="padding:0px 5px">${c.row_num}</td>
						<td style="padding:0px 5px">${c.cstt_name}</td>
						<td style="padding:0px 5px">${c.phone}</td>
						<td style="padding:0px 5px">${c.cstt_prt}</td>
						<td style="padding:0px 5px">${c.cstt_role_code_nm}</td>
						<td style="padding:0px 5px">${c.branch_name}</td>
						<td style="padding:0px 5px" class="text-left">${c.sido_code_nm} ${c.gugun_code_nm} ${c.address }</td>
						<td style="padding:0px 5px">${c.work_cnt}</td>
						<td style="padding:0px 5px">${c.resist_date}</td>
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

<form id="frm_cstt" name="frm_cstt" action="" method="post">
<div id="searchTeacher" class="layer-warp">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>컨설턴트 검색</h2>
			<div class="btn-close"><a href="javascript:none()"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>

		<div class="layer-content">

			<div class="search-block" style="margin-left:10px;margin-right:10px">
				<div class="search-row">
					<span class="txt-label">지역</span>
					<select class="formSelect" id="srch_sido" name="srch_sido" style="width:100px;" title="" onchange="get_gugun()">
						<option value="" selected="selected">시도</option>
						<c:forEach items="${s_list}" var="s">
							<option value="${s.sido_code}">${s.sido_code_nm}</option>
						</c:forEach>
					</select>
					<span class="txt-symbol">,</span>
					<div id="srch_gugun_div"  style="display:inline;">
						<select class="formSelect" style="width:100px;" title="" id="srch_gugun" name="srch_gugun">
							<option value="" selected="selected">구군</option>
						</select>
					</div>
					<span>
						<input type="text" id="srch_cstt_nm" name="srch_cstt_nm" value="" placeholder="성명" style="width:80px;" />
					</span>
					<span>
						<input type="text" id="srch_ph" name="srch_ph" value="" placeholder="연락처" style="width:80px;" />
					</span>
				</div><!-- // search-row -->
				<div class="btn-block">
					<a href="javascript:srch_tchr()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->

			<div class="row" id="div_tch">
				<table class="table-popup full" style="width:650px;margin:0px 20px">
					<colgroup>
						<col style="width:20%" />
							<col style="width:30%" />
							<col style="width:30%" />
							<col style="width:20%" />
					</colgroup>
					<thead>
						<tr>
							<th>강사명</th>
							<th>지역</th>
							<th>자격정보</th>
							<th>연락처</th>
						</tr>
					</thead>
				</table>
				<div class="table-scroll" style="height:123px">
					<table class="table-popup full" style="width:650px;margin:0px 20px">
						<colgroup>
							<col style="width:20%" />
							<col style="width:30%" />
							<col style="width:30%" />
							<col style="width:20%" />
						</colgroup>
						<tbody>
							<tr>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

			<div class="btn-block">
				<a href="javascript:none()" id="btn_pop_close" class="btn-negative"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>

</body>
</html>