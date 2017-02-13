<%@ page language="java" contentType="application/vnd.ms-excel"   pageEncoding="EUC-KR"%>
<%-- <%@ page language="java" contentType="text/html; charset=EUC-KR"    pageEncoding="EUC-KR"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.Date" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFCell" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFRow" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFSheet" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFWorkbook" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFCellStyle" %>
<%@ page import="org.apache.poi.ss.usermodel.IndexedColors" %>
<%@ page import="org.apache.poi.ss.usermodel.CellStyle" %>
<%@ page import="org.apache.poi.ss.util.CellRangeAddress" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.sweetk.kcti.stats.vo.StatsVo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.OutputStream" %>

<c:set var="prt" value="${prt}" />
<%-- <c:set var="nm" value="${nm}" /> --%>

<c:set var="f10" value="0"/>
<c:set var="f20" value="0"/>
<c:set var="f30" value="0"/>
<c:set var="f40" value="0"/>
<c:set var="f50" value="0"/>
<c:set var="f60" value="0"/>
<c:set var="f70" value="0"/>
<c:set var="ftot" value="0"/>
<c:set var="m10" value="0"/>
<c:set var="m20" value="0"/>
<c:set var="m30" value="0"/>
<c:set var="m40" value="0"/>
<c:set var="m50" value="0"/>
<c:set var="m60" value="0"/>
<c:set var="m70" value="0"/>
<c:set var="mtot" value="0"/>

<c:set var="now"><fmt:formatDate value="<%=new Date() %>" pattern="yyyy" /></c:set>

<c:forEach items="${list}" var="a" varStatus="status">
<c:set var="ages" value="${now - fn:substring(a.ages,0,4)}"/>
<c:if test="${ages lt 20 and cmmt_cnt eq 'F'}"> <c:set var="f10" value="${f10+1}"/></c:if>
<c:if test="${ages ge 20 and ages lt 30 and a.cmmt_cnt eq 'F'}"> <c:set var="f20" value="${f20+1}"/></c:if>
<c:if test="${ages ge 30 and ages lt 40 and a.cmmt_cnt eq 'F'}"> <c:set var="f30" value="${f30+1}"/></c:if>
<c:if test="${ages ge 40 and ages lt 50 and a.cmmt_cnt eq 'F'}"> <c:set var="f40" value="${f40+1}"/></c:if>
<c:if test="${ages ge 50 and ages lt 60 and a.cmmt_cnt eq 'F'}"> <c:set var="f50" value="${f50+1}"/></c:if>
<c:if test="${ages ge 60 and ages lt 70 and a.cmmt_cnt eq 'F'}"> <c:set var="f60" value="${f60+1}"/></c:if>
<c:if test="${ages ge 70 and a.cmmt_cnt eq 'F'}"> <c:set var="f70" value="${f70+1}"/></c:if>
<c:if test="${a.cmmt_cnt eq 'F'}"> <c:set var="ftot" value="${ftot+1}"/></c:if>
<c:if test="${ages lt 20 and a.cmmt_cnt eq 'M'}"> <c:set var="m10" value="${m10+1}"/></c:if>
<c:if test="${ages ge 20 and ages lt 30 and a.cmmt_cnt eq 'M'}"> <c:set var="m20" value="${m20+1}"/></c:if>
<c:if test="${ages ge 30 and ages lt 40 and a.cmmt_cnt eq 'M'}"> <c:set var="m30" value="${m30+1}"/></c:if>
<c:if test="${ages ge 40 and ages lt 50 and a.cmmt_cnt eq 'M'}"> <c:set var="m40" value="${m40+1}"/></c:if>
<c:if test="${ages ge 50 and ages lt 60 and a.cmmt_cnt eq 'M'}"> <c:set var="m50" value="${m50+1}"/></c:if>
<c:if test="${ages ge 60 and ages lt 70 and a.cmmt_cnt eq 'M'}"> <c:set var="m60" value="${m60+1}"/></c:if>
<c:if test="${ages ge 70 and a.cmmt_cnt eq 'M'}"> <c:set var="m70" value="${m70+1}"/></c:if>
<c:if test="${a.cmmt_cnt eq 'M'}"> <c:set var="mtot" value="${mtot+1}"/></c:if>



</c:forEach>
<c:choose>
	<c:when test="${prt eq 1}">
		<c:set var ="nm" value="${list[0].sido_cd_nm}" />
	</c:when>
	<c:when test="${prt eq 2}">
		<c:set var ="nm" value="${list[0].gugun_cd_nm}" />
	</c:when>
</c:choose>


