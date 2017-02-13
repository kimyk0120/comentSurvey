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
<%@ page import="com.sweetk.kcti.excel.vo.ExcelVo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.OutputStream" %>


<%
 		String name = "�ؼ���" + ".xlsx";
		name = new String(name.getBytes("KSC5601"), "8859_1");
 
	    out.clear();
	    out = pageContext.pushBody();
	    response.reset(); // �� ������ ������ excel ���� ���Ͽ��� �ѱ��� ������ ���� �߻�.

	    String strClient = request.getHeader("User-Agent");

	    String fileName = name;

	    if (strClient.indexOf("MSIE 5.5") > -1) {
	    response.setHeader("Content-Disposition", "filename=" + fileName + ";");
	    } else {
	    response.setContentType("application/vnd.ms-excel");
	    response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ";");
	    }

	    OutputStream fileOut = null;
	    
		//1���� workbook�� ���� 
		XSSFWorkbook workbook=new XSSFWorkbook();
		//2���� sheet���� 
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
        //������ row�� �÷��� �����Ѵ� 
        cell=row.createCell(0);
        cell.setCellValue(String.valueOf("����"));
        cell.setCellStyle(st);
        
        cell=row.createCell(1);
        cell.setCellValue(String.valueOf("�����Ҽ�"));
        cell.setCellStyle(st);
        
        cell=row.createCell(2);
        cell.setCellValue(String.valueOf("���ʼҼ�"));
        cell.setCellStyle(st);
        
        cell=row.createCell(3);
        cell.setCellValue(String.valueOf("����"));
        cell.setCellStyle(st);
        
        cell=row.createCell(4);
        cell.setCellValue(String.valueOf("�������"));
        cell.setCellStyle(st);
        
        cell=row.createCell(5);
        cell.setCellValue(String.valueOf("����"));
        cell.setCellStyle(st);
        
        cell=row.createCell(6);
        cell.setCellValue(String.valueOf("�����ּ�"));
        cell.setCellStyle(st);
        
        cell=row.createCell(7);
        cell.setCellValue(String.valueOf("�ڰ������"));
        cell.setCellStyle(st);
        
        cell=row.createCell(8);
        cell.setCellValue(String.valueOf("Ȱ�����"));
        cell.setCellStyle(st);
        
        cell=row.createCell(9);
        cell.setCellValue(String.valueOf("����"));
        cell.setCellStyle(st);
        
        cell=row.createCell(10);
        cell.setCellValue(String.valueOf("�߱���"));
        cell.setCellStyle(st);
        
        cell=row.createCell(11);
        cell.setCellValue(String.valueOf("�Ϻ���"));
        cell.setCellStyle(st);
        
        cell=row.createCell(12);
        cell.setCellValue(String.valueOf("�ֹ�ġ���"));
        cell.setCellStyle(st);
        
        cell=row.createCell(13);
        cell.setCellValue(String.valueOf("���Ȱ�����"));
        cell.setCellStyle(st);
        
        cell=row.createCell(14);
        cell.setCellValue(String.valueOf("�űԱ���(����⵵)"));
        cell.setCellStyle(st);
        
        cell=row.createCell(15);
        cell.setCellValue(String.valueOf("�űԱ���(�������)"));
        cell.setCellStyle(st);
        
        cell=row.createCell(16);
        cell.setCellValue(String.valueOf("�űԱ���(�̼��ð�)"));
        cell.setCellStyle(st);
        
        cell=row.createCell(17);
        cell.setCellValue(String.valueOf("�űԱ���(����)"));
        cell.setCellStyle(st);

        cell=row.createCell(18);
        cell.setCellValue(String.valueOf("�űԱ���(�������)"));
        cell.setCellStyle(st);
        
        cell=row.createCell(19);
        cell.setCellValue(String.valueOf("�űԱ���(���Ῡ��)"));
        cell.setCellStyle(st);
        
        cell=row.createCell(20);
        cell.setCellValue(String.valueOf("��������(����⵵)"));
        cell.setCellStyle(st);
        
        cell=row.createCell(21);
        cell.setCellValue(String.valueOf("��������(�������)"));
        cell.setCellStyle(st);
        
        cell=row.createCell(22);
        cell.setCellValue(String.valueOf("��������(�̼��ð�)"));
        cell.setCellStyle(st);
        
        cell=row.createCell(23);
        cell.setCellValue(String.valueOf("��������(����)"));
        cell.setCellStyle(st);

        cell=row.createCell(24);
        cell.setCellValue(String.valueOf("��������(�������)"));
        cell.setCellStyle(st);
        
        cell=row.createCell(25);
        cell.setCellValue(String.valueOf("��������(���Ῡ��)"));
        cell.setCellStyle(st);
        
        cell=row.createCell(26);
        cell.setCellValue(String.valueOf("Ȱ�����"));
        cell.setCellStyle(st);
        
        cell=row.createCell(27);
        cell.setCellValue(String.valueOf("Ȱ���ϼ�"));
        cell.setCellStyle(st);
        
        cell=row.createCell(28);
        cell.setCellValue(String.valueOf("Ȱ���ð�"));
        cell.setCellStyle(st);
        
        cell=row.createCell(29);
        cell.setCellValue(String.valueOf("Ȱ�����"));
        cell.setCellStyle(st);
        
        cell=row.createCell(30);
        cell.setCellValue(String.valueOf("�ؼ�Ƚ��"));
        cell.setCellStyle(st);
        
        cell=row.createCell(31);
        cell.setCellValue(String.valueOf("Ȱ����"));
        cell.setCellStyle(st);
        
        cell=row.createCell(32);
        cell.setCellValue(String.valueOf("���޿���"));
        cell.setCellStyle(st);
        
        %>
        <c:set var ="c_list" value="${list}" />
        
        <%
        
        ArrayList<ExcelVo> c_list = (ArrayList<ExcelVo>)pageContext.getAttribute("c_list") ;
        
        for(int i=0; i < c_list.size() ; i++ ) {
        	ExcelVo cvo = c_list.get(i);
        	        	
        	row=sheet.createRow((short) (i+1) );
	        cell=row.createCell(0);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getCmntor_no() ));
	        
	        cell=row.createCell(1);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getSido_nm() ));
	        
	        cell=row.createCell(2);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getGugun_nm() ));
	        
	        cell=row.createCell(3);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getName() ));
	        
	        cell=row.createCell(4);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getBirth_dt() ));

	        cell=row.createCell(5);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getGender() ));
	        
	        cell=row.createCell(6);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getAddress()));

	        cell=row.createCell(7);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getRgst_dt()));

	        cell=row.createCell(8);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getAct_lang()));

	        cell=row.createCell(9);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEng_pnt()));

	        cell=row.createCell(10);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getChn_pnt()));

	        cell=row.createCell(11);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getJpn_pnt()));

	        cell=row.createCell(12);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getMain_place()));

	        cell=row.createCell(13);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getHope_place()));

	        cell=row.createCell(14);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEdu_yyyy()));

	        cell=row.createCell(15);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEdu_place()));

	        cell=row.createCell(16);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEdu_tm()));

	        cell=row.createCell(17);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEdu_tot_pnt()));

	        cell=row.createCell(18);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEdu_avg_pnt()));

	        cell=row.createCell(19);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEdu_cmpl_yn()));

	        cell=row.createCell(20);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEdu_yyyy2()));

	        cell=row.createCell(21);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEdu_place2()));

	        cell=row.createCell(22);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEdu_tm2()));

	        cell=row.createCell(23);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEdu_tot_pnt2()));

	        cell=row.createCell(24);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEdu_avg_pnt2()));

	        cell=row.createCell(25);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getEdu_cmpl_yn2()));

	        cell=row.createCell(26);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getAct_ym()));

	        cell=row.createCell(27);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getAct_dt_cnt()));

	        cell=row.createCell(28);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getAct_tm()));

	        cell=row.createCell(29);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getAct_place()));

	        cell=row.createCell(30);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getCmmt_cnt()));

	        cell=row.createCell(31);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getAct_fee()));

	        cell=row.createCell(32);
        	cell.setCellStyle(st2);
	        cell.setCellValue(String.valueOf(cvo.getFee_yn()));

        }
        
		fileOut = response.getOutputStream(); 
		workbook.write(fileOut);
		fileOut.close();
		
		%>
