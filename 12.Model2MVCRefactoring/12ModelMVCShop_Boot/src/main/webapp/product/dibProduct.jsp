<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<html lang="ko">
<title>찜목록</title>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
   	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	
	<script type="text/javascript">
	
	var search = {
			"searchCondition" : $("select[name='searchCondition']").val(),
			"searchKeyword" : $("#searchKeyword").val(),
				"searchOrderByPrice" : $("input[name='searchOrderByPrice']").val()
			}	 
	 
	 $.ajax({
		    url: "/product/json/listProduct",
		    method: "POST",
		    contentType: 'application/json; charset=euc-kr',
		    data: JSON.stringify(search),
		    dataType: "json",
		    success: function(responseData) {
		        var totalCount = responseData.totalCount;
		        console.log("Total Count:", totalCount);

		        $("#productCountBadge").text(totalCount);

		        var productList = responseData.list;

		    },
		    error: function() {
		        console.log("Error 발생");
		    }
		});		
	
		//찜하기 취소
		$(function() {
			$("td:nth-child(5n)").on("click", function() {
				var prodNo = $(this).data('prodno');
				alert("찜하기가 취소되었습니다.");
				self.location = "dibCancleProduct?prodNo="+prodNo+"&menu=search";	
			});
		});

		//찜한 상품조회
		$(function() {
			$("td:nth-child(2n)").on("click", function() {
				var prodNo = $(this).data('prodno');
				self.location = "getProduct?prodNo="+prodNo+"&menu=search";	
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
		
		h4 {
			color : red;
			font-weight : bold;
		}
		
		th {
			text-align : center;
		}
		
        img  {
        	width : 50px;
        	height : 50px;
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
							<a href="#">상품검색 <span class="badge" id="productCountBadge"></span></a>
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
			
			<div class="col-md-9">
				<div class ="page-header text-info">
					<h4>찜한상품</h4>
				</div>
				
					<table class="table table-hover">
						<thead>
							<tr>
								<th>No</th>
								<th>상품명</th>
								<th>상품이미지</th>
								<th>가격</th>
								<th>정보</th>
							</tr>	
						</thead>
						
						<tbody>
						<c:set var="i" value ="0"/>
						<c:forEach var = "product" items = "${list}">
							<c:set var ="i" value = "${i+1}"/>
							<tr>
								<td align="center">${i}</td>
								<td align="center" data-prodNo = "${product.prodNo}">${product.prodName}</td>
								<td align="center"><img src="/images/uploadFiles/${product.fileName}"></td>								 
								<td align="center"><fmt:formatNumber value="${product.price}" pattern = "#,###"/>원</td>
								<td align="center" data-prodNo = "${product.prodNo}">
								찜한상태 찜하기 취소
								</td>
							</tr>			
						</c:forEach>						
						
						</tbody>
					</table>
			</div>
			<jsp:include page="../common/pageNavigator_new.jsp">	
				<jsp:param name = "listType" value = "dibProduct"/>
			</jsp:include>	
			
		</div>			
	</div>	
					

</body>