<%
		String name = "지역별 문화관광해설사 운영 현황";
		name = new String(name.getBytes("KSC5601"), "8859_1");
		
		String prt = pageContext.getAttribute("prt").toString();
		String nm = pageContext.getAttribute("nm").toString();
		nm = new String(nm.getBytes("KSC5601"), "8859_1");
		
		name = name +" " +nm + ".xlsx";
		
		out.clear();
	    out = pageContext.pushBody();
	    response.reset(); // 이 문장이 없으면 excel 등의 파일에서 한글이 깨지는 문제 발생.

	    String strClient = request.getHeader("User-Agent");
	    
	    String fileName = name;
		
		if (strClient.indexOf("MSIE 5.5") > -1) {
		    response.setHeader("Content-Disposition", "filename=" + fileName + ";");
		    } else {
		    response.setContentType("application/vnd.ms-excel");
		    response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
		    }
				
		/* response.setContentType("application/vnd.ms-excel"); 
		response.setHeader("Content-Disposition", "attachment; filename="+name+".xls"); 
	    response.setHeader("Content-Description", "JSP Generated Data"); */
	    
		OutputStream fileOut = null;
	    
		//1차로 workbook을 생성 
		XSSFWorkbook workbook=new XSSFWorkbook();
		//2차는 sheet생성 
		XSSFSheet sheet=workbook.createSheet("해설사 배치 현황");
		//엑셀의 행 
		XSSFRow row=null;
		//엑셀의 셀 
		XSSFCell cell=null;
		
		XSSFCellStyle st = workbook.createCellStyle();
		st.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		st.setFillPattern(CellStyle.SOLID_FOREGROUND);
		st.setBorderBottom(CellStyle.BORDER_MEDIUM);
	    st.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	    st.setBorderLeft(CellStyle.BORDER_MEDIUM);
	    st.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	    st.setBorderRight(CellStyle.BORDER_MEDIUM);
	    st.setRightBorderColor(IndexedColors.BLACK.getIndex());
	    st.setBorderTop(CellStyle.BORDER_MEDIUM);
	    st.setTopBorderColor(IndexedColors.BLACK.getIndex());
	    
	    XSSFCellStyle st2 = workbook.createCellStyle();
	    st2.setBorderBottom(CellStyle.BORDER_THIN);
	    st2.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	    st2.setBorderLeft(CellStyle.BORDER_THIN);
	    st2.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	    st2.setBorderRight(CellStyle.BORDER_THIN);
	    st2.setRightBorderColor(IndexedColors.BLACK.getIndex());
	    st2.setBorderTop(CellStyle.BORDER_THIN);
	    st2.setTopBorderColor(IndexedColors.BLACK.getIndex());
	    
	   /*  ArrayList<StatsVo> c_list = (ArrayList<StatsVo>)pageContext.getAttribute("c_list") ;
	    StatsVo sv = c_list.get(0);
	    String sNm = ""; */
	    
	   /*  if("1".equals(prt)) {
		    sNm = pageContext.getAttribute("sido_cd_nm").toString();
	    } else {
	    	sNm = pageContext.getAttribute("gugun_cd_nm").toString();;
	    } */
	    
	    row=sheet.createRow((short)0);
	    cell=row.createCell(0);
        cell.setCellValue(String.valueOf("문화관광해설사 성별/연령별 현황 ("+nm+")"));
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 2));
		cell.setCellStyle(st);
		
		row=sheet.createRow((short)1);
        cell=row.createCell(0);
        cell.setCellValue(String.valueOf("연령별"));
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 0, 0));
        cell.setCellStyle(st);
	    
        cell=row.createCell(1);
        cell.setCellValue(String.valueOf("성별"));
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 2));
        cell.setCellStyle(st);
        
        row=sheet.createRow((short)2);
        cell=row.createCell(1);
        cell.setCellValue(String.valueOf("여성"));
        cell.setCellStyle(st);
        
        cell=row.createCell(2);
        cell.setCellValue(String.valueOf("남성"));
        cell.setCellStyle(st);
        
       	row=sheet.createRow((short)3);
        cell=row.createCell(0);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf("20대 미만"));
        cell=row.createCell(1);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("f10").toString()));
        cell=row.createCell(2);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("m10").toString()));
       	row=sheet.createRow((short)3);
        cell=row.createCell(0);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf("20대"));
        cell=row.createCell(1);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("f20").toString()));
        cell=row.createCell(2);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("m20").toString()));
       	row=sheet.createRow((short)3);
        cell=row.createCell(0);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf("30대"));
        cell=row.createCell(1);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("f30").toString()));
        cell=row.createCell(2);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("m30").toString()));
       	row=sheet.createRow((short)3);
        cell=row.createCell(0);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf("40대"));
        cell=row.createCell(1);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("f40").toString()));
        cell=row.createCell(2);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("m40").toString()));
       	row=sheet.createRow((short)3);
        cell=row.createCell(0);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf("50대"));
        cell=row.createCell(1);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("f50").toString()));
        cell=row.createCell(2);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("m50").toString()));
       	row=sheet.createRow((short)3);
        cell=row.createCell(0);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf("60대"));
        cell=row.createCell(1);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("f60").toString()));
        cell=row.createCell(2);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("m60").toString()));
       	row=sheet.createRow((short)3);
        cell=row.createCell(0);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf("70대 이상"));
        cell=row.createCell(1);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("f70").toString()));
        cell=row.createCell(2);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("m70").toString()));
       	row=sheet.createRow((short)3);
        cell=row.createCell(0);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf("총계"));
        cell=row.createCell(1);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("ftot").toString()));
        cell=row.createCell(2);
       	cell.setCellStyle(st2);
        cell.setCellValue(String.valueOf(pageContext.getAttribute("mtot").toString()));
        
        fileOut = response.getOutputStream(); 
    	workbook.write(fileOut);
    	fileOut.close();
%>




		