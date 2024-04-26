<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<title>구매목록조회</title>
<head>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>	

	<script type="text/javascript">
		
		//구매상품 조회 Event
		function fncGetPurchaseList(currentPage) {	
			$("#currentPage").val(currentPage)
			$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
		}

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
	
		// 주문상세보기 Event
		$(function() {
			$("#detail").on("click", function() {
				var tranNo = $(this).data('tranno');
				self.location = "/purchase/getPurchase?tranNo="+tranNo;
			});				
		});
		
		// 배송확인 Event
		$(function() {
			$("#check").on("click", function() {
				var tranNo = $(this).data('tranno');
				var tranCode2 = $(this).data('trancode');
				var tranCode = String(tranCode2);
				console.log(tranNo);
				self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode="+tranCode;
			});				
		});

	</script>

	<style>
 		body {
			padding-top : 70px;
		}

		h4 {
			color : blue;
		}
		
		th {
			text-align : center;
		}
	</style>	
	
</head>

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
							<a href="#">찜한상품</a>
						</li>						
						<li class="list-group-item">
							<a href="#">최근본상품</a>
						</li>
					</ul>
				</div>
			</div>			

			<div class="col-md-9">

				<div class="page-header text-left">
					<h4>구매목록조회</h4>
				</div>
				
				<p class="text-primary">
					전체 ${resultPage.totalCount}건, 현재 ${resultPage.currentPage}페이지
				</p>
			
				<table class="table table-bordered">
					<input type = "hidden" id = "currentPage" name = "currentPage" value=""/>
					<thead>
						<tr>
							<th>No</th>
							<th>주문번호</th>
							<th>상품명</th>
							<th>결제금액</th>
							<th>주문상세보기</th>
							<th>배송현황</th>
							<th>도착확인</th>
						</tr>
					</thead>
					
					<tbody>
						<c:set var="i" value ="0"/>
						<c:forEach var = "purchase" items = "${list}">
							<c:set var ="i" value = "${i+1}"/>
							<tr>
								<td align="center">${i}</td>
								<td align="center">${purchase.tranNo}</td> 
								<td align="center">${purchase.purchaseProd.prodName}</td>
								<td align="right">${purchase.purchaseProd.price}원</td>
								<td align="center" id="detail" data-tranNo = "${purchase.tranNo}">상세보기</td>
								<td align="left">
								<c:if test = "${purchase.tranCode == '2'}">
									구매를 완료했습니다.	
								</c:if>
								<c:if test = "${purchase.tranCode == '3'}">
									현재 상품 배송중입니다.
								</c:if>
								<c:if test = "${purchase.tranCode == '4'}">
									상품이 배송완료 되었습니다.
								</c:if>	
								</td>
								<td align="left" id= "check" data-tranNo = "${purchase.tranNo}" data-tranCode = "${purchase.tranCode}">	
								<c:if test = "${purchase.tranCode == '3'}">
			 						배송확인
								</c:if>	
								</td>
							</tr>			
						</c:forEach>
					</tbody> 
				</table>
			</div>	
	
			<jsp:include page="../common/pageNavigator_new.jsp">	
				<jsp:param name = "listType" value = "purchase"/>
			</jsp:include>
		</div>				
	</div>

</body>
</html>