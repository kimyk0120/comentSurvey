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
<title>접수 l 정리수납상세 l 정리수납</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">
	$(function() {
		$('.formSelect').sSelect();
		
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
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}

		$("#btn-popup").click(function(event) {
			showModalDialog($("#regSchedule"));
		});

		$("#btn-add").click(function(event) {
			$("#input-block").show();
		});
		$("#btn-cancle").click(function(event) {
			$("#input-block").hide();
		});
	});
	
	$(document).ready(function() {
		
		var d = new Date(); 
		 var toDay = set_standard(d.getFullYear(), 4)+'-'+
			set_standard(d.getMonth() + 1, 2)+'-'+
			set_standard(d.getDate(), 2);
		 
		 var myDate = new Date(toDay)
		 myDate.setDate(myDate.getDate() + 1);
		 
		 myDate = set_standard(myDate.getFullYear(), 4)+'-'+
			set_standard(myDate.getMonth() + 1, 2)+'-'+
			set_standard(myDate.getDate(), 2);
		  
		 $('#cnsl_dt').val(toDay);
		 $('#estm_dt').val(myDate);
		
		var ph1 = "<c:out value="${info.ph1}"/>";
		if(ph1 != null && ph1 != '') {
			$("#ph1").val(ph1).attr("selected","selected"); 
		}
		
		var sido = "<c:out value="${info.sido_code}"/>";
		var gugun = "<c:out value="${info.gugun_code}"/>";
		
		if(sido != null && sido != '') {
			
			$("#sido_code").val(sido).attr("selected","selected");
		
			$.ajax({ 
				   url: "srch_gugun.do", 
				   type: "POST", 
				   data: {"s_sido" : sido},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "<select class=\"formSelect\" id=\"srvc_gugun_code\" name=\"srvc_gugun_code\" style=\"width:100px;\" title=\"\">";
					   str=str+"<option value=\"\">선택</option>";
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	     				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   str = str+"</select>";
					   document.getElementById("gugun_div").innerHTML=str;
					   
					   if(gugun != null && gugun != '') {
						   $("#srvc_gugun_code").val(gugun).attr("selected","selected"); 
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
	      
		$( '#estm_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		$( '#cnsl_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		
	});
	
	function set_standard(time, digits) {
		  var zero = '';
		  time = time.toString();

		  if (time.length < digits) {
			for (i = 0; i < digits - time.length; i++)
			  zero += '0';
		  }
		  return zero + time;
		}
	
	function get_gugun() {
		
		var e = document.getElementById("srvc_sido_code");
		var s_sido = e.options[e.selectedIndex].value;
				
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var tmp = msg.split('|');
				   
				   var str = "<select class=\"formSelect\" id=\"srvc_gugun_code\" name=\"srvc_gugun_code\" style=\"width:100px;\" title=\"\">";
				   for(var i = 0; i < tmp.length ; i++) {
					   var tmp_sub = tmp[i].split(",");
	    				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
				   }
				   str = str+"</select>";
				   document.getElementById("gugun_div").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
	}
	
	function arrg_save() {
		
		var p1 = $("#ph1").val();
		var p2 = $("#ph2").val();
		var p3 = $("#ph3").val();
		
		
		if(p1 != '' && p2 != '' && p3 != '') {
			mainform.srvc_phone.value=p1+"-"+p2+"-"+p3;
		}
		
		document.mainform.action = "arrg_strg_save.do";
		document.mainform.submit();
	}
	
	function arrg_next() {
		
		var p1 = $("#ph1").val();
		var p2 = $("#ph2").val();
		var p3 = $("#ph3").val();
		
		
		if(p1 != '' && p2 != '' && p3 != '') {
			mainform.srvc_phone.value=p1+"-"+p2+"-"+p3;
		}
		mainform.next_step_yn.value="Y";
		document.mainform.action = "arrg_strg_save.do";
		document.mainform.submit();
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
<input type="hidden" id="c_no" name="c_no" value="${info.cust_no }"/>
<input type="hidden" id="srvc_phone" name="srvc_phone"/>
<input type="hidden" id="arrg_step" name="arrg_step" value="1"/>
<input type="hidden" id="next_step_yn" name="next_step_yn" value="N"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

		<div class="contents">

			<div class="contents-top">
				<h2>정리수납상세</h2>
			</div>

			<div class="top-info">
				<div class="process">
					<ul>
						<li><span class="on"><span>접수</span></span></li><!-- 해당 단계에 클래스 on 추가 -->
						<li class="text-center"><span><span>견적</span></span></li>
						<li class="text-center"><span><span>계약</span></span></li>
						<li class="text-right"><span><span>작업</span></span></li>
					</ul>
				</div>
				<div class="breif-info">
					<p><a><span>입금관리</span></a></p>
					<dl class="clearfix">
						<dt>계약금</dt>
						<dd><span>0원</span></dd>
					</dl>
					<dl class="clearfix">
						<dt>입금액</dt>
						<dd><span class="point-color-r">0원</span></dd>
					</dl>
				</div>
			</div>

			<table class="talbe-view top-line">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>고객명</th>
						<td>${info.cust_nm }</td>
						<th>최초등록일</th>
						<td>${info.resist_dt }</td>
					</tr>
					<tr>
						<th>지역</th>
						<td>${info.sido_code_nm} ${info.gugun_code_nm } </td>
						<th>연락처</th>
						<td>${info.phone }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${info.sido_code_nm} ${info.gugun_code_nm } ${info.address}</td>
					</tr>
					<tr>
						<th>가족수</th>
						<td>${info.fmly_cnt } 명 </td>
						<th>면적 / 거주형태</th>
						<td> ${info.house_space } / ${info.live_prt } </td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3" class="padding-cell">${info.bigo}</td>
					</tr>
					<tr>
						<th class="bg-customer">서비스 고객명</th>
						<td colspan="3">
							<input type="text" id="srvc_cust_nm" name="srvc_cust_nm" value="${info.cust_nm }" style="width:80px" />
						</td>
					</tr>
					<tr>
						<th class="bg-customer">서비스 지역</th>
						<td>
							<select class="formSelect" id="srvc_sido_code" name="srvc_sido_code" style="width:100px;" onchange="get_gugun()">
								<option value="">시도</option>
								<c:set var="si" value="${info.sido_code}" />
								<c:forEach items="${s_list}" var="s">
									<option value="${s.sido_code}" <c:if test="${si eq s.sido_code}">selected="selected"</c:if> >${s.sido_code_nm}</option>
								</c:forEach>
							</select> 
							<div id="gugun_div"  style="display:inline;">
								<select class="formSelect" style="width:100px;" id="srvc_gugun_code" name="srvc_gugun_code">
									<option value="">구군</option>
								</select>
							</div>
						</td>
						<th class="bg-customer">연락처</th>
						<td>
							<select class="formSelect" style="width:60px" id="ph1" name="ph1">
								<option value="010" <c:if test="${info.ph1 eq '010'}">selected="selected"</c:if>>010</option>
								<option value="011" <c:if test="${info.ph1 eq '011'}">selected="selected"</c:if>>011</option>
								<option value="016" <c:if test="${info.ph1 eq '016'}">selected="selected"</c:if>>016</option>
								<option value="017" <c:if test="${info.ph1 eq '017'}">selected="selected"</c:if>>017</option>
								<option value="018" <c:if test="${info.ph1 eq '018'}">selected="selected"</c:if>>018</option>
								<option value="019" <c:if test="${info.ph1 eq '019'}">selected="selected"</c:if>>019</option>
							</select>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph2" name="ph2" value="${info.ph2 }" style="width:40px;min-width:40px" maxlength="4"/>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph3" name="ph3" value="${info.ph3 }" style="width:40px;min-width:40px" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th class="bg-customer">서비스 주소 (나머지)</th>
						<td colspan="3">
							<input type="text" id="srvc_address" name="srvc_address" value="${info.address }" placeholder="" style="width:94%" />
						</td>
					</tr>
					<tr>
						<th class="bg-branch">접수지점</th>
						<td>
							${srch.branch_name}
							<input type="hidden" id="cnsl_branch_code" name="cnsl_branch_code" value="${srch.branch_code }" />
							<%-- <select class="formSelect" style="width:100px" title="" id="cnsl_branch_code" name="cnsl_branch_code" >
								<c:set var="br" value="${info.branch_code}" />
								<c:forEach items="${b_list}" var="b">
									<option value="${b.branch_code}" <c:if test="${br eq b.branch_code}">selected="selected"</c:if> >${b.branch_name}</option>
								</c:forEach>
							</select> --%>
						</td>
						<th class="bg-branch">견적일</th>
						<td>
							<span class="set-date">
								<input type="text" id="estm_dt" name="estm_dt" value="" style="width:65px;" />
								<span class="btn-calendar"><a href="#a"><img src="image/btn_calendar_input.gif" alt="견적일 선택" /></a></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
					</tr>
					<tr>
						<th class="bg-branch">서비스명</th>
						<td>
							<select class="formSelect" style="width:100px" title="" id="srvc_prt_code" name="srvc_prt_code">
								<option value="B100" selected="selected">전체</option>
								<option value="B200">옷장</option>
								<option value="B300">주방</option>
								<option value="B400">냉장고</option>
								<option value="B500">컨설팅코칭</option>
								<option value="B600">자녀방</option>
							</select>
						</td>
						<th class="bg-branch">제휴업체</th>
						<td>
							<select class="formSelect" style="width:100px" title="">
								<option value="" selected="selected">선택</option>
								<c:forEach items="${a_list}" var="a">
									<option value="${a.allc_comp_no}">${a.allc_comp_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th class="bg-branch">상담일</th>
						<td>
							<span class="set-date">
								<input type="text" id="cnsl_dt" name="cnsl_dt" value=""  style="width:65px;" />
								<span class="btn-calendar"><a href="#a"><img src="image/btn_calendar_input.gif" alt="상담일 선택" /></a></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
						<th class="bg-branch">접수유형</th>
						<td>
							<select class="formSelect" style="width:100px" title="" id="rcv_type" name="rcv_type">
								<option value="" selected="selected">선택</option>
								<option value="인터넷">인터넷</option>
								<option value="전화">전화</option>
								<option value="소개">소개</option>
							</select>
						</td>
						<%-- <th class="bg-branch">견적토스</th>
						<td>
							<select class="formSelect" style="width:100px" title="" id="estm_branch_code" name="estm_branch_code">
								<option value="" selected="selected">선택</option>
								<c:forEach items="${b_list}" var="b">
									<option value="${b.branch_code}" >${b.branch_name}</option>
								</c:forEach>
							</select>
						</td> --%>
					</tr>
					<tr>
						<th class="bg-branch">상담내용</th>
						<td colspan="3" class="padding-cell">
							<textarea id="estm_bigo" name="estm_bigo" style="width:95%"></textarea>
						</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">
				<a href="javascript:history.back()" class="btn-negative abl"><span>취소</span></a>
				<a href="javascript:arrg_save()"><span>저장</span></a>
				<a href="javascript:arrg_next()" class="abr"><span>다음</span></a>
			</div><!--// btn-block -->		
			

		</div><!--// contents -->
		</form>
		
	</div><!--// container -->
</div>

<div id="regSchedule" class="layer-warp">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>입금관리</h2>
			<div class="btn-close"><a href="#a"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>

		<div class="layer-content">

			<div class="btn-block">				
				<a href="#a" id="btn-add"><span>+ 추가하기</span></a>
			</div><!--// btn-block -->

			<div id="input-block">
				<table>
					<colgroup>
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
					</colgroup>
					<tbody>
						<tr>
							<th>일자</th>
							<td>
								<span class="set-date">
									<input type="text" id="" name="" value="견적일" placeholder="견적일" style="width:65px;" />
									<span class="btn-calendar"><a href="#a"><img src="image/btn_calendar_input.gif" alt="견적일 선택" /></a></span><!-- 달력 선택 버튼 -->
								</span>
							</td>
							<th>금액</th>
							<td><input type="text" id="" name="" value="" placeholder="" style="width:80px;text-align:right" /> \</td>
							<td>
								<span class="btn-table green"><a href="#a"><span>저장</span></a></span>
								<span class="btn-table"><a href="#a" id="btn-cancle"><span>취소</span></a></span>
							</td>
						</tr>
					<tbody>					
				</table>
			</div>

			<div id="scroll-block">	
				<table>
					<colgroup>
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
					</colgroup>
					<tbody>
						<tr>
							<th>일자</th>
							<td><a href="#a" class="attach-file">2015-04-09</a></td>
							<th>금액</th>
							<td>50,000 \</td>
							<td><span class="btn-table red"><a href="#a"><span>삭제</span></a></span></td>
						</tr>
						<tr>
							<th>일자</th>
							<td><a href="#a" class="attach-file">2015-04-09</a></td>
							<th>금액</th>
							<td>50,000 \</td>
							<td><span class="btn-table red"><a href="#a"><span>삭제</span></a></span></td>
						</tr>
						<tr>
							<th>일자</th>
							<td><a href="#a" class="attach-file">2015-04-09</a></td>
							<th>금액</th>
							<td>50,000 \</td>
							<td><span class="btn-table red"><a href="#a"><span>삭제</span></a></span></td>
						</tr>
						<tr>
							<th>일자</th>
							<td><a href="#a" class="attach-file">2015-04-09</a></td>
							<th>금액</th>
							<td>50,000 \</td>
							<td><span class="btn-table red"><a href="#a"><span>삭제</span></a></span></td>
						</tr>
						<tr>
							<th>일자</th>
							<td><a href="#a" class="attach-file">2015-04-09</a></td>
							<th>금액</th>
							<td>50,000 \</td>
							<td><span class="btn-table red"><a href="#a"><span>삭제</span></a></span></td>
						</tr>
						<tr>
							<th>일자</th>
							<td><a href="#a" class="attach-file">2015-04-09</a></td>
							<th>금액</th>
							<td>50,000 \</td>
							<td><span class="btn-table red"><a href="#a"><span>삭제</span></a></span></td>
						</tr>
					<tbody>					
				</table>
			</div>

			<div class="btn-block">
				<a href="#a" class="btn-negative"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->
	</div><!--// layer-inner -->

</div><!--// layer-pop -->


</body>
</html>