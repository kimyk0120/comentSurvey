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
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.sweetk.kcti.commentary.vo.CommentaryVo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.OutputStream" %>


<%
		String name = "해설사" + ".xlsx";
		name = new String(name.getBytes("KSC5601"), "8859_1");

		/* response.setContentType("application/vnd.ms-excel"); 
		response.setHeader("Content-Disposition", "attachment; filename="+name+".xls"); 
	    response.setHeader("Content-Description", "JSP Generated Data"); */
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
	    
		//1차로 workbook을 생성 
		XSSFWorkbook workbook=new XSSFWorkbook();
		//2차는 sheet생성 
		XSSFSheet sheet=workbook.createSheet("commentory");
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
	
		row=sheet.createRow((short)0);
        //생성된 row에 컬럼을 생성한다 
        cell=row.createCell(0);
        cell.setCellValue(String.valueOf("관리번호"));
        cell.setCellStyle(st);
        
        cell=row.createCell(1);
        cell.setCellValue(String.valueOf("성명"));
        cell.setCellStyle(st);
        
        cell=row.createCell(2);
        cell.setCellValue(String.valueOf("지자체"));
        cell.setCellStyle(st);
        
        cell=row.createCell(3);
        cell.setCellValue(String.valueOf("배치장소"));
        cell.setCellStyle(st);
        
        cell=row.createCell(4);
        cell.setCellValue(String.valueOf("언어"));
        cell.setCellStyle(st);
        
        cell=row.createCell(5);
        cell.setCellValue(String.valueOf("관리구분"));
        cell.setCellStyle(st);

        cell=row.createCell(6);
        cell.setCellValue(String.valueOf("생년월일"));
        cell.setCellStyle(st);
        %>
        <c:set var ="c_list" value="${list}" />
        
        <%
        
        ArrayList<CommentaryVo> c_list = (ArrayList<CommentaryVo>)pageContext.getAttribute("c_list") ;
        
        for(int i=0; i < c_list.size() ; i++ ) {
        	CommentaryVo cvo = c_list.get(i);
	       
        	String actYn = "";
        	actYn = cvo.getAct_yn();
        	String actPrtNm = "";
        	actPrtNm = cvo.getAct_prt_nm();
        	String act = "";
        	
        	if("Y".equals(actYn)) {
        		act = "활동중";
        	} else {
        		if("".equals(actPrtNm) || "null".equals(actPrtNm) || actPrtNm == null) act = "비활동중";
        		else act = "비활동중" + "(" + actPrtNm + ")";
        	}
        	
        	row=sheet.createRow((short) (i+1) );
	        cell=row.createCell(0);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getCmntor_no() ));
	        cell=row.createCell(1);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getName() + "/" + cvo.getEng_name() + cvo.getEng_name2() ));
	        cell=row.createCell(2);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getSido_cd_nm() + cvo.getGugun_cd_nm() ));
	        cell=row.createCell(3);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getArrg_place() ));
	        cell=row.createCell(4);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getLang_nm() ));
	        cell=row.createCell(5);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(act));
	        cell=row.createCell(6);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getBirth_dt()));
        }
        
		fileOut = response.getOutputStream(); 
		workbook.write(fileOut);
		fileOut.close();
		
		%>
