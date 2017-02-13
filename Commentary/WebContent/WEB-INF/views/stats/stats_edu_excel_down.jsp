<%@ page language="java" contentType="application/vnd.ms-excel"   pageEncoding="EUC-KR"%>
<%-- <%@ page language="java" contentType="text/html; charset=EUC-KR"    pageEncoding="EUC-KR"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
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

<c:set var="yymm" value="${srch.srch_ym}" />
<c:set var="c_list" value="${list}" />
<%
		String name = "지역별 문화관광해설사 보수교육 실시 현황" + ".xlsx";
		name = new String(name.getBytes("KSC5601"), "8859_1");
		
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
	    
		OutputStream fileOut = null;
	    
		XSSFWorkbook workbook=new XSSFWorkbook();
		XSSFSheet sheet=workbook.createSheet("문화관광해설사 보수교육 실시 현황");
		XSSFRow row=null;
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
	    
	    String yM = pageContext.getAttribute("yymm").toString();
	    
	    row=sheet.createRow((short)0);
		cell=row.createCell(0);
        cell.setCellValue(String.valueOf("구분"));
		cell.setCellStyle(st);
		
		cell=row.createCell(1);
        cell.setCellValue(String.valueOf(yM+"년도  보수교육 실시 현황"));
		sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 4));
		cell.setCellStyle(st);
		
		row=sheet.createRow((short)1);
        cell=row.createCell(0);
        cell.setCellValue(String.valueOf("지역"));
        cell.setCellStyle(st);
	    
        cell=row.createCell(1);
        cell.setCellValue(String.valueOf("보수교육 실시여부(실시/미실시)"));
        cell.setCellStyle(st);
        
        cell=row.createCell(2);
        cell.setCellValue(String.valueOf("보수교육실시 기관명"));
        cell.setCellStyle(st);
        
        cell=row.createCell(3);
        cell.setCellValue(String.valueOf("보수교육 실시 시기"));
        cell.setCellStyle(st);
        
        cell=row.createCell(4);
        cell.setCellValue(String.valueOf("보수교육참여인원"));
        cell.setCellStyle(st);
        
        ArrayList<StatsVo> c_list = (ArrayList<StatsVo>)pageContext.getAttribute("c_list") ;
        String place ="";
        String tm = "";
        String cnt ="";
		for(int i=0; i < c_list.size() ; i++ ) {
        	
        	StatsVo svo = c_list.get(i);
        	
        	row=sheet.createRow((short) (i+2) );
            cell=row.createCell(0);
        	cell.setCellStyle(st2);
            cell.setCellValue(String.valueOf(svo.getSido_cd_nm() ));
            
            cell=row.createCell(1);
        	cell.setCellStyle(st2);
            cell.setCellValue(String.valueOf(svo.getEdu_yn() ));
            cell=row.createCell(2);
        	cell.setCellStyle(st2);
        	place = svo.getEdu_place();
        	if("".equals( place ) || place == null ) place = "";
            cell.setCellValue(String.valueOf(place));
            
            cell=row.createCell(3);
        	cell.setCellStyle(st2);
        	tm = svo.getEdu_tm();
        	if("".equals( tm ) || tm == null ) tm = "";
            cell.setCellValue(String.valueOf(tm));

            cell=row.createCell(4);
        	cell.setCellStyle(st2);
        	cnt = svo.getEdu_cnt();
        	if("".equals( cnt ) || cnt == null ) cnt = "";
            cell.setCellValue(String.valueOf(cnt ));
        }
        
        fileOut = response.getOutputStream(); 
    	workbook.write(fileOut);
    	fileOut.close();
%>

	