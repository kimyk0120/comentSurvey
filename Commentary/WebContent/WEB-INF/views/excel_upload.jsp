<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE HTML>
<html>
	<head>
		<title> :: EXCEL SAVE :: </title>
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
				
				var msg = "<c:out value="${msg}"/>";
				
				if( msg != '') {
					alert( msg + "건 업로드 되었습니다.");
					self.close();
				}
				
			});
			
			
		function excelSave() {
			
			 if(eupload.srchBsns.value == '') {
				alert("업로드할 파일을 선택하세요");
				return;
			} else if (!checkFileType(eupload.srchBsns.value) ) {
		         alert( "엑셀파일만 업로드 해주세요." );
		         return;
		     }
			
			if( confirm("업로드 하시겠습니까?") ) {
				document.eupload.action = "excel_save.do";
				document.eupload.submit();
				$("#btn_save").hide();
				$("#btn_close").hide();
		     } 
		}
		
		 function checkFileType( filePath ) {
		     var fileFormat = filePath.toLowerCase();

		     if( fileFormat.indexOf(".xls") > -1 ) return true;
		     else return false;
		 }
			
			
		</script>
  												
	</head>
	<body>
		<div class="news">
		  <h3>액셀 데이터 저장</h3>
			<ul>
		  	   <li>
		  	   	  <table>
			  	   	  <tr height=50>
							<td width=80px><nobr>파일 :&nbsp;</nobr></td>
						  	<td width=400>
								<form id="eupload" name="eupload" action="excel_save.do" method="POST" enctype="multipart/form-data">
									<input type="hidden" id="input_yyyy" name="input_yyyy" value="2014B">
									<input type="file" id="srchBsns" name="srchBsns">
								</form>
						  	</td>
					  </tr>
				  </table>
					<div class="clear"></div>
				  <table align="right">
				  	<tr>
				  		<td width=120px>
							<div class="event_button_save" id="btn_save"  >
								<a href="javascript:excelSave()">Save</a>
							</div>
						</td>
						<td width=20px></td>
						<td width=120px>
							<div class="event_button_cancel" id="btn_close">
								<a href="javascript:window.close()">Cancel</a>
							</div>
						</td>
				  </table>
				</li>
			</ul>
		</div>
	</body>
</html>


