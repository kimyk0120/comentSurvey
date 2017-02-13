<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBSPfS_qEROEROxgpkPTcuT25_UOtvq7FU&language=ko">
</script>
<script type="text/javascript" src="./js/jquery.form.js"></script>
<script type="text/javascript" src="./js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="./js/util.js"></script>
<script type="text/javascript" src="./js/jquery-ui.min.js"></script>
<script type="text/javascript">
var map = null;
var x = "37.4837121";
var y = "127.0324112";
var marker = null;

function initialize(map_id) {
	if($("input[name=si_latitude]").val()!=''){
		x = $("input[name=si_latitude]").val();
		y = $("input[name=si_longitude]").val();
	}
	map = null;
	var mapOptions = {
	  center: new google.maps.LatLng(x, y),
	  zoom: 15,
	  maxZoom: 19,
	  mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	map = new google.maps.Map(document.getElementById(map_id),  mapOptions);
	<c:if test="${user.us_gbn eq 0}">
	google.maps.event.addListener(map, "click", function(event) {
		//var location = event.latLng;
		var latLng = event.latLng + "";
		var arrPoint = latLng.split(",");
		var lati = arrPoint[0].substr(1);
		var lng = arrPoint[1].substr(1, arrPoint[1].length-2);
		addMarker(lati, lng);	  
    });
	</c:if>
}

function addMarker(lati, lng) {
	if(lati == '' || lng == '') return;
	if(marker != null) marker.setMap(null); //기존 핀이 있다면
	var latLng = new google.maps.LatLng(lati, lng);
	marker = new google.maps.Marker({
	    position: latLng,
	    map: map,
	    draggable: false,
	    animation: google.maps.Animation.DROP
	  });
	$("input[name=si_latitude]").val( lati );
	$("input[name=si_longitude]").val( lng );
	map.panTo(latLng);
}

function goList() {
	form1.proc_mode.value = "";
	form1.submit();
}

function saveData() {
	
	var addr = $("#paddr3").val();
	addr = addr == "" ? $("#paddr2").val() : addr;
	addr = addr == "" ? $("#paddr1").val() : addr;
	var road_addr = $("#raddr2").val();
	road_addr = road_addr == "" ? $("#raddr1").val() : road_addr;
	$("input[name=si_addr_po_code]").val(addr);
	$("input[name=si_addr_road_po_code]").val(road_addr);
	$("input[name=si_install_date]").val($("#iyear").val()+"-"+$("#imonth").val()+"-"+$("#iday").val());
	$("input[name=si_requidation_date]").val($("#ryear").val()+"-"+$("#rmonth").val()+"-"+$("#rday").val());
		
	<c:if test="${user.us_gbn eq 0}">
	if(form1.sido_code.value == "") {
    	alert("관리 지자체를 선택해 주십시오");
    	form1.sido_code.focus();
    	return;
    }
	</c:if>
	if(form1.si_reg_id.value == "") {
		alert("표지일련번호를 입력해 주십시오");
		form1.si_reg_id.focus();
		return;	
	}	
	if(form1.typeCode1.value == "") {
    	alert("표지종류(대분류)를 선택해 주십시오");
    	form1.typeCode1.focus();
    	return;
    }	
	if($("select[name=typeCode2] option").size() > 1 && form1.typeCode2.value ==''){
		alert("표지종류(세분류)를 선택해 주십시오");
    	form1.typeCode2.focus();
    	return;
	}
	if(form1.si_place_name.value == "") {
		alert("관광지명을 입력해 주십시오");
		form1.si_place_name.focus();
		return;	
	}
	if(form1.si_pillar_code.value == "") {
    	alert("지주형식을 선택해 주십시오");
    	form1.si_pillar_code.focus();
    	return;
    }
	<c:if test="${user.us_gbn ne 0}">
	
	if(form1.si_material.value == "") {
    	alert("지주 재질을 입력해 주십시오");
    	form1.si_material.focus();
    	return;
    }
	if($("#iyear").val() == "0000") {
    	alert("설치일(년도)을 선택해 주십시오");
    	$("#iyear").focus();
    	return;
    }
	if($("#imonth").val() == "00") {
    	alert("설치일(월)을 선택해 주십시오");
    	$("#imonth").focus();
    	return;
    }
	if($("#iday").val() == "00") {
    	alert("설치일(일)을 선택해 주십시오");
    	$("#day").focus();
    	return;
    }
	if(form1.si_width.value == "") {
    	alert("표지규격(가로)을 입력해 주십시오");
    	form1.si_width.focus();
    	return;
    }
	if(form1.si_height.value == "") {
    	alert("표지규격(세로)을 입력해 주십시오");
    	form1.si_height.focus();
    	return;
    }
	if(form1.si_latitude.value == "") {
    	alert("위치정보(위도)를 입력해 주십시오");
    	form1.si_latitude.focus();
    	return;
    }
	if(form1.si_longitude.value == "") {
    	alert("위치정보(경도)를 입력해 주십시오");
    	form1.si_longitude.focus();
    	return;
    }
	</c:if>
	
	if(confirm("저장하시겠습니까?")) {
		form1.proc_mode.value = "update";
		var options={
			type:'POST',
			dataType:'json',
			beforeSend :function() {
				$("#upfile_spinner").show();
				$("#btnDiv").hide();
			},
			success:function(data){
				if(data.resultCode=='0'){
					form1.proc_mode.value = "";
					form1.seq.value = data.resultMsg;
					form1.submit();
				}
				else {
					alert(data.resultMsg);
					$("#upfile_spinner").hide();
					$("#btnDiv").show();
				}
			},
			error:function(e){
				alert("시스템오류 " + e.responseText);
			}
		};
		$("#form1").ajaxSubmit(options);
	}
}

function deleteData() {
	if(confirm("삭제하시겠습니까?")) {
		form1.proc_mode.value = "delete";
		form1.submit();
	}
}


function setTypeCode(val){
	$("input[name=si_type_code]").val(val);
}

function showLoadView() {
	if(form1.si_rv_code.value.length > 100){
		$("#roadView").html(form1.si_rv_code.value.replace(/500/g,"560").replace(/350/g,"350"));
	}
	else {
		$("#roadView").html("");
	}
}


function popSignType() {
	openWindow("/home/pop_sign_type.jsp","_signType",1, 820, 700);
}

function popPillar() {
	openWindow("/home/pop_sign_pillar.jsp","_pillar",1, 820, 700);
}

function popRoadView() {
	openWindow("/home/pop_help_roadview.jsp","_roadview",1, 780, 700);
}


function getAddress() {
	
	var latitude = parseFloat($("input[name='si_latitude']").val());
	var longitude = parseFloat($("input[name='si_longitude']").val());
	var back_html = $("#searchAddr").html();
	if(isNaN(latitude)){
		alert("좌표(위도)를 정확히 입력해 주세요.");
		$("input[name='si_latitude']").focus();
		return;
	}
	else if(isNaN(longitude)) {
		alert("좌표를(경도) 정확히 입력해 주세요.");
		$("input[name='si_longitude']").focus();
		return;
	}
	$("input[name='si_latitude']").val(latitude);
	$("input[name='si_longitude']").val(longitude);
	
	$.ajax({
		url: "google_map.do", 
	    type: "POST", 
	    data: {"latlng": latitude+","+longitude},
	    dataType : "json",
		success: function(json) {
			var resultData = $.parseJSON(json.resultData);
			try {
				var idx = -1;
				var road_addr = "";
				for(var z=0; json.results.length > z; z++) {
					var data = json.results[z];
					for(var i=0; i<data.address_components.length-1; i++){
						var d = data.address_components[i];
						var dong = d.long_name.substring(d.long_name.length-1);
						
						//도로명 주소
						if(dong.match(/[길|로]/g)) {
							idx = z;
							road_addr = data.formatted_address.replace("대한민국 ","");
							break;
						}
						if(i>2) break;
					}
					if(idx > -1) {
						break;
					}
				}
				var address = "";
				if(idx == -1) {
					address = json.results[0].formatted_address.replace("대한민국 ","");
				} else if(idx == 0) {
					address = json.results[1].formatted_address.replace("대한민국 ","");
				} else {
					address = json.results[0].formatted_address.replace("대한민국 ","");
				}
				if(address == "" && road_addr == "") {
					alert("주소 정보를 찾을 수 없습니다.");
				} else {
					alert("지도위치와 주소를 확인해 주시고,\n세부주소가 맞지 않을 경우 수정해 주세요.");
				}
				$("input[name='si_addr']").val(address);
				$("input[name='si_addr_road']").val(road_addr);
				
				console.log("address : " + address);
			}
			catch (e) {
				alert("주소 정보를 찾을 수 없습니다. ");	
			}			
			//addMarker(latitude, longitude); //지도 위치 잡아 주기
		},
		error: function(e) {
			alert('주소 정보를 찾을 수 없습니다.브라우저 버전을 확인해주세요.');
		}
	});

}

</script>

<form name="form1" id="form1" method="post" action="/home.action">
<input type="hidden" name="mode" value="${mode}">
<input type="hidden" name="proc_mode" value="">
<input type="hidden" name="cur_page" value="${cur_page}">
<input type="hidden" name="searchKey" value="${searchKey}">
<input type="hidden" name="searchText" value="${searchText}">
<input type="hidden" name="seq" value="${seq}">

<!-- 검색조건 -->
<input type="hidden" name="isSearch" value="${isSearch}">
<input type="hidden" name="addr1" value="${addr1}">
<input type="hidden" name="addr2" value="${addr2}">
<input type="hidden" name="addr3" value="${addr3}">
<input type="hidden" name="cat1" value="${cat1}">
<input type="hidden" name="cat2" value="${cat2}">
<input type="hidden" name="regId" value="${regId}">
<input type="hidden" name="sdate" value="${sdate}">
<input type="hidden" name="edate" value="${edate}">

<!-- 국문표기여부는 무조건 Y 처리 -->
<input type="hidden" name="si_ko_yn" value="Y" />

		<!-- contents -->
        <div id="contents">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td><img src="images/sub_title06.gif" /></td>
                  <td class="sub_text1">Home &gt; 관광안내표지 > 관광안내표지 등록(수정)  </td>
                </tr>
             </table>
             
         <table width="100%" border="0" cellpadding="0" cellspacing="0"  >
            <tr>
              <td valign="top" class="sub_box"><!-- 게시판 테이블 시작 -->
                  
              <table width="100%">
                <tr>
                  <td align="left" valign="top" class="sub_box"><img src="images/sub_s_title03.gif" alt="title" />                
                  
                  <div class="bbs_list">     
                  	<div class="notice"><span class="impo">*</span> 필수입력사항입니다.</div>             	
                    <table width="100%" class="bbs_head_line2" >    
                    	<colgroup><col width="15%" /><col width="85%" /></colgroup>
                    	<c:if test="${user.us_gbn eq 0}">                
                        <tr>
                          <td class="board_write01"><span class="impo">*</span>관리 지자체</td>
                          <td class="sub_text8">
                            <select onChange="getGugunCode(1, this.value, '')"  name="sido_code" setimage="images/arrow_image.gif" style="width:180px;" class="selet_box1">
                              <option value=""> 시/도 </option>
                              <c:forEach var="list" items="${contMap.gov_list}" varStatus="st">
                                 <option value="${list.GO_CODE}" ${list.GO_CODE eq fn:substring(contMap.data.SI_GO_CODE,0,2) ? 'selected' : ''} > ${list.GO_NAME } </option>
                             </c:forEach>
                            </select>
                            <select id="gugun_code" name="gugun_code" setimage="images/arrow_image.gif" style="width:180px;" class="selet_box1">
                            <option value=""> 시/군/구</option>
                            </select>
                        </tr>
                        </c:if>
                        <tr>
                          <td class="board_write01"><span class="impo">*</span>관리번호</td>
                          <td class="sub_text8">표지일련번호
                            <input type="text" name="si_reg_id" value="${contMap.data.SI_REG_ID}" style="width:200px; " class="input_common" onBlur="checkRegId()" /></td>
                        </tr>
                        
                        <tr>
                          <td class="board_write01"><span class="impo">*</span>표지종류 <a href="javascript:popSignType()"><img src="images/icon04.gif"  align="absmiddle"></a></td>
                          <td class="sub_text8">
                          <input type="hidden" name="si_type_code" value="${contMap.data.SI_TYPE_CODE}" >
                          	<select name="typeCode1" setimage="images/arrow_image.gif" style="width:180px;" class="selet_box1">
                              <option value=""> 구분 </option>
                              <c:forEach var="list" items="${contMap.st_list}" varStatus="st">
                                 <option value="${list.CO_CODE}" ${list.CO_CODE eq fn:substring(contMap.data.SI_TYPE_CODE,0,4) ? 'selected' : ''} > ${list.CO_NAME } </option>
                             </c:forEach>
                            </select>
                            <select onChange="setTypeCode(this.value)" name="typeCode2" setimage="images/arrow_image.gif" style="width:180px;" class="selet_box1">
                              <option value=""> 세분류 </option>
                            </select></td>
                        </tr>
                        
                        <tr>
                          <td class="board_write01"><span class="impo">*</span>관광지명</td>
                          <td class="sub_text8"><input type="text" name="si_place_name" value="${contMap.data.SI_PLACE_NAME}" style="width:200px; " class="input_common" /> 
                            <span class="color3"> * 안내표지가 설치된 관광지명을 입력하십시오 (예: 해운대, 경복궁)</span></td>
                        </tr>
                          
                        <tr>
                          <td class="board_write01">다국어 표기</td>
                          <td>
                          
                          <a href="http://kto.visitkorea.or.kr/kor/translation/main.kto" target="_blank" /><div class="stand_view"><img src="images/arrow02.gif" alt="images" class="icon"/> 표기표준보기 (외국어 용례집)</div> </a>          				  
                          
                          <c:if test="${user.us_gbn eq 0}">
                          <!-- 로그인(관리자) 모드 view -->
                          <table width="100%">
                            <colgroup><col width="12%" /><col width="12%" /><col width="32%" /><col width="32%" /><col width="12%" /></colgroup>
                            <tr>
                              <td class="sub_table3">표기언어</td>
                              <td class="sub_table3">표기 여부</td>
                              <td class="sub_table3">표기내용</td>
                              <td class="sub_table3">표기표준</td>
                              <td class="sub_table3">표준준수 여부</td>
                            </tr>
                            <tr>
                              <td class="sub_text12">국문</td>
                              <td class="sub_text11"><input type="checkbox" value="Y" ${contMap.data.SI_KO_YN eq 'Y' or contMap.data.SI_SEQ eq null ? 'checked' : ''}></td>
                              <td class="sub_text5"><input type="text" name="si_name_ko" value="${contMap.data.SI_NAME_KO}" style="width:150px; " class="input_common" /></td>                              
                              <td class="sub_text5"><input type="hidden" name="si_guide_name_ko" value="" />-</td>
                              <td class="sub_text11"><input type="hidden" name="si_ko_guide_yn" value="Y" >-</td>
                            </tr>
                            <tr>
                              <td class="sub_text12">영문</td>
                              <td class="sub_text11"><input type="checkbox" name="si_en_yn" id="checkbox" value="Y" ${contMap.data.SI_EN_YN eq 'Y' ? 'checked' : ''} ></td>
                              <td class="sub_text5"><input type="text" name="si_name_en" value="${contMap.data.SI_NAME_EN}" style="width:150px; " class="input_common" /></td>
                              <td class="sub_text5"><input type="text" name="si_guide_name_en" value="${contMap.data.SI_GUIDE_NAME_EN}" style="width:150px; " class="input_common" /></td>
                              <td class="sub_text11"><input type="checkbox" name="si_en_guide_yn" id="checkbox" value="Y" ${contMap.data.SI_EN_GUIDE_YN eq 'Y' ? 'checked' : ''} ></td>
                            </tr>
                            <tr>
                              <td class="sub_text12">중문</td>
                              <td class="sub_text11"><input type="checkbox" name="si_ch_yn" id="checkbox" value="Y" ${contMap.data.SI_CH_YN eq 'Y' ? 'checked' : ''} ></td>
                              <td class="sub_text5"><input type="text" name="si_name_ch" value="${contMap.data.SI_NAME_CH}" style="width:150px; " class="input_common" /></td>
                              <td class="sub_text5"><input type="text" name="si_guide_name_ch" value="${contMap.data.SI_GUIDE_NAME_CH}" style="width:150px; " class="input_common" /></td>
                              <td class="sub_text11"><input type="checkbox" name="si_ch_guide_yn" id="checkbox" value="Y" ${contMap.data.SI_CH_GUIDE_YN eq 'Y' ? 'checked' : ''} ></td>
                            </tr>
                            <tr>
                              <td class="sub_text12 ">일문</td>
                              <td class="sub_text11"><input type="checkbox" name="si_jp_yn" id="checkbox" value="Y" ${contMap.data.SI_JP_YN eq 'Y' ? 'checked' : ''} ></td>
                              <td class="sub_text5"><input type="text" name="si_name_jp" value="${contMap.data.SI_NAME_JP}" style="width:150px; " class="input_common" /></td>
                              <td class="sub_text5"><input type="text" name="si_guide_name_jp" value="${contMap.data.SI_GUIDE_NAME_JP}" style="width:150px; " class="input_common" /></td>
                              <td class="sub_text11"><input type="checkbox" name="si_jp_guide_yn" id="checkbox" value="Y" ${contMap.data.SI_JP_GUIDE_YN eq 'Y' ? 'checked' : ''} ></td>
                            </tr>
                          </table>
                          </c:if>
                          <c:if test="${user.us_gbn eq 1}">
                          <!-- 로그인(지자체) 모드-->
                          <table width="100%">
                            <colgroup><col width="15%" /><col width="15%" /><col width="70%" /></colgroup>
                            <tr>
                              <td class="sub_table3">표기언어</td>
                              <td class="sub_table3">표기 여부</td>
                              <td class="sub_table3">표기내용</td>
                            </tr>
                            <tr>
                              <td class="sub_text12">국문</td>
                              <td class="sub_text11"><input type="checkbox" checked disabled ></td>
                              <td class="sub_text5">
                              	<input type="text" name="si_name_ko" value="${contMap.data.SI_NAME_KO}" style="width:350px; " class="input_common" />                              
	                            <input type="hidden" name="si_guide_name_ko" value="" />
	                            <input type="hidden" name="si_ko_guide_yn" value="Y" />
                              </td>
                            </tr>
                            <tr>
                              <td class="sub_text12">영문</td>
                              <td class="sub_text11"><input type="checkbox" name="si_en_yn" id="checkbox" value="Y" ${contMap.data.SI_EN_YN eq 'Y' ? 'checked' : ''} ></td>
                              <td class="sub_text5">
                              	<input type="text" name="si_name_en" value="${contMap.data.SI_NAME_EN}" style="width:350px; " class="input_common" />
								<input type="hidden" name="si_guide_name_en" value="${contMap.data.SI_GUIDE_NAME_EN}" />
	                            <input type="hidden" name="si_en_guide_yn" value="${contMap.data.SI_EN_GUIDE_YN eq 'Y' ? 'Y' : 'N'}" />
                              </td>
                            </tr>
                            <tr>
                              <td class="sub_text12">중문</td>
                              <td class="sub_text11"><input type="checkbox" name="si_ch_yn" id="checkbox" value="Y" ${contMap.data.SI_CH_YN eq 'Y' ? 'checked' : ''} ></td>
                              <td class="sub_text5">
                              	<input type="text" name="si_name_ch" value="${contMap.data.SI_NAME_CH}" style="width:350px; " class="input_common" />
								<input type="hidden" name="si_guide_name_ch" value="${contMap.data.SI_GUIDE_NAME_CH}" />
	                            <input type="hidden" name="si_ch_guide_yn" value="${contMap.data.SI_CH_GUIDE_YN eq 'Y' ? 'Y' : 'N'}" />
                              </td>
                            </tr>
                            <tr>
                              <td class="sub_text12 ">일문</td>
                              <td class="sub_text11"><input type="checkbox" name="si_jp_yn" id="checkbox" value="Y" ${contMap.data.SI_JP_YN eq 'Y' ? 'checked' : ''} ></td>
                              <td class="sub_text5">
                              	<input type="text" name="si_name_jp" value="${contMap.data.SI_NAME_JP}" style="width:350px; " class="input_common" />
								<input type="hidden" name="si_guide_name_jp" value="${contMap.data.SI_GUIDE_NAME_JP}" />
	                            <input type="hidden" name="si_jp_guide_yn" value="${contMap.data.SI_JP_GUIDE_YN eq 'Y' ? 'Y' : 'N'}" />
                              </td>
                            </tr>
                          </table>
                          </c:if>
                            <table width="100%">
                              <tr>
                                <td class="color3 border_no">* 표지에 사용되고 있는 다국어 표기 현황을 입력하십시오. 지도의 경우, 지도에 사용되고 있는 언어를 선택해주십시오</td>
                              </tr>
                            </table></td>
                        </tr> 
                  </table>
		     </div>
		  
		          <table width="100%">
		    <tr>
		    <td><img src="images/sub_s_title04.gif"></td>
			</tr>
		  </table>
		  
		  	<div class="bbs_list">
        		<table width="100%" class="bbs_head_line2">
				<colgroup><col width="15%" /><col width="35%" /><col width="15%" /><col width="35%" /></colgroup>
                 	 <tr>
                        <td class="board_write01"><span class="impo">*</span>지주형식 <a href="javascript:popPillar()"><img src="images/icon04.gif"  align="absmiddle"></a></td>
                        <td class="sub_text8">
                        
                        <div id="sp_list" style="display:none;">
                        <c:forEach var="list" items="${contMap.sp_list}" varStatus="st">
                        <li>
                        	<span class="co_code">${list.CO_CODE}</span>
                        	<span class="co_name">${list.CO_NAME}</span>
                        </li>
                        </c:forEach>
                        </div>
                        
						   <select  name="si_pillar_code" setimage="images/arrow_image.gif" style="width:180px;" class="selet_box1">
                              <option value=""> 선택 </option>
                              <c:forEach var="list" items="${contMap.sp_list}" varStatus="st">
                              	<c:choose>
                              		<c:when test="${st.index > 3 and (fn:substring(contMap.data.SI_TYPE_CODE,0,4) eq 'ST01' or fn:substring(contMap.data.SI_TYPE_CODE,0,4) eq 'ST01')}">
                              		</c:when>
                              		<c:otherwise>
                              		<option value="${list.CO_CODE}" ${list.CO_CODE eq contMap.data.SI_PILLAR_CODE ? 'selected' : ''} > ${list.CO_NAME } </option>
                              		</c:otherwise>
                              	</c:choose> 
                             </c:forEach>
                           </select></td>
                        <td class="board_write01"><span class="impo">*</span>지주재질</td>
                        <td class="sub_text8">
						   <input type="text" name="si_material" value="${contMap.data.SI_MATERIAL}" style="width:180px; " class="input_common" /></td>
                  	</tr>
          
         		    <tr>
                      <td class="board_write01"><span class="impo">*</span>설치일</td>
                      <td class="sub_text8">
                      <input type=hidden name="si_install_date" value="${contMap.data.SI_INSTALL_DATE}">
					  <select  id="iyear" setimage="images/arrow_image.gif" style="width:60px;" class="selet_box1">
					  <c:set var="y" value="${contMap.year+1}" />
					  <option value="0000"> ---- </option>
					  <c:forEach var="i" begin="1950" end ="${contMap.year}">
					  <c:set var="y" value="${y-1}" />
                        <option value="${y}">${y}</option>
                      </c:forEach>						
                      </select> 
                        년 
                        <select  id="imonth" setimage="images/arrow_image.gif" style="width:45px;" class="selet_box1">
                          <option value="00"> -- </option>
                          <c:forEach var="i" begin="1" end ="12">
                          <c:set var="m" value="0${i}" />
                          <option value="${fn:substring(m,fn:length(m)-2,3)}">${fn:substring(m,fn:length(m)-2,3)}</option>
                          </c:forEach>
                        </select> 
                        월 
                        <select  id="iday" setimage="images/arrow_image.gif" style="width:45px;" class="selet_box1">
                          <option value="00"> -- </option>
                          <c:forEach var="i" begin="1" end ="31">
                          <c:set var="m" value="0${i}" />
                          <option value="${fn:substring(m,fn:length(m)-2,3)}">${fn:substring(m,fn:length(m)-2,3)}</option>
                          </c:forEach>
                        </select> 
                        일 </td>
                        <td class="board_write01">
                        <c:if test="${contMap.data.SI_SEQ ne null}">
                        	철거일
                        </c:if>
                        </td>
                        <td class="sub_text8">
                        
                        <c:if test="${contMap.data.SI_SEQ ne null}">
                        
                        <input type="hidden" name="si_requidation_date" value="${contMap.data.SI_REQUIDATION_DATE}">
						<select  id="ryear" setimage="images/arrow_image.gif" style="width:60px;" class="selet_box1">
                        <c:set var="y" value="${contMap.year+1}" />
						  <option value="0000"> ---- </option>
						  <c:forEach var="i" begin="1950" end ="${contMap.year}">
						  <c:set var="y" value="${y-1}" />
	                        <option value="${y}">${y}</option>
	                      </c:forEach>
                      </select> 
                        년 
                        <select  id="rmonth" setimage="images/arrow_image.gif" style="width:45px;" class="selet_box1">
                          <option value="00"> -- </option>
                          <c:forEach var="i" begin="1" end ="12">
                          <c:set var="m" value="0${i}" />
                          <option value="${fn:substring(m,fn:length(m)-2,3)}">${fn:substring(m,fn:length(m)-2,3)}</option>
                          </c:forEach>
                        </select> 
                        월 
                        <select  id="rday" setimage="images/arrow_image.gif" style="width:45px;" class="selet_box1">
                          <option value="00"> -- </option>
                          <c:forEach var="i" begin="1" end ="31">
                          <c:set var="m" value="0${i}" />
                          <option value="${fn:substring(m,fn:length(m)-2,3)}">${fn:substring(m,fn:length(m)-2,3)}</option>
                          </c:forEach>
                        </select> 
                        일
                        </c:if>
                        </td>
                    </tr>
			    </table>
					
                <table width="100%">
					<colgroup><col width="15%" /><col width="85%" /></colgroup>
                    <tr>
                        <td class="board_write01"><span class="impo">*</span>표지규격</td>
                        <td colspan="3" class="sub_text8">가로
                           <input type="text" name="si_width" value="${contMap.data.SI_WIDTH}" style="width:100px; " class="input_common" />
                           cm , &nbsp;&nbsp; 세로
                           <input type="text" name="si_height" value="${contMap.data.SI_HEIGHT}" style="width:100px; " class="input_common" />
                           cm </td>
                  </tr>
          			<c:if test="${contMap.data.SI_SEQ ne null}">
                    <tr>
                        <td class="board_write01">유지보수<br /> 이력관리 </td>
                        <td class="sub_text8"><a href="javascript:popMaintenance()"><img src="images/btn_view.gif"></a></td>
                    </tr> 
                    </c:if>
          		</table>
		  
		  		<table width="100%" >
		  			<colgroup><col width="15%" /><col width="85%" /></colgroup>
                      <tr>
                        <td class="board_write01">위치정보</td>
						<td>
                            <table width="100%" class="bbs_small_list">
                              <tr>
                                <td class="sub_text8"><span>*</span>위도 <input type="text" name="si_latitude" value="${contMap.data.SI_LATITUDE}" style="width:180px; " class="input_common" /> &nbsp;&nbsp; <span>*</span>경도  <input type="text" name="si_longitude" value="${contMap.data.SI_LONGITUDE}" style="width:180px; " class="input_common" />
                                
                                <span id="searchAddr"><a href="javascript:getAddress()"><div class="stand_view"> <img src="images/arrow02.gif" alt="images" class="icon"/> 검색 </div></a></span>
                                
                                </td>
                              </tr>
                              <tr>
                                <td class="sub_text8">
                                	<div id="map_canvas" style="width:550px;height:400px;"></div>	
                                </td>
                              </tr>

                             <tr>
                                <td class="sub_text8">
                                  <h3><img src="images/arrow02.gif" alt="icon" / >&nbsp; 지번주소</h3>
                                  <!-- p>                                              
                                  <input type="hidden" name="si_addr_po_code" value="${contMap.data.SI_ADDR_PO_CODE}">                      
                                  <select onChange="getGugunCode(2, this.value, '')" id="paddr1" setimage="images/arrow_image.gif" style="width:120px;" class="selet_box1">
	                              	<option value=""> 전국(시,도) </option>
	                              	<c:forEach var="list" items="${contMap.gov_list}" varStatus="st">
	                                <option value="${list.GO_CODE}" ${list.GO_CODE eq fn:substring(contMap.data.SI_ADDR_PO_CODE,0,2) ? 'selected' : ''} > ${list.GO_NAME } </option>
	                             	</c:forEach>
	                              </select>
	                            <select onChange="getDongCode(this.value,'')" id="paddr2" setimage="images/arrow_image.gif" style="width:120px;" class="selet_box1">
	                            	<option value=""> 구/군 </option>
	                            </select>
                                  <select  id="paddr3" setimage="images/arrow_image.gif" style="width:120px;" class="selet_box1">
                                    <option value=""> 동 </option>
                                  </select>
                                  </p-->
                                  <p>
                                  상세주소&nbsp;
                                  <input type="text" name="si_addr" value="${contMap.data.SI_ADDR}" style="width:470px; " class="input_common" />
                                  </p>
                               </td>
                             </tr>
                         
                             <tr>
                                <td class="sub_text8">
                                  <h3><img src="images/arrow02.gif" alt="icon" / >&nbsp; 도로명주소</h3>
                                  <!-- p>                         
	                                  <input type="hidden" name="si_addr_road_po_code" value="${contMap.data.SI_ADDR_ROAD_PO_CODE}">                     
	                                  <select onChange="getGugunCode(3, this.value, '')" id="raddr1" setimage="images/arrow_image.gif" style="width:120px;" class="selet_box1">
		                              	<option value=""> 전국(시,도) </option>
		                              	<c:forEach var="list" items="${contMap.gov_list}" varStatus="st">
		                                <option value="${list.GO_CODE}" ${list.GO_CODE eq fn:substring(contMap.data.SI_ADDR_ROAD_PO_CODE,0,2) ? 'selected' : ''} > ${list.GO_NAME } </option>
		                             	</c:forEach>
		                              </select>
		                            <select  id="raddr2" setimage="images/arrow_image.gif" style="width:120px;" class="selet_box1">
		                            	<option value=""> 구/군 </option>
		                            </select>
                                  </p-->
                                  <p>
                                  상세주소&nbsp;
                                  <input type="text" name="si_addr_road"  style="width:470px; " class="input_common" />
                                  </p>
                               </td>
                              </tr>
                              
                              <tr>
                                <td class="sub_text8">
                                  <h3><img src="images/arrow02.gif" alt="icon" / >&nbsp; 위치(상세지역설명)</h3>
                                  <p> 
                                  	<input type="text" name="si_location" value="${contMap.data.SI_LOCATION}" style="width:98%; " class="input_common" />
                                  </p>
                               </td>
                              </tr>

                          </table>					  
                        </td>
                  </tr>

					  <tr>
                        <td rowspan="2" class="board_write01">이미지정보</td>
                        <td class="sub_text8">
                        
						<div class="bbs_small_list">
						<table>
                          <tr>
                            <td><!--<span class="impo">*</span>-->원거리</td>
                            <td><!--<span class="impo">*</span>-->근거리</td>
                          </tr>
                          <tr>
                            <td align="center">
                            	<div id="img1">
                            		<img src="${contMap.data.SI_IMG_URL1 ne null ? contMap.data.SI_IMG_URL1 : '/images/sub_image01.gif'}" width="270px;"/>
                            	</div>
                            	<input type="hidden" name="si_img_url1" value="${contMap.data.SI_IMG_URL1}" >
                            </td>
                            <td align="center">
                            	<div id="img2">
                            		<img src="${contMap.data.SI_IMG_URL2 ne null ? contMap.data.SI_IMG_URL2 : '/images/sub_image01.gif'}" width="270px;"/>
                            	</div>
                            	<input type="hidden" name="si_img_url2" value="${contMap.data.SI_IMG_URL2}" >
                            </td>
                          </tr>
                          <tr>
                            <td class="sub_text6 border_no">
                            </td>
                            <td class="sub_text6 border_no">
                            </td>
                          </tr>
                        </table>
						</div>						
						
						</td>
					  </tr>
                      <tr>
                        <td class="sub_text8">* 다음 로드뷰 태그 입력 <span class="color3">[다음 로드맵 URL / 지도삽입 도움말] <a href="javascript:popRoadView()"><img src="images/icon04.gif"  align="absmiddle"></a></span> <a href="http://map.daum.net/" target="_blank"><div class="stand_view"><img src="images/arrow02.gif" alt="images" class="icon"/> 로드뷰 열기 </div></a>
                        <br /><br />
                        <p style="padding-left:10px">로드뷰 URL 입력 <input type="text" name="si_rv_url" value="${contMap.data.SI_RV_URL}" style="width:98%;height:20px;"/></p>
                        <br />
                        <p id="roadView"></p>
                         <p style="padding-left:10px"> 로드뷰 지도삽입 입력
                        	<textarea name="si_rv_code" style="width:98%;height:100px;" class="input_common" onBlur="showLoadView(this)">${contMap.data.SI_RV_CODE}</textarea>                        </p>
                        
                        </td>
                        
                      </tr>
                </table>
			  </td>
				    
            </table>
			
				    
            <img src="images/spc.gif" height="15" />
            
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
              	<c:if test="${contMap.deleteButton eq 1 }">
                <td align="left">
                	<a href="javascript:deleteData()"><img src="images/btn_delet.gif" /></a>
                </td>
                </c:if>
                <td align="right">
                	<div id="btnDiv">
	                	<a href="javascript:saveData()"><img src="images/btn_save.gif" /></a> 
	                	<a href="javascript:goList();"><img src="images/btn_list.gif" /></a>
                	</div>
                	<div style="align:center;display:none;" id="upfile_spinner" ><img src="/js/images/ajax-loader.gif" ></div>
                </td>
              </tr>
            </table>
					
              <img src="images/spc.gif" height="15" /></td>
          </tr>
        </table> 
        </div>
        <!-- contents -->
</form>        


</form>
</div>
