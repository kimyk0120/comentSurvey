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
<script type="text/javascript">

	$(document).ready(function() {
		
		var y = "<c:out value="${now_ym}" />";
		
		if(y.substring(0, 4) != null && y.substring(0, 4) != '') {
			$("#srch_yy").val(y.substring(0, 4)).change(); 
		}
		if(y.substring(5, 7) != null && y.substring(5, 7) != '') {
			$("#srch_mm").val(y.substring(5, 7)).change(); 
		}
		
		var sido = "<c:out value="${info.srch_sido_cd}"/>";
		var gugun = "<c:out value="${info.srch_gugun_cd}"/>";
		
		if(sido != null && sido != '') {
			
		$("#srch_sido_cd").val(sido).change();
		
			$.ajax({ 
				   url: "srch_gugun.do", 
				   type: "POST", 
				   data: {"s_sido" : sido},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "<select class=\"formSelect\" id=\"srch_gugun_cd\" name=\"srch_gugun_cd\" style=\"width:180px;text-align:center;color:#6f7fc0;background-color:#d4daf3\" title=\"\">";
					   str=str+"<option value=\"\">선택</option>";
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	     				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   str = str+"</select>";
					   document.getElementById("gugun_div").innerHTML=str;
					   
					   $('.formSelect').sSelect();
					   if(gugun != null && gugun != '') {
						   $("#srch_gugun_cd").val(gugun).change(); 
					   }
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
		}
		
	});
	
	$(function() {
		$('.formSelect').sSelect();
		$('#tabs').tabs();
	});
	
	function go_term(prt) {
		
		$('#go_prt').val(prt);
		document.mainform.target = "_self";
		document.mainform.action = "cmmt_stats.do";
		document.mainform.submit();
	}
	
	function excel_down() {
		
		document.mainform.target = "_self";
		document.mainform.action = "stats_excel_down.do";
		document.mainform.submit();
	}
		
	function get_gugun() {
			
		var s_sido = $("select[name=srch_sido_cd]").val();
		
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var str = "<select class=\"formSelect\" id=\"srch_gugun_cd\" name=\"srch_gugun_cd\" style=\"width:150px;text-align:center;color:#6f7fc0;background-color:#d4daf3\" title=\"\">";
				   str=str+"<option value=\"\">전체</option>";
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
	
</script>
</head>
<body>
<div id="wrapper">
	
	<form id="mainform" name="mainform" action="" method="post">
	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container" class="main"><!-- 메인 페이지에 클래스 main 삽입 -->

		<div class="user-info">
			<div class="shadow-box">
				<div class="comment">안녕하세요.</div>
				<div class="view-content">
					<div class="user-photo">
						<div class="photo"><img src="image/user_default_70.png" alt="문지식님" /></div>
						<div class="cover"><a href="#a"><img src="image/user_cover_70.png" alt="문지식님" /></a></div><!-- 클릭했을 때 사용자 정보로 이동하지 않으면 a 태그 삭제 -->
					</div>
					<p class="name"><strong>문 지식</strong> 님</p>
					<p>현재 업데이트 현황입니다.</p>
				</div>
			</div><!--// shadow-box -->

			<div class="shadow-box">
				<div class="btn">
					<a href="#a"><span class="text1">문화관광해설사</span><span class="text2">관 리 시 스 템</span><span class="text3">안내</span></a>
				</div>
			</div><!--// shadow-box -->

		</div><!--// user-info -->
<input type="hidden" id="go_prt" name="go_prt" />

		<div class="contents">
		
			<div class="set-period">
					<span class="txt-symbol">기준년월</span>
						<select class="formSelect" id="srch_yy" name="srch_yy" style="width:80px;" title="">
							<c:forEach items="${y_list}" var="y">
								<option value="${y.yyyy}">${y.yyyy}</option>
							</c:forEach>
						</select><span style="margin:0px 15px 0 5px">년</span>
						<select class="formSelect" style="width:50px" title="월" name="srch_mm" id="srch_mm">
							<option value="01">1</option><option value="02">2</option><option value="03">3</option><option value="04">4</option>
							<option value="05">5</option><option value="06">6</option><option value="07">7</option><option value="08">8</option>
							<option value="09">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>
						</select><span style="margin:0px 15px 0 5px"> 월 </span>
				<span class="btn-term3 mr7"><a href="javascript:go_term('1')" class="btn-mon2" title="월 단위 선택"><span class="text-hidden">월 단위 선택</span></a></span>
				<span class="btn-term3 mr7"><a href="javascript:go_term('2')" class="btn-qtr2" title="분기 단위 선택"><span class="text-hidden">분기 단위 선택</span></a></span>
				<span class="btn-term3 mr7"><a href="javascript:go_term('3')" class="btn-half2" title="반기 단위 선택"><span class="text-hidden">반기 단위 선택</span></a></span><!-- 선택된 보기 설정에 믈래스 on 삽입-->
				<span class="btn-term3 on"><a href="javascript:go_term('4')" class="btn-year2" title="년 단위 선택"><span class="text-hidden">년 단위 선택</span></a></span><!-- 선택된 보기 설정에 믈래스 on 삽입-->
			</div>
			
			<div class="col2 clearfix">
				<div class="shadow-box float-left" style="width:48%">
					<div class="top-bar">
						<h2>문화관광해설사 성별/연령별 현황</h2>
						<div class="btn-box"><a href="javascript:excel_down()" class="btn-excel" title="엑셀 다운로드"><span class="text-hidden">다운</span></a></div>
					</div>
					<div class="view-content">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:40%" />
								<col style="width:40%" />
							</colgroup>
							<thead>
								<tr>
									<th style="border-right:1px solid #fff">시도</th>
									<th colspan="2">
										<select class="formSelect" id="srch_sido_cd" name="srch_sido_cd" style="width:150px;text-align:center;color:#6f7fc0;background-color:#d4daf3" title="" onchange="get_gugun()">
											<option value="">전체</option>
											<c:forEach items="${s_list}" var="s">
												<option value="${s.sido_cd}">${s.sido_cd_nm}</option>
											</c:forEach>
										</select>
									</th>
								</tr>
								<tr>
									<th rowspan="2" style="border-right:1px solid #fff">연령별</th>
									<th colspan="2">성별</th>
								</tr>
								<tr>
									<th style="background:#f0f3ff;border-right:1px solid #fff">여성</th>
									<th style="background:#f0f3ff;">남성</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>20대 미만</th>
									<td>12</td>
									<td>5</td>
								</tr>
								<tr>
									<th>20대</th>
									<td>19</td>
									<td>14</td>
								</tr>
								<tr>
									<th>30대</th>
									<td>55</td>
									<td>42</td>
								</tr>
								<tr>
									<th>40대</th>
									<td>49</td>
									<td>35</td>
								</tr>
								<tr>
									<th>50대</th>
									<td>40</td>
									<td>30</td>
								</tr>
								<tr>
									<th>60대</th>
									<td>22</td>
									<td>12</td>
								</tr>
								<tr>
									<th>70대 이상</th>
									<td style="border-bottom:1px solid #fff">10</td>
									<td style="border-bottom:1px solid #fff">7</td>
								</tr>
								<tr>
									<th style="background:#d4daf3;border-right:1px solid #fff;border-top:1px solid #fff">총 계</th>
									<th style="border-right:1px solid #fff;border-top:1px solid #fff">195</th>
									<th style="border-top:1px solid #fff">154</th>
								</tr>
							</tbody>
						</table>
					</div>
				</div><!-- // shadow-box -->

				<div class="shadow-box float-right" style="width:48%">
					<div class="top-bar">
						<h2>문화관광해설사 성별/연령별 현황</h2>
						<div class="btn-box"><a href="#a" class="btn-excel" title="엑셀 다운로드"><span class="text-hidden">다운</span></a></div>
					</div>
					<div class="view-content">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:40%" />
								<col style="width:40%" />
							</colgroup>
							<thead>
								<tr>
									<th style="border-right:1px solid #fff">시도</th>
									<th colspan="2">
										<div id="gugun_div" style="display:inline;">
											<select class="formSelect" id="srch_gugun_cd" name="srch_gugun_cd" style="width:150px;text-align:center;color:#6f7fc0;background-color:#d4daf3" title="" onchange="get_gugun()">
												<option value="">전체</option>
												<c:forEach items="${s_list}" var="s">
													<option value="${s.sido_cd}">${s.sido_cd_nm}</option>
												</c:forEach>
											</select>
										</div>
									</th>
								</tr>
								<tr>
									<th rowspan="2" style="border-right:1px solid #fff">연령별</th>
									<th colspan="2">성별</th>
								</tr>
								<tr>
									<th style="background:#f0f3ff;border-right:1px solid #fff">여성</th>
									<th style="background:#f0f3ff;">남성</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>20대 미만</th>
									<td>5</td>
									<td>2</td>
								</tr>
								<tr>
									<th>20대</th>
									<td>11</td>
									<td>10</td>
								</tr>
								<tr>
									<th>30대</th>
									<td>22</td>
									<td>11</td>
								</tr>
								<tr>
									<th>40대</th>
									<td>23</td>
									<td>12</td>
								</tr>
								<tr>
									<th>50대</th>
									<td>20</td>
									<td>12</td>
								</tr>
								<tr>
									<th>60대</th>
									<td>15</td>
									<td>14</td>
								</tr>
								<tr>
									<th>70대 이상</th>
									<td style="border-bottom:1px solid #fff">9</td>
									<td style="border-bottom:1px solid #fff">7</td>
								</tr>
								<tr>
									<th style="background:#d4daf3;border-right:1px solid #fff;border-top:1px solid #fff">총 계</th>
									<th style="border-right:1px solid #fff;border-top:1px solid #fff">91</th>
									<th style="border-top:1px solid #fff">65</th>
								</tr>
							</tbody>
						</table>
					</div>
				</div><!-- // shadow-box -->
			</div><!-- // col2 -->
			
			<div class="col2 clearfix" style="margin-top:20px">
				<div class="shadow-box float-left" style="width:48%">
					<div class="top-bar">
						<h2>지역별 문화관광해설사 배치 현황</h2>
						<div class="btn-box"><a href="#a" class="btn-excel" title="엑셀 다운로드"><span class="text-hidden">다운</span></a></div>
					</div>
					<div class="view-content" style="width:97%;min-height:0px">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:16%" />
								<col style="width:16%" />
								<col style="width:16%" />
								<col style="width:16%" />
								<col style="width:16%" />
							</colgroup>
							<thead>
								<tr>
									<th style="border-right:1px solid #fff">구분</th>
									<th colspan="5" style="border-right:1px solid #fff">문화관광해설사 배치현황</th>
								</tr>
								<tr>
									<th style="background:#f0f3ff;border-right:1px solid #fff">지역</th>
									<th style="background:#f0f3ff;border-right:1px solid #fff">해설사 1인당 월평균 배치일수</th>
									<th style="background:#f0f3ff;border-right:1px solid #fff">해설사 1인당 일일평균 활동시간</th>
									<th style="background:#f0f3ff;border-right:1px solid #fff">해설사 1인당 월 평균 활동시간</th>
									<th style="background:#f0f3ff;border-right:1px solid #fff">해설사 일일 최소활동시간</th>
									<th style="background:#f0f3ff;">해설사 일일 최대활동시간</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="view-content" style="overflow: auto;height: 250px; width: 100%;">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:16%" />
								<col style="width:16%" />
								<col style="width:16%" />
								<col style="width:16%" />
								<col style="width:16%" />
							</colgroup>
							<tbody>
								<tr>
									<td>서울특별시</td>
									<td>17.9</td>
									<td>7.2</td>
									<td>163</td>
									<td>4</td>
									<td>8</td>
								</tr>
								<tr>
									<td>부산광역시</td>
									<td>17.2</td>
									<td>7.0</td>
									<td>151</td>
									<td>3</td>
									<td>8</td>
								</tr>
								<tr>
									<td>대구광역시</td>
									<td>18.5</td>
									<td>7.6</td>
									<td>194</td>
									<td>4</td>
									<td>8</td>
								</tr>
								<tr>
									<td>인천광역시</td>
									<td>15.3</td>
									<td>6.2</td>
									<td>118</td>
									<td>4</td>
									<td>8</td>
								</tr>
								<tr>
									<td>광주광역시</td>
									<td>15.7</td>
									<td>6.5</td>
									<td>121</td>
									<td>5</td>
									<td>7</td>
								</tr>
								<tr>
									<td>대전광역시</td>
									<td>16.9</td>
									<td>7.1</td>
									<td>132</td>
									<td>4</td>
									<td>8</td>
								</tr>
								<tr>
									<td>경기도</td>
									<td>16.9</td>
									<td>7.1</td>
									<td>143</td>
									<td>4</td>
									<td>8</td>
								</tr>
								<tr>
									<td>강원도</td>
									<td>15.7</td>
									<td>6.7</td>
									<td>123</td>
									<td>4</td>
									<td>8</td>
								</tr>
								<tr>
									<td>충청북도</td>
									<td>15.4</td>
									<td>6.7</td>
									<td>111</td>
									<td>4</td>
									<td>8</td>
								</tr>
								<tr>
									<td>충청남도</td>
									<td>16.1</td>
									<td>6.8</td>
									<td>134</td>
									<td>4</td>
									<td>8</td>
								</tr>
								<tr>
									<td>전라북도</td>
									<td>16.2</td>
									<td>6.3</td>
									<td>107</td>
									<td>4</td>
									<td>7</td>
								</tr>
								<tr>
									<td>전라남도</td>
									<td>15.2</td>
									<td>6.5</td>
									<td>102</td>
									<td>4</td>
									<td>8</td>
								</tr>
								<tr>
									<td>경상남도</td>
									<td>17.6</td>
									<td>7.1</td>
									<td>165</td>
									<td>4</td>
									<td>8</td>
								</tr>
								<tr>
									<td>경상북도</td>
									<td>17.1</td>
									<td>7.2</td>
									<td>168</td>
									<td>4</td>
									<td>8</td>
								</tr>
								<tr>
									<td>세종시</td>
									<td>12.7</td>
									<td>6.2</td>
									<td>102</td>
									<td>3</td>
									<td>6</td>
								</tr>
								<tr>
									<td>제주시</td>
									<td>16.9</td>
									<td>7.0</td>
									<td>154</td>
									<td>4</td>
									<td>8</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div><!-- // shadow-box -->

				<div class="shadow-box float-right" style="width:48%">
					<div class="top-bar">
						<h2>지역별 문화관광해설사 해설서비스 수요 현황</h2>
						<div class="btn-box"><a href="#a" class="btn-excel" title="엑셀 다운로드"><span class="text-hidden">다운</span></a></div>
					</div>
					<div class="view-content" style="width:97%;min-height:0px">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:20%" />
							</colgroup>
							<thead>
								<tr>
									<th colspan="2" style="border-right:1px solid #fff">구분</th>
									<th colspan="3" style="border-right:1px solid #fff">해설서비스 수요 현황</th>
								</tr>
								<tr>
									<th style="background:#f0f3ff;border-right:1px solid #FFF">지역</th>
									<th style="background:#f0f3ff;border-right:1px solid #FFF;">관광자원명</th>
									<th style="background:#f0f3ff;border-right:1px solid #FFF;">해설사 상시 배치인원</th>
									<th style="background:#f0f3ff;border-right:1px solid #FFF">월 평균 방문객수</th>
									<th style="background:#f0f3ff;">월 평균 해설서비스 수요횟수</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="view-content" style="overflow: auto;height: 250px; width: 100%;">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:20%" />
							</colgroup>
							<tbody>
								<tr>
									<td>서울특별시</td>
									<td>박물관</td>
									<td>7</td>
									<td>221</td>
									<td>21</td>
								</tr>
								<tr>
									<td>부산광역시</td>
									<td>박물관</td>
									<td>5</td>
									<td>165</td>
									<td>18</td>
								</tr>
								<tr>
									<td>대구광역시</td>
									<td>박물관</td>
									<td>5</td>
									<td>209</td>
									<td>23</td>
								</tr>
								<tr>
									<td>인천광역시</td>
									<td>박물관</td>
									<td>5</td>
									<td>198</td>
									<td>20</td>
								</tr>
								<tr>
									<td>광주광역시</td>
									<td>박물관</td>
									<td>4</td>
									<td>165</td>
									<td>17</td>
								</tr>
								<tr>
									<td>대전광역시</td>
									<td>박물관</td>
									<td>4</td>
									<td>166</td>
									<td>18</td>
								</tr>
								<tr>
									<td>경기도</td>
									<td>박물관</td>
									<td>7</td>
									<td>198</td>
									<td>16</td>
								</tr>
								<tr>
									<td>강원도</td>
									<td>박물관</td>
									<td>4</td>
									<td>144</td>
									<td>11</td>
								</tr>
								<tr>
									<td>충청북도</td>
									<td>박물관</td>
									<td>4</td>
									<td>109</td>
									<td>10</td>
								</tr>
								<tr>
									<td>충청남도</td>
									<td>박물관</td>
									<td>4</td>
									<td>131</td>
									<td>16</td>
								</tr>
								<tr>
									<td>전라북도</td>
									<td>박물관</td>
									<td>7</td>
									<td>161</td>
									<td>17</td>
								</tr>
								<tr>
									<td>전라남도</td>
									<td>박물관</td>
									<td>4</td>
									<td>188</td>
									<td>18</td>
								</tr>
								<tr>
									<td>경상남도</td>
									<td>박물관</td>
									<td>4</td>
									<td>190</td>
									<td>19</td>
								</tr>
								<tr>
									<td>경상북도</td>
									<td>박물관</td>
									<td>4</td>
									<td>201</td>
									<td>22</td>
								</tr>
								<tr>
									<td>세종시</td>
									<td>박물관</td>
									<td>5</td>
									<td>119</td>
									<td>10</td>
								</tr>
								<tr>
									<td>제주시</td>
									<td>박물관</td>
									<td>4</td>
									<td>232</td>
									<td>31</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div><!-- // shadow-box -->
			</div><!-- // col2 -->
			
			<div class="col2 clearfix" style="margin-top:20px">
				<div class="shadow-box float-left" style="width:48%">
					<div class="top-bar">
						<h2>지역별 문화관광해설사 보수교육 실시 현황</h2>
						<div class="btn-box"><a href="#a" class="btn-excel" title="엑셀 다운로드"><span class="text-hidden">다운</span></a></div>
					</div>
					<div class="view-content" style="width:97%;min-height:0px">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:15%" />
								<col style="width:25%" />
								<col style="width:20%" />
								<col style="width:20%" />
							</colgroup>
							<thead>
								<tr>
									<th style="border-right:1px solid #FFF;">구분</th>
									<th colspan="4" style="border-right:1px solid #FFF;"> <fmt:formatDate value="${now}" pattern="yyyy" />년도  보수교육 실시 현황</th>
								</tr>
								<tr>
									<th style="background:#f0f3ff;border-right:1px solid #FFF;">지역</th>
									<th style="background:#f0f3ff;border-right:1px solid #FFF;">보수교육 실시여부(실시/미실시)</th>
									<th style="background:#f0f3ff;border-right:1px solid #FFF;">보수교육실시 기관명</th>
									<th style="background:#f0f3ff;border-right:1px solid #FFF;">보수교육 실시 시기</th>
									<th style="background:#f0f3ff;">보수교육참여인원</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="view-content" style="overflow: auto;height:250px; width: 100%;">
						<table class="talbe-list2 dark">
							<colgroup>
								<col style="width:20%" />
								<col style="width:15%" />
								<col style="width:25%" />
								<col style="width:20%" />
								<col style="width:20%" />
							</colgroup>
							<tbody>
								<tr>
									<td>서울특별시</td>
									<td>실시</td>
									<td>서울문화원</td>
									<td>2015-10-01</td>
									<td>18</td>
								</tr>
								<tr>
									<td>부산광역시</td>
									<td>실시</td>
									<td>부산문화원</td>
									<td>2015-05-01</td>
									<td>15</td>
								</tr>
								<tr>
									<td>대구광역시</td>
									<td>실시</td>
									<td>대구문화원</td>
									<td>2015-02-01</td>
									<td>22</td>
								</tr>
								<tr>
									<td>인천광역시</td>
									<td>실시</td>
									<td>인천문화원</td>
									<td>2015-09-01</td>
									<td>17</td>
								</tr>
								<tr>
									<td>광주광역시</td>
									<td>실시</td>
									<td>광주문화원</td>
									<td>2015-07-01</td>
									<td>22</td>
								</tr>
								<tr>
									<td>대전광역시</td>
									<td>실시</td>
									<td>대전문화원</td>
									<td>2015-10-01</td>
									<td>21</td>
								</tr>
								<tr>
									<td>경기도</td>
									<td>실시</td>
									<td>경기문화원</td>
									<td>2015-03-01</td>
									<td>32</td>
								</tr>
								<tr>
									<td>강원도</td>
									<td>실시</td>
									<td>강원문화원</td>
									<td>2015-10-01</td>
									<td>8</td>
								</tr>
								<tr>
									<td>충청북도</td>
									<td>실시</td>
									<td>충청문화원</td>
									<td>2015-10-01</td>
									<td>8</td>
								</tr>
								<tr>
									<td>충청남도</td>
									<td>실시</td>
									<td>문화원</td>
									<td>2015-10-01</td>
									<td>8</td>
								</tr>
								<tr>
									<td>전라북도</td>
									<td>실시</td>
									<td>문화원</td>
									<td>2015-10-01</td>
									<td>16</td>
								</tr>
								<tr>
									<td>전라남도</td>
									<td>실시</td>
									<td>문화원</td>
									<td>2015-10-01</td>
									<td>13</td>
								</tr>
								<tr>
									<td>경상남도</td>
									<td>실시</td>
									<td>문화원</td>
									<td>2015-10-01</td>
									<td>18</td>
								</tr>
								<tr>
									<td>경상북도</td>
									<td>실시</td>
									<td>문화원</td>
									<td>2015-10-01</td>
									<td>12</td>
								</tr>
								<tr>
									<td>세종시</td>
									<td>실시</td>
									<td>문화원</td>
									<td>2015-10-01</td>
									<td>11</td>
								</tr>
								<tr>
									<td>제주시</td>
									<td>실시</td>
									<td>문화원</td>
									<td>2015-10-01</td>
									<td>9</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div><!-- // shadow-box -->

			</div><!-- // col2 -->


		</div><!--// contents -->
	</div><!--// container -->
	</form>
</div>


</body>
</html>


