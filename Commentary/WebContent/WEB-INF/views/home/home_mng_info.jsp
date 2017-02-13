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
<title>가정관리 등록</title>
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
		
		/* $("#cnsl_dt").datepicker({
	    });
	    $("#cllc_dt").datepicker({
	    }); */
	
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
	
				/* $("div.btn-close > a", $dialog).one("click", function(event) {
					$dialog.hide()
						.prev("div.dim-warp").remove();
				}); */
				$("#btn_cllc_close", $dialog).one("click", function(event) {
					$('#cllc_dt').val('');
					$('#cllc_amt').val('');
					$dialog.hide()
						.prev("div.dim-warp").remove();
				});
				$("#btn_cllc_xclose", $dialog).one("click", function(event) {
					$('#cllc_dt').val('');
					$('#cllc_amt').val('');
					$dialog.hide()
						.prev("div.dim-warp").remove();
				});
				
			}
	
			function dialogInitPos($dialog) {
				var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
					top = Math.floor(($(window).height() - $dialog.height()) / 2);
				$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
			}
			
			$("#btn_cllc_add").click(function(event) {
				showModalDialog($("#regSchedule"));
			});
			
			$("#btn-add").click(function(event) {
				$("#input-block").show();
			});
			$("#btn-cancle").click(function(event) {
				$("#input-block").hide();
			});
			
			
	});

	function none() {
	}
	
	$(document).ready(function() {
	//	var f_b = "<c:out value="${info.fst_kid_birth}"/>";
	//	var s_b = "<c:out value="${info.scd_kid_birth}"/>";
	
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
		
		$( '#cnsl_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd",//날짜 출력 형식
			/* onClose: function( selectedDate ) {
				$( '#endDate' ).datepicker( 'option', 'minDate', selectedDate );
			} */
		});
		$( '#cllc_dt' ).datepicker({
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			changeYear:true, //년 셀렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd",//날짜 출력 형식
			/* onClose: function( selectedDate ) {
				$( '#fromDate' ).datepicker( 'option', 'maxDate', selectedDate );
			} */
		});
		
	});
	
	function home_mng_edit() {
		document.mainform.action = "home_mng_edit.do";
		document.mainform.submit();
	}
	
	function go_list() {
		document.mainform.action = "home_mng_list.do";
		document.mainform.submit();
	}
	
	function moveUrl(t, l, url ) {
		mainform.top.value=t;
		mainform.left.value=l;
		location.href = url+"?top="+t+"&left="+l;
		//document.mainform.action = url;
		//document.mainform.submit();
	}
	
	function cllc_save() {
		
		var dt = frm_cllc.cllc_dt.value;
		var amt = frm_cllc.cllc_amt.value;
		var h_no = mainform.h_no.value;
		amt = amt.replace(/,/gi,'');
		
		if(dt == "" || amt == "") {
			alert("일자 / 금액을 모두 입력하셔야 합니다.");
			return;
		}
		else {
			$.ajax({ 
				   url: "home_mng_cllc_save.do", 
				   type: "POST",
				   data: {"cllc_dt" : dt, "cllc_amt" : amt, "h_no" : h_no},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tp = msg.split('~');
					   var t1 = tp[0];
					   alert("t1 : " + t1);
					   var st = "<span class=\"point-color-r\">"+t1+"\\\</span>";
						document.getElementById("div_camt").innerHTML=st;
					   
					   var tmp = tp[1].split('|');
					   
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
						
					    $('#cllc_amt').val('');
					    $('#cllc_dt').val('');
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
					   alert("status : " + xhr.status);
				       alert("err: " +thrownError);
				   }
			});
		}
	}
	
	function cllc_del(seq) {
		
		var h_no = mainform.h_no.value;
		
		if(confirm("삭제하시겠습니까?")) {
			$.ajax({ 
				   url: "home_mng_cllc_del.do", 
				   type: "POST",
				   data: {"h_no" : h_no, "cllc_seq" : seq},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tp = msg.split('~');
					   var t1 = tp[0];
					   var st = "<span class=\"point-color-r\">"+t1+"\\\</span>";
						document.getElementById("div_camt").innerHTML=st;
					   
					   var tmp = tp[1].split('|');
					   
					   var str = "";
					   str = str+ "<table class=\"talbe-inner\"><colgroup><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /></colgroup><tbody>";
						
					   if( tmp == null || tmp == "" ) {
						   str = str+"<tr><td colspan=\"5\">입금결과가 없습니다</td></tr>";
					   }
					   else {
						   for(var i = 0; i < tmp.length ; i++) {
							   var tmp_sub = tmp[i].split("`");
							   
		        				str = str+"<tr><th>일자</th><td>"+tmp_sub[3]+"</td><th>금액</th><td>"+tmp_sub[2]+" \\</td>";
		        				str = str+"<td><span class=\"btn-table red\"><a href=\"javascript:cllc_del('"+tmp_sub[1]+"')\"><span>삭제</span></a></span></td>";
						   }
					   }
					   str = str+"</tbody></table>";		
					   document.getElementById("scroll-block").innerHTML=str;
						
					   $('#cllc_amt').val('');
						$('#cllc_dt').val('');
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
					   alert("status : " + xhr.status);
				       alert("err: " +thrownError);
				   }
			});
		}
	}
	
	function cmaComma(obj) {
	    var strNum = /^[/,/,0-9]*$/; // 숫자와 , 만 가능
	    var str = "" + obj.value.replace(/,/gi,''); // 콤마 제거  
	    var regx = new RegExp(/(-?\d+)(\d{3})/);  
	    
        if (!strNum.test(obj.value)) {
	        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
	        /* obj.value = 1; */
	        obj.focus();
	        return false;
	    }
		 
	    while(regx.test(str)){  
	    	str = str.replace(regx,"$1,$2");  
	    }  
        obj.value = str; 
	}
	
