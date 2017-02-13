<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="now" class="java.util.Date" />

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
		
		$( '#work_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		
		/* var y = "<c:out value="${now_ym}" />";
		
		if(y.substring(0, 4) != null && y.substring(0, 4) != '') {
			$("#srch_yy").val(y.substring(0, 4)).change(); 
		}
		if(y.substring(5, 7) != null && y.substring(5, 7) != '') {
			$("#srch_mm").val(y.substring(5, 7)).change(); 
		} */
		
	});
	$(function() {
		$('.formSelect').sSelect();
		
		var winHeight = $(window).height();
		var docHeight = $(document).height();
		
		function showModalDialogUrl(url) {
			$.get(url)
				.done(function(html) {
					var $dialog = $(html).appendTo(document.body);
					dialogInitPos($dialog);
					$dialog.fadeIn();

					$dialog.draggable({handler:"div.top-bar > h2"})
						.before('<div class="dim-warp" style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');
					
					if (winHeight < docHeight){
						$(".dim-warp").css ("height", docHeight);
					} else {
						$(".dim-warp").css ("height", winHeight);
					}

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
		
			if (winHeight < docHeight){
				$(".dim-warp").css ("height", docHeight);
			} else {
				$(".dim-warp").css ("height", winHeight);
			}

			$("#btn_act_close", $dialog).one("click", function(event) {
				$('#seq').val('');
				$('#work_yy').val('');
				$('#work_mm').val('');
				$('#work_dt_cnt').val('');
				$('#work_tm').val('');
				$('#work_place').val('');
				$('#visitor_cnt').val('');
				$('#cmmt_cnt').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_act_xclose", $dialog).one("click", function(event) {
				$('#seq').val('');
				$('#work_yy').val('');
				$('#work_mm').val('');
				$('#work_dt_cnt').val('');
				$('#work_tm').val('');
				$('#work_place').val('');
				$('#visitor_cnt').val('');
				$('#cmmt_cnt').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}

		$("#btn_act_add").click(function(event) {
			showModalDialog($("#layer_act"));
			
			$('#ym1').css("display","");
			$('#ym2').css("display","none");
			$('#seq').val("0");
		
			var y = $('#now_ym').val();
			
			if(y.substring(0, 4) != null && y.substring(0, 4) != '') {
				$("#work_yy").val(y.substring(0, 4)).change(); 
			}
			if(y.substring(5, 7) != null && y.substring(5, 7) != '') {
				$("#work_mm").val(y.substring(5, 7)).change(); 
			}
		});
		
	});
	
	function cmmt_info() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_info.do";
		document.mainform.submit();
	}
	function cmmt_edu_list() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_edu_list.do";
		document.mainform.submit();
	}
	function cmmt_fee_list() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_fee_list.do";
		document.mainform.submit();
	}
	function srch_act_list() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_act_list.do";
		document.mainform.submit();
	}
	
	function cmmt_list() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_list.do";
		document.mainform.submit();
	}
	
	function cmmt_create() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_create.do";
		document.mainform.submit();
	}
	
	function go_page(no) {
		mainform.pageNum.value = no;
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_act_list.do";
		document.mainform.submit();
	}
	
	function act_save() {
		
		var yy = $('#work_yy').val();
		var mm = $('#work_mm').val();
		var cNo = $('#cmntor_no').val();
		
		if($('#seq').val() == 0) {
			
			$.ajax({ 
				   url: "dup_check.do", 
				   type: "POST", 
				   data: {"yy" : yy, "mm" : mm, "c_no" : cNo},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					 if(msg == "1") {
						 alert("이미 등록된 활동월입니다.");
						 return;
					 } else {
						 value_save();
					 }
			       }
				}); 
		} else {
			value_save();
		}
		
	}
	
	function value_save() {
		
		var wCnt =  $('#work_dt_cnt').val();
		
		if(wCnt == "" || wCnt == null) {
			alert("활동일수를 입력해주세요.");
			$('#work_dt_cnt').focus();
			return;
		}
		else {
			if(confirm("저장하시겠습니까?")) {
				var vCnt =  $('#visitor_cnt').val();
				var cCnt =  $('#cmmt_cnt').val();
				
				var wTm =  $('#work_tm').val();
				if(vCnt == "" || vCnt == null) $('#visitor_cnt').val('0');
				if(cCnt == "" || cCnt == null) $('#cmmt_cnt').val('0');
				if(wCnt == "" || wCnt == null) $('#work_dt_cnt').val('0');
				if(wTm == "" || wTm == null) $('#work_tm').val('0');
				
				document.frm_act.target = "_self";
				document.frm_act.action = "cmmt_act_save.do";
				document.frm_act.submit();
			}
		}
	}
	
	/* function showKeyCode(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || (keyID == 8) || (keyID == 9) || (keyID == 46))
		{
			return;
		}
		else
		{
			return false;
		}
	} */
	
	function number_filter(str_value){
		return str_value.replace(/[^0-9]/gi, ""); 
	}
	
	function act_edit(seq, ym, cnt, tm, plc, vcnt, ccnt) {
		
		showModalDialog($("#layer_act"));
			
		var winHeight = $(window).height();
		var docHeight = $(document).height();
		
		function showModalDialog($dialog) {
			dialogInitPos($dialog);
			$dialog.fadeIn();

			$dialog.draggable({handler:"div.top-bar > h2"})
			.before('<div class="dim-warp" style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');

			if (winHeight < docHeight){
				$(".dim-warp").css ("height", docHeight);
			} else {
				$(".dim-warp").css ("height", winHeight);
			}

			$("#btn_act_close", $dialog).one("click", function(event) {
				$('#seq').val('');
				$('#work_yy').val('');
				$('#work_mm').val('');
				$('#work_dt_cnt').val('');
				$('#work_tm').val('');
				$('#work_place').val('');
				$('#visitor_cnt').val('');
				$('#cmmt_cnt').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_act_xclose", $dialog).one("click", function(event) {
				$('#seq').val('');
				$('#work_yy').val('');
				$('#work_mm').val('');
				$('#work_dt_cnt').val('');
				$('#work_tm').val('');
				$('#work_place').val('');
				$('#visitor_cnt').val('');
				$('#cmmt_cnt').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$('#ym1').css("display","none");
			$('#ym2').css("display","");
			
			
			$('#seq').val(seq);
			$('#work_dt_cnt').val(cnt);
			$('#work_tm').val(tm);
			$('#work_place').val(plc);
			$('#visitor_cnt').val(vcnt);
			$('#cmmt_cnt').val(ccnt);
			
			
			var wY = ym.substring(0,4);
			var wM = ym.substring(6,8);
			
			$('.replace').html(wY+"년 "+wM+"월");
			
			/* if(ym != "" ) {
				$("#work_yy").val(ym.substring(0,4)).change();
				$("#work_mm").val(ym.substring(6,8)).change();
			}
			 */
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}
	}
	
	function act_delete(seq) {
		
		if(confirm("삭제하시겠습니까?")) {
			$('#act_seq').val(seq);
			document.mainform.target = "_self";
			document.mainform.action = "act_delete.do";
			document.mainform.submit();
		}
		
	}
	
	
</script>
<style type="text/css">

.inner-block a span {
	display:inline-block;height:26px;
	font-size:1.0em;text-align:center;line-height:23px;
	padding:1px 10px;min-width:48px;border-radius:5px}
.inner-block a.btn-gray {border:1px solid #aaaaaa;border-radius:5px;width:50px;margin:auto}
.inner-block a.btn-gray span {border-bottom:3px solid #514f4f;color:#000}

.act-list {border-top:1px solid #dcdcdc;border-bottom:1px solid #dcdcdc}
/* .act-list th {height:33px;background:#efefef;color:#999;border-bottom:1px solid #dcdcdc}
.act-list td {height:30px;border-bottom:1px solid #dcdcdc;text-align:center;padding:0 10px} */

.act-list.dark th {height:35px;background:#bbb;color:#666;border-bottom:none}
.act-list.dark td {text-align:center;height:30px;padding:3px 10px 2px;color:#666;border-bottom:none}
.act-list.dark td a {color:#666;display:block}
.act-list.dark tr:nth-child(even) td {background:#eee}

</style>

</head>
<body>
<div id="wrapper">

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="pageNum" name="pageNum"/>
<input type="hidden" id="act_seq" name="act_seq"/>
<input type="hidden" id="c_no" name="c_no" value="${srch.cmntor_no }" />
<input type="hidden" id="now_ym" name="now_ym" value="${now_ym}" />

	<jsp:include page="../main/topMenu.jsp"  />
	
	<div id="container" class="main2"><!-- 왼쪽에 사용자 정보가 있을 경우 클래스 colum2 삽입 -->

		<div class="user-info">
			<div class="shadow-box">
				<div class="comment">안녕하세요.</div>
				<div class="view-content">
					<div class="user-photo">
						<c:set value="<%=session.getAttribute(\"prflImg\") %>" var="prfl" />
						<c:choose>
							<c:when test="${fn:length(prfl) gt 0 }">
								<img src="files/image/${prfl}" class="person" style="max-height:70px;width:inherit" alt="프로필 사진" />
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
		
			<div class="btn-block text-right mb10">
				<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
				<c:if test="${auth eq 1 or auth eq 2 or auth eq 3}">
					<a href="javascript:cmmt_create()" class="btn-blue"><span>해설사 신규 등록</span></a>
				</c:if>
				<a href="javascript:cmmt_list()" class="btn-orange"><span>리스트</span></a>
			</div>

			<ul id="tab" class="clearfix">
				<li><a href="javascript:cmmt_info()">기본 정보</a></li>
				<li><a href="javascript:cmmt_edu_list()">교육 이수 내용</a></li><!-- 선택된 곳에 클래스 on 추가 -->
				<li class="on"><a href="javascript:;">활동 정보</a></li>
				<li><a href="javascript:cmmt_fee_list()">활동비 지급 내역</a></li>
			</ul><!--// tab -->

			<div class="shadow-box">
			
				<table class="talbe-view" style="margin-bottom:10px;border:1px solid #dcdcdc">
					<colgroup>
						<col style="width:10%" />
						<col style="width:40%" />
						<col style="width:10%" />
						<col style="width:40%" />
					</colgroup>
					<tbody>
						<tr>
							<th>소속</th>
							<td>${info.sido_cd_nm} ${info.gugun_cd_nm}</td>
							<th>성명</th>
							<td>${info.name} </td>
						</tr>
					</tbody>
				</table>
			
			<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
				<c:if test="${auth eq 1 or auth eq 2 or auth eq 3}">
				<div class="btn-block text-right mb10">
					<a href="javascript:;" class="btn-blue" id="btn_act_add"><span>활동 등록</span></a>
				</div>
				</c:if>

				<table class="act-list dark">
					<colgroup>
						<col style="width:15%" />
						<col style="width:12%" />
						<col style="width:12%" />
						<col style="width:*" />
						<col style="width:12%" />
						<col style="width:12%" />
						<c:if test="${auth eq 1}">
							<col style="width:7%" />
						</c:if>
					</colgroup>
					<thead>
						<tr>
							<th>활동연월</th>
							<th>활동일수</th>
							<th>활동시간</th>
							<th>활동장소</th>
							<th>방문객수</th>
							<th>해설횟수</th>
							<c:if test="${auth eq 1}">
								<th>삭제</th>
							</c:if>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="c" varStatus="status">
							<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
							<tr>
								<td <c:if test="${auth eq 1 or auth eq 2 or auth eq 3}">
									onclick="javascript:act_edit('${c.seq}','${c.work_ym }','${c.work_dt_cnt }','${c.work_tm }','${c.work_place }','${c.visitor_cnt }','${c.cmmt_cnt}')"
									</c:if>
									style="cursor:pointer">${c.work_ym}</td>
								<td>${c.work_dt_cnt}</td>
								<td>${c.work_tm}</td>
								<td <c:if test="${auth eq 1 or auth eq 2 or auth eq 3}">
									onclick="javascript:act_edit('${c.seq}','${c.work_ym }','${c.work_dt_cnt }','${c.work_tm }','${c.work_place }','${c.visitor_cnt }','${c.cmmt_cnt}')"
									</c:if>
									style="cursor:pointer">${c.work_place}</td>
								<td>${c.visitor_cnt}</td>
								<td>${c.cmmt_cnt}</td>
								<c:if test="${auth eq 1}">
									<td>
										<div class="inner-block">
											<a href="javascript:act_delete('${c.seq}');" class="btn-gray"><span>삭제</span></a>
										</div>
									</td>
								</c:if>
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

<form id="frm_act" name="frm_act" action="" method="post">
<div id="layer_act" class="layer-warp">
<input type="hidden" id="cmntor_no" name="cmntor_no" value="${srch.cmntor_no }" />
<input type="hidden" id="c_no" name="c_no" value="${srch.cmntor_no }" />
<input type="hidden" id="seq" name="seq" value="0"/>
	<div class="layer-inner">
		<div class="top-bar">
			<h2>활동내역 등록</h2>
			<div class="btn-close"><a href="javascript:;" id="btn_act_xclose"><img src="image/btn_close.png" alt="Close" /></a></div>
		</div>

		<div class="contents" style="margin-left:5px;padding:5px">
			
			<table class="layerpop-list dark">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr id="ym1">
						<th>활동연도</th>
						<td colspan="3">
							<select class="formSelect" id="work_yy" name="work_yy" style="width:80px;" title="">
									<c:forEach items="${y_list}" var="y">
									<option value="${y.yyyy}">${y.yyyy}</option>
								</c:forEach>
							</select><span style="margin:0px 15px 0 5px">년</span>
							<select class="formSelect" style="width:50px" title="월" name="work_mm" id="work_mm">
								<option value="01">1</option><option value="02">2</option><option value="03">3</option><option value="04">4</option>
								<option value="05">5</option><option value="06">6</option><option value="07">7</option><option value="08">8</option>
								<option value="09">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>
							</select><span style="margin:0px 15px 0 5px"> 월 </span>
						</td>
					</tr>
					<tr id="ym2">
						<th>활동연도</th>
						<td colspan="3"><span class="replace"></span></td>
					</tr>
					<tr>
						<th>활동일수</th>
						<td>
							<input type="text" id="work_dt_cnt" name="work_dt_cnt" title="활동일수" placeholder="숫자만 입력하세요" class="row-input" onkeyup="this.value=number_filter(this.value);"/>
						</td>
						<th>활동시간</th>
						<td>
							<input type="text" id="work_tm" name="work_tm" title="활동시간" placeholder="숫자만 입력하세요" class="row-input" onkeyup="this.value=number_filter(this.value);"/>
						</td>
					</tr>
					<tr>
						<th>활동장소</th>
						<td colspan="3" ><input type="text" id="work_place" name="work_place" title="활동장소" style="width:90%;height:80%" /></td>
					</tr>
					<tr>
						<th>방문객수</th>
						<td><input type="text" id="visitor_cnt" name="visitor_cnt" title="방문객수" placeholder="숫자만 입력하세요" class="row-input" onkeyup="this.value=number_filter(this.value);"/></td>
						<th>해설횟수</th>
						<td><input type="text" id="cmmt_cnt" name="cmmt_cnt" title="해설횟수" placeholder="숫자만 입력하세요" class="row-input" onkeyup="this.value=number_filter(this.value);"/></td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block text-center" style="border-top:none">				
				<a href="javascript:act_save()" class="btn-blue"><span>저장</span></a>
				<a href="javascript:;" class="btn-orange" id="btn_act_close"><span>닫기</span></a>
			</div><!--// btn-block -->
			
		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>

</body>
</html>