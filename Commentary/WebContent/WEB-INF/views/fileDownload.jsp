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
  // 다운받을 파일의 이름을 가져옴
  String fileName = request.getParameter("fileName");
  String orgFileName = request.getParameter("orgFileName");
  
  /* System.out.println("fileName : " + fileName);
  System.out.println("orgFileName : " + orgFileName); */
 
  // 다운받을 파일이 저장되어 있는 폴더 이름
  String saveFolder = request.getParameter("filePath");
  
  // Context에 대한 정보를 알아옴
  ServletContext context = getServletContext(); // 서블릿에 대한 환경정보를 가져옴
  
  // 실제 파일이 저장되어 있는 폴더의 경로
  String realFolder = context.getRealPath(saveFolder);
  // 다운받을 파일의 전체 경로를 filePath에 저장
  String filePath = realFolder + "\\" + fileName;
  
  System.out.println("filePath" + filePath);
  
  try{
	  out.clear();
	  out = pageContext.pushBody();
   // 다운받을 파일을 불러옴
   File file = new File(filePath);
   byte b[] = new byte[4096];
   
   // page의 ContentType등을 동적으로 바꾸기 위해 초기화시킴
   response.reset();
   response.setContentType("application/octet-stream");
   
   // 한글 인코딩
   String Encoding = null; 
   
   if(request.getHeader("User-Agent").indexOf("MSIE") == -1) {
	   Encoding = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
  } else {
   		Encoding = new String(fileName.getBytes("UTF-8"), "8859_1");
  }
	response.setHeader("Content-Disposition", "attachment; filename = " + Encoding);
	
	// 파일의 세부 정보를 읽어오기 위해서 선언
	FileInputStream is = new FileInputStream(filePath);
	// 파일에서 읽어온 세부 정보를 저장하는 파일에 써주기 위해서 선언
	ServletOutputStream sos = response.getOutputStream();
	
	int numRead;
	// 바이트 배열 b의 0번 부터 numRead번 까지 파일에 써줌 (출력)
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