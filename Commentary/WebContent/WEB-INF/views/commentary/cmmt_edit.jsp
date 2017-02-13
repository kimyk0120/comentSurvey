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
		
		var email2 = "<c:out value="${info.email2}"/>";
		
		var e = document.getElementById("email2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email").style.display = "inline";
			$('#email3').val(email2);
		} else {
			document.getElementById("div_email").style.display = "none";
		}
		
		var h_ph1 = "<c:out value="${info.hand_ph1}"/>";
		if(h_ph1 != null && h_ph1 != '') {
			$("#hand_ph1").val(h_ph1).change(); 
		}
		
		/* var sido = "<c:out value="${info.sido_cd}"/>";
		var gugun = "<c:out value="${info.gugun_cd}"/>";
		
		if(sido != null && sido != '') {
			
		$("#sido_cd").val(sido).change();
		
			$.ajax({ 
				   url: "srch_gugun.do", 
				   type: "POST", 
				   data: {"s_sido" : sido},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "<select class=\"formSelect\" id=\"gugun_cd\" name=\"gugun_cd\" style=\"width:150px;\" title=\"\">";
					   str=str+"<option value=\"\">선택</option>";
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	     				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   str = str+"</select>";
					   document.getElementById("gugun_div").innerHTML=str;
					   
					   $('.formSelect').sSelect();
					   if(gugun != null && gugun != '') {
						   $("#gugun_cd").val(gugun).change(); 
					   }
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
		} */
		
		$('input:radio[name="last_edu_cd"]').filter('[value="${info.last_edu_cd}"]').attr('checked', true);
		$('input:radio[name="job"]').filter('[value="${info.job}"]').attr('checked', true);
		$('input:radio[name="gender"]').filter('[value="${info.gender}"]').attr('checked', true);
		$('input:checkbox[name="lang1"]').filter('[value="${lang.lang_cd1}"]').attr('checked', true);
		$('input:checkbox[name="lang2"]').filter('[value="${lang.lang_cd2}"]').attr('checked', true);
		$('input:radio[name="lang2_grade"]').filter('[value="${lang.lang_cd2_grade}"]').attr('checked', true);
		$('input:checkbox[name="lang3"]').filter('[value="${lang.lang_cd3}"]').attr('checked', true);
		$('input:radio[name="lang3_grade"]').filter('[value="${lang.lang_cd3_grade}"]').attr('checked', true);
		$('input:checkbox[name="lang4"]').filter('[value="${lang.lang_cd4}"]').attr('checked', true);
		$('input:radio[name="lang4_grade"]').filter('[value="${lang.lang_cd4_grade}"]').attr('checked', true);
		$('input:checkbox[name="lang9"]').filter('[value="${lang.lang_cd9}"]').attr('checked', true);
		$('input:radio[name="lang9_grade"]').filter('[value="${lang.lang_cd9_grade}"]').attr('checked', true);
		
		var bDt = "<c:out value="${info.birth_dt}"/>";
		if(bDt != "") {
			$('#birth_dt_yy').val(bDt.substring(0, 4));
			var mm = bDt.substring(5, 7);
			var dd = bDt.substring(8, 10);
			$("#birth_dt_mm").val(mm).change(); 
			$("#birth_dt_dd").val(dd).change(); 
		}
		
		var yn = "<c:out value="${info.act_yn}"/>";
		
		$('input:radio[name="act_yn"]').filter('[value="${info.act_yn}"]').attr('checked', true);
		
		if(yn == "Y") {
			document.getElementById("act_prt").style.display = "none";
		}
		else {
			document.getElementById("act_prt").style.display = "inline-block";
			$('input:radio[name="act_prt_cd"]').filter('[value="${info.act_prt_cd}"]').attr('checked', true);
		}
		
	});

	$(function() {
		$('.formSelect').sSelect();
	});
	
	function email_select() {
		var e = document.getElementById("email2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email").style.display = "inline";
			$('#email3').val("");
		} else {
			document.getElementById("div_email").style.display = "none";
		}
			
	}
	
	function goPopup(){
		// 주소검색을 수행할 팝업 페이지를 호출합니다.
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("zip_test_popup2.do","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}


	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
			// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
			document.mainform.home_addr1.value = roadFullAddr;
			//document.form.roadAddrPart1.value = roadAddrPart1;
			//document.form.roadAddrPart2.value = roadAddrPart2;
			//document.form.addrDetail.value = addrDetail;
			//document.form.engAddr.value = engAddr;
			//document.form.jibunAddr.value = jibunAddr;
			document.mainform.home_zip.value = zipNo;
			//document.form.admCd.value = admCd;
			//document.form.rnMgtSn.value = rnMgtSn;
			//document.form.bdMgtSn.value = bdMgtSn;
	}
	
	function get_gugun() {
		
		var s_sido = $("select[name=sido_cd]").val();
		
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var str = "<select class=\"formSelect\" id=\"gugun_cd\" name=\"gugun_cd\" style=\"width:150px;\" title=\"소속 구군 선택\">";
				   str=str+"<option value=\"\">선택</option>";
				   if(msg != "" && msg != null) {
					   var tmp = msg.split('|');
					   
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
	
	function cmmt_save() {
		
		var ph1 = mainform.home_ph1.value;
		var ph2 = mainform.home_ph2.value;
		var ph3 = mainform.home_ph3.value;
		
		if(ph1 != '' && ph2 != '' && ph3 != '') {
			mainform.home_phone.value=ph1+"-"+ph2+"-"+ph3;
		}
		
		var hp1 = mainform.hand_ph1.value;
		var hp2 = mainform.hand_ph2.value;
		var hp3 = mainform.hand_ph3.value;
		
		if(hp1 != '' && hp2 != '' && hp3 != '') {
			mainform.hand_phone.value=hp1+"-"+hp2+"-"+hp3;
		}
		
		var yy = mainform.birth_dt_yy.value;
		var mm = mainform.birth_dt_mm.value;
		var dd = mainform.birth_dt_dd.value;
		
		if(yy != '' && mm != '' && dd != '') {
			mainform.birth_dt.value=yy+"년"+mm+"월"+dd+"일";
		}
		
		var e1 = mainform.email1.value;
		var e2 = mainform.email2.value;
		var e3 = mainform.email3.value;
		
		if(e1 != '') {
			if(e2 != '') {
				mainform.email.value=e1+"@"+e2;
			} else if(e3 != '') {
				mainform.email.value=e1+"@"+e3;
			}
		}
		
		if(mainform.name.value == "" ) {
			alert("성명을 입력하여 주십시요.");
			$("#name").focus();
			return;
		} else if(mainform.birth_dt.value == "" ) {
			alert("생년월일을 입력하여 주십시요.");
			$("#birth_dt_yy").focus();
			return;
		} else if(mainform.gender.value == "" ) {
			alert("성별을 선택하여 주십시요.");
			// $("#lecture_code").focus();
			return;
		} else if(mainform.rgst_dt.value == "" ) {
			alert("해설사 등록일을 입력하여 주십시요.");
			$("#rgst_dt").focus();
			return;
		} else if(mainform.arrg_place.value == "" ) {
			alert("배치 장소를 입력하여 주십시요.");
			$("#arrg_place").focus();
			return;
		} else if(mainform.sido_cd.value == "" ) {
			alert("소속 지역을 선택하여 주십시요.");
			return;
		/* } else if(mainform.gugun_cd.value == "" ) {
			alert("소속 지역을 선택하여 주십시요.");
			return; */
		} else if(mainform.home_zip.value == "" || mainform.home_addr1.value == "" ) {
			alert("자택주소를 선택하여 주십시요.");
			$("#home_zip").focus();
			return;      
		/* } else if(mainform.home_phone.value == "" ) {
			alert("자택전화를 입력하여 주십시요.");
			$("#ph1").focus();
			return; */
			/* 자택주소는 필수에서 제외 (2016.11.17) */
		} else if(mainform.hand_phone.value == "" ) {
			alert("휴대전화를 입력하여 주십시요.");
			$("#hp1").focus();
			return;
		} else if(mainform.email.value == "" ) {
			alert("이메일을 입력하여 주십시요.");
			$("#email1").focus();
			return;
		} else {
			document.mainform.target = "_self";
			document.mainform.action = "cmmt_update.do";
			document.mainform.submit();
		}
	}
	function cmmt_info() {
		document.mainform2.target = "_self";
		document.mainform2.action = "cmmt_info.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
		document.mainform2.submit();
	}
	
	
	function readURL(input) {

		var  str_dotlocation,str_ext,str_low;
		str_value  = $('#stdt_img').val();
		str_low   = str_value.toLowerCase(str_value);
		str_dotlocation = str_low.lastIndexOf(".");
		str_ext   = str_low.substring(str_dotlocation+1);

		if (str_ext != "png" && str_ext != "jpg" && str_ext != "gif" && str_ext != "jpeg") {
		     alert("파일 형식이 맞지 않습니다.\n png,jpg,gif,jpeg 만\n 업로드가 가능합니다!");
		  	 $('#stdt_img').val('');
		     return;
		}
		
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();

	        reader.onload = function (e) {
	            $('#img_view').attr('src', e.target.result);
	        }

	        reader.readAsDataURL(input.files[0]);
	        
	        document.getElementById("img_view").height = "110";
	        $('#img_view2').css("visibility","hidden");
	    }
	}
	
	function img_del() {
		
		var str = "<div class=\"photo\"><img id=\"img_view2\" src=\"image/user_defaut_112.png\" alt=\"문지식님\" /></div>";
		str = str + "<div class=\"cover\"><img id=\"img_view\" src=\"image/user_cover_112.png\" alt=\"문지식님\" /></div>";
		str = str + "<span class=\"btn-table\"><input type=\"file\" id=\"stdt_img\" name=\"stdt_img\" style=\"width:90px;height:20px;margin-left:5px;filter:alpha(opacity=1);opacity:1;cursor:pointer;\" onchange=\"readURL(this)\"/></span>";
		
		document.getElementById("div_img").innerHTML=str;
	    mainform.img_change.value="Y";
	}
	
	function act_change() {
		var yn =  $(':radio[name="act_yn"]:checked').val();
		if(yn == "Y") {
			document.getElementById("act_prt").style.display = "none";
		}
		else {
			document.getElementById("act_prt").style.display = "inline-block";
		}
	} 
	
	function number_filter(str_value){
		return str_value.replace(/[^0-9]/gi, ""); 
	}
	
</script>

</head>
<body>
<div id="wrapper">
	
<form id="mainform2" name="mainform2" action="" method="post">
<input type="hidden" id="c_no" name="c_no" value="${info.cmntor_no }" />
</form>
<form id="mainform" name="mainform"  method="post" enctype="multipart/form-data">
	<jsp:include page="../main/topMenu.jsp"  />
	
<input type="hidden" id="birth_dt" name="birth_dt" />
<input type="hidden" id="home_phone" name="home_phone" />
<input type="hidden" id="hand_phone" name="hand_phone" />
<input type="hidden" id="email" name="email" />
<input type="hidden" id="cmntor_no" name="cmntor_no" value="${info.cmntor_no }" />

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
					<a href="#a"><span class="text1">문화관광해설사</span><span class="text2">관 리 시 스 템</span><span class="text3">안내</span></a>
				</div>
			</div><!--// shadow-box -->

		</div><!--// user-info -->

		<div class="contents">

			<div class="shadow-box">				

				<h3>기본 정보 수정 <span style="font-size:10px">(*는 필수입력사항입니다.)</span></h3>

				<table class="talbe-view">
					<colgroup>
						<col style="width:10%" />
						<col style="width:40%" />
						<col style="width:10%" />
						<col style="width:40%" />
					</colgroup>
					<tbody>
						<tr>
							<th rowspan="2">소속<span>*</span></th>
							<td>
								${info.sido_cd_nm}
								<input type="hidden" id="sido_cd" name="sido_cd" value="${info.sido_cd }" />
							</td>
							<th rowspan="2">해설사 등록일<span>*</span></th>
							<td rowspan="2">
								<input type="text" id="rgst_dt" name="rgst_dt" placeholder="날짜 선택" title="해설사 등록일" class="calendar" value="${info.rgst_dt }"/>
							</td>
						</tr>
						<tr>
							<td>
								${info.gugun_cd_nm}
								<input type="hidden" id="gugun_cd" name="gugun_cd" value="${info.gugun_cd }" />
								<!-- <div id="gugun_div" style="display:inline;">
									<select class="formSelect" style="width:150px;" title="소속 구군 선택">
										<option value="">구군</option>
									</select>
								</div> -->
							</td>
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
							<th rowspan="2">성명<span>*</span></th>
							<td rowspan="2">
								<div class="item-block">
									<input type="text" name="name" id="name" value="${info.name }" title="성명"/>
								</div>
							</td>
							<th rowspan="2">영문</th>
							<td style="border-right:1px solid #dcdcdc">
								<div class="item-block">
									<input type="text" name="eng_name" id="eng_name" value="${info.eng_name }" placeholder="성" title="영문 성"/>
								</div>
							</td>
							<td rowspan="4" style="border-bottom:0px">
								<div id="div_img" class="user-photo" style="width:131px;height:131px;">
									<c:choose>
										<c:when test="${fn:length(info.prfl_img) gt 0 }">
											<div class="cover"><img id="img_view" src="files/image/${info.prfl_img}" class="person" style="height:auto;" alt="프로필 사진" /></div>
											<span class="btn-table">
												<!-- <input type="file" id="stdt_img" name="stdt_img" style="margin-top:130px;width:90px;height:20px;margin-left:80px;filter:alpha(opacity=1);opacity:1;cursor:pointer;" onchange="readURL(this)" title="프로필사진"/> -->
											</span>
										</c:when>
										<c:otherwise>
											<div class="photo"><img id="img_view2" src="image/user_defaut_112.png" alt="${info.name }" /></div>
											<div class="cover"><img id="img_view" src="image/user_cover_112.png" alt="${info.name }" /></div>
											<span class="btn-table">
												<!-- <input type="file" id="stdt_img" name="stdt_img" style="width:90px;height:20px;margin-left:5px;filter:alpha(opacity=1);opacity:1;cursor:pointer;" onchange="readURL(this)" title="프로필사진"/> -->
											</span>
										</c:otherwise>
									</c:choose>
								</div>
							</td>
						</tr>
						<tr>
							<td style="border-right:1px solid #dcdcdc">
								<div class="item-block">
									<input type="text" name="eng_name2" id="eng_name2" value="${info.eng_name2 }" placeholder="이름" title="영문 이름"/>
								</div>
							</td>
						</tr>
						<tr>
							<th>성별<span>*</span></th>
							<td>
								<div class="pos-relative"><input type="radio" name="gender" id="rd1" value="M" /><label for="rd1">남성</label></div>
								<div class="pos-relative"><input type="radio" name="gender" id="rd2" value="F" /><label for="rd2">여성</label></div>
							</td>
							<th>이메일<span>*</span></th>
							<td style="border-right:1px solid #dcdcdc">
								<div class="email-block">
									<input type="text" name="email1" id="email1" value="${info.email1 }" title="이메일 아이디" style="width:110px"/>
									<span class="txt-symbol">@</span>
									<!-- <input type="text" name="email2" id="email2" value="" title="이메일 도메인" /> -->
									<select class="formSelect phone-num" style="width:100px" name="email2" id="email2" title="이메일 도메인 선택" onchange="email_select()">
										<option value="">직접입력</option>
										<option value="naver.com" <c:if test="${info.email2 eq 'naver.com'}">selected="selected"</c:if>>naver.com</option>
										<option value="nate.com" <c:if test="${info.email2 eq 'nate.com'}">selected="selected"</c:if>>nate.com</option>
										<option value="empal.com" <c:if test="${info.email2 eq 'empal.com'}">selected="selected"</c:if>>empal.com</option>
										<option value="daum.net" <c:if test="${info.email2 eq 'daum.net'}">selected="selected"</c:if>>daum.net</option>
										<option value="hanmail.net" <c:if test="${info.email2 eq 'hanmail.net'}">selected="selected"</c:if>>hanmail.net</option>
										<option value="google.com" <c:if test="${info.email2 eq 'google.com'}">selected="selected"</c:if>>google.com</option>
										<option value="gmail.com" <c:if test="${info.email2 eq 'gmail.com'}">selected="selected"</c:if>>gmail.com</option>
										<option value="hotmail.com" <c:if test="${info.email2 eq 'hotmail.com'}">selected="selected"</c:if>>hotmail.com</option>
									</select>
									<div id="div_email"  style="display:inline;">
										<input type="text" id="email3" name="email3" style="width:110px" title="이메일 도메인 직접 입력" />
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th rowspan="2">생년월일<span>*</span></th>
							<td rowspan="2">
								<input type="text" name="birth_dt_yy" id="birth_dt_yy" value="" title="생일 년도" class="id-num" style="width:50px"/><span style="margin:0px 15px 0 5px">년</span>
								<select class="formSelect" style="width:50px" title="월" name="birth_dt_mm" id="birth_dt_mm">
									<option value="01">1</option><option value="02">2</option><option value="03">3</option><option value="04">4</option>
									<option value="05">5</option><option value="06">6</option><option value="07">7</option><option value="08">8</option>
									<option value="09">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>
								</select><span style="margin:0px 15px 0 5px"> 월 </span>
								<select class="formSelect" style="width:50px" title="일" name="birth_dt_dd" id="birth_dt_dd">
									<option value="01">1</option><option value="02">2</option><option value="03">3</option><option value="04">4</option><option value="05">5</option>
									<option value="06">6</option><option value="07">7</option><option value="08">8</option><option value="09">9</option><option value="10">10</option>
									<option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option>
									<option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option>
									<option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option>
									<option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option>
									<option value="31">31</option>
								</select><span style="margin:0px 15px 0 5px"> 일 </span>
							</td>
							<th>자택전화</th>
							<td style="border-right:1px solid #dcdcdc">
								<div class="phone-block">
									<input type="text" id="home_ph1" name="home_ph1" value="${info.home_ph1 }" title="전화번호 국번" class="row-input" onkeyup="this.value=number_filter(this.value);" maxlength="4"/>
									<span class="txt-symbol">-</span>
									<input type="text" id="home_ph2" name="home_ph2" value="${info.home_ph2 }" title="전화번호 앞 3~4 자리" class="row-input" onkeyup="this.value=number_filter(this.value);" maxlength="4"/>
									<span class="txt-symbol">-</span>
									<input type="text" id="home_ph3" name="home_ph3" value="${info.home_ph3 }" title="전화번호 뒤 4 자리" class="row-input" onkeyup="this.value=number_filter(this.value);" maxlength="4"/>
								</div>
							</td>
						</tr>
						<tr>
							<th>휴대전화<span>*</span></th>
							<td style="border-right:1px solid #dcdcdc">
								<div class="phone-block">
									<select class="formSelect phone-num" style="width:60px" title="휴대전화 앞 자리" id="hand_ph1" name="hand_ph1">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="019">019</option>
									</select>
									<span class="txt-symbol">-</span>
									<input type="text" id="hand_hp2" name="hand_ph2" value="${info.hand_ph2 }" title="휴대전화 중간 4 자리" class="row-input" onkeyup="this.value=number_filter(this.value);" maxlength="4"/>
									<span class="txt-symbol">-</span>
									<input type="text" id="hand_hp3" name="hand_ph3" value="${info.hand_ph3 }" title="휴대전화 뒤 4 자리" class="row-input" onkeyup="this.value=number_filter(this.value);" maxlength="4"/>
								</div>
							</td>
							<td>
								<input type="file" id="stdt_img" name="stdt_img" onchange="readURL(this)" title="프로필사진"/>
							</td>
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
							<th>자택주소<span>*</span></th>
							<td colspan="4">
								<input type="text" id="home_zip" name="home_zip" title="우편번호" class="row-input" value="${info.home_zip }"/>
								<span class="btn-table"><a href="javascript:goPopup()"><span>우편번호검색</span></a></span>
								<input type="text" id="home_addr1" name="home_addr1" title="나머지 주소" class="long-input" value="${info.home_addr1 }"/>
							</td>
						</tr>
						<tr>
							<th>활동구분</th>
							<td colspan="4">
								<div class="pos-relative"><input type="radio" name="act_yn" id="act_yn_radio1" value="Y" onclick="javascript:act_change()" /><label for="act_yn_radio1">활동중</label></div>
								<div class="pos-relative"><input type="radio" name="act_yn" id="act_yn_radio2" value="N" onclick="javascript:act_change()" /><label for="act_yn_radio2">미활동</label></div>
								<div id="act_prt" style="display:none;">
									<div class="pos-relative"><input type="radio" name="act_prt_cd" id="act_prt_radio1" value="02" /><label for="act_prt_radio1">휴직</label></div>
									<div class="pos-relative"><input type="radio" name="act_prt_cd" id="act_prt_radio2" value="03" /><label for="act_prt_radio2">정지</label></div>
									<div class="pos-relative"><input type="radio" name="act_prt_cd" id="act_prt_radio3" value="04" /><label for="act_prt_radio3">박탈</label></div>
								</div>
							</td>
						</tr>
						<tr>
							<th>최종 정규교육</th>
							<td colspan="4">
								<div class="pos-relative"><input type="radio" name="last_edu_cd" id="radio11" value="01" /><label for="radio11">안받음</label></div>
								<div class="pos-relative"><input type="radio" name="last_edu_cd" id="radio12" value="02" /><label for="radio12">초등학교</label></div>
								<div class="pos-relative"><input type="radio" name="last_edu_cd" id="radio13" value="03" /><label for="radio13">중학교</label></div>
								<div class="pos-relative"><input type="radio" name="last_edu_cd" id="radio14" value="04" /><label for="radio14">고등학교</label></div>
								<div class="pos-relative"><input type="radio" name="last_edu_cd" id="radio15" value="05" /><label for="radio15">대학(교)</label></div>
								<div class="pos-relative"><input type="radio" name="last_edu_cd" id="radio16" value="06" /><label for="radio16">대학(교)(4년제 미만)</label></div>
								<div class="pos-relative"><input type="radio" name="last_edu_cd" id="radio17" value="07" /><label for="radio17">대학(교)(4년제 이상)</label></div>
								<div class="pos-relative"><input type="radio" name="last_edu_cd" id="radio18" value="08" /><label for="radio18">대학원 석사과정</label></div>
								<div class="pos-relative"><input type="radio" name="last_edu_cd" id="radio19" value="09" /><label for="radio19">대학원 박사과정</label></div>
							</td>
						</tr>
						<tr>
							<th>활동언어</th>
							<td colspan="4">
								<span style="background:#DCDDDE"> # 복수선택가능 </span>
								<div class="lng-block">
									<div class="pos-relative"><input type="checkbox" name="lang1" id="lang1" value="01" /><label for="lang1">한국어</label><span class="kr"></span></div>
									<div class="pos-relative"><input type="checkbox" name="lang2" id="lang2" value="02" /><label for="lang2">영어</label><span class="eng"></span></div>
										<span>(</span>
										<div class="pos-relative"><input type="radio" name="lang2_grade" id="rd_lang21" value="H" /><label for="rd_lang21" style="padding-left:15px">상</label></div>
										<div class="pos-relative"><input type="radio" name="lang2_grade" id="rd_lang22" value="M" /><label for="rd_lang22" style="padding-left:15px">중</label></div>
										<div class="pos-relative"><input type="radio" name="lang2_grade" id="rd_lang23" value="L" /><label for="rd_lang23" style="padding-left:15px">하</label></div>
										<span style="margin-right:20px">)</span>
									<div class="pos-relative"><input type="checkbox" name="lang3" id="lang3" value="03" /><label for="lang3">중국어</label><span class="ch"></span></div>
										<span>(</span>
										<div class="pos-relative"><input type="radio" name="lang3_grade" id="rd_lang31" value="H" /><label for="rd_lang31" style="padding-left:15px">상</label></div>
										<div class="pos-relative"><input type="radio" name="lang3_grade" id="rd_lang32" value="M" /><label for="rd_lang32" style="padding-left:15px">중</label></div>
										<div class="pos-relative"><input type="radio" name="lang3_grade" id="rd_lang33" value="L" /><label for="rd_lang33" style="padding-left:15px">하</label></div>
										<span style="margin-right:20px">)</span>
									<div class="pos-relative"><input type="checkbox" name="lang4" id="lang4" value="04" /><label for="lang4">일본어</label><span class="jap"></span></div>
										<span>(</span>
										<div class="pos-relative"><input type="radio" name="lang4_grade" id="rd_lang41" value="H" /><label for="rd_lang41" style="padding-left:15px">상</label></div>
										<div class="pos-relative"><input type="radio" name="lang4_grade" id="rd_lang42" value="M" /><label for="rd_lang42" style="padding-left:15px">중</label></div>
										<div class="pos-relative"><input type="radio" name="lang4_grade" id="rd_lang43" value="L" /><label for="rd_lang43" style="padding-left:15px">하</label></div>
										<span style="margin-right:20px">)</span>
									<br/>
									<div class="pos-relative"><input type="checkbox" name="lang9" id="lang9" value="09" /><label for="lang9" class="etc">기타</label></div>
									<input type="text" id="etc_lang" name="etc_lang" style="width:120px" value="${lang.etc_lang}" placeholder="기타일 경우 입력" title="기타 언어"/>
										<span>(</span>
										<div class="pos-relative"><input type="radio" name="lang9_grade" id="rd_lang91" value="상" /><label for="rd_lang91" style="padding-left:15px">상</label></div>
										<div class="pos-relative"><input type="radio" name="lang9_grade" id="rd_lang92" value="중" /><label for="rd_lang92" style="padding-left:15px">중</label></div>
										<div class="pos-relative"><input type="radio" name="lang9_grade" id="rd_lang93" value="하" /><label for="rd_lang93" style="padding-left:15px">하</label></div>
										<span>)</span>
								</div>
							</td>
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
							<td align="center"><input type="text" id="eng_test_yy" name="eng_test_yy" title="영어 응시년도" style="width:80%" value="${info.eng_test_yy }"/></td>
							<td align="center"><input type="text" id="eng_test_nm" name="eng_test_nm" title="영어 시험명" style="width:80%" value="${info.eng_test_nm }"/></td>
							<td align="center"> <input type="text" id="eng_test_pnt" name="eng_test_pnt" title="영어 점수" value="${info.eng_test_pnt }"/></td>
						</tr>
						<tr>
							<td align="center">중국어</td>
							<td align="center"><input type="text" id="chn_test_yy" name="chn_test_yy" title="중국어 응시년도" style="width:80%" value="${info.chn_test_yy }"/></td>
							<td align="center"><input type="text" id="chn_test_nm" name="chn_test_nm" title="중국어 시험명" style="width:80%" value="${info.chn_test_nm }"/></td>
							<td align="center"><input type="text" id="chn_test_pnt" name="chn_test_pnt" title="중국어 점수" value="${info.chn_test_pnt }"/></td>
						</tr>
						<tr>
							<td align="center">일본어</td>
							<td align="center"><input type="text" id="jpn_test_yy" name="jpn_test_yy" title="일본어 응시년도" style="width:80%" value="${info.jpn_test_yy }"/></td>
							<td align="center"><input type="text" id="jpn_test_nm" name="jpn_test_nm" title="일본어 시험명" style="width:80%" value="${info.jpn_test_nm }"/></td>
							<td align="center"><input type="text" id="jpn_test_pnt" name="jpn_test_pnt" title="일본어 점수" value="${info.jpn_test_pnt }"/></td>
						</tr>
						<tr>
							<td align="center"><input type="text" id="etc_lang_nm" name="etc_lang_nm" placeholder="기타" style="text-align:center;width:80%" value="${info.etc_lang_nm }" title="기타시험언어"/></td>
							<td align="center"><input type="text" id="etc_test_yy" name="etc_test_yy" title="기타 시험응시년도" style="width:80%" value="${info.etc_test_yy }"/></td>
							<td align="center"><input type="text" id="etc_test_nm" name="etc_test_nm" title="기타 시험명" style="width:80%" value="${info.etc_test_nm }"/></td>
							<td align="center"><input type="text" id="etc_test_pnt" name="etc_test_pnt" title="기타 점수" value="${info.etc_test_pnt }"/></td>
						</tr>
						<tr>
							<th>주배치장소<span>*</span></th>
							<td colspan="4">
								<input type="text" id="arrg_place" name="arrg_place" title="배치 장소" class="long-input" value="${info.arrg_place }"/>
							</td>
						</tr>
						<tr>
							<th>희망활동장소</th>
							<td colspan="4">
								<input type="text" id="hope_place" name="hope_place" title="희망활동 장소" class="long-input" value="${info.hope_place }"/>
							</td>
						</tr>
					</tbody>
				</table>
<%-- 
				<h3>선택 정보</h3>
				<table class="talbe-view">
					<colgroup>
						<col style="width:20%" />
						<col style="width:*" />
					</colgroup>
					<tbody>
						<tr>
							<th>뉴스레터신청</th>
							<td>
								<div class="pos-relative"><input type="radio" name="letter" id="radio3" value="" /><label for="radio3">예</label></div>
								<div class="pos-relative"><input type="radio" name="letter" id="radio4" value="" /><label for="radio4">아니요</label></div>
								<div class="pos-relative"><input type="radio" name="letter" id="radio5" value="" /><label for="radio5">긴급상황만 수신</label></div>
							</td>
						</tr>
						<tr>
							<th>자격취득일자</th>
							<td><input type="text" id="text29" name="" value="날짜 선택" placeholder="날짜 선택"  class="calendar" title="자격취득일자" /></td>
						</tr>
						<tr>
							<th>결혼여부</th>
							<td>
								<div class="pos-relative"><input type="radio" name="mm" id="radio6" value="" /><label for="radio6">미혼</label></div>
								<div class="pos-relative"><input type="radio" name="mm" id="radio7" value="" /><label for="radio7">기혼</label></div>
							</td>
						</tr>
						<tr>
							<th>결혼기념일</th>
							<td><input type="text" id="text30" name="" value="날짜 선택" placeholder="날짜 선택"  class="calendar" title="결혼기념일" /></td>
						</tr>
					</tbody>
				</table> --%>


				<div class="btn-block text-center mt20">
					<a href="javascript:cmmt_save()" class="btn-blue"><span>내역 등록</span></a>
					<a href="javascript:cmmt_info()" class="btn-orange"><span>취소</span></a>
				</div>

			</div><!-- // shadow-box -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</div>


</body>
</html>

