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
<title>문화관광해설사 인력관리 시스템</title>
<link href="common/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		var yn = "<%=session.getAttribute("chkYn") %>";
		var fst = "<c:out value="${fstYn}"/>";
		
		if(yn == "N" && fst == "Y") {
			showModalDialog($("#layer_act"));
			
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

				$("#btn_close", $dialog).one("click", function(event) {
									
					var chk = $("input:checkbox[id='chk_yn']").is(":checked");
					
					if(chk) {
						$.ajax({ 
							   url: "main_check.do", 
							   type: "POST", 
							   dataType:"text",
							   cache: false,
							   success: function(msg){
							   }
							   , error: function (xhr, ajaxOptions, thrownError) {
							      }
							}); 
					}
					
					$dialog.hide()
						.prev("div.dim-warp").remove();
				});
			}

			function dialogInitPos($dialog) {
				var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
					top = Math.floor(($(window).height() - $dialog.height()) / 2);
				$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
			}
		}
	});
	
	$(function() {
		$('.formSelect').sSelect();
		$('#tabs').tabs();
				
	});
	
	function main_info() {
		window.location.href="main_info.do?top=9&left=9";
	}
</script>
</head>
<body>
<div id="wrapper">
<form id="mainform" name="mainform" action="" method="post">
	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container" class="colum2-small"><!-- 이런 형태의 서브 페이지에 대해서 클래스 colum2-small 삽입 -->

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

			<div class="shadow-box">

				<h2><span class="text1">문화관광해설사</span><span class="text2">관 리 시 스 템</span></h2>

				<h3><span>문화관광해설사란,</span></h3>

				<p class="img-box mb5">
					<img src="image/img_commentator.png" alt="문화관광해설사는 문화유산,관광자원, 생태환경, 풍습, 지역이해(역사와 문화)를 쉽게 이해할 수 있도록 설명하는 전문 해설가입니다." />
				</p>

				<div class="section-text">
					<p>
						단순 안내만을 담당하는 가이드와 달리,<br />
						관광객들에게 우리의 문화유산이 올바르고 이해하기 쉽게 전달될 수 있도록 설명하는 <strong class="point-g">전문 해설가</strong>입니다.<br />
						관광객이 우리 고유의 <strong class="point-b">문화유산</strong>이나 <strong class="point-b">관광자원</strong>, <strong class="point-b">풍습</strong>, <strong class="point-b">생태환경</strong>, <strong class="point-b">해당 지역의 역사나 문화</strong>를 쉽게 이해할 수 있도록 <strong class="point-g">해설하고</strong>, <strong class="point-g">생활문화를 체험</strong>할 수 있도록 돕는 역할을 합니다.<br />
						따라서 우리의 문화와 역사, 관광자원에 대한 해박한 <strong class="point-v">지식과 소양</strong>을 갖추어야 하며,  관련 자료를 <strong class="point-v">수집하고 연구</strong>하는 노력을 계속적으로 이어가야 합니다.
					</p>
					<p>
						처음 문화관광해설사 제도가 도입된 것은  2001년 한국방문의 해, 2002년 월드컵 등 대규모 국가행사를 맞이하여 우리나라를 방문하는 외국인에게 우리의 문화와 전통, 관광자원을 올바르게 이해시키기 위함이었습니다.
					</p>
					<p>
						초기에는 ‘문화유산해설사’라는 명칭으로, 문화재나 문화유산을 중심으로 활동을 해왔으며,이후 ‘문화관광해설사’로 이름을 바꾸고 관광지, 관광단지, 농어촌 체험관광 등 다양한 분야의 관광자원으로 업무 영역이 확대되었습니다.  2011년 관광진흥법이 개정되며 문화관광해설사의 명칭이 법제화되었습니다. 
					</p>
				</div><!-- // section-text -->

				<h3><span>문화관광해설사 관리통합 시스템은,</span></h3>

				<div  class="section-diagram clearfix">
					<dl class="system1">
						<dt><span>투입</span><span>(Input)</span></dt>
						<dd>
							<p><span class="bullet"><strong>해설사 양성</strong> (국고 / 지방비)</span></p>
							<p><span>- 신규/보수 양성비</span></p>
						</dd>
						<dd>
							<p><span class="bullet"><strong>해설사 운영</strong> (국고 / 지방비)</span></p>
							<p><span>- 활동비</span></p>
						</dd>
						<dd class="in"><span><strong>투입인력정보</strong></span><span class="line">해설사 개인정보</span><span class="line">(소속, 성, 연령, 교육, 언어 등)</span></dd>
					</dl>
					<dl class="system2">
						<dt><span>산출</span><span>(Output)</span></dt>
						<dd>
							<p><span class="bullet">문화관광해설사 <strong>양성</strong> 인력</span></p>
						</dd>
						<dd>
							<p><span class="bullet">문화관광해설사 제공</span></p>
							<p><span>- 제공시간, 수혜자수 등</span></p>
						</dd>
					</dl>
					<dl class="system3">
						<dt><span>평가</span><span>(Outcomes)</span></dt>
						<dd>
							<p><span class="bullet"><strong>관광만족도</strong> 증가</span></p>
							<p><span>- <strong>관광객수</strong> 증가</span></p>
						</dd>
						<dd>
							<p><span class="bullet"><strong>국내 관광상품의 고부가가치화</strong></span></p>
							<p><span>- 관광안내체계 구축사업 심층평가 참조</span></p>
						</dd>
					</dl>
				</div><!-- // section-diagram -->

			</div>

			<div class="bottom-logo"><!-- class="contents" div 안에 넣어주세요~ 이전 파일들도 마찬가지입니다. -->
				<ul class="clearfix">
					<li><a href="http://www.mcst.go.kr"><img src="image/logo_mcst.png" alt="문화체육관광부" /></a></li>
					<li><a href="http://www.kcti.re.kr"><img src="image/logo_kcti.png" alt="한국문화관광연구원" /></a></li>
				</ul>
			</div><!-- // bottom-logo -->

		</div><!--// contents -->

	</div><!--// container -->
	</form>
</div>

<form id="frm_popup" name="frm_popup" action="" method="post">
<div id="layer_act" class="layer-warp" style="width:300px">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>소개 페이지</h2>
		</div>

		<div class="contents" style="margin-left:5px;padding:5px">
			<div class="pos-relative"><h3><input type="checkbox" name="chk_yn" id="chk_yn" value="Y" /><label for="chk_yn">다음 로그인시에는 소개 페이지를 보지 않겠습니다.</label></h3></div>
			
			<div class="btn-block text-center" style="border-top:none">				
				<a href="javascript:;" class="btn-orange" id="btn_close"><span>닫기</span></a>
			</div><!--// btn-block -->
			
		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>


</body>
</html>


