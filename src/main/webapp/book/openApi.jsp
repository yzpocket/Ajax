<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- CDN 참조-------------------------------------- -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!-- ------------------------------------------------- -->
<script>
$(function(){
	$('#btnSearch').click(function(evt){
		evt.preventDefault(); //기본동작 막는다. submit하려는 기본동작.
		//검색어 입력값 받기
		let keyword=$('#title').val();
		if(!keyword){
			alert('검색어 입력')
			return;
		}
		let url="openApiResult.jsp?query="+encodeURIComponent(keyword)+"&display=20&start=1";
		send(url, keyword, 1);
	})
})

function send(url, keyword, cpage){ //ajax요청 보내는 함수
	$.ajax({
		type:'get',
		url:url,
		dataType:'json',
		cache:false
		
	})
	.done(function(res){
		//alert(res);
		console.log(res);
		let total=res.total;
		let obj={
				total:total,
				keyword:keyword,
				cpage:cpage,
				display:20
		}
		showList(res.items, obj);
		showPage(obj);
	})
	.fail(function(err){
		alert('err: '+err.status);
		console.log(err.reponseText);
	})
}//send--------

function showList(items, obj){
	let str='<h2>'+obj.keyword+'검색 결과 '+obj.total+'개</h2>';
	
	str+='<table class="table">';
	str+='<tr>'
	$.each(items, function(i, book){
		str+='<td width="20%" style="text-align: center">';
		str+='<a href="'+book.link+'" target="_blank">';
		str+='<img src="'+book.image+'" class="img img-thumbnail" style="width:70%">';
		str+='<h5>'+book.title+'</h5>';
		str+='</a>';
		//저자 author, 정가 price, 판매가 discount, 출판사 publish, 출판일 pubdate ...등 추가하면 된다.
		str+='</td>';
		if(i%5==4){ //한 행에 5개 단위로 보여 주기 위해서
			str+="</tr><tr>";
		}
	});
	str+='</tr>'
	str+='</table>';
	
	$('#openApiBook').html(str);
}

/* 총 게시글 수 : total
 * 한 페이지당 보여줄 개수 : display
 * 페이지수 :
	 
	 Java에서는 
	 if(total%display==0){
		 pageCount=total/display;
	 }else{
		 pageCount=total/display+1;
	 }
	 ==> PageCount=(total-1)/display+1; //<<<<========== 외우기 java용 페이지 구하기
	 JavaScript에서는 int/int => 실수가 나온다. 소수점..
	let pageCount=Math.ceil((total-1)/display); //<<<<==== 외우기 javascript용 페이지 구하기
			Math.ceill()로 +1을하지 않고 그냥 올린다.

 */
function showPage(obj){
	let total=obj.total; //총 검색한 도서개수
	let display=obj.display; //한 페이지당 보여줄 목록 개수
	if(total>200){ // 최대200개로 제한
		total=200;
	}
	//let pageCount=Math.floor((total-1)/display+1);  //Math.floor()로 실수의 소수점을 버린다.
	let pageCount=Math.ceil((total-1)/display); //<<<<==== Math.ceill()로 +1을하지 않고 그냥 올린다.
	//alert('pageCount: '+pageCount);
	/*
	#start값 구하기
	cpage(i)	display		start		
		1			20			1
		2						21
		3						41
		4						61
		
		===> (c-1)*d+1
	*/
	let query=obj.keyword; //검색어
	
	
	let str='<ul class="pagination">';
		for(let i=1;i<=pageCount;i++){
			let start=(i-1)*display+1; //시작값 네이버에 넘길 파라미터 값
			console.log('start : '+start); 
			if(i==obj.cpage){
			str+='<li class="active">';
			}else{
			str+='<li>';
			}
			str+='<a href="#" onclick="fetch(\''+query+'\', '+start+', '+i+')">';
			str+=i
			str+='</a>';
			str+='</li>';
		}
		str+='</ul>';
		$('#pageNavi').html(str);
}
	
function fetch(query, start, cpage){
	//alert(query+"/"+start+"/"+cpage);
	let url="openApiResult.jsp?query="+encodeURIComponent(query)+"&display=20&start="+start;
	send(url, query, cpage);

}

</script>
<div class="container">
   <div class="row">
      <div class="col-md-12">
         <form action="test.jsp">
            <h1 class="text-center">Naver 도서 검색</h1>
            <input type="text" name="title" id="title" placeholder="도서명을 입력하세요" class="form-control">
            <button class="btn btn-info" id="btnSearch">검    색</button>
         </form>
      </div>      
   </div>
   <hr>
   <div id="pageNavi" class="text-center">
   </div>
   <hr>
   <div id="openApiBook">
   
   </div>
</div>