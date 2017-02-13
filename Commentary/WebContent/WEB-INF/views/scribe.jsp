<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE HTML>
<html>

	<head>
		<title> :: PRIDE IN SUSTINVEST :: </title>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="./css/style.css" rel="stylesheet" type="text/css" media="all" />
		<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700' rel='stylesheet' type='text/css'>
		<link rel="stylesheet" type="text/css" href="./css/tree.css" />

		<script src="./js/jquery.js
		" type="text/javascript"></script>
		<script src="./js/jquery.easydropdown.js"></script>
		
		<script type="text/javascript" src="./js/jquery.openCarousel.js"></script> 
		<script type="text/javascript" src="./js/jquery.easing.js"></script>
        <script type="text/javascript" src="./js/jquery.ulslide.js"></script>
        
		<script type="text/javascript" src="./js/tree.js"></script>
		<script type="text/javascript" src="./js/Chart.js"></script> 
		<script src="./js/star-rating.js"></script>
        <script src="./js/easyResponsiveTabs.js" type="text/javascript"></script>     										
		<!----Calender -------->
		  <link rel="stylesheet" href="./css/clndr.css" type="text/css" />
		  <script src="./js/underscore-min.js" type="text/javascript"></script>
		  <script src= "./js/moment-2.2.1.js" type="text/javascript"></script>
		  <script src="./js/clndr.js" type="text/javascript"></script>
		  <script src="./js/site.js" type="text/javascript"></script>
  		<!----End Calender -------->
  		<script type="text/javascript" src="./js/smk-accordion.js"></script> 
  		
		<script type="text/javascript">
			jQuery(document).ready(function($){
				
				$(".accordion").smk_Accordion({
					showIcon: true, //boolean
					animation: true, //boolean
					closeAble: false, //boolean
					slideSpeed: 300 //integer, miliseconds
				});
			});
			
		</script>
		<!---- Slider ------>
		 <link rel="stylesheet" href="./css/slider.css" type="text/css" />
		<script type="text/javascript" src="./js/jquery.cslider.js"></script>
		<script type="text/javascript" src="./js/modernizr.custom.28468.js"></script>
	

	<script type="text/javascript">
			$(window).keypress(function(event) {
			    if (!(event.which == 115 && event.ctrlKey) && !(event.which == 19)) return true;
			    
			    saveMe();
			    event.preventDefault();
			    event.stopPropagation();
			    
			    return false;
			});
			
			$(function() {
			
				$('#da-slider').cslider({
					autoplay	: true,
					bgincrement	: 450
				});
			});
		
			
			function saveMe() {
				if(dp_input.bsns_cd.value == '' || dp_input.dp_cd.value == '') {
					alert("종목과 DP를 모두 선택하세요.");
				} else {
					$.ajax({ 
						   url: "scribe_act.do", 
						   type: "POST",
						   data: $("#dp_input").serialize(),
						   dataType:"text",
						   cache: false,
						   success: function(msg){
							   alert("저장되었습니다.");
							 
							   var tmp = msg.split('`');
							   
							   if (tmp[0] == 'null' || tmp[0] == null) tmp[0]='';
							   if (tmp[1] == 'null' || tmp[1] == null) tmp[1]='';
							   document.getElementById("etc_text").innerHTML=tmp[0];
							   document.getElementById("help_text").innerHTML=tmp[1];
							   
							   var tmp_sub = tmp[2].split('|');
							   var tmp_sub2 = tmp[6].split('|');
							   
							   dp_input.dtl_cnt.value = tmp_sub.length;
							   
							   var str = '';
							   for(var i = 0; i < tmp_sub.length ; i++) {
								   if(tmp_sub2[i] == 'undefined' || tmp_sub2[i] == null ) tmp_sub2[i] = '';
	str = str + "<table width=100%><tr><td colspan=\"2\" bgcolor=\"#999999\" style=\"text-align:center;vertical-align:middle;color:#FFFFFF\" width=250px height=30px>" + tmp_sub[i];
	str = str + "</td></tr><tr><td colspan=\"2\" bgcolor=\"#CCCCCC\" style=\"text-align:left;vertical-align:middle;color:#FFFFFF\" width=250px height=150px>";
	str = str + "<div class=\"stra-area\"><textarea id=\"dtl_info"+(i+1)+ "\" name=\"dtl_info"+(i+1)+ "\" style=\"height:150px\" value=\"\">"+tmp_sub2[i]+"</textarea></div></td></tr></table>";
	str = str + "<table><tr><td height=10px></td></tr></table>";
							   }
							   document.getElementById("dtl_info").innerHTML=str;
							   
							   if (tmp[5] == 'null' || tmp[5] == null) tmp[5]='';
							   if (tmp[7] == 'null' || tmp[7] == null) tmp[7]='';
							   if (tmp[8] == 'null' || tmp[8] == null) tmp[8]='';
							   
							   dp_input.pnt.value=tmp[5];
							   dp_input.src.value = tmp[7];
							   dp_input.memo.value=tmp[8];
							   
							   document.getElementById("dp_nm").innerHTML="<h3>" + "[" + tmp[3] + "] " + tmp[4] + "</h3>";
							   
							   dp_input.dp_cd.value=tmp[3];
							   
							   if(tmp[9] == 'Y') {
								   alert("다음 종목으로 넘어갑니다.");
								   bsnsNext();
							   }
						   }
						   , error: function (xhr, ajaxOptions, thrownError) {
							   alert("status : " + xhr.status);
						       alert("err: " +thrownError);
						   }
					});
				}
			}
			
			function dpNext() {
				if(dp_input.bsns_cd.value == '' || dp_input.dp_cd.value == '') {
					alert("종목과 DP를 모두 선택하세요.");
				} else {
					
					document.getElementById('btn_dtpt').style.display = 'none';
					
					$.ajax({ 
						   url: "scribe_act.do", 
						   type: "POST",
						   data: $("#dp_input").serialize(),
						   dataType:"text",
						   cache: false,
						   success: function(msg){
							  
						   }
						   , error: function (xhr, ajaxOptions, thrownError) {
						   }
					});
					
					$.ajax({ 
						   url: "dp_next.do", 
						   type: "POST",
						   data: {"dp_cd" : dp_input.dp_cd.value, "bsns_cd" : dp_input.bsns_cd.value},
						   dataType:"text",
						   cache: false,
						   success: function(msg){
							 
							   var tmp = msg.split('`');
							   
							   if (tmp[0] == 'null' || tmp[0] == null) tmp[0]='';
							   if (tmp[1] == 'null' || tmp[1] == null) tmp[1]='';
							   document.getElementById("etc_text").innerHTML=tmp[0];
							   document.getElementById("help_text").innerHTML=tmp[1];
							   
							   var tmp_sub = tmp[2].split('|');
							   var tmp_sub2 = tmp[6].split('|');
							   
							   dp_input.dtl_cnt.value = tmp_sub.length;
							   
							   var str = '';
							   for(var i = 0; i < tmp_sub.length ; i++) {
								   if(tmp_sub2[i] == 'undefined' || tmp_sub2[i] == null ) tmp_sub2[i] = '';
	str = str + "<table width=100%><tr><td colspan=\"2\" bgcolor=\"#999999\" style=\"text-align:center;vertical-align:middle;color:#FFFFFF\" width=250px height=30px>" + tmp_sub[i];
	str = str + "</td></tr><tr><td colspan=\"2\" bgcolor=\"#CCCCCC\" style=\"text-align:left;vertical-align:middle;color:#FFFFFF\" width=250px height=150px>";
	str = str + "<div class=\"stra-area\"><textarea id=\"dtl_info"+(i+1)+ "\" name=\"dtl_info"+(i+1)+ "\" style=\"height:150px\" value=\"\">"+tmp_sub2[i]+"</textarea></div></td></tr></table>";
	str = str + "<table><tr><td height=10px></td></tr></table>";
							   }
							   document.getElementById("dtl_info").innerHTML=str;
							   
							   if (tmp[5] == 'null' || tmp[5] == null) tmp[5]='';
							   if (tmp[7] == 'null' || tmp[7] == null) tmp[7]='';
							   if (tmp[8] == 'null' || tmp[8] == null) tmp[8]='';
							   if (tmp[10] == 'null' || tmp[10] == null) tmp[10]='';
							   if (tmp[11] == 'null' || tmp[11] == null) tmp[11]='';
							   if (tmp[12] == 'null' || tmp[12] == null) tmp[12]='';
							   
							   dp_input.pnt.value=tmp[5];
							   dp_input.src.value = tmp[7];
							   dp_input.memo.value=tmp[8];
							   dp_input.comp_cntn.value=tmp[10];
							   dp_input.comp_src.value=tmp[11];
							   
							   var yy = tmp[12];
							   var yy2 = "";
							   if ( yy!= '') {
								   if(yy.substr(4,1) == "A") yy2 = "상반기";
								   else if (yy.substr(4,1) == "B") yy2 = "하반기";
							   }
							   document.getElementById("appr_yyyy_data").innerHTML="<h3 style=\"font-size:12px\">"+yy.substr(0,4)+"년  "+yy2+"</h3>";
							   
							   document.getElementById("dp_nm").innerHTML="<h3>" + "[" + tmp[3] + "] " + tmp[4] + "</h3>";
							   
							   dp_input.dp_cd.value=tmp[3];
							   
							   if(tmp[9] == 'Y') {
								   alert("다음 종목으로 넘어갑니다.");
								   bNext();
							   }
							   
							   document.getElementById('btn_dtpt').style.display = 'block';
							   
						   }
						   , error: function (xhr, ajaxOptions, thrownError) {
							   alert("status : " + xhr.status);
						       alert("err: " +thrownError);
						   }
					});
					
				}
			}
			
			function dpPrev() {
				if(dp_input.bsns_cd.value == '' || dp_input.dp_cd.value == '') {
					alert("종목과 DP를 모두 선택하세요.");
				} else {
					
					document.getElementById('btn_dtpt').style.display = 'none';
					
					$.ajax({ 
						   url: "scribe_act.do", 
						   type: "POST",
						   data: $("#dp_input").serialize(),
						   dataType:"text",
						   cache: false,
						   success: function(msg){
							  
						   }
						   , error: function (xhr, ajaxOptions, thrownError) {
						   }
					});
					
					$.ajax({ 
						   url: "dp_prev.do", 
						   type: "POST",
						   data: {"dp_cd" : dp_input.dp_cd.value, "bsns_cd" : dp_input.bsns_cd.value},
						   dataType:"text",
						   cache: false,
						   success: function(msg){
							 
							   var tmp = msg.split('`');
							   
							   if (tmp[0] == 'null' || tmp[0] == null) tmp[0]='';
							   if (tmp[1] == 'null' || tmp[1] == null) tmp[1]='';
							   document.getElementById("etc_text").innerHTML=tmp[0];
							   document.getElementById("help_text").innerHTML=tmp[1];
							   
							   var tmp_sub = tmp[2].split('|');
							   var tmp_sub2 = tmp[6].split('|');
							   
							   dp_input.dtl_cnt.value = tmp_sub.length;
							   
							   var str = '';
							   for(var i = 0; i < tmp_sub.length ; i++) {
								   if(tmp_sub2[i] == 'undefined' || tmp_sub2[i] == null ) tmp_sub2[i] = '';
	str = str + "<table width=100%><tr><td colspan=\"2\" bgcolor=\"#999999\" style=\"text-align:center;vertical-align:middle;color:#FFFFFF\" width=250px height=30px>" + tmp_sub[i];
	str = str + "</td></tr><tr><td colspan=\"2\" bgcolor=\"#CCCCCC\" style=\"text-align:left;vertical-align:middle;color:#FFFFFF\" width=250px height=150px>";
	str = str + "<div class=\"stra-area\"><textarea id=\"dtl_info"+(i+1)+ "\" name=\"dtl_info"+(i+1)+ "\" style=\"height:150px\" value=\"\">"+tmp_sub2[i]+"</textarea></div></td></tr></table>";
	str = str + "<table><tr><td height=10px></td></tr></table>";
							   }
							   document.getElementById("dtl_info").innerHTML=str;
							   
							   if (tmp[5] == 'null' || tmp[5] == null) tmp[5]='';
							   if (tmp[7] == 'null' || tmp[7] == null) tmp[7]='';
							   if (tmp[8] == 'null' || tmp[8] == null) tmp[8]='';
							   if (tmp[10] == 'null' || tmp[10] == null) tmp[10]='';
							   if (tmp[11] == 'null' || tmp[11] == null) tmp[11]='';
							   if (tmp[12] == 'null' || tmp[12] == null) tmp[12]='';
							   
							   dp_input.pnt.value=tmp[5];
							   dp_input.src.value = tmp[7];
							   dp_input.memo.value=tmp[8];
							   dp_input.comp_cntn.value=tmp[10];
							   dp_input.comp_src.value=tmp[11];
							   
							   var yy = tmp[12];
							   var yy2 = "";
							   if ( yy!= '') {
								   if(yy.substr(4,1) == "A") yy2 = "상반기";
								   else if (yy.substr(4,1) == "B") yy2 = "하반기";
							   }
							   document.getElementById("appr_yyyy_data").innerHTML="<h3 style=\"font-size:12px\">"+yy.substr(0,4)+"년  "+yy2+"</h3>";
							   
							   document.getElementById("dp_nm").innerHTML="<h3>" + "[" + tmp[3] + "] " + tmp[4] + "</h3>";
							   
							   dp_input.dp_cd.value=tmp[3];
							   
							   if(tmp[9] == 'Y') {
								   alert("이전 종목으로 넘어갑니다.");
								   bPrev();
							   }
							   
							   document.getElementById('btn_dtpt').style.display = 'block';
						   }
						   , error: function (xhr, ajaxOptions, thrownError) {
							   alert("status : " + xhr.status);
						       alert("err: " +thrownError);
						   }
					});
					
				}
			}
			
			function get_bsns() {
				
				var bsnsNo = $('#gics_sstn').val();
				
				$.ajax({ 
					   url: "bsns_list.do", 
					   type: "POST", 
					   data: {"gics_sstn" : bsnsNo},
					   dataType:"text",
					   cache: false,
					   success: function(msg){
						   var tmp = msg.split('|');
						   
						   var str = "<select class=\"flat\" tabindex=\"9\" id=\"bsns_no\" name=\"bsns_no\" onChange=\"setNm()\">";
           					str = str+"<option value=\"\">선택</option>";

						   for(var i = 0; i < tmp.length ; i++) {
							   var tmp_sub = tmp[i].split(",");
	            				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
						   }
						   
						   str = str+"</select>";
						   document.getElementById("bsns_select").innerHTML=str;
					   }
					   , error: function (xhr, ajaxOptions, thrownError) {
					        alert("status : " + xhr.status);
					        alert("err: " +thrownError);
					      }
					}); 
				
				$('#g_lvl').val(bsnsNo);
			}
			
			function setNm(){
				var e = document.getElementById("bsns_no");
				var nm = e.options[e.selectedIndex].text;
				
				//var asst_scal = "";
				$.ajax({ 
					url: "bsns_srch.do", 
					   type: "POST", 
					   data: {"bsns_nm" : nm},
					   dataType:"text",
					   cache: false,
					   success: function(msg){
						   var tmp = msg.split('`');
						   bsns_no = tmp[0];
						   document.getElementById("bsnm").innerHTML="<h3>" + "["+bsns_no+"] "+ nm +"</h3>";
						   
						   document.getElementById("gics_names").innerHTML = tmp[4] +" - " + tmp[5] + " - " + tmp[6];
						   document.getElementById("asst_scal").innerHTML = tmp[2];
							document.getElementById("main_comp").innerHTML = tmp[7];
							document.getElementById("acct_mon").innerHTML = tmp[8];
							document.getElementById("list_dt").innerHTML = tmp[9];
							document.getElementById("esta_dt").innerHTML = tmp[10];
						   
					   }
					}); 
				
				dp_input.bsns_cd.value = e.options[e.selectedIndex].value;
			}
			
			
			function srch_bsns() {
				
				var bsnsNm = $('#srchBsns').val();
				
				$.ajax({ 
					   url: "bsns_srch.do", 
					   type: "POST", 
					   data: {"bsns_nm" : bsnsNm},
					   dataType:"text",
					   cache: false,
					   success: function(msg){
						   
						   if(msg == null || msg=='') {
							   alert("검색 종목이 없습니다.");
							   $('#srchBsns').val("");
						   }
						   else {
							   var tmp = msg.split('`');
							   
							   var srch_gics = tmp[3];
								$("#gics_sstn").val(srch_gics).attr("selected", "selected");
								
							   var tmp3 = tmp[11].split('|');
							   
							   var str = "<select class=\"flat\" tabindex=\"9\" id=\"bsns_no\" name=\"bsns_no\" onChange=\"setNm()\">";
	           					str = str+"<option value=\"\">선택</option>";
	
							   for(var i = 0; i < tmp3.length ; i++) {
								   var tmp_sub = tmp3[i].split(",");
		            				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
							   }
							   
							   str = str+"</select>";
							   document.getElementById("bsns_select").innerHTML=str;
							   
							   
							   var bsnsNo = tmp[0];
								$("#bsns_no").val(bsnsNo).attr("selected", "selected");
								
								document.getElementById("bsnm").innerHTML="<h3>" + "[" + tmp[0] + "] " +tmp[1] +"</h3>";
								dp_input.bsns_cd.value = tmp[0];
								
								document.getElementById("gics_names").innerHTML = tmp[4] +" - " + tmp[5] + " - " + tmp[6];
								document.getElementById("asst_scal").innerHTML = tmp[2];
								document.getElementById("main_comp").innerHTML = tmp[7];
								document.getElementById("acct_mon").innerHTML = tmp[8];
								document.getElementById("list_dt").innerHTML = tmp[9];
								document.getElementById("esta_dt").innerHTML = tmp[10];
								
								$('#g_lvl').val(srch_gics);
						   }
					   }
					   , error: function (xhr, ajaxOptions, thrownError) {
					      }
					}); 
				
			}
			
			function bNext() {
				
				var bsnsNo = dp_input.bsns_cd.value;
				
				$.ajax({ 
					   url: "bsns_next.do", 
					   type: "POST", 
					   data: {"bsns_no" : bsnsNo},
					   dataType:"text",
					   cache: false,
					   success: function(msg){
						   
						   if(msg == null || msg=='') {
							   alert("검색 종목이 없습니다.");
							   $('#srchBsns').val("");
						   }
						   else {
							   var tmp = msg.split('`');
							   
							   var srch_gics = tmp[3];
								$("#gics_sstn").val(srch_gics).attr("selected", "selected");
								
							   var tmp3 = tmp[11].split('|');
							   
							   var str = "<select class=\"flat\" tabindex=\"9\" id=\"bsns_no\" name=\"bsns_no\" onChange=\"setNm()\">";
	           					str = str+"<option value=\"\">선택</option>";
	
							   for(var i = 0; i < tmp3.length ; i++) {
								   var tmp_sub = tmp3[i].split(",");
		            				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
							   }
							   
							   str = str+"</select>";
							   document.getElementById("bsns_select").innerHTML=str;
							   
							   var bsnsNo2 = tmp[0];
								$("#bsns_no").val(bsnsNo2).attr("selected", "selected");
								
								document.getElementById("bsnm").innerHTML="<h3>" + "[" + tmp[0] + "] " +tmp[1] +"</h3>";
								
								dp_input.bsns_cd.value = tmp[0];
								
								document.getElementById("gics_names").innerHTML = tmp[4] +" - " + tmp[5] + " - " + tmp[6];
								document.getElementById("asst_scal").innerHTML = tmp[2];
								document.getElementById("main_comp").innerHTML = tmp[7];
								document.getElementById("acct_mon").innerHTML = tmp[8];
								document.getElementById("list_dt").innerHTML = tmp[9];
								document.getElementById("esta_dt").innerHTML = tmp[10];

								$('#g_lvl').val(srch_gics);
						   }
					   }
					   , error: function (xhr, ajaxOptions, thrownError) {
					      }
					});
				
			}
			
			function bPrev() {
				
				var bsnsNo = dp_input.bsns_cd.value;
				
				$.ajax({ 
					   url: "bsns_prev.do", 
					   type: "POST", 
					   data: {"bsns_no" : bsnsNo},
					   dataType:"text",
					   cache: false,
					   success: function(msg){
						   
						   if(msg == null || msg=='') {
							   alert("검색 종목이 없습니다.");
							   $('#srchBsns').val("");
						   }
						   else {
							   var tmp = msg.split('`');
							   
							   var srch_gics = tmp[3];
								$("#gics_sstn").val(srch_gics).attr("selected", "selected");
								
							   var tmp3 = tmp[11].split('|');
							   
							   var str = "<select class=\"flat\" tabindex=\"9\" id=\"bsns_no\" name=\"bsns_no\" onChange=\"setNm()\">";
	           					str = str+"<option value=\"\">선택</option>";
	
							   for(var i = 0; i < tmp3.length ; i++) {
								   var tmp_sub = tmp3[i].split(",");
		            				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
							   }
							   
							   str = str+"</select>";
							   document.getElementById("bsns_select").innerHTML=str;
							   
							   var bsnsNo2 = tmp[0];
								$("#bsns_no").val(bsnsNo2).attr("selected", "selected");
								
								document.getElementById("bsnm").innerHTML="<h3>" + "[" + tmp[0] + "] " +tmp[1] +"</h3>";
								
								dp_input.bsns_cd.value = tmp[0];
								
								document.getElementById("gics_names").innerHTML = tmp[4] +" - " + tmp[5] + " - " + tmp[6];
								document.getElementById("asst_scal").innerHTML = tmp[2];
								document.getElementById("main_comp").innerHTML = tmp[7];
								document.getElementById("acct_mon").innerHTML = tmp[8];
								document.getElementById("list_dt").innerHTML = tmp[9];
								document.getElementById("esta_dt").innerHTML = tmp[10];

								$('#g_lvl').val(srch_gics);
								
								//dp_info(dp_input.dp_cd.value, tmp[0]);
						   }
					   }
					   , error: function (xhr, ajaxOptions, thrownError) {
					      }
					});
				
			}
			
			function bsnsNext(){
				if(dp_input.bsns_cd.value == '' || dp_input.dp_cd.value == '') {
					alert("종목과 DP를 모두 선택하세요.");
				} else {
					
					document.getElementById('btn_bsns').style.display = 'none';
					
					$.ajax({ 
						   url: "scribe_act.do", 
						   type: "POST",
						   data: $("#dp_input").serialize(),
						   dataType:"text",
						   cache: false,
						   success: function(msg){
							  
						   }
						   , error: function (xhr, ajaxOptions, thrownError) {
						   }
					});
				
					$.ajax({ 
						   url: "bsns_next.do", 
						   type: "POST", 
						   data: {"bsns_no" : dp_input.bsns_cd.value},
						   dataType:"text",
						   cache: false,
						   success: function(msg){
							   
							   if(msg == null || msg=='') {
								   alert("검색 종목이 없습니다.");
								   $('#srchBsns').val("");
								   document.getElementById('btn_bsns').style.display = 'block';
							   }
							   else {
								   var tmp = msg.split('`');
								   
								   var srch_gics = tmp[3];
									$("#gics_sstn").val(srch_gics).attr("selected", "selected");
									
								   var tmp3 = tmp[11].split('|');
								   
								   var str = "<select class=\"flat\" tabindex=\"9\" id=\"bsns_no\" name=\"bsns_no\" onChange=\"setNm()\">";
		           					str = str+"<option value=\"\">선택</option>";
		
								   for(var i = 0; i < tmp3.length ; i++) {
									   var tmp_sub = tmp3[i].split(",");
			            				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
								   }
								   
								   str = str+"</select>";
								   document.getElementById("bsns_select").innerHTML=str;
								   
								   var bsnsNo2 = tmp[0];
									$("#bsns_no").val(bsnsNo2).attr("selected", "selected");
									
									document.getElementById("bsnm").innerHTML="<h3>" + "[" + tmp[0] + "] " +tmp[1] +"</h3>";
									
									dp_input.bsns_cd.value = tmp[0];
									
									document.getElementById("gics_names").innerHTML = tmp[4] +" - " + tmp[5] + " - " + tmp[6];
									document.getElementById("asst_scal").innerHTML = tmp[2];
									document.getElementById("main_comp").innerHTML = tmp[7];
									document.getElementById("acct_mon").innerHTML = tmp[8];
									document.getElementById("list_dt").innerHTML = tmp[9];
									document.getElementById("esta_dt").innerHTML = tmp[10];

									$('#g_lvl').val(srch_gics);
									
									dp_info(dp_input.dp_cd.value, tmp[0]);
									//document.getElementById('btn_bsns').style.display = 'block';
							   }

						   }
						   , error: function (xhr, ajaxOptions, thrownError) {
						      }
						});
				}
			}
			
			function bsnsPrev(){
				if(dp_input.bsns_cd.value == '' || dp_input.dp_cd.value == '') {
					alert("종목과 DP를 모두 선택하세요.");
				} else {
					
					document.getElementById('btn_bsns').style.display = 'none';
					
					$.ajax({ 
						   url: "scribe_act.do", 
						   type: "POST",
						   data: $("#dp_input").serialize(),
						   dataType:"text",
						   cache: false,
						   success: function(msg){
							  
						   }
						   , error: function (xhr, ajaxOptions, thrownError) {
						   }
					});
				
					$.ajax({ 
						   url: "bsns_prev.do", 
						   type: "POST", 
						   data: {"bsns_no" : dp_input.bsns_cd.value},
						   dataType:"text",
						   cache: false,
						   success: function(msg){
							   
							   if(msg == null || msg=='') {
								   alert("검색 종목이 없습니다.");
								   $('#srchBsns').val("");
							   }
							   else {
								   var tmp = msg.split('`');
								   
								   var srch_gics = tmp[3];
									$("#gics_sstn").val(srch_gics).attr("selected", "selected");
									
								   var tmp3 = tmp[11].split('|');
								   
								   var str = "<select class=\"flat\" tabindex=\"9\" id=\"bsns_no\" name=\"bsns_no\" onChange=\"setNm()\">";
		           					str = str+"<option value=\"\">선택</option>";
		
								   for(var i = 0; i < tmp3.length ; i++) {
									   var tmp_sub = tmp3[i].split(",");
			            				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
								   }
								   
								   str = str+"</select>";
								   document.getElementById("bsns_select").innerHTML=str;
								   
								   var bsnsNo2 = tmp[0];
									$("#bsns_no").val(bsnsNo2).attr("selected", "selected");
									
									document.getElementById("bsnm").innerHTML="<h3>" + "[" + tmp[0] + "] " +tmp[1] +"</h3>";
									
									dp_input.bsns_cd.value = tmp[0];
									
									document.getElementById("gics_names").innerHTML = tmp[4] +" - " + tmp[5] + " - " + tmp[6];
									document.getElementById("asst_scal").innerHTML = tmp[2];
									document.getElementById("main_comp").innerHTML = tmp[7];
									document.getElementById("acct_mon").innerHTML = tmp[8];
									document.getElementById("list_dt").innerHTML = tmp[9];
									document.getElementById("esta_dt").innerHTML = tmp[10];

									$('#g_lvl').val(srch_gics);
									
									dp_info(dp_input.dp_cd.value, tmp[0]);
							   }
						   }
						   , error: function (xhr, ajaxOptions, thrownError) {
						      }
						});
				}
			}
			
			function dp_info(dp, bsnsNo) {
				
				$.ajax({ 
					   url: "dp_info.do", 
					   type: "POST", 
					   data: {"DTPT_CODE" : dp, "BSNS_NO" : bsnsNo},
					   dataType:"text",
					   cache: false,
					   success: function(msg){
						   var tmp = msg.split('`');
						   
						   if (tmp[0] == 'null' || tmp[0] == null) tmp[0]='';
						   if (tmp[1] == 'null' || tmp[1] == null) tmp[1]='';
						   document.getElementById("etc_text").innerHTML=tmp[0];
						   document.getElementById("help_text").innerHTML=tmp[1];
						   
						   var tmp_sub = tmp[2].split('|');
						   var tmp_sub2 = tmp[4].split('|');
						   
						   dp_input.dtl_cnt.value = tmp_sub.length;
						   
						   var str = '';
						   for(var i = 0; i < tmp_sub.length ; i++) {
							   if(tmp_sub2[i] == 'undefined' || tmp_sub2[i] == null ) tmp_sub2[i] = '';
str = str + "<table width=100%><tr><td colspan=\"2\" bgcolor=\"#999999\" style=\"text-align:center;vertical-align:middle;color:#FFFFFF\" width=250px height=30px>" + tmp_sub[i];
str = str + "</td></tr><tr><td colspan=\"2\" bgcolor=\"#CCCCCC\" style=\"text-align:left;vertical-align:middle;color:#FFFFFF\" width=250px height=150px>";
str = str + "<div class=\"stra-area\"><textarea id=\"dtl_info"+(i+1)+ "\" name=\"dtl_info"+(i+1)+ "\" style=\"height:150px\" value=\"\">"+tmp_sub2[i]+"</textarea></div></td></tr></table>";
str = str + "<table><tr><td height=10px></td></tr></table>";
						   }
						   document.getElementById("dtl_info").innerHTML=str;
						   
						   if (tmp[3] == 'null' || tmp[3] == null) tmp[3]='';
						   if (tmp[5] == 'null' || tmp[5] == null) tmp[5]='';
						   if (tmp[6] == 'null' || tmp[6] == null) tmp[6]='';
						   if (tmp[7] == 'null' || tmp[7] == null) tmp[7]='';
						   if (tmp[8] == 'null' || tmp[8] == null) tmp[8]='';
						   if (tmp[9] == 'null' || tmp[9] == null) tmp[9]='';
						   
						   dp_input.pnt.value=tmp[3];
						   dp_input.src.value = tmp[5];
						   dp_input.memo.value=tmp[6];
						   dp_input.comp_cntn.value=tmp[7];
						   dp_input.comp_src.value=tmp[8];
						   
						   var yy = tmp[9];
						   var yy2 = "";
						   if ( yy!= '') {
							   if(yy.substr(4,1) == "A") yy2 = "상반기";
							   else if (yy.substr(4,1) == "B") yy2 = "하반기";
						   }
						   document.getElementById("appr_yyyy_data").innerHTML="<h3 style=\"font-size:12px\">"+yy.substr(0,4)+"년  "+yy2+"</h3>";
						   
						   document.getElementById('btn_bsns').style.display = 'block';
					   }
					   , error: function (xhr, ajaxOptions, thrownError) {
					      }
					});
			}
			
			
			function getSrc(num, dp_code) {
				alert("#" + dp_code + "의 " + num + "번째");
			}
			
			function get_dpInfo(dp_code, dp_name) {
				
				var dpCd = dp_code;
				dp_input.dp_cd.value=dpCd;
				
				var bsnsNo = dp_input.bsns_no.value;
								
				$.ajax({ 
					   url: "dp_info.do", 
					   type: "POST", 
					   data: {"DTPT_CODE" : dpCd, "BSNS_NO" : bsnsNo},
					   dataType:"text",
					   cache: false,
					   success: function(msg){
						   var tmp = msg.split('`');
						   
						   if (tmp[0] == 'null' || tmp[0] == null) tmp[0]='';
						   if (tmp[1] == 'null' || tmp[1] == null) tmp[1]='';
						   document.getElementById("etc_text").innerHTML=tmp[0];
						   document.getElementById("help_text").innerHTML=tmp[1];
						   
						   var tmp_sub = tmp[2].split('|');
						   var tmp_sub2 = tmp[4].split('|');
						   
						   dp_input.dtl_cnt.value = tmp_sub.length;
						   
						   var str = '';
						   for(var i = 0; i < tmp_sub.length ; i++) {
							   if(tmp_sub2[i] == 'undefined' || tmp_sub2[i] == null ) tmp_sub2[i] = '';
str = str + "<table width=100%><tr><td colspan=\"2\" bgcolor=\"#999999\" style=\"text-align:center;vertical-align:middle;color:#FFFFFF\" width=250px height=30px>" + tmp_sub[i];
str = str + "</td></tr><tr><td colspan=\"2\" bgcolor=\"#CCCCCC\" style=\"text-align:left;vertical-align:middle;color:#FFFFFF\" width=250px height=150px>";
str = str + "<div class=\"stra-area\"><textarea id=\"dtl_info"+(i+1)+ "\" name=\"dtl_info"+(i+1)+ "\" style=\"height:150px\" value=\"\">"+tmp_sub2[i]+"</textarea></div></td></tr></table>";
str = str + "<table><tr><td height=10px></td></tr></table>";
						   }
						   document.getElementById("dtl_info").innerHTML=str;
						   
						   if (tmp[3] == 'null' || tmp[3] == null) tmp[3]='';
						   if (tmp[5] == 'null' || tmp[5] == null) tmp[5]='';
						   if (tmp[6] == 'null' || tmp[6] == null) tmp[6]='';
						   if (tmp[7] == 'null' || tmp[7] == null) tmp[7]='';
						   if (tmp[8] == 'null' || tmp[8] == null) tmp[8]='';
						   if (tmp[9] == 'null' || tmp[9] == null) tmp[9]='';
						   
						   dp_input.pnt.value=tmp[3];
						   dp_input.src.value = tmp[5];
						   dp_input.memo.value=tmp[6];
						   dp_input.comp_cntn.value=tmp[7];
						   dp_input.comp_src.value=tmp[8];
						   
						   var yy = tmp[9];
						   var yy2 = "";
						   if ( yy!= '') {
							   if(yy.substr(4,1) == "A") yy2 = "상반기";
							   else if (yy.substr(4,1) == "B") yy2 = "하반기";
						   }
						   document.getElementById("appr_yyyy_data").innerHTML="<h3 style=\"font-size:12px\">"+yy.substr(0,4)+"년  "+yy2+"</h3>";
						   
						   document.getElementById("dp_nm").innerHTML="<h3>"+"["+dp_code+"] " +dp_name+"</h3>";
					   }
					   , error: function (xhr, ajaxOptions, thrownError) {
					        //alert("status : " + xhr.status);
					        //alert("err: " +thrownError);
					      }
					}); 
			}
			
		function excelSave(){
			var popUrl = "excel_upload.do";	//팝업창에 출력될 페이지 URL
			var popOption = "width=500, height=240, resizable=yes, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl,"",popOption);
		} 	
		
		function excelDown(){
			var popUrl = "excel_download.do";	//팝업창에 출력될 페이지 URL
			var popOption = "width=560, height=240, resizable=yes, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
				window.open(popUrl,"",popOption);
		} 	
		
		function checkEnterKey(){
			if(event.keyCode==13){srch_bsns();}
		}
		</script>
		
		
		
  		<!----------- Magnifying Popup ------------->
		 <script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
 		 <link href="css/magnific-popup.css" rel="stylesheet" type="text/css">		
				<script type="text/javascript">
					$(document).ready(function() {
					$('.popup-with-zoom-anim').magnificPopup({
					type: 'inline',
					fixedContentPos: false,
					fixedBgPos: true,
					overflowY: 'auto',
					closeBtnInside: true,
					preloader: false,
					midClick: true,
					removalDelay: 300,
					mainClass: 'my-mfp-zoom-in'
				});
																					
			});
	   </script>											
	</head>	
	<body>
	
	<div align="center">

