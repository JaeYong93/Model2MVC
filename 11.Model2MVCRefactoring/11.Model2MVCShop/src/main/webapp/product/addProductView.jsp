<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<html lang="ko">
<title>상품등록</title>
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

<script type="text/javascript">

	$(function() {
		$( "button.btn.btn-primary").on("click" , function() {
			fncAddProduct();
		});
	});	

	$(function() {
		$("a[href='#']").on("click" , function() {
			$("form")[0].reset();
		});
	});	

	function fncAddProduct() {
		// Form 유효성 검증
		var name=$("input[name='prodName']").val();
		var detail=$("input[name='prodDetail']").val();
		var date=$("input[name='manuDate']").val();
		var price=$("input[name='price']").val();
		
		if(name == null || name.length <1){
			alert("상품명은 반드시 입력하셔야 합니다.");
			return;
		}
		if(detail == null || detail.length <1){
			alert("상세정보는 반드시 입력하셔야 합니다.");
			return;
		}
		if(date == null || date.length <1){
			alert("제조일자는 반드시 입력하셔야 합니다.");
			return;
		}
		if(price == null || price.length <1){
			alert("가격은 반드시 입력하셔야 합니다.");
			return;
		}
		$("form").attr("method" , "POST").attr("action" , "/product/addProduct").submit();
	}
	
</script>

<script type="text/javascript" src="../javascript/calendar.js">
</script>

	<style>
 		body {
            padding-top : 70px;
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
						 <li class="list-group-item"><a href="#">상품검색</a>
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
	
		<div class="page-header text-left">
			<h4>상품등록</h4>
		</div>
		
		<form class= "form-horizontal" name="addProd" enctype="multipart/form-data">
			<input type = "hidden" name = "menu" value = "${param.menu}">
			
			<div class="form-group">
				<label for="prodName" class="col-sm-2 control-label" >상품명</label>
		    	<div class="col-sm-4">
		    		<input type="text" class="form-control" id="prodName" name="prodName"> 		
				</div>
			</div>	

			<div class="form-group">
				<label for="prodDetail" class="col-sm-2 control-label" >상품상세정보</label>
		    	<div class="col-sm-4">
		    		<input type="text" class="form-control" id="prodDetail" name="prodDetail"> 		
				</div>
			</div>			
			
			<div class="form-group">
				<label for="manuDate" class="col-sm-2 control-label" >제조일자</label>
		    	<div class="col-sm-4">
		    		<input type="text" class="form-control" id="manuDate" name="manuDate">
		    		<img src="../images/ct_icon_date.gif" width= "15" height= "15"
						onclick = "show_calendar('document.addProd.manuDate', document.addProd.manuDate.value)"/>		
				</div>
			</div>				
			
			<div class="form-group">
				<label for="price" class="col-sm-2 control-label" >가격</label>
		    	<div class="col-sm-4">
		    		<input type="text" class="form-control" id="price" name="price">	
				</div>
			</div>				
			
			<div class="form-group">
				<label for="fileName" class="col-sm-2 control-label" >상품이미지</label>
		    	<div class="col-sm-4">
		    		<input type="file" class="form-control" id="fileName" name="fileName">	
				</div>
			</div>					
			
			<br/><br/><br/>
			
			<div class="form-group">
		    	<div class="col-sm-4 text-center">
		    		<button type=button class="btn btn-primary">등록</button>
					<a class="btn btn-primary btn" href="#" role="button">취소</a>		    			
				</div>
			</div>			
			
		</form>
	</div>

</body>
</html>
