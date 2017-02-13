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
<script src="common/js/Chart.js"></script>

<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<!-- <script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script> -->
<script type="text/javascript" src="common/js/ui.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		
		var prt = "<c:out value="${srch.srch_dt_prt}" />";
		$("#srch_dt_prt").val(prt).change(); 		
		
		var str = "<c:out value="${srch.srch_str_ym}" />";
		var end = "<c:out value="${srch.srch_end_ym}" />";
		
		if(prt == "1") {
			$("#srch_mm1").css("display","inline-block");
			$("#srch_mm2").css("display","inline-block");
			$("#srch_yy1").css("display","none");
			$("#srch_yy2").css("display","none");
			if(str != "")  $("#str_ym1").val(str).change(); 
			if(end != "") $("#end_ym1").val(end).change(); 
		} else if(prt == "2") {
			$("#srch_mm1").css("display","none");
			$("#srch_mm2").css("display","none");
			$("#srch_yy1").css("display","inline-block");
			$("#srch_yy2").css("display","inline-block");
			if(str != "") $("#str_ym2").val(str.substring(0, 4)).change(); 
			if(end != "") $("#end_ym2").val(end.substring(0, 4)).change(); 
		} 
	});
	
	function ym_change() {
		
		var prt = $("select[name=srch_dt_prt]").val();
		
		if(prt == "1") {
			$("#srch_mm1").css("display","inline-block");
			$("#srch_mm2").css("display","inline-block");
			$("#srch_yy1").css("display","none");
			$("#srch_yy2").css("display","none");
		} else if(prt == "2") {
			$("#srch_mm1").css("display","none");
			$("#srch_mm2").css("display","none");
			$("#srch_yy1").css("display","inline-block");
			$("#srch_yy2").css("display","inline-block");
		} 
	}
	
	$(function() {
		/* $('.formSelect').sSelect(); */
		$('#tabs').tabs();
	});
	
	function go_srch() {
		
		var prt = $("select[name=srch_dt_prt]").val();
		var str1 = $("select[name=str_ym1]").val();
		var end1 = $("select[name=end_ym1]").val();
		var str2 = $("select[name=str_ym2]").val();
		var end2 = $("select[name=end_ym2]").val();
		
		if(prt == "1") {
			$('#srch_str_ym').val(str1);
			$('#srch_end_ym').val(end1);
		} else if(prt == "2") {
			$('#srch_str_ym').val(str2+'-01');
			$('#srch_end_ym').val(end2+'-12');
		} 
		
		if( $('#srch_str_ym').val() > $('#srch_end_ym').val()  ){
			alert("시작값이 종료값보다 클 수 없습니다.");
			return;
		}
		else {
			document.mainform.target = "_self";
			document.mainform.action = "main.do";
			document.mainform.submit();
		}
	}
	
	function excel_down() {
		document.mainform.target = "_self";
		document.mainform.action = "stats_excel_down.do";
		document.mainform.submit();
	}
	
	function main_info() {
		window.location.href="main_info.do?top=9&left=9";
	}
	
	function qna_info(q_no) {
		$('#q_seq').val(q_no);
		document.mainform.action = "qna_info.do";
		document.mainform.submit();
	}
	
	function board_info(b_no) {
		$('#b_seq').val(b_no);
		document.mainform.action = "board_info.do";
		document.mainform.submit();
	}
	