<form id="dp_input" name="dp_input" action="scribe_act.do" method="POST">
<input type="hidden" id="bsns_cd" name="bsns_cd" value="">
<input type="hidden" id="dtl_cnt" name="dtl_cnt" value="">
<input type="hidden" id="dp_cd" name="dp_cd" value="">
<input type="hidden" id="g_lvl" name="g_lvl" value="">
<input type="hidden" id="input_yyyy" name="input_yyyy" value="${yy }">


<table>
	<tr height="5px">
		<td></td>
	</tr>
	<tr>
		<td width="310px" height="60px" style="text-align:center;vertical-align:middle;border-bottom:1px; border-style:solid;border-bottom-color:#CDC9C9;" rowspan="2">
			<img src="images/sustinvest_logo.png" align="left" width="200px">
		</td>
		<td bgcolor="#36648B" width="425px" height="35px" style="text-align:left;vertical-align:bottom;padding:2px 5px 5px 5px;color:#FFFFFF;font-size:13px">
			SUSTINVEST ESG Assessment System
		</td>
		<td bgcolor="#36648B" width="425px" height="35px" style="text-align:right;vertical-align:bottom;padding:2px 5px 5px 5px;color:#FFFFFF;font-size:13px">
			<c:set var="yyyy" value="${fn:substring(yy,0,4)}"/>
			<c:set var="yyyy_prt" value="${fn:substring(yy,4,5)}"/>
			<c:choose>
				<c:when test="${yyyy_prt eq 'A'}">${yyyy}년도 상반기 입력기간입니다.</c:when>
				<c:otherwise>${yyyy}년도 하반기 입력기간입니다.</c:otherwise>
			</c:choose>
		</td>
	</tr>	
	<tr>
		<td bgcolor="#CDC9C9" height="20px" style="text-align:left;vertical-align:bottom;padding:2px 5px 5px 5px;color:#FFFFFF;font-size:13px" colspan="2">
			<nav id="topMenu" >
			    <ul>
			        <li class="topMenuLi">
			            <a class="menuLink" href="scribe.do">기업평가</a>
			        </li>
			        <li>|</li>
			        <li class="topMenuLi">
			            <a class="menuLink" href="contro_list.do">Controversy</a>
			            <ul class="submenu">
			                <li><a class="submenuLink" href="contro_sect_list.do">sector contro</a></li>
			            </ul>
			        </li>
			        <li>|</li>
			        <li class="topMenuLi">
			            <a class="menuLink" href="verifi_list.do">Verification</a>
			        </li>
			        <c:if test="${auth ne 'user'}">
			        <li>|</li>
			        <li class="topMenuLi">
			            <a class="menuLink" href="universe_list.do">Universe</a>
			        </li>
			        <li>|</li>
			        <li class="topMenuLi">
			            <a class="menuLink" href="datapoint.do">Datapoint</a>
			        </li>
			        <li>|</li>
			        <li class="topMenuLi">
			            <a class="menuLink" href="member_list.do">User</a>
			        </li>
			        <c:if test="${auth eq 'admin'}">
			        <li>|</li>
			        <li class="topMenuLi">
			            <a class="menuLink" href="grading.do">Grading</a>
			        </li>
			        </c:if>
			        </c:if>
			    </ul>
			</nav>
		</td>
	</tr>
	<tr height="5px"><td></td></tr>
