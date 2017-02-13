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
				$("#btn_home_close", $dialog).one("click", function(event) {
					$('#srch_sido').val('');
					$('#srch_gugun').val('');
					$('#srch_home_mngr').val('');
					$('#srch_ph').val('');
					document.getElementById("div_home").innerHTML="";
					$dialog.hide()
						.prev("div.dim-warp").remove();
				});
				$("#btn_home_xclose", $dialog).one("click", function(event) {
					$('#srch_sido').val('');
					$('#srch_gugun').val('');
					$('#srch_home_mngr').val('');
					$('#srch_ph').val('');
					document.getElementById("div_home").innerHTML="";
					$dialog.hide()
						.prev("div.dim-warp").remove();
				});
				
			}
	
			function dialogInitPos($dialog) {
				var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
					top = Math.floor(($(window).height() - $dialog.height()) / 2);
				$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
			}
			
			
	
			$("#btn_home_add").click(function(event) {
				showModalDialog($("#searchHome"));
			});
			/* $("#btn_cllc_add").click(function(event) {
				showModalDialog($("#div_cllc"));
			}); */
			
			
	});
	
	function pick_home_mngr(seq, nm ) {
		$("#m_no").val(seq);
		$("#home_mng").val(nm);
		
		$("#btn_home_close").trigger('click');
	}


	function none() {
	}
	
	function srch_home() {
		
		var si = frm_home.srch_sido.value;
		var gu = frm_home.srch_gugun.value;
		var ho = frm_home.srch_home_mngr.value;
		var ph = frm_home.srch_ph.value;
		
		if(si == "" && gu == "" && ho == "" && ph == "") {
			alert("하나 이상 조건으로 검색해야 합니다.");
			return;
		}
		else {
			
		 $.ajax({ 
			   url: "srch_home_mngr.do", 
			   type: "POST", 
			   data: {"si" : si, "gu" : gu, "ho" : ho, "ph" : ph},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var tmp = msg.split('|');
				   
				   var str = "<table class=\"table-popup full\" style=\"width:650px;margin:0px 20px\"><colgroup><col style=\"width:25%\" /><col style=\"width:25%\" /><col style=\"width:25%\" /><col style=\"width:25%\" /></colgroup><thead><tr><th>가정관리사명</th><th>지역</th><th>연락처</th><th>구분</th></tr></thead></table>";
				   str = str + "<div class=\"table-scroll\" style=\"height:123px\"><table class=\"table-popup full\" style=\"width:650px;margin:0px 20px\"><colgroup><col style=\"width:25%\" /><col style=\"width:25%\" /><col style=\"width:25%\" /><col style=\"width:25%\" /></colgroup><tbody>";
				   if( tmp == null || tmp == "" ) {
					   str = str+"<tr><td colspan=\"4\">검색결과가 없습니다</td></tr>";
				   }
				   else {
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split("`");
	        				str = str+"<tr><td><a href=\"javascript:pick_home_mngr('"+tmp_sub[0]+"','"+tmp_sub[1]+"')\"> "+tmp_sub[1]+"</a></td><td>"+tmp_sub[2]+" "+tmp_sub[3]+"</td><td>"+tmp_sub[5]+"</td><td>"+tmp_sub[4]+"</td></tr>";
					   }
				   }
				   str = str+"</tbody></table></div>";
				   document.getElementById("div_home").innerHTML=str;
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			});
		}
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
				   var tmp = msg.split('|');
				   
				   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:100px;\" title=\"\">";
				   
				   if(msg != null && msg != "") {
				   
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
		    				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
				   }
				   else {
					   str = str+"<option value=\"\">구군</option>";
				   }
				   str = str+"</select>";
				   document.getElementById("srch_gugun_div").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
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
	
	function home_mng_save() {
		
		document.mainform.action = "home_mng_save.do";
		document.mainform.submit();
	}
	
	function cmaComma(obj) {
		var num_check=/^[/,/,0-9]*$/;
	    //var strNum = /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
	    var str = "" + obj.value.replace(/,/gi,''); // 콤마 제거  
	    var regx = new RegExp(/(-?\d+)(\d{3})/);  
	    
	      if (!num_check.test(obj.value)) {
		        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
		        obj.focus();
		        return false;
		    }
	 
	    while(regx.test(str)){  
	    	str = str.replace(regx,"$1,$2");  
	    }  
        obj.value = str; 
	}
	
	function moveUrl(t, l, url ) {
		mainform.top.value=t;
		mainform.left.value=l;
		location.href = url+"?top="+t+"&left="+l;
	}

