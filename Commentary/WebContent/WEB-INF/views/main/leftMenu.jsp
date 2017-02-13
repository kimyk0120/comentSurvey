<%@ page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<script type="text/javascript"> 

	function schd_add() {
		window.open('', 'popup_post', 'width=1000, height=815, resizable=no, scrollbars=yes, status=no');
	    mainform.target = 'popup_post';
		document.mainform.action = "schd_srch.do";
		document.mainform.submit();
	}



</script>

	<body id="left-frame">
<div class="lnb">
	<ul>
<%	
	String leftId = request.getParameter("left");
	String lt = (String)request.getAttribute("left"); 
	if(leftId == null || leftId == "") {
		if(lt != null && lt != "") {
			leftId= lt;
		} else {
			leftId = "0";
		}
	}
	 %>
	 <c:set value="<%=leftId %>" var="lid" />
		<%
	String lp = session.getAttribute("leftMenu").toString();
	String topId = request.getParameter("top");
	String tt = (String)request.getAttribute("top"); 
	if(topId == null || topId == "") {
		if(tt != null && tt != "") {
			topId = tt;
		} else {
			topId = "0";
		}
	}
	String th = session.getAttribute("auth").toString();
	
	int id = Integer.parseInt(topId);
	
	String left[] =lp.split(";");
	String le = left[id];
	String lefts[] = le.split(":");
	String leftss[] = lefts[1].split(",");
	String menuName = null;
	String menuPath = null;
	String row = null;

	for(int i=0; i < leftss.length; i++) {
		
		String[] tmp = leftss[i].split("`");
		row = tmp[0];
		menuName = tmp[1];
		menuPath = tmp[2];
	%>
	<c:set value="<%=i %>" var="sz" />
				<li><a id="menu<%=i %>" href="javascript:moveUrl('<%=topId %>','<%=i %>','<%=menuPath %>');" <c:if test="${lid eq sz}">class="on"</c:if>><%= menuName %></a></li> 
	<%	
	}
    %>
	</ul>
	<c:set value="<%=topId %>" var="tp" />
	<c:set value="<%=th %>" var="ath" />
	<c:if test="${tp lt 2 and ath eq '001'}" >
	<div class="btn-block">
		<a href="javascript:schd_add()"><span>일정검색</span></a>
	</div>
	</c:if>
</div><!--// lnb -->


</body>

    <%!
public static String toUTF8(String str) throws Exception
{ 
	if(str != null) 
		return new String(str.getBytes("8859_1"),"utf-8");
	else
		return null;
} 
%>