</table>

<table style=" width:1200px">
<tr>
	<td width="320px" height=470 align="left" style="vertical-align:top;height:470px" rowspan="2">
		  <div class="scribe_news">
	  	   	  <table class="company_select">
		  	   	  <tr height="30px">
		  	   	  	<th width="80px">섹터</th>
		  	   	  	<td width="240px">
		  	   	  		<div class="styled-select" >
						<select id="gics_sstn" name="gics_sstn" tabindex="9" class="flat" onchange="get_bsns()">
	            				<option value="">선택</option>
	            			<c:forEach items="${l_list}" var="l">
								<option value="${l.GICS_SSTN_CODE}">${l.GICS_SSTN_CODE_NM}</option>
							</c:forEach>
						</select>
		  	   	  		</div>
		  	   	  	</td>
		  	   	  </tr>
		  	   	  <tr height=30>
		  	   	  	<th>종목</th>
		  	   	  	<td>
						<div class="styled-select" id="bsns_select">
						<select class="flat">
	            				<option value="">선택</option>
						</select>								
						</div> 	  	
						
		  	   	  	</td>
		  	   	  </tr>
				  <tr height=30>
		  	   	  	<th width=80px>검색</th>
		  	   	  	<td width=120>
						<div class="bsns-search-box">	
							<input type="text" id="srchBsns" name="srchBsns" value="" onKeyDown="javascript:checkEnterKey()">
							<input type="button" onclick="javascript:srch_bsns()" value=" " />
						</div>		  	   	  	
		  	   	  	</td>
		  	   	  </tr>
			  </table>
			  <div id="btn_bsns" align="center">
				  <table>
  	   	  		  	<tr>
		  	   	  		<td width="100px">
							<div class="btn_scribe_prev"><a href="javascript:bsnsPrev()">Prev</a></div>
						</td>
						<td width="100px">
							<div class="btn_scribe_next"><a href="javascript:bsnsNext()">Next</a></div>
						</td>	
					</tr>
				</table>
			</div>
			<div id="bsnm">
				<h3>-</h3>							
			</div>
			<table class="company_info">
				<tr height="30">
					<td id="gics_names" name="gics_names" colspan="3"  width="320px"></td>
				</tr>
				<tr height="30">
					<td id="asst_scal" name="asst_scal"></td>
					<td id="main_comp" name="main_comp"></td>
					<td id="acct_mon" name="acct_mon"></td>
				</tr>
				<tr height="30">
					<td id="esta_dt" name="esta_dt"></td>
					<td colspan="2" id="list_dt" name="list_dt"></td>
				</tr>
			</table>
			<ul id="tree_menu" style="width:313px;height:566px; overflow-y:auto">
				${tree_list}
			</ul>
		</div>
		<div class="clear"></div>
		<div align="center" style="margin:5px 0px 5px 0px">
		<table>
			<tr>
				<td width="130px">
					<div class="btn_scribe_down"><a href="javascript:excelDown()">Download</a></div>
				</td>
				<td width="130px">
					<div class="btn_scribe_excel"><a href="javascript:excelSave()">Upload</a></div>
				</td>
			</tr>
		</table>
		</div>
	</td>

	<td colspan="2">
		<div class="dp_header">
		  	<div id="dp_nm">
		  		<h3>-</h3>
			</div>
			<div class="clear"> </div>
		</div>
		<!-- <div class="clear"><br/></div> -->
		<div class="comment-area">
			<table class="member_info">
				<tr height=5px></tr>
				<tr>
					<th width="80px" style="text-align:right"><div id="appr_yyyy_data"></div></th>
					<th width="45px" style="text-align:right">수집</th>
					<td width="100px"><input type="text" id="COMP_APPR_NM" name="COMP_APPR_NM" placeholder=""></td>
					<th width="65px" style="text-align:right">수집리뷰</th>
					<td width="100px"><input type="text" id="COMP_APPR_NM" name="COMP_APPR_NM" placeholder=""></td>
					<th width="45px" style="text-align:right">평가</th>
					<td width="100px"><input type="text" id="COMP_APPR_NM" name="COMP_APPR_NM" placeholder=""></td>
					<th width="65px" style="text-align:right">평가리뷰</th>
					<td width="100px"><input type="text" id="COMP_APPR_NM" name="COMP_APPR_NM" placeholder=""></td>
				</tr>
				<tr height=5px></tr>
			</table>
			<!-- <div class="textbox_year"><input type="text" name="input_yyyy_lb" class="textbox_yyyy" value="2014년 하반기 입력기간 입니다." readonly></div>
			<div class="text-box"><input type="text" class="textbox" value="수집담당:" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '수집담당:';}"></div>
			<div class="text-box"><input type="text" class="textbox" value="평가담당:" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '평가담당:';}"></div> -->
		</div>
	</td>
