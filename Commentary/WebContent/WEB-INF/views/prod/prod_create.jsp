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
<title>상품 상세정보</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">
	
	function prod_save() {
		
		if($("#prod_code").val() == "" || $("#prod_code").val() == null) {
			alert("품목코드를 입력하세요.");
		    $("#prod_code").focus();
		} else if ($("#prod_name").val() == "" || $("#prod_name").val() == null) {
			alert("품목명을 입력하세요.");
		    $("#prod_name").focus();
		} else {
		
			$.ajax({ 
			   url: "prod_code_check.do", 
			   type: "POST", 
			   data: {"p_cd" : $("#prod_code").val()},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   
				   if(msg == "Y") {
					    document.mainform.action = "prod_insert.do";
					    document.mainform.submit();
				   }
				   else {
					   alert("코드가 중복됩니다. 다시 입력해주세요");
					   $("#prod_code").focus();
					   return false;
				   }
				   
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
		}
	}
	
	function moveUrl(t, l, url ) {
		mainform.top.value=t;
		mainform.left.value=l;
		location.href = url+"?top="+t+"&left="+l;
		//document.mainform.action = url;
		//document.mainform.submit();
	}
	
	function cmaComma(obj) {
		var num_check=/^[/,/,0-9]*$/;
	    //var strNum = /^[/,/,0,1,2,3,4,5,6,7,8,9,/]/; // 숫자와 , 만 가능
	    var str = "" + obj.value.replace(/,/gi,''); // 콤마 제거  
	    var regx = new RegExp(/(-?\d+)(\d{3})/);  
	    
	      if (!num_check.test(obj.value)) {
		        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
		        obj.focus();
		        return false;
		    }
	 
	    while(regx.test(str)){  
	    	str = str.replace(regx,"$1,$2");  
	    }  
        obj.value = str; 
	}
	
</script>
</head>
<body>

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="srch_prod" name="srch_prod" value="${srch.srch_prod}"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />
		
		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">품목 생성</h2>
				<h3 class="mb0">신규 품목 생성</h3>
			</div>

			<table class="talbe-view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>품목코드</th>
						<td><input type="text" id="prod_code" name="prod_code" value="${info.prod_code }" placeholder="3자리로 입력하세요"/></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<th>품목명</th>
						<td><input type="text" id="prod_name" name="prod_name" value="${info.prod_name }" /></td>
						<td></td>
						<td></td>
					</tr>
					<c:forEach items="${p_list }" var="p">
						<tr>
							<th>출고단가 ( ${p.dlvr_objt_code_nm } )</th>
							<td colspan="3">
								<input type="text" id="p_${p.dlvr_objt_code}" name="p_${p.dlvr_objt_code}" onkeyup="cmaComma(this);"/>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div class="btn-block">
				<a href="javascript:prod_save()"><span>저장</span></a>
				<a href="javascript:history.back()" class="btn-gray"><span>취소</span></a>
			</div><!--// btn-block -->
			
		</div><!--// layer-content -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</body>
</html>