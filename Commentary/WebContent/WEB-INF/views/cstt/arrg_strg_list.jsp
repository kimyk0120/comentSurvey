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

			$("#btn_arrg").click(function(event) {
				showModalDialog($("#searchCust"));
			});
		});
	
	function go_page(no) {
		
		mainform.pageNum.value = no;
		document.mainform.action = "arrg_strg_list.do";
		document.mainform.submit();
	}
	
	function src_arrg_strg() {
		document.mainform.action = "arrg_strg_list.do";
		document.mainform.submit();
	}
	
	function cust_create() {
		document.mainform.action = "cust_create2.do";
		document.mainform.submit();
	}
	
	function checkEnterKey(){
		if(event.keyCode==13){src_arrg_strg();}
	}
	
	function arrg_strg_info(seq) {
		mainform.arrg_no.value = seq;
		document.mainform.action = "arrg_strg_info.do";
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
	
	function srch_cust() {
		
		var si = frm_cust.srch_sido.value;
		var gu = frm_cust.srch_gugun.value;
		var cust_nm = frm_cust.srch_cust_nm.value;
		var ph = frm_cust.srch_ph.value;
		
		if(si == "" && gu == "" && cust_nm == "" && ph == "") {
			alert("하나 이상 조건으로 검색해야 합니다.");
			return;
		}
		else {
			
		 $.ajax({ 
			   url: "srch_arrg_cust.do", 
			   type: "POST", 
			   data: {"si" : si, "gu" : gu, "cust_nm" : cust_nm, "ph" : ph},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var tmp = msg.split('|');
				   
				   var str = "<table class=\"table-popup full\" style=\"width:650px;margin:0px 20px\"><colgroup><col style=\"width:20%\" /><col style=\"width:30%\" /><col style=\"width:50%\" /></colgroup><thead><tr><th>성명</th><th>연락처</th><th>주소</th></tr></thead></table>";
				   str = str + "<div class=\"table-scroll\" style=\"height:123px\"><table class=\"table-popup full\" style=\"width:650px;margin:0px 20px\"><colgroup><col style=\"width:20%\" /><col style=\"width:30%\" /><col style=\"width:50%\" /></colgroup><tbody>";
				   if( tmp == null || tmp == "" ) {
					   str = str+"<tr><td colspan=\"3\">검색결과가 없습니다</td></tr>";
				   }
				   else {
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	        				str = str+"<tr><td><a href=\"javascript:pick_cust('"+tmp_sub[0]+"')\"> "+tmp_sub[1]+"</a></td><td>"+tmp_sub[5]+"</td><td>"+tmp_sub[2]+" "+tmp_sub[3]+" "+tmp_sub[4]+"</td></tr>";
					   }
				   }
				   str = str+"</tbody></table></div>";
				   document.getElementById("div_cust").innerHTML=str;
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			});
		}
	}
	
	function pick_cust(cd) {
		if ( confirm("해당 고객으로 정리수납 등록하시겠습니까?") ) {
			mainform.c_no.value= cd;
			
			document.mainform.action = "arrg_strg_create.do";
			document.mainform.submit();
		}
	}
	
	function none() {
		var a ="";
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
				<h2>정리수납</h2>
				<div class="btn-block">
					<a href="javascript:none()" id="btn_arrg"><span>정리수납등록</span></a>
				</div>
			</div>

			<div class="search-block">
				<div class="search-row">
					<select class="formSelect" style="width:150px;margin-right:20px" title="" id="srch_branch" name="srch_branch">
						<option value="">지점</option>
						<c:forEach items="${b_list}" var="b">
							<option value="${b.branch_code}" <c:if test="${srch.srch_branch eq b.branch_code}">selected="selected"</c:if>>${b.branch_name}</option>
						</c:forEach>
					</select>
					<select class="formSelect" style="width:100px;margin-right:20px" title="" id="srch_arrg_strg_st" name="srch_arrg_strg_st">
						<option value="" selected="selected">상태</option>
						<option value="접수" <c:if test="${srch.srch_arrg_strg_st eq '접수'}">selected="selected"</c:if>>접수</option>
						<option value="접수완료" <c:if test="${srch.srch_arrg_strg_st eq '접수완료'}">selected="selected"</c:if>>접수완료</option>
						<option value="견적배정" <c:if test="${srch.srch_arrg_strg_st eq '견적배정'}">selected="selected"</c:if>>견적배정</option>
						<option value="견적반려" <c:if test="${srch.srch_arrg_strg_st eq '견적반려'}">selected="selected"</c:if>>견적반려</option>
						<option value="견적완료" <c:if test="${srch.srch_arrg_strg_st eq '견적완료'}">selected="selected"</c:if>>견적완료</option>
						<option value="계약완료" <c:if test="${srch.srch_arrg_strg_st eq '계약완료'}">selected="selected"</c:if>>계약완료</option>
						<option value="작업배정" <c:if test="${srch.srch_arrg_strg_st eq '작업배정'}">selected="selected"</c:if>>작업배정</option>
						<option value="작업반려" <c:if test="${srch.srch_arrg_strg_st eq '작업반려'}">selected="selected"</c:if>>작업반려</option>
						<option value="작업완료" <c:if test="${srch.srch_arrg_strg_st eq '작업완료'}">selected="selected"</c:if>>작업완료</option>
						<option value="계약취소" <c:if test="${srch.srch_arrg_strg_st eq '계약취소'}">selected="selected"</c:if>>계약취소</option>
					</select>
					<input type="text" id="srch_name" name="srch_name" placeholder="팀장명 검색" value="${srch.srch_name}" class="readonly" style="margin-right:20px" onKeyDown="javascript:checkEnterKey()"/>
					<input type="text" id="srch_cust_name" name="srch_cust_name" placeholder="성명 검색" value="${srch.srch_cust_name}" class="readonly" onKeyDown="javascript:checkEnterKey()"/>
				</div>
				<div class="search-row">
					<span class="txt-label" style="min-width:40px">기간</span>
					<select class="formSelect" id="srch_dt_prt" name="srch_dt_prt" style="width:100px;margin-right:20px" title="" >
						<option value="">선택</option>
						<option value="1" <c:if test="${srch.srch_dt_prt eq '1'}">selected="selected"</c:if>>접수일</option>
						<option value="2" <c:if test="${srch.srch_dt_prt eq '2'}">selected="selected"</c:if>>계약일</option>
						<option value="3" <c:if test="${srch.srch_dt_prt eq '3'}">selected="selected"</c:if>>작업일</option>
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
					<col style="width:5%" />
					<%-- <col style="width:8%" /> --%>
					<col style="width:8%" />
					<col style="width:15%" />
					<col style="width:8%" />
					<col style="width:19%" />
					<col style="width:8%" />
					<col style="width:8%"/>
					<col style="width:19%"/>
					<col style="width:10%"/>
				</colgroup>
				<thead>
					<tr>
						<th style="padding:0px 5px">No</th>
						<!-- <th style="padding:0px 5px">관리코드</th> -->
						<th style="padding:0px 5px">고객명</th>
						<th style="padding:0px 5px">연락처</th>
						<th style="padding:0px 5px">구분</th>
						<th style="padding:0px 2px">접수/계약지점</th>
						<th style="padding:0px 5px">팀장</th>
						<th style="padding:0px 5px">AS여부</th>
						<th style="padding:0px 5px">계약금액/수수료</th>
						<th style="padding:0px 5px">접수일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
					<tr onclick="javascript:arrg_strg_info('${c.arrg_strg_no}')">
						<td style="padding:0px 5px">${c.row_num}</td>
						<%-- <td style="padding:0px 5px">${c.arrg_strg_no}</td> --%>
						<td style="padding:0px 5px">${c.srvc_cust_nm}</td>
						<td style="padding:0px 5px">${c.srvc_phone}</td>
						<td style="padding:0px 5px">${c.arrg_strg_st_cd}</td>
						<td style="padding:0px 5px">
							${c.cnsl_branch_name}
							/
							${c.estm_branch_name}
						</td>
						<td style="padding:0px 5px">${c.cstt_name}</td>
						<td style="padding:0px 5px">
							${c.as_appl_dt}
						</td>
						<td style="padding:0px 5px"><fmt:formatNumber value="${c.tot_work_amt}" /> / <fmt:formatNumber value="${c.estm_fee}" /></td>
						<td style="padding:0px 5px">${c.cnsl_dt}</td>
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

<form id="frm_cust" name="frm_cust" action="" method="post">
<div id="searchCust" class="layer-warp">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>고겍 검색</h2>
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
						<input type="text" id="srch_cust_nm" name="srch_cust_nm" value="" placeholder="성명" style="width:80px;" />
					</span>
					<span>
						<input type="text" id="srch_ph" name="srch_ph" value="" placeholder="연락처" style="width:80px;" />
					</span>
				</div><!-- // search-row -->
				<div class="btn-block">
					<a href="javascript:srch_cust()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->

			<div class="row" id="div_cust">
				<table class="table-popup full" style="width:650px;margin:0px 20px">
					<colgroup>
						<col style="width:20%" />
							<col style="width:30%" />
							<col style="width:30%" />
							<col style="width:20%" />
					</colgroup>
					<thead>
						<tr>
							<th>고객명</th>
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
				<a href="javascript:cust_create()"><span>고객등록</span></a>
				<a href="javascript:none()" id="btn_pop_close" class="btn-negative"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>

</body>
</html>