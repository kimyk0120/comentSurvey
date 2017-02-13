<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<head>
	<script type="text/javascript">
	
	$(document).ready(function(){

		var le = <%=request.getParameter("left") %>;
		var tp = <%=request.getParameter("top") %>;
		
		if(tp == "" || tp == null) $('#top').val('9');
		if(le == "" || le == null) $('#left').val('9');
		
		 $.ajax({ 
			   url: "uri_save.do", 
			   type: "POST", 
			   data: {"uri" : window.location.pathname},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      } 
			}); 
		
	});
	
	function logout () {
		if(confirm("로그아웃 하시겠습니까?")) {
			document.mainform.action = "logout.do";
			document.mainform.submit();
		}
	}
	
	function main_user_edit() {
		
		var id = "<%=session.getAttribute("UserId").toString() %>";
		var before_url = window.location.pathname;
		
		$('#login_user_id').val(id);
		$('#before_url').val(before_url);
		
		document.mainform.action = "direct_user_edit.do";
		document.mainform.submit();
	}
	
	function login () {
		document.mainform.action = "login.do";
		document.mainform.submit();
	}
	
	function go_main() {
		$('#top').val('9');
		$('#left').val('9');
		document.mainform.action = "main.do";
		document.mainform.submit();
	}
	
	function moveUrl(t, l, url ) {
		$('#top').val(t);
		$('#left').val(l);
		location.href = url+"?top="+t+"&left="+l;
	}
	
	</script>
</head>

<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<input type="hidden" id="login_user_id" name="login_user_id"  />
<input type="hidden" id="before_url" name="before_url"  />
<body>
<div id="gnb" class="clearfix">
	<h1>
		<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
		<c:choose>
			<c:when test="${auth eq 9}">
				<a href="javascript:login()" title="문화관광해설사 인력관리 시스템 메인"><img src="image/kcti_logo.png" alt="문화관광해설사 인력관리 시스템" /></a>
			</c:when>
			<c:otherwise>
				<a href="javascript:go_main()" title="문화관광해설사 인력관리 시스템 메인"><img src="image/kcti_logo.png" alt="문화관광해설사 인력관리 시스템" /></a>
			</c:otherwise>
		</c:choose>
	</h1>
	<ul class="clearfix">
		<%
		
		String topId = request.getParameter("top");
		String tt = (String)request.getAttribute("top"); 
		if(topId == null || topId == "") {
			if(tt != null && tt != "") {
				topId= tt;
			} else {
				topId = "9";
			}
		}
		%>
		<c:set value="<%=topId %>" var="tid" />
		
		<%	
	String leftId = request.getParameter("left");
	String lt = (String)request.getAttribute("left"); 
	if(leftId == null || leftId == "") {
		if(lt != null && lt != "") {
			leftId= lt;
		} else {
			leftId = "9";
		}
	}
	 %>
	 <c:set value="<%=leftId %>" var="lid" />
	 
	<%	
	String tp = session.getAttribute("topMenu").toString();
	String top[] =tp.split(",");
	String menuName = null;
	String menuPath = null;
	String row = null;
	
	String lp = session.getAttribute("leftMenu").toString();
	String left[] =lp.split(";");
	String menuName2 = null;
	String menuPath2 = null;
	String row2 = null;

	for(int i=0; i < top.length; i++) {
		
		String[] tmp = top[i].split("`");
		row = tmp[0];
		menuName = tmp[1];
		menuPath = tmp[2];
	%>
	<c:set value="<%=i %>" var="sz" />
				<li <c:if test="${tid eq sz}">class="on"</c:if>><a id="menu<%=i %>" href="javascript:moveUrl('<%=i %>','0','<%=menuPath %>');" ><%= menuName %></a>
	<%	
	
	String le = left[i];
	String lefts[] = le.split(":");
	String leftss[] = lefts[1].split(",");
%>
		<ul class="clearfix" style="width:500px;left:0">
<%

	for(int a=0; a < leftss.length; a++) {
		
		String[] tmp2 = leftss[a].split("`");
		row = tmp2[0];
		menuName2 = tmp2[1];
		menuPath2 = tmp2[2];
	%>
	<c:set value="<%=a %>" var="sz2" />
	
				<li <c:if test="${lid eq sz2}">class="on"</c:if>><a id="menu<%=a %>" href="javascript:moveUrl('<%=i %>','<%=a %>','<%=menuPath2 %>');" ><%= menuName2 %></a></li>
	<%	
	}
%>	
		</ul>
		<%
	}
    %>
		</li>
	</ul>
	</div><!--// gnb -->
	
		<c:set value="<%=session.getAttribute(\"authNo\") %>" var="auth" />
		<c:choose>
			<c:when test="${auth eq 9}">
				<div class="top-menu">
					<a href="javascript:login()" class="btn-login" title="로그인"><span>로그인</span></a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="top-menu">
					<a href="javascript:main_user_edit()" class="btn-user" title="사용자 정보"><span>사용자 정보</span></a>
					<a href="javascript:logout()" class="btn-logout" title="로그아웃"><span>로그아웃</span></a>
					<a href="#a" class="btn-login" title="로그인" style="display:none"><span>로그인</span></a>
				</div>
			</c:otherwise>
		</c:choose>
	
		<!-- <div class="top-menu">
			<a href="#a" class="btn-user" title="사용자 정보"><span class="text-hidden">사용자 정보</span></a>
			<a href="javascript:logout()" class="btn-logout" title="로그아웃"><span>로그아웃</span></a>
			<a href="#a" class="btn-login" title="로그인" style="display:none"><span>로그인</span></a>
		</div> -->
</body>
</html>
<%!
public static String toUTF8(String str) throws Exception
{ 
	if(str != null) 
		return new String(str.getBytes("8859_1"),"utf-8");
	else
		return null;
} 
%>