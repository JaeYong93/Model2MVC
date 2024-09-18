<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet">	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->

   
    <!-- Bootstrap Dropdown Hover JS -->
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }

		.carousel-inner .item img {
			display: block;
			margin: 0 auto; 
			max-width: 1000px;
			height: 450px;
		}
		
		.left carousel-control {
		
			width: 50px;
		}

		.right carousel-control {
		
			width: 50px;
		}
     </style>
   	
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
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
	 
	 	// 회원정보조회 Event	
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a:contains('회원목록조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  개인정보조회회 Event  처리 =============	
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
	
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  아래의 내용은 http://getbootstrap.com/getting-started/  참조 -->	
   	<div class="container ">
   	
   		<div class="row">
   			
   			<div class="col-md-3">
   				
   				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-user"></i> 회원관리
         			</div>
         			
         			<!--  회원관리 아이템 -->
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
						<li class="list-group-item"><a href="#">상품검색 <span class="badge" id="productCountBadge"></span></a>
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

				<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
						<li data-target="#carousel-example-generic" data-slide-to="1"></li>
						<li data-target="#carousel-example-generic" data-slide-to="2"></li>
					</ol>
	
				<div class="carousel-inner" role="listbox">
					<div class="item active">
						<img src="/images/uploadFiles/backpack2.png" id="first slide" alt="First slide">
					</div>
					<div class="item">
						<img src="/images/uploadFiles/choko.jpg" id="second slide" alt="Second slide">
					</div>
					
					<div class="item">
						<img src="/images/uploadFiles/wirelessmouse.jpg" id="third slide" alt="Third slide">
					</div>
				</div>
				
				<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a>
				
				<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
					<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
				</div>				
	
   			</div>
   		</div>

    </div>

</body>

</html>