</script>
<style type="text/css">
	.chart-legend li span{
    display: inline-block;
    width: 12px;
    height: 12px;
    margin-right: 5px;
}
</style>
</head>
<body>
<div id="wrapper">

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="srch_str_ym" name="srch_str_ym" />
<input type="hidden" id="srch_end_ym" name="srch_end_ym" />
<input type="hidden" id="b_seq" name="b_seq" />
<input type="hidden" id="q_seq" name="q_seq" />
	
	<jsp:include page="main/topMenu.jsp"  />

	<div id="container" class="main"><!-- 메인 페이지에 클래스 main 삽입 -->

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
								<div class="cover"><img src="image/user_cover_70.png" alt="<%=session.getAttribute("UserNm") %>" /></div><!-- 클릭했을 때 사용자 정보로 이동하지 않으면 a 태그 삭제 -->
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
<input type="hidden" id="go_prt" name="go_prt" />

		<div class="contents">

			<div class="set-period">
				<span class="txt-symbol">검색기준</span>
					<select class="formSelect" id="srch_dt_prt" name="srch_dt_prt" style="width:80px;" title="" onchange="javascript:ym_change()">
						<option value="1">월</option>
						<option value="2">년</option>
					</select>
			
				<span class="txt-symbol">시작</span>
				<div id="srch_mm1" style="display:inline-block">
					<select class="formSelect" id="str_ym1" name="str_ym1" style="width:100px;" title="">
						<c:forEach items="${m_list}" var="m">
							<option value="${m.ym}">${m.yymm}</option>
						</c:forEach>
					</select>
				</div>
				<div id="srch_yy1" style="display:inline-block">
					<select class="formSelect" id="str_ym2" name="str_ym2" style="width:100px;" title="">
						<c:forEach items="${y_list}" var="y">
							<option value="${y.yyyy}">${y.yy}</option>
						</c:forEach>
					</select>
				</div>
				<span class="txt-symbol">종료</span>
				<div id="srch_mm2" style="display:inline-block">
					<select class="formSelect" id="end_ym1" name="end_ym1" style="width:100px;" title="">
						<c:forEach items="${m_list}" var="m">
							<option value="${m.ym}">${m.yymm}</option>
						</c:forEach>
					</select>
				</div>
				<div id="srch_yy2" style="display:inline-block">
					<select class="formSelect" id="end_ym2" name="end_ym2" style="width:100px;" title="">
						<c:forEach items="${y_list}" var="y">
							<option value="${y.yyyy}">${y.yy}</option>
						</c:forEach>
					</select>
				</div>
				<a href="javascript:go_srch()"><img src="image/magnifier13.png" style="height:18px;margin-left:10px" alt="검색"/><span class="text-hidden">검색</span> </a>
			</div>

			<div class="col2 clearfix">
				<div class="shadow-box float-left">
					<div class="top-bar">
						<h2>이용 관광객 수</h2>
						<!-- <div class="btn-box"><a href="#a" class="btn-more" title="더보기"><span class="text-hidden">더보기</span></a></div> -->
					</div>
					<div class="section">
						<div class="criteria">
							<!-- <p>2015년 06월 10일</p> -->
							<!-- <p>00:00 기준</p> -->
						</div>
						<p class="index">전국<span><fmt:formatNumber pattern="#,###" value="${info.tot_visitor_cnt}" /></span>명</p>
					</div>
				</div><!-- // shadow-box -->

				<div class="shadow-box float-right">
					<div class="top-bar">
						<h2>활동 해설사 수</h2>
						<!-- <div class="btn-box"><a href="#a" class="btn-more" title="더보기"><span class="text-hidden">더보기</span></a></div> -->
					</div>
					<div class="section">
						<div class="criteria">
							<!-- <p>2015년 06월 10일</p> -->
							<!-- <p>00:00 기준</p> -->
						</div>
						<p class="index">전국<span><fmt:formatNumber pattern="#,###" value="${info.tot_cmmt_cnt}" /></span>명</p>
					</div>
				</div><!-- // shadow-box -->
			</div><!-- // col2 -->

			<div class="shadow-box">
				<div class="top-bar">
					<h2>각 시도별 월별 해설사 정보 업데이트 현황</h2>
					<div class="btn-box">
						<!-- <a href="#a" class="btn-view-graph on" title="그래프로 보기"></a>선택된 보기에 클래스 on 삽입
						<a href="#a" class="btn-view-table" title="테이블로 보기"></a> -->
					</div>
				</div>
				<div class="view-content" style="padding:50px">
					<div style="width:98%">
						<canvas id="canvas" height="180px" width="600px"></canvas>
						<div id="js-legend" class="chart-legend"></div>
					</div>
				</div>
			</div><!-- // shadow-box -->

			<div class="shadow-box">
				<div class="top-bar">
					<h2>각 시도별 월별 로그인 현황</h2>
					<div class="btn-box">
						<!-- <a href="#a" class="btn-view-graph" title="그래프로 보기"></a>
						<a href="#a" class="btn-view-table on" title="테이블로 보기"></a>선택된 보기에 클래스 on 삽입 -->
					</div>
				</div>
				<div class="view-content" style="padding:50px">
					<div style="width:98%">
						<canvas id="canvas2" height="180px" width="600px"></canvas>
						<div id="js-legend2" class="chart-legend"></div>
					</div>
				</div>
			</div><!-- // shadow-box -->

			<div class="shadow-box">
				<div id="tabs" class="clearfix">
				  <ul class="title float-left">
					<li><a href="#tabs-1" class="tab1">공지사항</a></li>
					<li><a href="#tabs-2" class="tab2">Q&amp;A</a></li>
				  </ul>
				  <div id="tabs-1" class="content float-left">
					<table class="talbe-list">
						<colgroup>
							<col style="width:12%" />
							<col style="width:*" />
							<col style="width:12%"/>
							<col style="width:12%"/>
							<col style="width:14%"/>
						</colgroup>
						<thead>
							<tr>
								<th>시도</th>
								<th>제목</th>
								<th>첨부파일여부</th>
								<th>작성자</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${b_list}" var="c" varStatus="status">
							<tr onclick="javascript:board_info('${c.board_seq}')">
								<td>${c.sido_cd_nm}</td>
								<td>${c.title}</td>
								<td>
									<c:if test="${c.file_cnt gt 0}" ><img src="./image/ico_file.png" alt="첨부파일" /> </c:if>
								</td>
								<td>${c.nm}</td>
								<td>${c.reg_dt}</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				  </div>
				  <div id="tabs-2" class="content float-left">
					<table class="talbe-list faq">
						<colgroup>
							<col style="width:12%" />
							<col style="width:12%"/>
							<col style="width:*" />
							<col style="width:12%"/>
							<col style="width:14%"/>
						</colgroup>
						<thead>
							<tr>
								<th>No</th>
								<th>시도</th>
								<th>제목</th>
								<th>작성자</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${q_list}" var="q" varStatus="status">
							<tr onclick="javascript:qna_info('${q.qna_seq}')">
								<td>
									<c:choose>
										<c:when test="${q.up_qna_seq gt 0}">
											[RE]
										</c:when>
										<c:otherwise>
											${q.row_num}
										</c:otherwise>
									</c:choose>
								</td>
								<td>${q.sido_cd_nm}</td>
								<td>${q.title}</td>
								<td>${q.nm}</td>
								<td>${q.reg_dt}</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				  </div>
				</div>
			</div><!-- // shadow-box -->

		</div><!--// contents -->
	</div><!--// container -->
	</form>
