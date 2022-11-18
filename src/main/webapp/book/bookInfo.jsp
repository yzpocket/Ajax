<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ajax.book.*" %>
<%
	BookDAO dao=new BookDAO();
	
	BookDTO book=dao.getBookInfo(request.getParameter("isbn"));
	request.setAttribute("book", book);
	/* 아래 json형태 쓰는법.
	{"속성명":"값"} <--중괄호
		*/
	
%>
{
	"title":"${book.title}",
	"isbn":"${book.isbn}",
	"publish":"${book.publish}",
	"published":"${book.published}",
	"price":"${book.price}",
	"bimage":"${book.bimage}"
}