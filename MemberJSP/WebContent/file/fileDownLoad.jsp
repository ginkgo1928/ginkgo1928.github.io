<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String fileName=request.getParameter("fileName");
String realFolder=request.getServletContext().getRealPath("/storage");
System.out.println(realFolder+"\\"+fileName);

//다운로드 파일 생성,한글은 지원안한다.
File file=new File(realFolder,fileName);
fileName = URLEncoder.encode(fileName,"UTF-8").replace("+"," ");

response.setHeader("Content-Disposition", "+attachment;fileName="+fileName);
response.setHeader("Content-Length", file.length()+"");

//에러 안뜨기 위해 사용

/*
getOutputStream() has already been called for this response
JSP에서는 SERVLET으로 변환될 때 내부적으로 out객체가 자동으로 생성하기 때문에 따라 
out객체를 만들면 충돌이 일어나서 저런 메시지가 뜨는 것이다.
그래서 먼저 out를 초기화하고 생성하면 된다
*/
out.clear();
out=pageContext.pushBody();

BufferedInputStream bis=new BufferedInputStream(new FileInputStream(file));
BufferedOutputStream bos=new BufferedOutputStream(response.getOutputStream());

//내가 long 타입으로 해서 int로 형변환
// a b c d 결과는 잘 나오는데 에러가 나온다.
//java.lang.IllegalStateException-->에러 :내부적으로 부르는데 바꿧다.
//내장객체가 외부로 갈 수 있도록 길을 터놨는데 강제로 내가 바꿔서 에러가 났다. 
//원인 response.getOutputStream 
int size=(int)file.length();
byte [] b=new byte[size]; 
bis.read(b,0,size);//읽고
bos.write(b);//보낸다

bis.close();
bos.close();

%>


