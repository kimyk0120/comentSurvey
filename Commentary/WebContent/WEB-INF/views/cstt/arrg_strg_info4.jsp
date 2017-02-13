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
			
			$("#btn_cllt_close", $dialog).one("click", function(event) {
				$('#cllt_dt').val('');
				$('#cllt_amt').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
				
				cllt_reload();
			});
			$("#btn_cllt_xclose", $dialog).one("click", function(event) {
				$('#cllt_dt').val('');
				$('#cllt_amt').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
				
				cllt_reload();
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
		
		var saveYn = "<c:out value="${save_yn}"/>";
		if(saveYn == "y") {
			alert("저장되었습니다.");
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
	      
		$( '#as_appl_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		$( '#as_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		$( '#give_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		$( '#cllt_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
	    
	});
	
	function go_list() {
		
		document.mainform.target = "_self";
		document.mainform.action = "arrg_strg_list.do";
		document.mainform.submit();
	}
	
	function arrg_finish() {
		
		$('#finish_yn').val('Y');
		
		var cstt = $( "#cstt_no" ).val();
		
		if(cstt != "") $("#as_cstt_no").val(cstt);
		
		document.mainform.target = "_self";
		document.mainform.action = "arrg_strg_update4.do";
		document.mainform.submit();
	}
	
	function cmaComma(obj) {
		var strNum = /^[/,/,0-9]*$/;
		var str = "" + obj.value.replace(/,/gi,''); // 콤마 제거  
	    var regx = new RegExp(/(-?\d+)(\d{3})/);  
		
		if (!strNum.test(obj.value)) {
	        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
	        obj.focus();
	        return false;
	    }

		while(regx.test(str)){  
	        str = str.replace(regx,"$1,$2");  
	    }  
        obj.value = str;
	}
	
	function none() {
	}
	
	function arrg_strg_edit(seq) {
		mainform.step_move.value="4";
		document.mainform.target = "_self";
		document.mainform.action = "arrg_strg_info.do";
		document.mainform.submit();
	}
	
	function cllt_save() {
		
		var dt = frm_cllt.cllt_dt.value;
		var amt = frm_cllt.cllt_amt.value;
		var arrg_no = mainform.arrg_no.value;
		amt = amt.replace(/,/gi,'');
		
		if(dt == "" || amt == "") {
			alert("일자 / 금액을 모두 입력하셔야 합니다.");
			return;
		}
		else {
			$.ajax({ 
				   url: "cllt_save.do", 
				   type: "POST",
				   data: {"cllt_dt" : dt, "cllt_amt" : amt, "arrg_no" : arrg_no},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "";
					   str = str+ "<table class=\"talbe-inner\"><colgroup><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /></colgroup><tbody>";
						
					   if( tmp == null || tmp == "" ) {
						   str = str+"<tr><td colspan=\"5\">입금결과가 없습니다</td></tr>";
					   }
					   else {
						   for(var i = 0; i < tmp.length ; i++) {
							   var tmp_sub = tmp[i].split("`");
							   
		        				str = str+"<tr><th>일자</th><td>"+tmp_sub[3]+"</td><th>금액</th><td>"+tmp_sub[2]+" \\</td>";
		        				str = str+"<td><span class=\"btn-table red\"><a href=\"javascript:cllt_del('"+tmp_sub[1]+"')\"><span>삭제</span></a></span></td>";
						   }
					   }
					   str = str+"</tbody></table>";		
					   document.getElementById("scroll-block").innerHTML=str;
						
					   $('#cllt_amt').val('');
						$('#cllt_dt').val('');
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
					   alert("status : " + xhr.status);
				       alert("err: " +thrownError);
				   }
			});
		}
	}
	
	function cllt_del(seq) {
		
		var arrg_no = mainform.arrg_no.value;
		
		if(confirm("삭제하시겠습니까?")) {
			$.ajax({ 
				   url: "cllt_del.do", 
				   type: "POST",
				   data: {"arrg_no" : arrg_no, "cllt_seq" : seq},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "";
					   str = str+ "<table class=\"talbe-inner\"><colgroup><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /></colgroup><tbody>";
						
					   if( tmp == null || tmp == "" ) {
						   str = str+"<tr><td colspan=\"5\">입금결과가 없습니다</td></tr>";
					   }
					   else {
						   for(var i = 0; i < tmp.length ; i++) {
							   var tmp_sub = tmp[i].split("`");
							   
		        				str = str+"<tr><th>일자</th><td>"+tmp_sub[3]+"</td><th>금액</th><td>"+tmp_sub[2]+" \\</td>";
		        				str = str+"<td><span class=\"btn-table red\"><a href=\"javascript:cllt_del('"+tmp_sub[1]+"')\"><span>삭제</span></a></span></td>";
						   }
					   }
					   str = str+"</tbody></table>";		
					   document.getElementById("scroll-block").innerHTML=str;
						
					   $('#cllt_amt').val('');
						$('#cllt_dt').val('');
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
					   alert("status : " + xhr.status);
				       alert("err: " +thrownError);
				   }
			});
		}
	}
	
	function cllt_reload() {
		
		var arrg_no = mainform.arrg_no.value;
		
		$.ajax({ 
			   url: "cllt_reload.do", 
			   type: "POST",
			   data: {"arrg_no" : arrg_no},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var str = "";
				   str  = str + "<span class=\"point-color-r\">"+msg+"원</span>";
				   document.getElementById("div_camt").innerHTML=str;
				   
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
				   alert("status : " + xhr.status);
			       alert("err: " +thrownError);
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
<input type="hidden" id="arrg_no" name="arrg_no" value="${info.arrg_strg_no }"/>
<input type="hidden" id="c_no" name="c_no" value="${info.cust_no }"/>
<input type="hidden" id="srvc_phone" name="srvc_phone"/>
<input type="hidden" id="arrg_step" name="arrg_step" value="4"/>
<input type="hidden" id="finish_yn" name="finish_yn" value="N"/>
<input type="hidden" id="arrg_strg_st_cd" name="arrg_strg_st_cd" value="${info.arrg_strg_st_cd }"/>
<input type="hidden" id="step_move" name="step_move"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

		<div class="contents">

			<div class="contents-top">
				<h2>정리수납상세</h2>
			</div>

			<div class="top-info">
				<div class="process">
					<ul>
						<li><span><span>접수</span></span></li><!-- 해당 단계에 클래스 on 추가 -->
						<li class="text-center"><span><span>견적</span></span></li>
						<li class="text-center"><span><span>계약</span></span></li>
						<li class="text-right"><span class="on"><span>작업</span></span></li>
					</ul>
				</div>
				<div class="breif-info">
					<p><a href="javascript:none()" id="btn-popup"><span>입금관리</span></a></p>
					<dl class="clearfix">
						<dt>계약금</dt>
						<dd><span><fmt:formatNumber value="${info.tot_work_amt}" />원</span></dd>
					</dl>
					<dl class="clearfix">
						<dt>입금액</dt>
						<dd><div id="div_camt"><span class="point-color-r"><fmt:formatNumber value="${info.cllt_amt }"/>원</span></div></dd>
					</dl>
				</div>
			</div>
<% pageContext.setAttribute("newLineChar", "\n"); %>
			<table class="talbe-view top-line">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>서비스고객명</th>
						<td>${info.srvc_cust_nm }</td>
						<th>연락처</th>
						<td>${info.srvc_phone}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${info.srvc_sido_code_nm} ${info.srvc_gugun_code_nm } ${info.srvc_address}</td>
					</tr>
					<tr>
						<th>서비스명</th>
						<td>${info.srvc_prt_code_nm } </td>
						<th>접수일</th>
						<td> ${info.cnsl_dt}</td>
					</tr>
					</tbody>
			</table>
			<table class="talbe-view top-line">
				<colgroup>
					<col style="width:10%" />
					<col style="width:25%" />
					<col style="width:10%" />
					<col style="width:20%" />
					<col style="width:10%" />
					<col style="width:25%" />
				</colgroup>
				<tbody>
					<tr>
						<th rowspan="3" class="bg-customer">견적금액</th>
						<td rowspan="3" ><fmt:formatNumber value="${info.estm_amt}" />원</td>
						<th class="bg-customer">견적CBM</th>
						<td>${info.cbm}</td>
						<th rowspan="3" class="bg-customer">견적 내역</th>
						<td rowspan="3" class="padding-cell">
							<div style="width:100%;height:90px;overflow:auto">${fn:replace(info.estm_cntn, newLineChar, "<br/> ")}</div>
						</td>
					</tr>
					<tr>
						<th class="bg-customer">작업예상시간</th>
						<td>${info.work_expc_time} 시간</td>
					</tr>
					<tr>
						<th class="bg-customer">작업인원</th>
						<td>${info.worker_cnt} 명</td>
					</tr>
				</tbody>
			</table>
			<table class="talbe-view top-line">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th class="bg-customer">옵션금액</th>
						<td><fmt:formatNumber value="${info.option_amt}" />원</td>
						<th class="bg-customer">옵션내역</th>
						<td class="padding-cell">
							<div style="width:100%;height:50px;overflow:auto">${fn:replace(info.option_cntn, newLineChar, "<br/> ")}</div>
						</td>
					</tr>
					<tr>
						<th class="bg-customer">견적총금액</th>
						<td colspan="3"><fmt:formatNumber value="${info.tot_work_amt}" />원</td>
					</tr>
					<tr>
						<th class="bg-branch">계약일</th>
						<td>${info.ctrt_dt }</td>
						<th class="bg-branch">계약취소</th>
						<td>
							<c:choose>
								<c:when test="${info.ctrt_cancel_yn eq 'N'}">계약</c:when>
								<c:when test="${info.ctrt_cancel_yn eq 'Y'}">계약취소</c:when>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th class="bg-branch">선급금</th>
						<td><fmt:formatNumber value="${info.prepaid}" />원</td>
						<th class="bg-branch">선급지급일</th>
						<td>${info.prepaid_dt }</td>
					</tr>
					<tr>
						<th class="bg-branch">작업시작일</th>
						<td>${info.work_start_dt }</td>
						<th class="bg-branch">작업종료일</th>
						<td>${info.work_end_dt }</td>
					</tr>
					<tr>
						<th class="bg-branch">시작시간 </th>
						<td>${info.start_time}</td>
						<th class="bg-branch">종료시간</th>
						<td>${info.end_time}</td>
					</tr>
					<tr>
						<th class="bg-branch">작업지점</th>
						<td>${info.work_branch_name}</td>
					</tr>
				</tbody>
				</table>
				<dl class="table-dl"><!-- 개인 정보와 떨어져 있는 처음 dl 에만 mt35 삽입 -->
					<dt>
						작업자
					</dt>
					<dd>
						<div id ="div_w_list">
						<table class="talbe-inner">
							<colgroup>
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:20%" />
							</colgroup>
							<thead>
								<tr>
									<th>성명</th>
									<th>구성</th>
									<th>작업비</th>
									<th>지급액</th>
									<th>지급일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${w_list}" var="w" varStatus="status">
									<tr>
										<td><a href="javascript:worker_info('${w.cstt_no}','${w.cstt_name}','${w.role_prt_code}','${w.work_exps}','${w.fee}','${w.give_amt}','${w.give_dt}','${w.bigo}')">${w.cstt_name}</a></td>
										<td>${w.role_prt_code}</td>
										<td>${w.work_exps}</td>
										<td>${w.give_amt}</td>
										<td>${w.give_dt}</td>
									</tr>
								</c:forEach>
								<c:if test="${fn:length(w_list) == 0 }">
									<tr>
										<td colspan="4">등록된 작업자가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
						</div>
					</dd>
				</dl>
				<table class="talbe-view top-line">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th class="bg-customer">A/S신청일</th>
						<td>${info.as_appl_dt }</td>
						<th class="bg-customer">A/S일자</th>
						<td>${info.as_dt }</td>
					</tr>
					<tr>
						<th class="bg-customer">A/S비용</th>
						<td><fmt:formatNumber value="${info.as_amt}" />원</td>
						<th class="bg-customer">A/S처리자</th>
						<td><span style="font-weight:bold;color:#555;margin-right:5px">${info.as_cstt_name}</span></td>
					</tr>
					<tr>
						<th class="bg-customer">A/S처리내역</th>
						<td colspan="3" class="padding-cell">
							<div style="width:100%;height:90px;overflow:auto">${fn:replace(info.as_cntn, newLineChar, "<br/> ")}</div>
						</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">
				<a href="javascript:arrg_strg_edit()" class="btn-negative abl"><span>수정</span></a>
				<a href="javascript:go_list()" class="abr"><span>리스트</span></a>
			</div><!--// btn-block -->		
			

		</div><!--// contents -->
		</form>
		
	</div><!--// container -->
</div>

<form id="frm_cllt" name="frm_cllt" action="" method="post">
<div id="regSchedule" class="layer-warp">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>입금관리</h2>
			<div class="btn-close"><a href="javascript:none()" id="btn_cllt_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>

		<div class="layer-content">

			<div class="btn-block">				
				<a id="btn-add"><span>+ 추가하기</span></a>
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
							<th>입금일자</th>
							<td>
								<span class="set-date">
									<input type="text" id="cllt_dt" name="cllt_dt" style="width:80px;" />
									<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="견적일 선택" /></span><!-- 달력 선택 버튼 -->
								</span>
							</td>
							<th>금액</th>
							<td><input type="text" id="cllt_amt" name="cllt_amt" style="width:80px;text-align:right" onkeyup="cmaComma(this);"/> 원</td>
							<td>
								<span class="btn-table green"><a href="javascript:cllt_save()"><span>저장</span></a></span>
								<span class="btn-table"><a href="#a" id="btn-cancle"><span>취소</span></a></span>
							</td>
						</tr>
					</tbody>					
				</table>
			</div>

			<div id="scroll-block">	
				<table class="talbe-inner">
					<colgroup>
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
					</colgroup>
					<tbody>
						<c:forEach items="${c_list}" var="c">
							<tr>
								<th>일자</th>
								<td>${c.cllt_dt}</td>
								<th>금액</th>
								<td>
									<fmt:formatNumber value="${c.cllt_amt}" /> 원
								</td>
								<td>
									<c:choose>
										<c:when test="${c.cllt_seq eq 0 }">
											<span style="font-weight:bold;color:#00bcae">선급금</span>
										</c:when>
										<c:otherwise>
											<span class="btn-table red"><a href="javascript:cllt_del('${c.cllt_seq }')"><span>삭제</span></a></span>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>					
				</table>
			</div>

			<div class="btn-block">
				<a href="javascript:none()" class="btn-negative" id="btn_cllt_close"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->
	</div><!--// layer-inner -->

</div><!--// layer-pop -->
</form>


</body>
</html>