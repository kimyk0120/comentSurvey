<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
 <%@page import="java.io.*"%>
 <%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
 
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <html>
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Insert title here</title>
 </head>
 <body>

 <% 
  // �ٿ���� ������ �̸��� ������
  String fileName = request.getParameter("fileName");
  String orgFileName = request.getParameter("orgFileName");
  
  /* System.out.println("fileName : " + fileName);
  System.out.println("orgFileName : " + orgFileName); */
 
  // �ٿ���� ������ ����Ǿ� �ִ� ���� �̸�
  String saveFolder = request.getParameter("filePath");
  
  // Context�� ���� ������ �˾ƿ�
  ServletContext context = getServletContext(); // ������ ���� ȯ�������� ������
  
  // ���� ������ ����Ǿ� �ִ� ������ ���
  String realFolder = context.getRealPath(saveFolder);
  // �ٿ���� ������ ��ü ��θ� filePath�� ����
  String filePath = realFolder + "\\" + fileName;
  
  System.out.println("filePath" + filePath);
  
  try{
	  out.clear();
	  out = pageContext.pushBody();
   // �ٿ���� ������ �ҷ���
   File file = new File(filePath);
   byte b[] = new byte[4096];
   
   // page�� ContentType���� �������� �ٲٱ� ���� �ʱ�ȭ��Ŵ
   response.reset();
   response.setContentType("application/octet-stream");
   
   // �ѱ� ���ڵ�
   String Encoding = null; 
   
   if(request.getHeader("User-Agent").indexOf("MSIE") == -1) {
	   Encoding = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
  } else {
   		Encoding = new String(fileName.getBytes("UTF-8"), "8859_1");
  }
	response.setHeader("Content-Disposition", "attachment; filename = " + Encoding);
	
	// ������ ���� ������ �о���� ���ؼ� ����
	FileInputStream is = new FileInputStream(filePath);
	// ���Ͽ��� �о�� ���� ������ �����ϴ� ���Ͽ� ���ֱ� ���ؼ� ����
	ServletOutputStream sos = response.getOutputStream();
	
	int numRead;
	// ����Ʈ �迭 b�� 0�� ���� numRead�� ���� ���Ͽ� ���� (���)
	while((numRead = is.read(b,0,b.length)) != -1){
		sos.write(b,0,numRead);
	}
	
	sos.flush();
	sos.close();
	is.close();
	} catch(Exception e){
		e.printStackTrace();
	}
 %>
 </body>
 </html>