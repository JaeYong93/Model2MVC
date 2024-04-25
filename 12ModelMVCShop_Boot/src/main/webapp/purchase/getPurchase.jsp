<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang ="ko">
<title>구매상세조회</title>
<head>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>	

</head>

	<script type="text/javascript">
	
		// 회원목록조회 Event
		$(function() {
			$("a:contains('회원목록조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		});
			
		// 개인정보조회회 Event	
		$(function() {
			$("a[href='#']:contains('개인정보조회')").on("click" , function() {
				self.location = "/user/getUser?userId=${sessionScope.user.userId}"
			});
		});

		// 판매상품등록 Event
		$(function() {
			$( "a:contains('판매상품등록')" ).on("click" , function() {
				self.location = "../product/addProductView.jsp"
	 		});
		});		
	
		// 판매상품관리 Event
		$(function() {
			$( "a:contains('판매상품관리')" ).on("click" , function() {
				self.location = "/product/listProduct?menu=manage"
			});
		});		
		
		// 상품검색 Event
		$(function() {
			$("a[href='#' ]:contains('상품검색')").on("click" , function() {
				self.location = "/product/listProduct?menu=search"
			});
		});	
		
		// 구매이력조회 Event
		$(function() {
			$("a[href='#']:contains('구매이력조회')").on("click" , function() {
				self.location = "/purchase/listPurchase";
			});	
		});		
		
		// 최근본상품 Event
		$(function() { 
			$( "a:contains('최근본상품')" ).on("click" , function() {
				$(self.location).attr("href","../history.jsp");
			});
		});	
		
		// 구매정보 수정 Event
		$(function() {
			var tranNo = ${purchase.tranNo};
			$( "button.btn.btn-primary").on("click" , function() {
				self.location = "updatePurchaseView?tranNo="+tranNo;
			});
		});	
	
		// 확인 Evnet
		$(function() {
			$("#check").on("click" , function() {
				history.back();
			});
		});			

// 		<a href="/updatePurchaseView?tranNo=${purchase.tranNo}">수정</a>
// 		<a href="javascript:history.go(-1);">확인</a>		
		
	</script>	

	<style>
 		body {
			padding-top : 70px;
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

		.Form-group {
			text-align : right;
		}
		
	</style>

<body>
	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">

		<div class="row">
	
			<div class="col-md-3">
		
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

			<div class="col-md-9">
				<table class="table table-bordered">
					<thead class = "thead-dark">
						<tr>
							<th colspan="2" class="table-name"><h4>구매내역 상세조회</h4></th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td class="success">물품번호</td>
							<td class="active">${purchase.purchaseProd.prodNo}</td>
						</tr>
						<tr>
							<td class="success">상품명</td>
							<td class="active">${purchase.purchaseProd.prodName}</td>
						</tr>						
						<tr>
							<td class="success">구매자아이디</td>
							<td class="active">${purchase.buyer.userId}</td>
						</tr>
						<tr>
							<td class="success">구매자이름</td>
							<td class="active">${purchase.receiverName}</td>
						</tr>
						<tr>
							<td class="success">결제금액</td>
							<td class="active">${purchase.purchaseProd.price}원</td>
						</tr>						
						<tr>
							<td class="success">구매방법</td>
							<td class="active">${purchase.paymentOption == '1' ? '현금구매' : '신용구매'}</td>
						</tr>
						<tr>
							<td class="success">구매자연락처</td>
							<td class="active">${purchase.receiverPhone}</td>
						</tr>
						<tr>
							<td class="success">구매자주소</td>
							<td class="active">${purchase.dlvyAddr}</td>
						</tr>
						<tr>
							<td class="success">구매요청사항</td>
							<td class="active">${purchase.dlvyRequest}</td>
						</tr>
						<tr>
							<td class="success">배송희망일</td>
							<td class="active">${purchase.dlvyDate}</td>
						</tr>
						<tr>
							<td class="success">주문일</td>
							<td class="active">${purchase.orderDate}</td>
						</tr>						
						
					</tbody>
				
				</table>
				<div class = "Form-group">
					<input type ="hidden" name="tranNo" value="${purchase.tranNo}" id="tranNo">
					<button type=button class="btn btn-primary">수정</button>
					<button type=button class="btn btn-primary" id="check">확인</button>
				</div>					
			
			</div>
		</div>
	</div>						

</body>
</html>