</script>
</head>
<body>
<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="c_no" name="c_no" value="${info.cust_no }" />
<input type="hidden" id="h_no" name="h_no" value="${info.home_mng_no }" />
<input type="hidden" id="srch_prt" name="srch_prt" value="${srch.srch_prt }" />
<input type="hidden" id="srch_cust" name="srch_cust" value="${srch.srch_cust }" />
<input type="hidden" id="srch_home_mngr" name="srch_home_mngr" value="${srch.srch_home_mngr }" />
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }" />
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }" />
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp" flush="false" />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp" flush="false" />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">가정관리상세</h2>
				<h3 class="mb0">${info.cust_nm} 고객</h3>
			</div>

			<table class="talbe-view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>고객명</th>
						<td>${info.cust_nm}</td>
						<th>최초등록일</th>
						<td>${c_info.resist_dt}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${c_info.sido_code_nm} ${c_info.gugun_code_nm } ${c_info.address }</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td colspan="3">${c_info.phone}</td>
					</tr>
					<tr>
						<th>지하철역</th>
						<td>${c_info.subway}</td>
						<th>거주현황</th>
						<td>${c_info.live_prt}</td>
					</tr>
					<tr>
						<th>가족수</th>
						<td>${c_info.fmly_cnt}명</td>
						<th>평수</th>
						<td>${c_info.house_space}</td>
					</tr>
					<tr>
						<th>첫째출생년도</th>
						<td>${c_info.fst_kid_birth}</td>
						<th>둘째출생년도</th>
						<td>${c_info.scd_kid_birth}</td>
					</tr>
					<tr>
						<th>상담일</th>
						<td>${info.cnsl_dt}</td>
						<th>상태</th>
						<td>${info.home_mng_prt }</td>
					</tr>
					<tr>
						<th>서비스</th>
						<td colspan="3">
							${info.home_mng_srvc_code_nm }
						</td>
					</tr>
					<tr>
						<th>가정관리사</th>
						<td colspan="3">${info.home_mngr_name }</td>
					</tr>
					<tr>
						<th>시간</th>
						<td>${info.time }</td>
						<th>이용시간</th>
						<td>${info.use_tm }</td>
					</tr>
					<tr>
						<th>고객단가</th>
						<td><fmt:formatNumber value="${info.cust_unit_cost}" /> 원</td>
						<th>고객금</th>
						<td><fmt:formatNumber value="${info.cust_amt}" /> 원</td>
					</tr>
					<tr>
						<th>작업자단가</th>
						<td><fmt:formatNumber value="${info.home_mngr_unit_cost}" /> 원</td>
						<th>시터금</th>
						<td><fmt:formatNumber value="${info.home_mngr_amt}" /> 원</td>
					</tr>
					<tr>
						<th>입금액</th>
						<td><div id="div_camt" style="display:inline;"><span class="point-color-r"><fmt:formatNumber value="${info.tot_dpst_amt}" /> 원</span> </div>
							<span class="btn-table"><a href="javascript:none()" id="btn_cllc_add"><span>입금</span></a></span>
						</td>
						<th>송금액</th>
						<td><fmt:formatNumber value="${info.tot_remit_amt}" /> 원</td>
					</tr>
				</tbody>
			</table>
			
			
			<div class="btn-block">
				<a href="javascript:home_mng_edit()" class="btn-negative"><span>수정</span></a>
				<a href="javascript:go_list()"><span>리스트</span></a>
			</div><!--// contents -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>
</form>

<form id="frm_cllc" name="frm_cllc" action="" method="post">
<div id="regSchedule" class="layer-warp">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>입금관리</h2>
			<div class="btn-close"><a href="javascript:none()" id="btn_cllc_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
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
									<input type="text" id="cllc_dt" name="cllc_dt" style="width:65px;" />
									<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="견적일 선택" /></span><!-- 달력 선택 버튼 -->
								</span>
							</td>
							<th>금액</th>
							<td><input type="text" id="cllc_amt" name="cllc_amt" style="width:80px;text-align:right" onkeyup="cmaComma(this);"/> \</td>
							<td>
								<span class="btn-table green"><a href="javascript:cllc_save()"><span>저장</span></a></span>
								<span class="btn-table"><a href="#a" id="btn-cancle"><span>취소</span></a></span>
							</td>
						</tr>
					<tbody>					
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
								<td>${c.cllc_dt}</td>
								<th>금액</th>
								<td>
									<fmt:formatNumber value="${c.cllc_amt}" /> \
								</td>
								<td><span class="btn-table red"><a href="javascript:cllc_del('${c.cllc_seq }')"><span>삭제</span></a></span></td>
							</tr>
						</c:forEach>
					<tbody>					
				</table>
			</div>

			<div class="btn-block">
				<a href="javascript:none()" class="btn-negative" id="btn_cllc_close"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->
	</div><!--// layer-inner -->

</div><!--// layer-pop -->
</form>

</body>
</html>