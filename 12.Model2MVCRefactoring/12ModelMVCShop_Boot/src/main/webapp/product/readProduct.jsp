<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">
<title>��ǰ������</title>
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
			        console.log("Error �߻�");
			    }
			});	
	
		//��ǰ ���� Event	
		$(function() {
			$("button.btn.btn-primary").on("click" ,function() {
				$("form").attr("method", "POST").attr("action", "/purchase/addPurchaseView").submit();				
			});	
		});
		
		// ��ǰ ���� ���� �� Ȯ�� Event
		$(function() {
			$("#check").on("click" ,function() {
				self.location = "/product/listProduct?menu=manage";
			});	
		});		
		
		// ���� ������ Event
		$(function() {
			$("a[href='#']").on("click", function() {
				history.back();	
			});
		});
		
		// ����������ȸ Event	
		$(function() {
			$("a[href='#']:contains('����������ȸ')").on("click" , function()  {
				self.location = "/user/getUser?userId=${sessionScope.user.userId}"
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

		// ���� Event
		$(function() { 
			$("a:contains('����')" ).on("click" , function() {
				$(self.location).attr("href","/product/dibProductList");
			});
		});		
				
		// �ֱٺ���ǰ Event
		$(function() { 
		$( "a:contains('�ֱٺ���ǰ')" ).on("click" , function() {
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
						<i class="glyphicon glyphicon-user"></i> ȸ������
					</div>

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
							<li class="list-group-item">
								<a href="#">��ǰ�˻�<span class="badge" id="productCountBadge"></span></a>
							</li>
							<li class="list-group-item">
								<a href="#">�����̷���ȸ</a>
							</li>
							<li class="list-group-item">
								<a href="#">����</a>
							</li>						
							<li class="list-group-item">
								<a href="#">�ֱٺ���ǰ</a>
							</li>
						</ul>
				</div>
			</div>
			
			<div class= "col-md-9">
				<div class ="page-header text-info">
					<h4>��ǰ������</h4>
				</div>

				<form class= "form-horizontal">
					<input type ="hidden" name="prodNo" id="prodNo" value="${product.prodNo}">
					<div class="form-group">
						<label for="prodNo" class="col-sm-2 control-label" >��ǰ��ȣ</label>
				    	<div class="col-md-4">
				    		${product.prodNo}		
						</div>
					</div>
					
					<div class="form-group">
						<label for="prodName" class="col-sm-2 control-label" >��ǰ��</label>
				    	<div class="col-md-4">
				    		${product.prodName}		
						</div>
					</div>
											
					<div class="form-group">
						<label for="fileName" class="col-sm-2 control-label" >��ǰ�̹���</label>
				    	<div class="col-md-4">
				    		<img src = "/images/uploadFiles/${product.fileName}" alt="��ǰ�̹���">		
						</div>
					</div>			
		
					<div class="form-group">
						<label for="prodDetail" class="col-sm-2 control-label" >��ǰ������</label>
				    	<div class="col-md-4">
				    		${product.prodDetail}		
						</div>
					</div>
					
					<div class="form-group">
						<label for="manuDate" class="col-sm-2 control-label" >��������</label>
				    	<div class="col-md-4">
				    		${product.manuDate}		
						</div>
					</div>
		
					<div class="form-group">
						<label for="prodDetail" class="col-sm-2 control-label" >����</label>
				    	<div class="col-md-4">
				    		${product.price}��		
						</div>
					</div>
					
					<div class="form-group">
						<label for="regDate" class="col-sm-2 control-label" >��ǰ�����</label>
				    	<div class="col-md-4">
				    		${product.regDate}		
						</div>
					</div>
		
					<br/><br/><br/>
			
					<div class="form-group">
				    	<div class="col-sm-4 text-center">
							<c:choose>
								<c:when test="${param.menu != null && param.menu eq 'search'}">
				    				<button type=button class="btn btn-primary">����</button>
									<a class="btn btn-primary btn" href="#" role="button">����</a>
								</c:when>
								
								<c:otherwise>
									<button type=button class="btn btn-primary" id="check">Ȯ��</button>
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