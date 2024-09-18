<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html lang="ko">
<title>��ǰ������ȸ</title>
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
	
	
	// ��ǰ �߰� Ȯ�� Event(��ǰ����Ʈ�� ���ư�)
	$(function() {
		$("button.btn.btn-primary:contains('Ȯ��')").on("click", function() {
			self.location = "/product/listProduct?menu=manage";		
		});
	});
	
	// ��ǰ �߰� ��� Event
	$(function() {
		$("button.btn.btn-primary:contains('�߰����')").on("click", function() {
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
								<a href="#">��ǰ�˻�</a>
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
		
			<div class= "col-md-9">
	
				<table class="table table-bordered">
					<thead class = "thead-dark">
						<tr>
							<th colspan="2" class="table-name"><h4>��ǰ���</h4></th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td>��ǰ��</td>
							<td>${product.prodName}</td>
						</tr>
						<tr>
							<td>��ǰ������</td>
							<td>${product.prodDetail}</td>
						</tr>
						<tr>
							<td>��������</td>
							<td>${product.manuDate}</td>
						</tr>
						<tr>
							<td>����</td>
							<td>${product.price}��</td>
						</tr>
						<tr>
							<td>��ǰ�̹���</td>
							<td><img src = "/images/uploadFiles/${product.fileName}" alt="��ǰ�̹���"></td>
						</tr>		
					</tbody>
				
				</table>
				<div class = "Form-group">
					<button type=button class="btn btn-primary">Ȯ��</button>
					<button type=button class="btn btn-primary">�߰����</button>
				</div>
			
			</div>		
		</div>
	</div>

</body>
</html>