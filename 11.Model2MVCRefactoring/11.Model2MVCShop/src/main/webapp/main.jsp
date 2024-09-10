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
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
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
			// ȸ��������ȸ Event	
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('ȸ�������ȸ')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  ����������ȸȸ Event  ó�� =============	
	 	$(function() {
	 		$("a[href='#']:contains('����������ȸ')").on("click" , function()  {
	 			self.location = "/user/getUser?userId=${sessionScope.user.userId}"
	 		});
	 	});

		// �ǸŻ�ǰ��� Event
		$(function() {
	 		$( "a:contains('�ǸŻ�ǰ���')" ).on("click" , function() {
				self.location = "../product/addProductView.jsp"
	 		});
		});		
	
		// �ǸŻ�ǰ���� Event
		$(function() {
	 		$( "a:contains('�ǸŻ�ǰ����')" ).on("click" , function() {
				self.location = "/product/listProduct?menu=manage"
	 		});
	 	});		
		
		// ��ǰ�˻� Event
	 	$(function() {
	 		$("a[href='#' ]:contains('��ǰ�˻�')").on("click" , function()  {
	 			self.location = "/product/listProduct?menu=search"
	 		});
	 	});	
		
		// �����̷���ȸ Event
	 	$(function() {
			$("a[href='#']:contains('�����̷���ȸ')").on("click" , function() {
				self.location = "/purchase/listPurchase";
			});	
		});		
		
		// �ֱٺ���ǰ Event
		$(function() { 
		$( "a:contains('�ֱٺ���ǰ')" ).on("click" , function() {
			$(self.location).attr("href","../history.jsp");
			});
		});	 
		 
	 </script>	
	
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  �Ʒ��� ������ http://getbootstrap.com/getting-started/  ���� -->	
   	<div class="container ">
   	
   		<div class="row">
   			
   			<div class="col-md-3">
   				
   				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-user"></i> ȸ������
         			</div>
         			
         			<!--  ȸ������ ������ -->
					<ul class="list-group">
						<li class="list-group-item">
							<a href="#">����������ȸ</a> 
						 </li>
						 <c:if test="${sessionScope.user.role == 'admin'}">
						 <li class="list-group-item"><a href="#">ȸ�������ȸ</a></li>
						 </c:if>
					</ul>
				</div>
               
                <c:if test="${sessionScope.user.role == 'admin'}">
				<div class="panel panel-primary">
					<div class="panel-heading">
							<i class="glyphicon glyphicon-tasks"></i> ��ǰ����
         			</div>
					<ul class="list-group">
						 <li class="list-group-item">
						 	<a href="#">�ǸŻ�ǰ���</a>
						 </li>
						 <li class="list-group-item">
						 	<a href="#">�ǸŻ�ǰ����</a>
						 </li>
					</ul>
		        </div>
                </c:if>
               
				<div class="panel panel-primary">
					<div class="panel-heading">
							<i class="glyphicon glyphicon-shopping-cart"></i> ��ǰ����
	    			</div>
					<ul class="list-group">
						 <li class="list-group-item"><a href="#">��ǰ�˻�</a>
						 </li>
						  <li class="list-group-item">
						  	<a href="#">�����̷���ȸ</a>
						  </li>
						 <li class="list-group-item">
						 	<a href="#">�ֱٺ���ǰ</a>
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
      <!-- Main jumbotron for a primary marketing message or call to action -->

    </div>

	<!-- ���� : http://getbootstrap.com/css/   : container part..... -->


</body>

</html>