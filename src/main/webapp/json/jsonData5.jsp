<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" import="net.sf.json.*"%>
<%--
[1] JSON라이브러리 다운로드
   https://sourceforge.net/projects/json-lib/files/json-lib/json-lib-2.4/
   https://sheplim.tistory.com/entry/JSON-lib
   [2] 프로젝트/WEB-INF/lib 아래 6개의 jar파일을 붙여넣는다.
   [3] import="net.sf.json.*"
   
   Java Bean객체를 JSON형태로 변환해주는 라이브러리
--%>

<%
	//JSONObject obj=JSONObject.fromObject(bookDto);  fromObject로 DTO를 받아오면
	//아래처럼 마찬가지로 db것들을 키 밸류로 추출 할 수 있다.
	JSONObject obj=new JSONObject();
	obj.put("isbn", "7777");
	obj.put("title", "JSON라이브러리 활용");
	obj.put("price", "22550");
	obj.put("publish", "정보문화사");
	obj.put("published", "2021-05-03");
	obj.put("bimage", "g.jpg");
%>

<%=obj.toString()%>