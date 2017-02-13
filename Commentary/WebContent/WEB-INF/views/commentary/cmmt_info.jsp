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
<jsp:useBean id="now" class="java.util.Date" />

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
		
		$( '#rgst_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		
		
		var newDate = new Date();
		var yy = newDate.getFullYear();
		var mm = newDate.getMonth()+1;
		var dd = newDate.getDate();
		var toDay = yy + "-" + mm + "-" + dd;
		
		var up = "<c:out value="${update}"/>";
		if( up == "Y") alert("수정되었습니다.");
		var yn = "<c:out value="${userYn}"/>";
		if( yn == "Y") alert("시스템에 등록되었습니다.");
		
	});

	$(function() {
		$('.formSelect').sSelect();
	});
	
	
	
	function cmmt_edu_list() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_edu_list.do";
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
	
	function cmmt_list() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_list.do";
		document.mainform.submit();
	}
	
	function cmmt_edit() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_edit.do";
		document.mainform.submit();
	}
	
	function cmmt_create() {
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_create.do";
		document.mainform.submit();
	}
	
	function cmmt_delete() {
		if(confirm("탈퇴처리하시겠습니까?")) {
			document.mainform.target = "_self";
			document.mainform.action = "cmmt_delete.do";
			document.mainform.submit();
		}
	}
	
	function user_create() {
		
		//console.log("email : " + $('#email').val());
		
		if(confirm("등록된 이메일로 회원 가입 진행하시겠습니까?")) {
			if($('#email').val() != "") {
				$.ajax({ 
					   url: "id_check.do", 
					   type: "POST", 
					   data: {"id" : $('#email').val()},
					   dataType:"text",
					   cache: false,
					   success: function(msg){
						   if(msg == "Y") {
							    document.mainform.target = "_self";
								document.mainform.action = "cmmt_user_create.do";
								document.mainform.submit();
						   }
						   else if(msg == "N"){
							   alert("동일한 아이디가 존재합니다. 이메일 확인하시고 다시 진행하세요.");
							   return false;
						   }
					   }
					   , error: function (xhr, ajaxOptions, thrownError) {
					      }
					}); 
			}
			else {
				alert("등록된 이메일이 없습니다. 이메일 입력하시고 다시 진행하세요.");
			   return false;
			}
		}
	}
	
	function main_info() {
		window.location.href="main_info.do?top=9&left=9";
	}
	
</script>

<style type="text/css">

	h3 {
		display:inline !important;
		font-weight: bold;
	}
</style>


</head>
<body>
<div id="wrapper">
	
