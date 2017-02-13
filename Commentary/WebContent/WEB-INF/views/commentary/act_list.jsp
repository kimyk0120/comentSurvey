<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.Date" %>

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
<jsp:useBean id="now" class="java.util.Date" />

<script type="text/javascript">


$(function() {
	$('.formSelect').sSelect();
});

	$(document).ready(function() {
		var ym = "<c:out value="${srch.srch_ym}" />";
		$("#srch_ym").val(ym).attr("selected","selected"); 
		
		var sido = "<c:out value="${srch.srch_sido}"/>";
		var gugun = "<c:out value="${srch.srch_gugun}"/>";
		var auth = "<c:out value="${srch.auth_no}"/>";
		var gYn = "<c:out value="${srch.srch_area}"/>";
		$("#gYn").val(gYn);
		
		if(sido != null && sido != '') {
			//$("#srch_sido").val(sd).attr("selected","selected");
			
			if(auth == "1" && gYn == "Y" ) {
				$.ajax({ 
					   url: "srch_gugun.do", 
					   type: "POST", 
					   data: {"s_sido" : sido},
					   dataType:"text",
					   cache: false,
					   success: function(msg){
						   var tmp = msg.split('|');
						   
						   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:150px;\" title=\"\" tabindex=\"2\">";
						   str=str+"<option value=\"\">전체</option>";
						   for(var i = 0; i < tmp.length ; i++) {
							   var tmp_sub = tmp[i].split(",");
		     				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
						   }
						   str = str+"</select>";
						   document.getElementById("gugun_div").innerHTML=str;
						   
						   if(gugun != null && gugun != '') {
							   $("#srch_gugun").val(gugun).attr("selected","selected"); 
						   }
						   $('.formSelect').sSelect();
					   }
					   , error: function (xhr, ajaxOptions, thrownError) {
					      }
					});
			} else if(auth == "2" && gugun != null && gugun != '') {
				$("#srch_gugun").val(gugun).attr("selected","selected"); 
				$('.formSelect').sSelect();
			}
		}
		
		var yn = "<c:out value="${srch.srch_act_yn}"/>";
		
		$('input:radio[name="srch_act_yn"]').filter('[value="${srch.srch_act_yn}"]').attr('checked', true);
		
	});

	
	function go_page(no) {
		mainform.pageNum.value = no;
		document.mainform.target = "_self";
		document.mainform.action = "act_list.do";
		document.mainform.submit();
	}
	
	function srch_act_list() {
		
		var si = $("select[name=srch_sido]").val(); 
		var gu = $("select[name=srch_gugun]").val() 
		if(si == null || si == "") {
			alert("지역(시/도)을 선택해주세요.");
			return;
		} else if ($('#gYn').val() == "Y" && (gu == null || gu == "" )) {
			alert("지역(시/군/구)을 선택해주세요.");
			return;
		} else {
			document.mainform.target = "_self";
			document.mainform.action = "act_list.do";
			document.mainform.submit();
		}
		
	}
	
	/* function checkEnterKey(){
		if(event.keyCode==13){srch_cmmt();}
	} */
	
	function get_gugun() {
		
		var s_sido = $("select[name=srch_sido]").val();
		
		var yn = s_sido.substring(0, 1);
		s_sido = s_sido.substring(1, 2);
		$('#gYn').val(yn);
		
		if(yn == "Y") {
		
			$.ajax({ 
				   url: "srch_gugun.do", 
				   type: "POST", 
				   data: {"s_sido" : s_sido},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:150px;\" title=\"\">";
					   str=str+"<option value=\"\">전체</option>";
					   var tmp = msg.split('|');
					   if(msg != "") {
						   for(var i = 0; i < tmp.length ; i++) {
							   var tmp_sub = tmp[i].split(",");
		        				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   		}
					   }
					   str = str+"</select>";
					   
					   document.getElementById("gugun_div").innerHTML=str;
					   
					   $('.formSelect').sSelect();
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
		}
	}
	
	function act_edit(cno, nm, cnt, tm, plc, vcnt, ccnt, afee, pyn, sido, gugun, gyn) {
		
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
				$('#cmntor_no').val('');
				$('#name').val('');
				$('#work_ym').val('');
				$('#work_dt_cnt').val('');
				$('#work_tm').val('');
				$('#work_place').val('');
				$('#visitor_cnt').val('');
				$('#cmmt_cnt').val('');
				$('#act_fee').val('');
				$('#pay_yn').val('');
				$('#act_sido').val('');
				$('#act_gugun').val('');
				$('#act_gyn').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_act_xclose", $dialog).one("click", function(event) {
				$('#cmntor_no').val('');
				$('#name').val('');
				$('#work_ym').val('');
				$('#work_dt_cnt').val('');
				$('#work_tm').val('');
				$('#work_place').val('');
				$('#visitor_cnt').val('');
				$('#cmmt_cnt').val('');
				$('#act_fee').val('');
				$('#pay_yn').val('');
				$('#act_sido').val('');
				$('#act_gugun').val('');
				$('#act_gyn').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			var ym = $("select[name=srch_ym]").val();
			
			$('#cmntor_no').val(cno);
			$('#name').val(nm);
			$('#work_ym').val(ym);
			$('#work_dt_cnt').val(cnt);
			$('#work_tm').val(tm);
			$('#work_place').val(plc);
			$('#visitor_cnt').val(vcnt);
			$('#cmmt_cnt').val(ccnt);
			$('#act_fee').val(afee);
			$('#act_sido').val(sido);
			$('#act_gugun').val(gugun);
			$('#act_gyn').val(gyn);
			
			$('input:radio[name="pay_yn"]').filter("[value="+pyn+"]").attr('checked', true);
			if(pyn == "" || pyn == null) {
				$('input:radio[name="pay_yn"]').filter("[value=Y]").attr('checked', true);
			}
			
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}
	}
	
	function act_save() {
		
		var wCnt =  $('#work_dt_cnt').val();
		var fee = $('#act_fee').val();
		
		if(wCnt == "" || wCnt == null) {
			alert("활동일수를 입력해주세요.");
			$('#work_dt_cnt').focus();
			return;
		} else if(fee == "" || fee == null) {
			alert("활동비를 입력해주세요.");
			$('#act_fee').focus();
			return;
		} else {
			if(confirm("저장하시겠습니까?")) {
				var wCnt =  $('#work_dt_cnt').val();
				var wTm =  $('#work_tm').val();
				var vCnt =  $('#visitor_cnt').val();
				var cCnt =  $('#cmmt_cnt').val();
				if(vCnt == "" || vCnt == null) $('#visitor_cnt').val('0');
				if(cCnt == "" || cCnt == null) $('#cmmt_cnt').val('0');
				if(wCnt == "" || wCnt == null) $('#work_dt_cnt').val('0');
				if(wTm == "" || wTm == null) $('#work_tm').val('0');
				
				document.frm_act.target = "_self";
				document.frm_act.action = "act_save.do";
				document.frm_act.submit();
			}
		}
	}
	
	function number_filter(str_value){
		return str_value.replace(/[^0-9]/gi, ""); 
	}
</script>

<style type="text/css">

	.search-block .item-block dl:first-child {width:45%;}
	.search-block .item-block dl:last-child {width:52%;}
	input[type="text"] {min-width:25px;}
</style>

</head>
<body>
<div id="wrapper">

	<!-- 접근성 : skip navi -->
	<dl id="skip-navi">
		<dt class="hidden"><strong>바로가기 메뉴</strong></dt>
		<dd><a href="#gnb" class="accessibility">주요메뉴 바로가기</a></dd>
		<dd><a href="#container" class="accessibility">본문 바로가기</a></dd>
	</dl>
	<!-- //skip navi -->
	
<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="c_no" name="c_no"/>
<input type="hidden" id="pageNum" name="pageNum"/>
<input type="hidden" id="gYn" name="gYn"/>
	<jsp:include page="../main/topMenu.jsp"  />
	

	<div id="container" class="colum1"><!-- 왼쪽에 사용자 정보가 없을 경우 클래스 colum1 삽입 -->

		<div class="contents">

			<h2>문화관광해설사 월별 활동 조회 및 등록</h2>

			<div class="shadow-box">

				<div class="search-block" style="height:35px">
					<div class="search-row">
						<span class="txt-symbol">기준년월</span>
								<select class="formSelect" id="srch_ym" name="srch_ym" style="width:100px;margin-left:10px" title="" >
									<c:forEach items="${m_list}" var="m">
										<option value="${m.ym}" <c:if test="${m.ym eq srch.srch_ym}">selected="selected"</c:if>>${m.yymm}</option>
									</c:forEach>
								</select>
					<c:choose>
						<c:when test="${srch.auth_no eq 1}">
							<label for="srch_sido_cd">지역선택</label>
								<select class="formSelect" id="srch_sido" name="srch_sido" style="width:150px;margin-right:7px" title="" onchange="get_gugun()" tabindex="1">
									<option value="">전체</option>
									<c:forEach items="${s_list}" var="s">
										<option value="${s.gugun_yn}${s.sido_cd}" <c:if test="${s.sido_cd eq srch.srch_sido}">selected="selected"</c:if>>${s.sido_cd_nm}</option>
									</c:forEach>
								</select>
							<div id="gugun_div" style="display:inline;">
							</div>
						</c:when>
						<c:when test="${srch.auth_no eq 2 and srch.srch_area eq 'Y'}">
							<label for="srch_sido_cd">${srch.sido_cd_nm}</label>
							<select class="formSelect" id="srch_gugun" name="srch_gugun" style="width:150px;margin-right:7px" title="시군구 선택" >
								<c:forEach items="${g_list}" var="s">
									<option value="${s.gugun_cd}">${s.gugun_cd_nm}</option>
								</c:forEach>
							</select>
						</c:when>
					</c:choose>
					</div>
					<div class="btn-block">
						<a href="javascript:srch_act_list()" class="btn-search4" tabindex="8"><span>검색</span></a>
					</div>
				</div>
				
				<!-- <div class="btn-block text-right mb10">
					<a href="javascript:cmmt_create()" class="btn-blue" tabindex="9"><span>저장</span></a>
				</div> -->
				<table class="talbe-list" style="overflow-y:scroll">
					<colgroup>
						<col style="width:5%" />
						<col style="width:15%" />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:22%" />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:8%" />
					</colgroup>
					<thead>
						<tr>
							<th>NO</th>
							<th>성명 </th>
							<th>활동일수</th>
							<th>활동시간</th>
							<th>활동장소</th>
							<th>방문객수</th>
							<th>해설횟수</th>
							<th>활동비</th>
							<th>지급여부</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="c" varStatus="status">
							<tr onclick="javascript:act_edit('${c.cmntor_no}','${c.name}','${c.work_dt_cnt }','${c.work_tm }','${c.work_place }','${c.visitor_cnt }','${c.cmmt_cnt}','${c.act_fee}','${c.pay_yn}','${c.sido_cd}','${c.gugun_cd}','${c.srch_area}')">
								<td>${c.row_num}</td>
								<td>${c.name} / ${c.eng_name} ${c.eng_name2}</td>
								<td>${c.work_dt_cnt}</td>
								<td>${c.work_tm}</td>
								<td>${c.work_place}</td>
								<td>${c.visitor_cnt}</td>
								<td>${c.cmmt_cnt}</td>
								<td>${c.act_fee}</td>
								<td>${c.pay_yn}</td>
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
					   		<li><a class="no-bg" href="javascript:go_page('1')" tabindex="22">&lt;&lt;</a></li>
					   		<li><a class="no-bg" href="javascript:go_page('${(numPageGroup-2)*pageGroupSize+1 }')" tabindex="23">&lt;</a></li>
					   </c:if>
					
					   <c:forEach var="i" begin="${startPage}" end="${endPage}" varStatus="status">
					       <li>
					           <c:choose>
					               <c:when test="${currentPage == i}">
					               		<a href="javascript:go_page('${i}')" class="no-bg on" tabindex="${status.index+31}">${i}</a>
					               </c:when>
					               <c:otherwise>
							       		<a href="javascript:go_page('${i}')" class="no-bg" tabindex="${status.index+31}">${i}</a>
					               </c:otherwise>
							   </c:choose>    		
					       </li>
					   </c:forEach>
					   <c:if test="${numPageGroup < pageGroupCount}">
					   		<li><a class="no-bg" href="javascript:go_page('${numPageGroup*pageGroupSize+1}')" tabindex="41">&gt;</a></li>
					   		<li><a class="no-bg" href="javascript:go_page('<fmt:formatNumber value="${count/pageSize+1}" type="number" maxFractionDigits="0"/>')" tabindex="42">&gt;&gt;</a></li>
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
<input type="hidden" id="cmntor_no" name="cmntor_no" />
<input type="hidden" id="pageNum" name="pageNum" value="${srch.pageNum}"/>
<input type="hidden" id="srch_ym" name="srch_ym" value="${srch.srch_ym}"/>
<input type="hidden" id="act_sido" name="act_sido" />
<input type="hidden" id="act_gugun" name="act_gugun" />
<input type="hidden" id="act_gyn" name="act_gyn"/>
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
					<tr>
						<th>년월</th>
						<td><input type="text" id="work_ym" name="work_ym" readonly="readonly"/></td>
						<th>해설사</th>
						<td><input type="text" id="name" name="name" readonly="readonly"/></td>
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
					<tr>
						<th>활동비</th>
						<td><input type="text" id="act_fee" name="act_fee" title="방문객수" placeholder="숫자만 입력하세요" class="row-input" onkeyup="this.value=number_filter(this.value);"/></td>
						<th>지급여부</th>
						<td>
							<div class="pos-relative" style="display:inline"><input type="radio" name="pay_yn" id="rd11" value="Y" /><label for="rd11">지급</label></div>
							<div class="pos-relative" style="display:inline"><input type="radio" name="pay_yn" id="rd12" value="N" /><label for="rd12">미지급</label></div>
						</td>
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