</div>

<script>

	var barChartData = {
		labels : [
					<c:forEach items="${u_list}" var="u" varStatus="esgStatus">
							"${u.sido_cd_nm}"
						<c:if test="${!esgStatus.last}">    
						  ,    
						</c:if>
					</c:forEach>
		          ],
		datasets : [
			{
				label: "해설사 수", 
				fillColor : "rgba(220,220,220,0.5)",
				strokeColor : "rgba(220,220,220,0.8)",
				highlightFill: "rgba(220,220,220,0.75)",
				highlightStroke: "rgba(220,220,220,1)",
				data : [
						<c:forEach items="${u_list}" var="u" varStatus="esgStatus">
						${u.cmntor_cnt}
						<c:if test="${!esgStatus.last}">    
						,    
						</c:if>
						</c:forEach>
				        ]
			},
			{
				label: "업데이트 건수", 
				fillColor : "rgba(151,187,205,0.5)",
				strokeColor : "rgba(151,187,205,0.8)",
				highlightFill : "rgba(151,187,205,0.75)",
				highlightStroke : "rgba(151,187,205,1)",
				data : [
						<c:forEach items="${u_list}" var="u" varStatus="esgStatus">
						${u.cmntor_update_cnt}
						<c:if test="${!esgStatus.last}">    
						,    
						</c:if>
						</c:forEach>
				        ]
			}
		]
	} 
	
	var barChartData2 = {
			labels : [
						<c:forEach items="${l_list}" var="l" varStatus="esgStatus">
								"${l.sido_cd_nm}"
							<c:if test="${!esgStatus.last}">    
							  ,    
							</c:if>
						</c:forEach>
			          ],
			datasets : [
				{
					label: "가입자 수",
					fillColor : "rgba(220,220,220,0.5)",
					strokeColor : "rgba(220,220,220,0.8)",
					highlightFill: "rgba(220,220,220,0.75)",
					highlightStroke: "rgba(220,220,220,1)",
					data : [
							<c:forEach items="${l_list}" var="l" varStatus="esgStatus">
							"${l.user_cnt}"
							<c:if test="${!esgStatus.last}">    
							,    
							</c:if>
							</c:forEach>
					        ]
				},
				{
					label: "로그인 수",
					fillColor : "rgba(151,187,205,0.5)",
					strokeColor : "rgba(151,187,205,0.8)",
					highlightFill : "rgba(151,187,205,0.75)",
					highlightStroke : "rgba(151,187,205,1)",
					data : [
							<c:forEach items="${l_list}" var="l" varStatus="esgStatus">
							"${l.login_cnt}"
							<c:if test="${!esgStatus.last}">    
							,    
							</c:if>
							</c:forEach>
					        ]
				}
			]
		}
	/* 
	Chart.types.Bar.extend({
	    name: "BarAlt",
	    draw: function(){
	        this.options.barValueSpacing = this.chart.width / 5;
	        Chart.types.Bar.prototype.draw.apply(this, arguments);
	    }
	});
	Chart.types.Bar.extend({
	    name: "BarAlt2",
	    draw: function(){
	        this.options.barValueSpacing = this.chart.width / 7;
	        Chart.types.Bar.prototype.draw.apply(this, arguments);
	    }
	});
	 */
	window.onload = function(){
		
		/* var ln = "<c:out value="${fn:length(u_list)}" />"; */
		
		var options = {
				scaleShowLabels : true,
				showDatasetLabels : true,
				scaleShowGridLines : true,
				barShowStroke : true,
				responsive : true,
				barValueSpacing : 15,
				 showTooltips: false,
				    onAnimationComplete: function () {

				        var ctx = this.chart.ctx;
				        ctx.font = this.scale.font;
				        ctx.fillStyle = this.scale.textColor
				        ctx.textAlign = "center";
				        ctx.textBaseline = "bottom";

				        this.datasets.forEach(function (dataset) {
				            dataset.bars.forEach(function (bar) {
				                ctx.fillText(bar.value, bar.x, bar.y - 5);
				            });
				        })
				    }
			}
		
		var ctx = document.getElementById("canvas").getContext("2d");
		var myChart = new Chart(ctx).Bar(barChartData, options);
		
		document.getElementById('js-legend').innerHTML = myChart.generateLegend();
		
		var ctx2 = document.getElementById("canvas2").getContext("2d");
		var myChart2 = new Chart(ctx2).Bar(barChartData2, options);
		
		document.getElementById('js-legend2').innerHTML = myChart2.generateLegend();
		
		
		/* window.myBar = new Chart(ctx2).Bar(barChartData2, {
			scaleShowLabels : true,
			showDatasetLabels : true,
			scaleShowGridLines : true,
			barShowStroke : true,
			responsive : true,
			barValueSpacing : 15,
			showTooltips: false,
		    onAnimationComplete: function () {

		        var ctx = this.chart.ctx;
		        ctx.font = this.scale.font;
		        ctx.fillStyle = this.scale.textColor
		        ctx.textAlign = "center";
		        ctx.textBaseline = "bottom";

		        this.datasets.forEach(function (dataset) {
		            dataset.bars.forEach(function (bar) {
		                ctx.fillText(bar.value, bar.x, bar.y - 5);
		            });
		        })
		    }
		});
		 */

	}
	
	</script>

</body>
</html>