</script>
</head>
<body>
<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="c_no" name="c_no" value="${info.cust_no }" />
<input type="hidden" id="m_no" name="m_no" />
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp" flush="false" />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp" flush="false" />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">가정관리등록</h2>
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
						<td>${info.resist_dt}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${info.sido_code_nm} ${info.gugun_code_nm } ${info.address }</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td colspan="3">${info.phone}</td>
					</tr>
					<tr>
						<th>지하철역</th>
						<td>${info.subway}</td>
						<th>거주현황</th>
						<td>${info.live_prt}</td>
					</tr>
					<tr>
						<th>가족수</th>
						<td>${info.fmly_cnt}명</td>
						<th>평수</th>
						<td>${info.house_space}</td>
					</tr>
					<tr>
						<th>첫째출생년도</th>
						<td>${info.fst_kid_birth}</td>
						<th>둘째출생년도</th>
						<td>${info.scd_kid_birth}</td>
					</tr>
					<tr>
						<th>상담일</th>
						<td>
							<span class="set-date">
								<input type="text" id="cnsl_dt" name="cnsl_dt" style="width:80px;" />
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="시작일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
						<th>상태</th>
						<td>
							<select class="formSelect" id="home_mng_prt" name="home_mng_prt" style="width:100px;">
								<option value="상담">상담</option>
								<option value="견적">견적</option>
								<option value="계약">계약</option>
								<option value="완료">완료</option>
								<option value="재이용">재이용</option>
							</select> 
						</td>
					</tr>
					<tr>
						<th>서비스</th>
						<td colspan="3">
							<div class="pos-relative" style="display:inline;top:-4px">
								<input type="checkbox" id="home_srvc1" name="home_srvc1" value="Y"/><label for="home_srvc1"><span></span></label>
							</div>
							<div style="display:inline;top:10px;position:relative;margin-right:20px">가사도우미</div>
							<div class="pos-relative" style="display:inline;top:-4px">
								<input type="checkbox" id="home_srvc2" name="home_srvc2" value="Y"/><label for="home_srvc2"><span></span></label>
							</div>
							<div style="display:inline;top:10px;position:relative;margin-right:20px">베이비시터</div>
							<div class="pos-relative" style="display:inline;top:-4px">
								<input type="checkbox" id="home_srvc3" name="home_srvc3" value="Y"/><label for="home_srvc3"><span></span></label>
							</div>
							<div style="display:inline;top:10px;position:relative;margin-right:20px" >입주도우미</div>
							<div class="pos-relative" style="display:inline;top:-4px">
								<input type="checkbox" id="home_srvc4" name="home_srvc4" value="Y"/><label for="home_srvc4"><span></span></label>
							</div>
							<div style="display:inline;top:10px;position:relative;">산후도우미</div>
						</td>
					</tr>
					<tr>
						<th>가정관리사</th>
						<td colspan="3">
							<a href="javascript:none()" id="btn_home_add"><input type="text" id="home_mng" name="home_mng" style="width:150px" readonly="readonly" placeholder="가정관리사 선택"/></a>
						</td>
					</tr>
					<tr>
						<th>시간</th>
						<td><input type="text" id="time" name="time" style="width:100px"/></td>
						<th>이용시간</th>
						<td><input type="text" id="use_tm" name="use_tm" style="width:100px"/></td>
					</tr>
					<tr>
						<th>고객단가</th>
						<td><input type="text" id="cust_unit_cost" name="cust_unit_cost" style="width:100px" onkeyup="cmaComma(this);"/> 원</td>
						<th>고객금</th>
						<td><input type="text" id="cust_amt" name="cust_amt" style="width:100px" onkeyup="cmaComma(this);"/> 원</td>
					</tr>
					<tr>
						<th>작업자단가</th>
						<td><input type="text" id="home_mngr_unit_cost" name="home_mngr_unit_cost" style="width:100px" onkeyup="cmaComma(this);"/> 원</td>
						<th>시터금</th>
						<td><input type="text" id="home_mngr_amt" name="home_mngr_amt" style="width:100px" onkeyup="cmaComma(this);"/> 원</td>
					</tr>
					<tr>
						<th>입금액</th>
						<td><input type="text" id="cllc_amt" name="cllc_amt" style="width:100px" onkeyup="cmaComma(this);"/> 원</td>
						<th>입금일</th>
						<td>
							<span class="set-date">
								<input type="text" id="cllc_dt" name="cllc_dt" style="width:80px;" />
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="입금일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
					</tr>
					<tr>
						<th>송금액</th>
						<td><input type="text" id="tot_remit_amt" name="tot_remit_amt" style="width:100px" onkeyup="cmaComma(this);"/> 원</td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
			
			
			<div class="btn-block">
				<a href="javascript:home_mng_save()"><span>저장</span></a>
				<a href="javascript:history.back()" class="btn-gray"><span>취소</span></a>
			</div><!--// contents -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>
</form>

<form id="frm_home" name="frm_home" action="" method="post">
<div id="searchHome" class="layer-warp">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>가정관리사 검색</h2>
			<div class="btn-close"><a href="javascript:none()" id="btn_home_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
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
						<input type="text" id="srch_home_mngr" name="srch_home_mngr" value="" placeholder="성명" style="width:80px;" />
					</span>
					<span>
						<input type="text" id="srch_ph" name="srch_ph" value="" placeholder="연락처" style="width:80px;" />
					</span>
				</div><!-- // search-row -->
				<div class="btn-block">
					<a href="javascript:srch_home()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->

			<div class="row" id="div_home">
				<table class="table-popup full" style="width:650px;margin:0px 20px">
					<colgroup>
						<col style="width:20%" />
							<col style="width:30%" />
							<col style="width:30%" />
							<col style="width:20%" />
					</colgroup>
					<thead>
						<tr>
							<th>가정관리사명</th>
							<th>지역</th>
							<th>연락처</th>
							<th>구분</th>
						</tr>
					</thead>
				</table>
				<%-- <div class="table-scroll" style="height:123px">
					<table class="table-popup full" style="width:650px;margin:0px 20px">
						<colgroup>
							<col style="width:25%" />
							<col style="width:25%" />
							<col style="width:25%" />
							<col style="width:25%" />
						</colgroup>
						<tbody>
							<tr>
							</tr>
						</tbody>
					</table>
				</div> --%>
			</div>

			<div class="btn-block">
				<a href="javascript:none()" id="btn_home_close" class="btn-negative"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>
<%-- 
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
</form> --%>

</body>
</html>