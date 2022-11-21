<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" import="ajax.book.*"%>
<jsp:useBean id="bookDto" class="ajax.book.BookDTO" scope="page"/>
<jsp:setProperty property="*" name="bookDto"/>


<%
/*  파라미터로 넘어온 데이터를 bookDto객체에 모두 셋팅 */
	BookDAO dao=new BookDAO();
	int n=dao.updateBook(bookDto);
	request.setAttribute("n", n); //이렇게 키밸류저장해주면 <%=n %.> 이거대신 ${n} 이거 쓸수 있다.
%>
{
	"result":${n}
} 