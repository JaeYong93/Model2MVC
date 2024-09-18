<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang ="ko">
<title>���Ż���ȸ</title>
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
	
		// ȸ�������ȸ Event
		$(function() {
			$("a:contains('ȸ�������ȸ')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		});
			
		// ����������ȸȸ Event	
		$(function() {
			$("a[href='#']:contains('����������ȸ')").on("click" , function() {
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
			$("a[href='#' ]:contains('��ǰ�˻�')").on("click" , function() {
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
		
		// �������� ���� Event
		$(function() {
			var tranNo = ${purchase.tranNo};
			var tranCode = ${purchase.tranCode};
			$("button.btn.btn-primary").on("click" , function() {
				if(tranCode===4) {
					alert("�̹� ��� �Ϸ�� ��ǰ���� ������ �Ұ����մϴ�.")
				} else {
					self.location = "updatePurchaseView?tranNo="+tranNo;					
				}
			});
		});	
	
		// Ȯ�� Evnet
		$(function() {
			$("#check").on("click" , function() {
				history.back();
			});
		});			

// 		<a href="/updatePurchaseView?tranNo=${purchase.tranNo}">����</a>
// 		<a href="javascript:history.go(-1);">Ȯ��</a>		
		
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
							<a href="#">����</a>
						</li>						
						<li class="list-group-item">
							<a href="#">�ֱٺ���ǰ</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="col-md-9">
				<table class="table table-bordered">
					<thead class = "thead-dark">
						<tr>
							<th colspan="2" class="table-name"><h4>���ų��� ����ȸ</h4></th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td class="success">��ǰ��ȣ</td>
							<td class="active">${purchase.purchaseProd.prodNo}</td>
						</tr>
						<tr>
							<td class="success">��ǰ��</td>
							<td class="active">${purchase.purchaseProd.prodName}</td>
						</tr>						
						<tr>
							<td class="success">�����ھ��̵�</td>
							<td class="active">${purchase.buyer.userId}</td>
						</tr>
						<tr>
							<td class="success">�������̸�</td>
							<td class="active">${purchase.receiverName}</td>
						</tr>
						<tr>
							<td class="success">�����ݾ�</td>
							<td class="active">${purchase.purchaseProd.price}��</td>
						</tr>						
						<tr>
							<td class="success">���Ź��</td>
							<td class="active">${purchase.paymentOption == '1' ? '���ݱ���' : '�ſ뱸��'}</td>
						</tr>
						<tr>
							<td class="success">�����ڿ���ó</td>
							<td class="active">${purchase.receiverPhone}</td>
						</tr>
						<tr>
							<td class="success">�������ּ�</td>
							<td class="active">${purchase.dlvyAddr}</td>
						</tr>
						<tr>
							<td class="success">���ſ�û����</td>
							<td class="active">${purchase.dlvyRequest}</td>
						</tr>
						<tr>
							<td class="success">��������</td>
							<td class="active">${purchase.dlvyDate}</td>
						</tr>
						<tr>
							<td class="success">�ֹ���</td>
							<td class="active">${purchase.orderDate}</td>
						</tr>						
						
					</tbody>
				
				</table>
				<div class = "Form-group">
					<input type ="hidden" name="tranNo" value="${purchase.tranNo}" id="tranNo">
					<button type=button class="btn btn-primary">����</button>
					<button type=button class="btn btn-primary" id="check">Ȯ��</button>
				</div>					
			
			</div>
		</div>
	</div>						

</body>
</html>