</tr>	
<tr>	
	<td style="vertical-align:top;">
		<div class="scribe_news">
			<ul style="height:797px; overflow-y:auto">
	  			<li>
				<table style="width:100%">
					<tr height="30px">
						<td bgcolor="#999999" style="text-align:center;vertical-align:middle;color:#FFFFFF" width=40px>
						점수
						</td>
						<td bgcolor="#CCCCCC" style="text-align:left;vertical-align:middle;color:#FFFFFF" width=210px>
							<div class="stra-area">
								<input type="text" id="pnt" name="pnt" style="height:30px" value="" maxlength="4"/>
							</div>		
						</td>
					</tr>
				</table>
<!----------------------------- FOR BR --------------------------------->
<table><tr><td height=10px></td></tr></table>
<!----------------------------- FOR BR --------------------------------->
				<div id="dtl_info">
				
				</div>
				<table style="width:100%">
					<tr height=60px>
						<td bgcolor="#999999" style="text-align:center;vertical-align:middle;color:#FFFFFF" width=40px>출처</td>
						<td bgcolor="#CCCCCC" style="text-align:left;vertical-align:middle;color:#FFFFFF" width=210px>
							<div class="stra-area">
								<textarea id="src" name="src" style="height:60px"></textarea>
							</div>		
						</td>
					</tr>
				</table>
