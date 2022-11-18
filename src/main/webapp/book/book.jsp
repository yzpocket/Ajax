<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
response.setHeader("Pragma","No-cache"); //HTTP 1.0 
response.setDateHeader ("Expires", 0); 
	response.setHeader("Cache-Control","no-cache");
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOK</title>
<!-- CDN 참조-------------------------------------- -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!-- ------------------------------------------------- -->
<style type="text/css">


</style>


<script type="text/javascript">
		//jQuery를 이용해서 해보려 한다.
		//src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"> 를 상단에서 임포트해야 쓸 수 있다.
		//$.ajax() 함수를 이용해서 ajax 요청을 해보자.
		/*	// $.ajax() 함수의 구조 
		
			$.ajax({
				type:'get',				//처럼 요청방식 get/post 기술
				url:'~.jsp', 			//서버 페이지 경로 기술
				cache:false,			//캐시 사용여부 기술
				dataType:'xml',			//응답 유형 기술
				success:function(res){	//성공적으로 수행 될 경우 실행되는 함수
					
				},
				error:function(err){	//에러 발생 시 실행되는 함수
					
				}
			})
		
		*/
		/* 삭제 기
				ajax요청 보내기
				get방식으로
				?isbn=visbn
				bookDelete.jsp로 
				응답유형: xml
				
				bookDelete.jsp에서는 BookDAO생성해서
				메서드 호출
				int deleteBook(isbn)==>delete문을 수행
				
				결과값이 0보다 크면
				getAllBook()호출
		*/
		function goDel(visbn){
			$.ajax({
				type:'get',				//처럼 요청방식 get/post 기술
				url:'bookDelete.jsp?isbn='+visbn, 			//서버 페이지 경로 기술 매개변수를 넣어줘야됨..
				cache:false,			//캐시 사용여부 기술
				dataType:'xml',			//응답 유형 기술
				success:function(res){	//성공적으로 수행 될 경우 실행되는 함수
					//alert(res);
					let n=$(res).find('result').text(); // String
					if(parseInt(n)>0){
						getAllBook();
					}else{
						alert('삭제 실패')
					}
				},
				error:function(err){	//에러 발생 시 실행되는 함수
					alert('error: '+err.status);
				}
			})
		}
		/* 수정 기능
		*POST* 방식으로
		bookinfo.jsp요청 보내기
		?isbn=visbn
		응답유형 :xml
		
		bookInfo.jsp에서 BookDAO생성해서
		getBookInfo(isbn)호출하기.
		
		결과 xml형태로 출력하기.
		==>isbn
		*/
		function goEdit(visbn){
			$.ajax({
				type:'post',				//처럼 요청방식 get/post 기술
				url:'bookInfo.jsp',			//서버 페이지 경로 기술 매개변수를 넣어줘야됨..
				data:"isbn="+visbn, //**post**방식일때 전송할 파라미터 데이터는 data 속성값으로 넣어준다.
				cache:false,			//캐시 사용여부 기술
				dataType:'json',			//응답 유형 기술 **json**으로 해보자.
				success:function(res){	//성공적으로 수행 될 경우 실행되는 함수
					//alert(JSON.stringify(res)); //[object object]이렇게 나타난다 json객체로온다. JSON.stringify로 문자열로 볼 수 있음.
					let vtitle=res.title;
					let vpublish=res.publish;
					let vpubdate=res.published;
					let vprice=res.price;
					let vimage=res.bimage;
					//alert(vtitle);
					$('#isbn').val(visbn);
					$('#title').val(vtitle);
					$('#publish').val(vpublish);
					$('#published').val(vpubdate);
					$('#price').val(vprice);
					let str="<img src='./images/"+vimage+"'>";
					$('#bimage').html(str);
				},
				error:function(err){	//에러 발생 시 실행되는 함수
					alert('error: '+err.status);
				}
			})
		}
		
		function goEditEnd(){
			//post로.
			//bookUpdate.jsp로
			//data 속성값으로 수정할 값을 파라미터 데이터로 만들어 보내야 한다.
			//폼 객체의 serialize()함수 활용
			let paramStr=$('#editF').serialize();
			alert(paramStr);
			
		}
		
		function getAllBook(){
			$.ajax({
				type:'GET',
				url:'bookAll.jsp',
				cache:false,
				dataType:'html',
				success:function(res){
					//alert(res)
					$('#book_data').html(res);
				},
				error:function(err){
					alert('error: '+err.status)
				}
			})
		
	}

