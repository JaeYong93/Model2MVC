<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">
<title>상품상세정보</title>
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
		
		$(function() {
			$("button.btn.btn-primary").on("click" ,function() {
			    $("form").attr("method", "POST").attr("action", "/purchase/addPurchaseView").submit();				
			})	
		})
	</script>	
	
	<style>
 		body {
            padding-top : 50px;
        }
    </style>

</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">
	
		<div class ="page-header text-info">
			<h4>상품상세정보</h4>
		</div>

		<form class= "form-horizontal">
			<input type ="hidden" name="prodNo" id="prodNo" value="${product.prodNo}">
			<div class="form-group">
				<label for="prodNo" class="col-sm-2 control-label" >상품번호</label>
		    	<div class="col-md-4">
		    		${product.prodNo}		
				</div>
			</div>
			
			<div class="form-group">
				<label for="prodName" class="col-sm-2 control-label" >상품명</label>
		    	<div class="col-md-4">
		    		${product.prodName}		
				</div>
			</div>
									
			<div class="form-group">
				<label for="fileName" class="col-sm-2 control-label" >상품이미지</label>
		    	<div class="col-md-4">
		    		<img src = "/images/uploadFiles/${product.fileName}" alt="상품이미지">		
				</div>
			</div>			

			<div class="form-group">
				<label for="prodDetail" class="col-sm-2 control-label" >상품상세정보</label>
		    	<div class="col-md-4">
		    		${product.prodDetail}		
				</div>
			</div>
			
			<div class="form-group">
				<label for="manuDate" class="col-sm-2 control-label" >제조일자</label>
		    	<div class="col-md-4">
		    		${product.manuDate}		
				</div>
			</div>

			<div class="form-group">
				<label for="prodDetail" class="col-sm-2 control-label" >가격</label>
		    	<div class="col-md-4">
		    		${product.price}원		
				</div>
			</div>
			
			<div class="form-group">
				<label for="regDate" class="col-sm-2 control-label" >상품등록일</label>
		    	<div class="col-md-4">
		    		${product.regDate}		
				</div>
			</div>

			<br/><br/><br/>
			
			<div class="form-group">
		    	<div class="col-sm-4 text-center">
					<c:choose>
						<c:when test="${param.menu != null && param.menu eq 'search'}">
		    				<button type=button class="btn btn-primary">구매</button>
							<a class="btn btn-primary btn" href="#" role="button">이전</a>
						</c:when>
						
						<c:otherwise>
							<button type=button class="btn btn-primary">확인</button>
						</c:otherwise>
					</c:choose>			    			
				</div>
			</div>
		</form>				
	</div>

</body>
</html>