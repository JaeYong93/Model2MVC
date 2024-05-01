<%@ page contentType="text/html; charset=EUC-KR" %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<title>열어본 상품 보기</title>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
		
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">


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
	
		// 회원목록조회 Event
		$(function() {
			$("a:contains('회원목록조회')").on("click" , function() {
				self.location = "/user/listUser"
			});
		});
		
		// 개인정보조회 Event	
		$(function() {
			$("a[href='#']:contains('개인정보조회')").on("click" , function()  {
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
			$("a[href='#' ]:contains('상품검색')").on("click" , function()  {
				self.location = "/product/listProduct?menu=search"
			});
		});	
		
		// 찜목록 Event
		$(function() { 
			$("a:contains('찜목록')" ).on("click" , function() {
				$(self.location).attr("href","/product/dibProductList");
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

	</script>
	
	<style>
		body {
			padding-top : 70px;
		}
	</style>	
	  
</head>
<body>
	<jsp:include page="/layout/toolbar.jsp"/>

	<br/><br/>
	

	
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

	<%
	    request.setCharacterEncoding("euc-kr");
	    response.setCharacterEncoding("euc-kr");
	
	    Cookie[] cookies = request.getCookies();
	    String history = null;
	
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("history")) {
	                history = cookie.getValue();
	                break;
	            }
	        }
	    }
	
	    String currentProduct = request.getParameter("prodNo");
	
	    if (currentProduct != null && !currentProduct.isEmpty()) {
	        int prodNo = Integer.parseInt(currentProduct);
	        
	        if (history == null) {
	            history = String.valueOf(prodNo);
	        } else {
	            history += "|" + prodNo;
	        }
	
	        Cookie historyCookie = new Cookie("history", history);
	        historyCookie.setMaxAge(24 * 60 * 60); 
	        response.addCookie(historyCookie);
	    }
	
	    if (history != null) {
	        String[] h = history.split("\\|");
	%>	
			<div class="col-md-9">
				<h4>최근열어본상품</h4>
				<div>
	<%
			for (int i = 0; i < h.length; i++) {
	%>			
				<a href="/product/getProduct?prodNo=<%=h[i]%>&menu=search" target="rightFrame"><%=h[i]%></a> <br/>
	<%
			}
	%>			
				</div>
			</div>	
	<%
	    } else {
	%>  
	    	
	    	<div class="col-md-9">
			<h4>최근열어본상품</h4>
			<div>
		</div>
	</div>
			
	<% 		
	    }
	%>				


	</div>			

</body>
</html>