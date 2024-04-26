<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html lang="ko">
<title>상품정보조회</title>
<head>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<script type="text/javascript">
	
	
	// 상품 추가 확인 Event(상품리스트로 돌아감)
	$(function() {
		$("button.btn.btn-primary:contains('확인')").on("click", function() {
			self.location = "/product/listProduct?menu=manage";		
		});
	});
	
	// 상품 추가 등록 Event
	$(function() {
		$("button.btn.btn-primary:contains('추가등록')").on("click", function() {
			self.location = "/product/addProductView.jsp";	
		});
	});
	
	</script>
	
	<style>
 		body {
			padding-top : 70px;
		}
		
		h4 {
			color : #FC697D;
			font-weight : bold;
		}
				
		img {
			width : 200px;
			height : 350px;
			display: block;
			margin: 0 auto;
		}
		
		.table-name{
			text-align : center; 
		}			
		
		.table-bordered {
			border: 4px solid black; 
			border-collapse: collapse; 
		}		
		
		.table-bordered thead tr td {
			border: 4px solid black;
			padding: 6px;
		}
		
		.table-bordered tbody tr td {
			border: 1px solid black;
			padding: 6px;
		}			
		
		.table-bordered tbody tr td:first-child {
			background : #F4F0DD;
		}		
		
		.Form-group {
			text-align : right;
		}
		

	</style>
	
</head>

<body>

	<jsp:include page="/layout/toolbar.jsp" />

	<div class= "container">
		
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
								<a href="#">최근본상품</a>
							</li>
						</ul>
				</div>
			</div>
		
			<div class= "col-md-9">
	
				<table class="table table-bordered">
					<thead class = "thead-dark">
						<tr>
							<th colspan="2" class="table-name"><h4>상품등록</h4></th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td>상품명</td>
							<td>${product.prodName}</td>
						</tr>
						<tr>
							<td>상품상세정보</td>
							<td>${product.prodDetail}</td>
						</tr>
						<tr>
							<td>제조일자</td>
							<td>${product.manuDate}</td>
						</tr>
						<tr>
							<td>가격</td>
							<td>${product.price}원</td>
						</tr>
						<tr>
							<td>상품이미지</td>
							<td><img src = "/images/uploadFiles/${product.fileName}" alt="상품이미지"></td>
						</tr>		
					</tbody>
				
				</table>
				<div class = "Form-group">
					<button type=button class="btn btn-primary">확인</button>
					<button type=button class="btn btn-primary">추가등록</button>
				</div>
			
			</div>		
		</div>
	</div>

</body>
</html>