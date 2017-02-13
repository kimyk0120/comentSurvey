<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE HTML>
<html>
	<head>
		<title> :: EXCEL DOWN :: </title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700' rel='stylesheet' type='text/css'>
		<script src="js/jquery.js" type="text/javascript"></script>
		<script type="text/javascript" src="js/tree.js"></script>
		<link rel="stylesheet" type="text/css" href="css/tree.css" />
		
		<script type="text/javascript" src="js/Chart.js"></script> 
		<script type="text/javascript" src="js/jquery.openCarousel.js"></script> 
		<script src="js/star-rating.js"></script>
		<script src="js/jquery.easydropdown.js"></script>
		<script type="text/javascript" src="js/jquery.easing.js"></script>
        <script type="text/javascript" src="js/jquery.ulslide.js"></script>
        <script src="js/easyResponsiveTabs.js" type="text/javascript"></script>     										
  		<script type="text/javascript" src="js/smk-accordion.js"></script> 
		<script type="text/javascript">
			jQuery(document).ready(function($){
				
				$(".accordion").smk_Accordion({
					showIcon: true, //boolean
					animation: true, //boolean
					closeAble: false, //boolean
					slideSpeed: 300 //integer, miliseconds
				});
				
			});
			
			
		function excelDown() {
			
			if(edownload.yyyy1.value == '') {
				alert("년도를 선택하세요");
				$("#yyyy1").focus();
				return;
			} else if (edownload.yyyy2.value == '') {
				alert("반기를 선택하세요");
				$("#yyyy2").focus();
		         return;
		     }
			else if (edownload.esg.value == '') {
				alert("ESG를 선택하세요");
				$("#esg").focus();
		         return;
		     }
			else if (edownload.prt.value == '') {
				alert("다운로드 받을 항목을 선택하세요");
				$("#prt").focus();
		         return;
		     }
			
			if( confirm("다운로드 하시겠습니까?") ) {
				document.edownload.action = "excel_down.do";
				document.edownload.submit();
		     } 
		}
		
			
		</script>
  												
	</head>
	<body>
		<form id="edownload" name="edownload" action="excel_download.do" method="POST">
		<div class="news">
		  <h3>액셀 다운로드</h3>
			  	<table class="company_select2">
			  	   	  <tr height="20px">
							<td width="50px"><nobr>년도</nobr></td>
						  	<td>
						  		<div class="styled-select2" >
						  			<select id="yyyy1" name="yyyy1" tabindex="9" class="flat">
			            				<option value="">선택</option>
										<option value="2014">2014년</option>
										<option value="2015">2015년</option>
										<option value="2016">2016년</option>
										<option value="2017">2017년</option>
										<option value="2018">2018년</option>
										<option value="2019">2019년</option>
									</select>
						  		</div>
						  	</td>
						  	<td width="50px"><nobr>반기</nobr></td>
						  	<td>
						  		<div class="styled-select2" >
						  			<select id="yyyy2" name="yyyy2" tabindex="9" class="flat">
			            				<option value="">선택</option>
										<option value="A">상반기</option>
										<option value="B">하반기</option>
									</select>
						  		</div>
						  	</td>
					  </tr>
					  <tr height="20px">
							<td width="50px"><nobr>ESG</nobr></td>
						  	<td>
						  		<div class="styled-select2" >
						  			<select id="esg" name="esg" tabindex="9" class="flat">
			            				<option value="">선택</option>
										<option value="E">환경</option>
										<option value="S">사회</option>
										<option value="G">지배구조</option>
									</select>
						  		</div>
						  	</td>
						  	<td width="50px"><nobr>항목</nobr></td>
						  	<td>
						  		<div class="styled-select2" >
						  			<select id="prt" name="prt" tabindex="9" class="flat">
			            				<option value="">선택</option>
										<option value="pnt">점수</option>
										<option value="expl">항목</option>
										<option value="src">출처</option>
										<option value="tot">전체</option>
									</select>
						  		</div>
						  	</td>
					  </tr>
				  </table>
				<div class="clear"></div>
				
				<table align="right">
					<tr height=5px></tr>
				  	<tr>
				  		<td width=120px">
							<div class="event_button_save" id="btn_save"  >
								<a href="javascript:excelDown();">Down</a>
							</div>
						</td>
						<td width=30px></td>
						<td width=120px>
							<div class="event_button_cancel" id="btn_close">
								<a href="javascript:window.close()">Cancel</a>
							</div>
						</td>
					</tr>
					<tr height=5px></tr>
				  </table>
			</div>
		</form>
	</body>
</html>