<!----------------------------- FOR BR --------------------------------->
<table><tr><td height=10px></td></tr></table>
<!----------------------------- FOR BR --------------------------------->
				<table style="width:100%">
					<tr height="60px">
						<td bgcolor="#999999" style="text-align:center;vertical-align:middle;color:#FFFFFF" width=40px>
						메모
						</td>
						<td bgcolor="#CCCCCC" style="text-align:left;vertical-align:middle;color:#FFFFFF" width=210px>
							<div class="stra-area">
								<textarea id="memo" name="memo" style="height:60px"></textarea>
							</div>		
						</td>
					</tr>
				</table>
<!----------------------------- FOR BR --------------------------------->
<table><tr><td height=10px></td></tr></table>
<!----------------------------- FOR BR --------------------------------->

				<table style="width:100%">
					<tr>
						<td rowspan="3" bgcolor="#999999" style="text-align:center;vertical-align:middle;color:#FFFFFF" width=40px>
						기업<br/>피드백
						</td>
						<td bgcolor="#CCCCCC" style="text-align:left;vertical-align:middle;color:#FFFFFF" width=210px height="100px">
							<div class="stra-area">
								<textarea style="height:80px" id="comp_cntn" name="comp_cntn" placeholder="(내용)"></textarea>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan=2 bgcolor="#888888" height="1"></td>
					</tr>
					<tr>
						<td bgcolor="#CCCCCC" style="text-align:left;vertical-align:middle;color:#FFFFFF" width=210px height="100px">
							<div class="stra-area" style="height:100px">
								<textarea style="height:80px" id="comp_src" name="comp_src" placeholder="(출처)"></textarea>
							</div>
						</td>
					</tr>
				</table>

	  	   	    <div class="clear"> </div>
				</li>
			</ul>
		</div>
	</td>
	<td style="vertical-align:top;width:400px">
		<table>
			<tr>
				<td width=400px style="border:1px solid">
					<div class="scribe_help">
  						<h3>배점기준</h3>
  					</div>
  					<div class="clear"> </div>
				</td>
			</tr>
			<tr height=218px>
				<td width=95% style="border:1px solid">
					<div class="news_desc" style="width:95%; height:218px; overflow-y:auto">
						<div id="etc_text"></div>
					</div>
					<div class="clear"> </div>
				</td>
			</tr>
			<tr>
				<td width=400px style="border:1px solid">
					<div class="scribe_help"><h3>도움말</h3></div>
					<div class="clear"> </div>
				</td>
			</tr>
			<tr height=460px>
				<td width=95% style="border:1px solid">
					<div class="news_desc" style="width:95%; height:460px; overflow-y:auto">
						<div id="help_text"></div>
					</div>
				</td>
			</tr>
		</table>	
		<div id ="btn_dtpt" align="center" style="margin:5px 0px 5px 0px">				  
			<table>
				<tr>
					<td width="100px">
						<div class="btn_scribe_prev"><a href="javascript:dpPrev()">Prev</a></div>
					</td>
					<td width="100px">
						<div class="btn_scribe_next"><a href="javascript:dpNext()">Next</a></div>
					</td>		
				</tr>                                
			</table>
		</div>
	</td>
</tr>
</table>							  

</form>
</div>
	</body>
</html>


