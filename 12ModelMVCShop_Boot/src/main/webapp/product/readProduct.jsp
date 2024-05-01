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
	
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>		

	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<script type="text/javascript">
		
	
		//상품 구매 Event	
		$(function() {
			$("button.btn.btn-primary").on("click" ,function() {
				$("form").attr("method", "POST").attr("action", "/purchase/addPurchaseView").submit();				
			});	
		});
		
		// 상품 정보 수정 후 확인 Event
		$(function() {
			$("#check").on("click" ,function() {
				self.location = "/product/listProduct?menu=manage";
			});	
		});		
		
		// 이전 페이지 Event
		$(function() {
			$("a[href='#']").on("click", function() {
				history.back();	
			});
		});
		
		// 개인정보조회 Event	
		$(function() {
			$("a[href='#']:contains('개인정보조회')").on("click" , function()  {
				self.location = "/user/getUser?userId=${sessionScope.user.userId}"
			});
		});
		
		// 상품검색 Event
		$(function() {
			$("a[href='#' ]:contains('상품검색')").on("click" , function()  {
				self.location = "/product/listProduct?menu=search"
			});
		});	
		
		// 구매이력조회 Event
		$(function() {
			$("a[href='#']:contains('구매이력조회')").on("click" , function() {
				self.location = "/purchase/listPurchase";
			});
		});		

		// 찜목록 Event
		$(function() { 
			$("a:contains('찜목록')" ).on("click" , function() {
				$(self.location).attr("href","/product/dibProductList");
			});
		});		
				
		// 최근본상품 Event
		$(function() { 
		$( "a:contains('최근본상품')" ).on("click" , function() {
				$(self.location).attr("href","../history.jsp");
			});
		});	
		
		
		
	</script>	
	
	<style>
 		body {
            padding-top : 70px;
        }
        img  {
        	width : 200px;
        	height : 200px;
        }
    </style>

</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />
	
	<div class="container">

		<div class= "row">
			
			<div class= "col-md-3">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-user"></i> 회원관리
					</div>

						<ul class="list-group">
							<li class="list-group-item">
								<a href="#">개인정보조회</a>
							</li>
							<c:if test="${sessionScope.user.role == 'admin'}">
							<li class="list-group-item"><a href="#">회원목록조회</a></li>
							</c:if>
						</ul>
				</div>
               
				<c:if test="${sessionScope.user.role == 'admin'}">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-tasks"></i> 상품관리
					</div>
					
						<ul class="list-group">
							<li class="list-group-item">
								<a href="#">판매상품등록</a>
							</li>
							<li class="list-group-item">
								<a href="#">판매상품관리</a>
							</li>
						</ul>
		        </div>
                </c:if>
               
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-shopping-cart"></i> 상품구매
					</div>
						
						<ul class="list-group">
							<li class="list-group-item">
								<a href="#">상품검색</a>
							</li>
							<li class="list-group-item">
								<a href="#">구매이력조회</a>
							</li>
							<li class="list-group-item">
								<a href="#">찜목록</a>
							</li>						
							<li class="list-group-item">
								<a href="#">최근본상품</a>
							</li>
						</ul>
				</div>
			</div>
			
			<div class= "col-md-9">
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
									<button type=button class="btn btn-primary" id="check">확인</button>
								</c:otherwise>
							</c:choose>			    			
						</div>
					</div>
				</form>
			</div>
		</div>		
	</div>

</body>
</html>