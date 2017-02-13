<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="java.util.Iterator" %>
<%@page import="org.apache.commons.logging.Log" %>
<%@page import="org.apache.commons.logging.LogFactory" %>
<%
Log logPaging = LogFactory.getLog(getClass());
System.out.println("getRowPerPage:" + pagingList.getRowPerPage());
try{
if(pagingList != null && pagingList.getTotalRow() > 0){ %>
<%-- paging : str --%>
<div class="paging" >
	<a href="javascript:goPage('<%=pagingList.getPrePage()%>')" class="no-bg">&lt;&lt;</a>
	<%
	Iterator tmp =pagingList.getPageNumCol().iterator();
	int pagingSize=pagingList.getPageNumCol().size();
	int pagingLoop=1;
	String styleFont01="style=\"font-size:9pt;font-family:µ¸¿ò, Arial, sans-serif;color:blue;font-weight:bold;\"";
	String styleFont02="style=\"font-size:9pt;font-family:µ¸¿ò, Arial, sans-serif;color:gray;font-weight:none;\"";
	while(tmp.hasNext()){
		if(pagingLoop>1) out.print("<span>.</span>");
		String iterNum=String.valueOf(tmp.next());
	%>	
		<a href="javascript:goPage('<%=iterNum%>');">
		<%=pagingList.getCurrentPage()==Integer.parseInt(iterNum)?"<b><strong><span style='font-size:15px;color:red;'>"+iterNum+"</span></strong></b>":iterNum%>
		</a>
	<%
		pagingLoop++;
	}
	%>
	<a href="javascript:goPage('<%=pagingList.getNextPage()%>')" class="no-bg">&gt;&gt;</a>
</div>
<% } %>
<%
}catch(Exception e){
	logPaging.error(e);
}
%>