</script>
</head>
<!--onload시 출판사 목록 가져오기  -->
<body onload="getPublish()">
   <div class="container">
	<h2 id="msg">서적 정보 페이지</h2>
<form name="findF" id="findF" role="form"
 action="" method="POST">
<div class="form-group">
<label for="sel" class="control-label col-sm-2">출판사</label>
<span id="sel"></span><span id="sel2"></span>
</div>
<p>
<div class='form-group'>
	<label for="books" class="control-label col-sm-2" id="msg1">도서검색</label>
	<div class="col-sm-6">
	<input type="text" name="books" id="books"
	 onkeyup="autoComp(this.value)"
	 class="form-control" >
	 <!-- ---------------------------- -->
	 <div id="lst1" class="listbox"
	  style="display:none">
	 	<div id="lst2" class="blist"
	 	 style="display:none">
	 	</div>
	 </div>
	 <!-- ---------------------------- -->
	</div>
</div>
</form>
<div>
 
 <button type="button"
  onclick="getBook()"
  class="btn btn-primary">검색</button>
 
 <button type="button" onclick="getAllBook()" class="btn btn-success">모두보기</button>
 <button type="button" id="openBtn"
  class="btn btn-info">OPEN API에서 검색</button><br><br>
</div>
<div id="localBook">

<table class="table table-bordered" border="1" style="margin:0;padding:0">
	<tr class="info">
		<td style="width:20%;">서명</td>
		<td style="width:20%;">출판사</td>
		<td style="width:20%;">가격</td>
		<td style="width:20%;">출판일</td>
		<td style="width:20%;">편집</td>
	</tr>
</table>
<!-- ----------------------- -->
<div id="book_data" "></div>
<!-- ----------------------- -->
<form id="editF" name="editF">
<table id="book_info" class="table table-hover" border="2">
	<tr>
		<td width="20%">ISBN코드</td>
		<td>
		<input type="text" name="isbn" id="isbn"
		class="form-control" readonly>
		</td>
		<td rowspan="6" width="30%" id="bimage" class="text-center"></td>
	</tr>
	<tr>
		<td>서명</td>
		<td>
		<input type="text" name="title" id="title"
		class="form-control">
		</td>
		
	</tr>
	<tr>
		
		<td>출판사</td>
		<td>
		<input type="text" name="publish" id="publish"
		class="form-control">
		</td>
		
	
	</tr>
	<tr>
	
		<td>가격</td>
		<td>
		<input type="text" name="price" id="price"
		class="form-control">
		</td>
		
	</tr>
	<tr>
	
		<td>출판일</td>
		<td>
		<input type="text" name="published"
		 id="published"  disabled
		class="form-control">
		</td>
		
	</tr>
	<tr>
		<td colspan="2">
		<button type="button"
		onclick="goEditEnd()" class="btn btn-danger">수정하기</button></td>
	</tr>
</table>
</form>
	</div>
</div><!-- #localBook end -->

<!-- ------------------------------- -->
<div id="openApiBook">

</div>
	
</body>
</html>

<!-- https://apis.daum.net/search/book -->
<!-- 53c73f32f6c4150ca5aa184ba6250d8e -->

<!-- https://apis.daum.net/search/book?apikey=53c73f32f6c4150ca5aa184ba6250d8e&q=다음카카오&output=json -->




