<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<title>상품목록</title>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
   	<link href="/css/animate.min.css" rel="stylesheet">
   	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
   	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui=css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">
	
	$(function() {
		$("a[href='#']:contains('배송관리(리팩토링중)')").on("click" , function() {
			self.location = "/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=${product.proTranCode}&currentPage=${param.currentPage}";
		});	
	});		
	
	
	function fncGetProductList(currentPage) {
	    var menu = "${param.menu}";
	    $("#currentPage").val(currentPage)
	    $("#menu").val(menu)
	    $("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
	}
	
	$(function() {
		 $( "button.btn.btn-default" ).on("click" , function() {
			fncGetProductList(1);
		});
	 });	
		

	
</script>

	<style>
 		body {
            padding-top : 50px;
        }
        
        .thumbnail {
        	width: 275px;
        	height: 400px;
        }
        
         .thumbnail img{
        	width: 200px;
        	height: 200px;
        }       
     </style>

</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class ="page-header text-info">
			<c:if test="${param.menu != null && param.menu eq 'manage'}">
			<h4>상품관리</h4>
			</c:if>
			<c:if test="${param.menu != null && param.menu eq 'search'}">
			<h4>상품목록조회</h4>
			</c:if>

		</div>
	
		<div class="row">
			<div class="col-md-3 text-left">
				<p class="text-primary">
		    		전체 ${resultPage.totalCount}건, 현재 ${resultPage.currentPage}페이지
		    	</p>
		    </div>	

			<div class="col-md-9 text-right">
			    <form class="form-inline" name="detailForm">
			    	<input type = "hidden" id = "menu" name = "menu" value = "">
			    	<div class="form-group">
			    		<select class="form-control" name="searchCondition">
							<option value="0" ${! empty search.searchCondition && search.searchCondition==1 ? "selected" : ""}>상품명</option>
							<option value="1" ${! empty search.searchCondition && search.searchCondition==2 ? "selected" : ""}>가격</option>									    		
			    		</select>
			    	</div>
			    	
			    	<div class="form-group">
			    		<label class="sr-only" for ="searchKeyword">검색 키워드를 입력하세요.</label> 
			    		<input type = "text" class="form-control" id="searchKeyword" name = "searchKeyword" placeholder ="검색 키워드"
			    			value = "${! empty search.searchKeyword ? search.searchKeyword : '' }" autocomplete="on">
			    	</div>
			    	
			    	<button type="button" class="btn btn-default">검색</button>
					<input type = "hidden" id = "currentPage" name = "currentPage" value=""/> 
				</form>
			</div>
		</div>
		    
		<br/><br/>


		<tbody>
			<c:set var="i" value="0"/>
			<c:forEach var = "product" items = "${list}" varStatus="looop">
				<c:set var = "i" value = "${i+1}"/>
				<c:if test="${loop.index % 4==0}">
					<div class="row">
				</c:if>			

				<div class="col-sm-4 col-md-3">	
					<div class="thumbnail">					
						<img src="/images/uploadFiles/${product.fileName}" alt="상품이미지">
						<div class="caption">
							<h3>No: ${i}</h3>
							<p>${product.prodDetail}</p>
				 			<c:if test = "${param.menu != null && param.menu eq 'manage'}">
				 				<p><a href = "/product/getProduct?prodNo=${product.prodNo}&menu=manage" 
				 					class="btn btn-default" role="button" >상품정보수정</a>
									<a href="#" class="btn btn-default" role="button">배송관리(리팩토링중)</a></p>
					 		</c:if>
					 		<c:if test = "${param.menu != null && param.menu eq 'search'}">
					 			<p><a href = "/product/getProduct?prodNo=${product.prodNo}&menu=search" 
					 				class="btn btn-default" role="button">상세정보보기</a>
					 				<a href="#" class="btn btn-default" role="button">찜하기(구현중...)</a></p>
				 			</c:if>								

						</div>
					</div>
				</div>
	    	</c:forEach>
    	</tbody> 			
	</div>
			<jsp:include page="../common/pageNavigator_new.jsp">	
				<jsp:param name = "listType" value = "product"/>
			</jsp:include>	
</body>
</html>