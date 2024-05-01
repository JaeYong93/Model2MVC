<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>

<html lang="ko">
<title>상품정보수정</title>
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

		// 싱픔 정보 수정 Event
		$(function() {
			$("button.btn.btn-primary:contains('수정')").on("click", function() {
				fncUpdateProduct();	
			});
		});
		
		// 이전 페이지 Event
		$(function() {
			$("button.btn.btn-primary:contains('취소')").on("click", function() {
				history.back();	
			});
		});	

		// 회원정보조회 Event
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('회원목록조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		// 개인정보조회회 Event
	 	$( "a:contains('개인정보조회')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});

		// 판매상품등록 Event
	 	$( "a:contains('판매상품등록')" ).on("click" , function() {
			$(self.location).attr("href","../product/addProductView.jsp");
		});		

		// 판매상품관리 Event
	 	$( "a:contains('판매상품관리')" ).on("click" , function() {
			$(self.location).attr("href","/product/listProduct?menu=manage");
		});		
		
		// 상품검색 Event
	 	$( "a:contains('상품검색')" ).on("click" , function() {
			$(self.location).attr("href","/product/listProduct?menu=search");
		});		
		
		// 구매이력조회 Event
	 	$( "a:contains('구매이력조회')" ).on("click" , function() {
			$(self.location).attr("href","/purchase/listPurchase");
		});

		// 찜목록 Event
	 	$( "a:contains('찜목록')" ).on("click" , function() {
			$(self.location).attr("href","/product/dibProductList");
		});			
		
		// 최근본상품 Event
	 	$( "a:contains('최근본상품')" ).on("click" , function() {
			$(self.location).attr("href","../history.jsp");
		});		
		
	
		// jQuery 달력 Event
		$(function(){
			$('#manuDate').datepicker({
				dateFormat: 'yy/mm/dd',
				showMonthAfterYear : true,
				showOn : "both",
				buttonImage: "../images/calander.png",
				changeYear : true,
				changeMonth : true,
				monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				dayNamesMin: ['일','월','화','수','목','금','토'],
				dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
				position: {
					my: 'right top',
					at: 'right bottom'
		        },
				onSelect: function(dateText, inst) {
					var selectedDate = $(this).datepicker('getDate');
					var today = new Date();
					today.setHours(0,0,0,0);
					
					if (selectedDate > today) {
						alert("오늘 이전의 날짜만 선택할 수 있습니다.");
						$(this).val(''); 
					}
				} 
			});
		});	
	
		function fncUpdateProduct() {
			// Form 유효성 검증
			var name=$("input[name='prodName']").val();
			var detail=$("input[name='prodDetail']").val();
			var date=$("input[name='manuDate']").val();
			var price=$("input[name='price']").val();
			
			if(name == null || name.length <1){
				alert("이름은 반드시 입력하셔야 합니다.");
				return;
			}
			if(detail == null || detail.length <1){
				alert("상세정보는 반드시 입력하셔야 합니다.");
				return;
			}
			if(date == null || date.length <8){
				alert("제조일자는 반드시 입력하셔야 합니다.");
				return;
			}
			if(price == null || price.length <1){
				alert("가격은 반드시 입력하셔야 합니다.");
				return;
			}
			$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").submit();
		}

	</script>

	<style>
 		body {
            padding-top : 70px;
        }
        
        h4 {
        	color : green;
        }
        
        .Form-group-defalut {
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
								<a href="#">찜목록</a>
							</li>						
							<li class="list-group-item">
								<a href="#">최근본상품</a>
							</li>
						</ul>
				</div>
			</div>
			
			<div class="col-md-9">
				<div class="page-header text-left">
					<h4>상품정보수정</h4>
				</div>
				<form class= "form-horizontal" name="addProd" enctype="multipart/form-data">
					<input type = "hidden" name = "prodNo" value= "${product.prodNo}">

					<div class="form-group">
						<label for="prodName" class="col-sm-2 control-label" >상품명</label>
		    			<div class="col-sm-4">
		    				<input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}"> 		
						</div>
					</div>	

					<div class="form-group">
						<label for="prodDetail" class="col-sm-2 control-label" >상품상세정보</label>
				    	<div class="col-sm-4">
				    		<input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}"> 		
						</div>
					</div>			
			
					<div class="form-group">
						<label for="manuDate" class="col-sm-2 control-label" >제조일자</label>
				    	<div class="col-sm-4">
				    		<input type="text" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate}">
						</div>
					</div>				
			
					<div class="form-group">
						<label for="price" class="col-sm-2 control-label">가격</label>
				    	<div class="col-sm-4">
				    		<input type="text" class="form-control" id="price" name="price" value="${product.price}">	
						</div>
					</div>				
			
					<div class="form-group">
						<label for="fileName" class="col-sm-2 control-label" >상품이미지</label>
				    	<div class="col-sm-4">
				    		<input type="file" class="form-control" id="fileName" name="fileName"
				    			value= "/images/uploadFiles/${product.fileName}">	
						</div>
					</div>					
			
					<br/><br/><br/>			
				</form>	
					<div class = "Form-group-defalut">
						<button type=button class="btn btn-primary">수정</button>
						<button type=button class="btn btn-primary">취소</button>
					</div>		
			</div>
		</div>
	</div>s

</body>
</html>
