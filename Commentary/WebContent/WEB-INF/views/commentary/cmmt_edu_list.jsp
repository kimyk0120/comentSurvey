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

<!--[if lt IE 9]>
      <script src="</script'>https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="</script'>https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<script type="text/javascript">

	$(document).ready(function() {
		
		var y = "<c:out value="${now_ym}" />";
		
		if(y.substring(0, 4) != null && y.substring(0, 4) != '') {
			$("#srch_yy").val(y.substring(0, 4)).change(); 
		}
		if(y.substring(5, 7) != null && y.substring(5, 7) != '') {
			$("#srch_mm").val(y.substring(5, 7)).change(); 
		}
		
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

			$("#btn_edu_close", $dialog).one("click", function(event) {
				$('#edu_seq').val('');
				$('#edu_prt').val('');
				$('#yyyy').val('');
				$('#edu_place').val('');
				$('#edu_nm').val('');
				$('#edu_tm').val('');
				$('#cmpl_yn').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_edu_xclose", $dialog).one("click", function(event) {
				$('#edu_seq').val('');
				$('#edu_prt').val('');
				$('#yyyy').val('');
				$('#edu_place').val('');
				$('#edu_nm').val('');
				$('#edu_tm').val('');
				$('#cmpl_yn').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}

		$("#btn_edu_add").click(function(event) {
			showModalDialog($("#layer_edu"));
		});
	});
	
	function cmmt_info() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_info.do";
		document.mainform.submit();
	}
	function cmmt_act_list() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_act_list.do";
		document.mainform.submit();
	}
	function cmmt_fee_list() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_fee_list.do";
		document.mainform.submit();
	}
	
	function edu_save() {
		document.frm_edu.target = "_self";
		document.frm_edu.action = "cmmt_edu_save.do";
		document.frm_edu.submit();
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
		document.mainform.action = "cmmt_edu_list.do";
		document.mainform.submit();
	}
	
	function edu_edit(c_no, seq, prt, yy, place, nm, tm, yn) {
		
		showModalDialog($("#layer_edu"));
			
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

			$("#btn_edu_close", $dialog).one("click", function(event) {
				$('#edu_seq').val('');
				$('#edu_prt').val('');
				$('#yyyy').val('');
				$('#edu_place').val('');
				$('#edu_nm').val('');
				$('#edu_tm').val('');
				$('#edu_cmpl').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_edu_xclose", $dialog).one("click", function(event) {
				$('#edu_seq').val('');
				$('#edu_prt').val('');
				$('#yyyy').val('');
				$('#edu_place').val('');
				$('#edu_nm').val('');
				$('#edu_tm').val('');
				$('#edu_cmpl').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$('#edu_seq').val(seq);
			$('input:radio[name="edu_prt"]').filter("[value="+prt+"]").attr('checked', true);
			$('#yyyy').val(yy);
			$('#edu_place').val(place);
			$('#edu_nm').val(nm);
			$('#edu_tm').val(tm);
			$('input:radio[name="edu_cmpl"]').filter("[value="+yn+"]").attr('checked', true);
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}
	}
	
	/* function showKeyCode(e) {
		//event = event || window.event;
		//var keyID = (event.which) ? event.which : event.keyCode;
		
		if(!window.event && !e) return;
   		var keyCode = window.event ? window.event.keyCode : e.which;
		
   		console.log("keycode : " + keyCode);
   		
		if( ( keyCode >=48 && keyCode <= 57 ) || ( keyCode >=96 && keyCode <= 105 ) || (keyCode == 8) || (keyCode == 9) || (keyCode == 46))
		{
			return;
		}
		else
		{
	   		console.log("keycode2 : " + keyCode);
			// if(window.event) window.event.returnValue = false;
		      // else e.preventDefault();
	   		return false;
		}
	} */
	function number_filter(str_value){
		return str_value.replace(/[^0-9]/gi, ""); 
	}
	
</script>
</head>
<body>
<div id="wrapper">

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="pageNum" name="pageNum"/>
<input type="hidden" id="c_no" name="c_no" value="${srch.cmntor_no }" />
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
								<img src="files/image/${prfl}" class="person" style="max-height:70px;width:inherit" alt="프로필 사진"/>
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
					<a href="#a"><span class="text1">문화관광해설사</span><span class="text2">관 리 시 스 템</span><span class="text3">안내</span></a>
				</div>
			</div><!--// shadow-box -->

		</div><!--// user-info -->

		<div class="contents">
		
			<div class="btn-block text-right mb10">
				<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
				<c:if test="${auth eq 1 or auth eq 2 or auth eq 3}">
					<a href="javascript:cmmt_create()" class="btn-blue" tabindex="1"><span>해설사 신규 등록</span></a>
				</c:if>
				<a href="javascript:cmmt_list()" class="btn-orange" tabindex="2"><span>리스트</span></a>
			</div>

			<ul id="tab" class="clearfix">
				<li><a href="javascript:cmmt_info();" tabindex="3">기본 정보</a></li>
				<li class="on"><a href="javascript:;" tabindex="4">교육 이수 내용</a></li><!-- 선택된 곳에 클래스 on 추가 -->
				<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
				<c:if test="${auth ne 5}">
				<li><a href="javascript:cmmt_act_list();" tabindex="5">활동 정보</a></li>
				<li><a href="javascript:cmmt_fee_list()" tabindex="6">활동비 지급 내역</a></li>
				</c:if>
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
				<c:if test="${auth eq 1 or auth eq 2 or auth eq 3 or auth eq 5}">
					<div class="btn-block text-right">
						<a href="javascript:;" class="btn-blue" id="btn_edu_add" tabindex="7"><span>교육 내역 등록</span></a>
					</div>
				</c:if>

				<table class="talbe-list dark">
					<colgroup>
						<col style="width:15%" />
						<col style="width:15%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:15%" />
						<col style="width:15%" />
					</colgroup>
					<thead>
						<tr>
							<th>교육구분</th>
							<th>시행연도</th>
							<th>교육기관</th>
							<th>교육명</th>
							<th>이수시간</th>
							<th>수료여부</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="c" varStatus="status">
						<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
						<c:set value="${c.edu_prt}" var="prt" />
						<c:choose>
							<c:when test="${auth eq 1 or auth eq 2 or auth eq 3 or (auth eq 5 and prt eq 1)}">
							<tr onclick="javascript:edu_edit('${c.cmntor_no}', '${c.edu_seq}', '${c.edu_prt}','${c.yyyy}','${c.edu_place}','${c.edu_nm }','${c.edu_tm }','${c.edu_cmpl}')">
								<td>
									<a href="javascript:edu_edit('${c.cmntor_no}', '${c.edu_seq}', '${c.edu_prt}','${c.yyyy}','${c.edu_place}','${c.edu_nm }','${c.edu_tm }','${c.edu_cmpl}')" tabindex="${status.index+10 }" >${c.edu_prt_nm}</a>
								</td>
							</c:when>
							<c:otherwise>
							<tr>
								<td>${c.edu_prt_nm}</td>
							</c:otherwise>
						</c:choose>
								<td>${c.yyyy}년도</td>
								<td>${c.edu_place}</td>
								<td>${c.edu_nm }</td>
								<td>${c.edu_tm }</td>
								<td>
									<c:choose>
										<c:when test="${c.edu_cmpl eq 'Y' }">수료</c:when>
										<c:when test="${c.edu_cmpl eq 'N' }">미수료</c:when>
									</c:choose>
								</td>
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
					
					   <c:forEach var="i" begin="${startPage}" end="${endPage}">
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
					   		<li><a class="no-bg" href="javascript:go_page('<fmt:formatNumber value="${count/pageSize}" type="number" maxFractionDigits="0"/>')" tabindex="42">&gt;&gt;</a></li>
					   </c:if>
					</c:if>
				</ul>
				
			</div><!-- // shadow-box -->

		</div><!--// contents -->
	</div><!--// container -->
	</form>
</div>

<form id="frm_edu" name="frm_edu" action="" method="post">
<div id="layer_edu" class="layer-warp">
<input type="hidden" id="cmntor_no" name="cmntor_no" value="${srch.cmntor_no }" />
<input type="hidden" id="c_no" name="c_no" value="${srch.cmntor_no }" />
<input type="hidden" id="edu_seq" name="edu_seq" value="0"/>
	<div class="layer-inner">
		<div class="top-bar">
			<h2>교육이수 등록</h2>
			<div class="btn-close"><a href="javascript:none()" id="btn_edu_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
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
						<th>교육구분</th>
						<td style="text-align:left">
							<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
							<c:choose>
								<c:when test="${auth ne 5}">
							<div class="pos-relative" style="display:inline"><input type="radio" name="edu_prt" id="rd11" value="1" /><label for="rd11">신규</label></div>
							<div class="pos-relative" style="display:inline"><input type="radio" name="edu_prt" id="rd12" value="2" /><label for="rd12">보수</label></div>
								</c:when>
								<c:otherwise>
									<div class="pos-relative" style="display:inline"><input type="radio" name="edu_prt" id="rd11" value="1" checked="checked"/><label for="rd11">신규</label></div>
								</c:otherwise>
							</c:choose>
						</td>
						<th>시행연도</th>
						<td style="text-align:left"><input type="text" id="yyyy" name="yyyy" style="width:50%;margin-right:10px;" title="시행연도" placeholder="숫자만 입력하세요" onkeyup="this.value=number_filter(this.value);"/>년도</td>
					</tr>
					<tr>
						<th>교육기관</th>
						<td colspan="3" style="text-align:left"><input type="text" id="edu_place" name="edu_place" value="" title="교육기관" style="width:90%;height:80%" /></td>
					</tr>
					<tr>
						<th>교육명</th>
						<td colspan="3" style="text-align:left"><input type="text" id="edu_nm" name="edu_nm" value="" title="교육명" style="width:90%;height:80%"/></td>
					</tr>
					<tr>
						<th>이수시간</th>
						<td style="text-align:left"><input type="text" id="edu_tm" name="edu_tm" title="이수시간" placeholder="숫자만 입력하세요" onkeyup="this.value=number_filter(this.value);" class="row-input" /></td>
						<th>수료</th>
						<td style="text-align:left">
							<div class="pos-relative" style="display:inline"><input type="radio" name="edu_cmpl" id="rd21" value="N" /><label for="rd21">미수료</label></div>
							<div class="pos-relative" style="display:inline"><input type="radio" name="edu_cmpl" id="rd22" value="Y" /><label for="rd22">수료</label></div>
						</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block text-center" style="border-top:none">				
				<a href="javascript:edu_save()" class="btn-blue"><span>저장</span></a>
				<a href="javascript:;" class="btn-orange" id="btn_edu_close"><span>닫기</span></a>
			</div><!--// btn-block -->
			
		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>

</body>
</html>