<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="birth_dt" name="birth_dt" />
<input type="hidden" id="home_phone" name="home_phone" value="${info.home_phone }"/>
<input type="hidden" id="hand_phone" name="hand_phone" value="${info.hand_phone }"/>
<input type="hidden" id="name" name="name" value="${info.name }"/>
<input type="hidden" id="email" name="email" value="${info.email }"/>
<input type="hidden" id="sido_cd" name="sido_cd" value="${info.sido_cd }"/>
<input type="hidden" id="gugun_cd" name="gugun_cd" value="${info.gugun_cd }"/>
<input type="hidden" id="c_no" name="c_no" value="${info.cmntor_no }" />
<input type="hidden" id="auth_no" name="auth_no" value="${srch.auth_no }" />
<input type="hidden" id="srch_sido" name="srch_sido" value="${srch.srch_sido }" />
<input type="hidden" id="srch_gugun" name="srch_gugun" value="${srch.srch_gugun}" />
<input type="hidden" id="srch_nm" name="srch_nm" value="${srch.srch_nm }" />
<input type="hidden" id="srch_area" name="srch_area" value="${srch.srch_area }" />
<input type="hidden" id="srch_act_yn" name="srch_act_yn" value="${srch.srch_act_yn }" />
	
	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container" class="main"><!-- 왼쪽에 사용자 정보가 있을 경우 클래스 colum2 삽입 -->

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
					<a href="javascript:main_info()"><span class="text1">문화관광해설사</span><span class="text2">관 리 시 스 템</span><span class="text3">안내</span></a>
				</div>
			</div><!--// shadow-box -->

		</div><!--// user-info -->

		<div class="contents">

			<div class="btn-block text-right mb10">
				<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
				<c:if test="${auth eq 1 or auth eq 2 or auth eq 3 or auth eq 5}">
					<c:if test="${fn:length(info.id) eq 0 and auth eq 1 }" >
						<a href="javascript:user_create()" class="btn-green"><span>시스템 등록</span></a>
					</c:if>
					<a href="javascript:cmmt_create()" class="btn-blue"><span>해설사 신규 등록</span></a>
				</c:if>
				<a href="javascript:cmmt_list()" class="btn-orange"><span>리스트</span></a>
			</div>
			
			<ul id="tab" class="clearfix">
				<li class="on"><a href="javascript:;">기본 정보</a></li><!-- 선택된 곳에 클래스 on 추가 -->
				<li><a href="javascript:cmmt_edu_list()">교육 이수 내용</a></li>
				<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
				<c:if test="${auth ne 5}">
				<li><a href="javascript:cmmt_act_list()">활동 정보</a></li>
				<li><a href="javascript:cmmt_fee_list()">활동비 지급 내역</a></li>
				</c:if>
			</ul><!--// tab -->
			

			<div class="shadow-box">				

				<!-- <h3>기본 정보</h3> -->
				<%-- <c:if test="${fn:length(info.id) eq 0 }" >
					<div class="btn-block text-right mb10">
						<a href="javascript:user_create()" class="btn-green"><span>시스템 등록</span></a>
					</div>
				</c:if> --%>

				<table class="talbe-view">
					<colgroup>
						<col style="width:10%" />
						<col style="width:40%" />
						<col style="width:10%" />
						<col style="width:40%" />
					</colgroup>
					<tbody>
						<tr>
							<th rowspan="2">소속</th>
							<td>${info.sido_cd_nm }</td>
							<th rowspan="2">해설사 등록일</th>
							<td rowspan="2">${info.rgst_dt} </td>
						</tr>
						<tr>
							<td>${info.gugun_cd_nm }</td>
						</tr>
					</tbody>
				</table>
				<table class="talbe-view">
					<colgroup>
						<col style="width:10%" />
						<col style="width:30%" />
						<col style="width:10%" />
						<col style="width:30%" />
						<col style="width:20%" />
					</colgroup>
					<tbody>
						<tr>
							<th rowspan="2">성명</th>
							<td rowspan="2">${info.name }</td>
							<th rowspan="2">영문</th>
							<td>${info.eng_name }</td>
							<td rowspan="5" >
								<c:choose>
									<c:when test="${fn:length(info.prfl_img) gt 0 }">
										<img src="files/image/${info.prfl_img}" class="person" style="height:auto;" alt="프로필 사진"/>
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td>${info.eng_name2 }</td>
						</tr>
						<tr>
							<th>성별</th>
							<td>
								<c:choose>
									<c:when test="${info.gender eq 'M' }">
										남성
									</c:when>
									<c:when test="${info.gender eq 'F' }">
										여성
									</c:when>
									<c:otherwise>
									</c:otherwise>
								</c:choose>
							</td>
							<th>이메일</th>
							<td>${info.email }</td>
						</tr>
						<tr>
							<th rowspan="2">생년월일</th>
							<td rowspan="2">${info.birth_dt }</td>
							<th>자택전화</th>
							<td>${info.home_phone }</td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td>${info.hand_phone }</td>
						</tr>
					</tbody>
				</table>
				<table class="talbe-view">
					<colgroup>
						<col style="width:10%" />
						<col style="width:15%" />
						<col style="width:25%" />
						<col style="width:30%" />
						<col style="width:20%" />
					</colgroup>
					<tbody>
						<tr>
							<th>자택주소</th>
							<td colspan="4"> (${info.home_zip }) ${info.home_addr1 }</td>
						</tr>
						<tr>
							<th>활동 구분</th>
							<td colspan="4">
								<c:choose>
									<c:when test="${info.act_yn eq 'N'}">
										미활동중 ( ${info.act_prt_nm} )
									</c:when>
									<c:when test="${info.act_yn eq 'Y'}">
										활동중
									</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>최종 정규교육</th>
							<td colspan="4">${info.last_edu_nm }</td>
						</tr>
						<%-- <tr>
							<th>직업</th>
							<td colspan="4">${info.job_nm }</td>
						</tr> --%>
						<tr>
							<th>활동언어</th>
							<td colspan="4">${info.lang_nm }</td>
						</tr>
						<tr>
							<th rowspan="5">어학점수</th>
							<th>구분</th>
							<th>응시년도</th>
							<th>시험명</th>
							<th>점수(또는 등급)</th>
						</tr>
						<tr>
							<td align="center">영어</td>
							<td align="center">${info.eng_test_yy }</td>
							<td align="center">${info.eng_test_nm }</td>
							<td align="center">${info.eng_test_pnt }</td>
						</tr>
						<tr>
							<td align="center">중국어</td>
							<td align="center">${info.chn_test_yy }</td>
							<td align="center">${info.chn_test_nm }</td>
							<td align="center">${info.chn_test_pnt }</td>
						</tr>
						<tr>
							<td align="center">일본어</td>
							<td align="center">${info.jpn_test_yy }</td>
							<td align="center">${info.jpn_test_nm }</td>
							<td align="center">${info.jpn_test_pnt }</td>
						</tr>
						<tr>
							<td align="center">${info.etc_lang_nm }</td>
							<td align="center">${info.etc_test_yy }</td>
							<td align="center">${info.etc_test_nm }</td>
							<td align="center">${info.etc_test_pnt }</td>
						</tr>
						<tr>
							<th>주배치장소</th>
							<td colspan="4">${info.arrg_place }</td>
						</tr>
						<tr>
							<th>희망활동장소</th>
							<td colspan="4">${info.hope_place }</td>
						</tr>
					</tbody>
				</table>

				<div class="btn-block text-center mt20">
					<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
						<c:if test="${auth eq 1}">
							<div class="abr" style="margin-right:5px"><a href="javascript:cmmt_delete();" class="btn-red" title="회원탈퇴"><span>회원탈퇴</span></a></div>
						</c:if>
					<c:if test="${auth eq 1 or auth eq 4 or auth eq 5}">
						<a href="javascript:cmmt_edit()" class="btn-blue" title="내역 수정"><span>내역 수정</span></a>
					</c:if>
					<a href="javascript:cmmt_list()" class="btn-orange" title="리스트"><span>리스트</span></a>
				</div>

			</div><!-- // shadow-box -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</div>


</body>
</html>

