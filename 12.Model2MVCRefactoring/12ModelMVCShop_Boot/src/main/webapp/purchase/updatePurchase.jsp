<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang ="ko">
<title>������������</title>
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
		$(function(){
			$('#dlvyDate').datepicker({
				dateFormat: 'yy/mm/dd',
				showMonthAfterYear : true,
				showOn : "both",
				buttonImage: "../images/calander.png",
				changeYear : true,
				changeMonth : true,
				monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
				monthNames: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
				dayNamesMin: ['��','��','ȭ','��','��','��','��'],
				dayNames: ['�Ͽ���','������','ȭ����','������','�����','�ݿ���','�����'],
				position: {
					my: 'right top',
					at: 'right bottom'
				},
				onSelect: function(dateText, inst) {
					var selectedDate = $(this).datepicker('getDate');
					var today = new Date();
					
					if (selectedDate < today) {
						alert("���� ������ ��¥�� ������ �� �ֽ��ϴ�.");
						$(this).val(''); 
					}
				}
			});
		});
		
		// �������� ���� Event
		$(function() {
			$("button.btn.btn-primary").on("click", function() {
				fncUpdatePurchase();	
			});
		});		
		
		function fncUpdatePurchase() {
			// Form ��ȿ�� ����
			var tranNo=$("input[name='tanNo']").val();
			var name=$("input[name='receiverName']").val();
			var phone=$("input[name='receiverPhone']").val();
			var addr=$("input[name='dlvyAddr']").val();
			var date=$("input[name='dlvyDate']").val();
			
			if(name == null || name.length <1){
				alert("�̸��� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(phone == null || phone.length <1){
				alert("����ó�� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(addr == null || addr.length <1){
				alert("�ּҴ� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(date == null || date.length <1){
				alert("���������� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			$("form").attr("method" , "POST").attr("action" , "/purchase/updatePurchase").submit();
		}
		
		
		// ���� ��� Event
		$(function() {
			$("#undo").on("click", function() {
				history.back();
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
	 	$( "a:contains('����')" ).on("click" , function() {
			$(self.location).attr("href","/product/dibProductList");
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
</head>

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
                         <li><a href="#">��ǰ�˻�</a></li>
                         <li><a href="#">�����̷���ȸ</a></li>
                         <li><a href="#">����</a></li>	                         
                         <li><a href="#">�ֱٺ���ǰ</a></li>
					</ul>
				</div>
			</div>			
	
			<div class="col-md-9">
				<form>
				<input type ="hidden" name="tranNo" value="${purchase.tranNo}" id="tranNo">
				<table class="table table-bordered">
					<thead class = "thead-dark">
						<tr>
							<th colspan="2" class="table-name"><h4>������������</h4></th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td class="success">�����ھ��̵�</td>
							<td class="active">${purchase.buyer.userId}</td>
						</tr>
						<tr>
							<td class="success">�������̸�</td>
							<td class="active">
								<input type = "text" name = "receiverName" value = "${purchase.receiverName}">
							</td>
						</tr>
						<tr>
							<td class="success">���Ź��</td>
							<td class="active">
								<select id="paymentOption" name="paymentOption">
									<option value="1" ${purchase.paymentOption eq '1' ? 'selected' : ''}>���ݱ���</option>
									<option value="2" ${purchase.paymentOption eq '2' ? 'selected' : ''}>�ſ뱸��</option>
								</select>
							</td>
						</tr>						
						<tr>
							<td class="success">������ ����ó</td>
							<td class="active">
								<input type = "text" name = "receiverPhone" value = "${purchase.receiverPhone}">
							</td>
						</tr>
						<tr>
							<td class="success">������ �ּ�</td>
							<td class="active">
								<input type = "text" name = "dlvyAddr" value = "${purchase.dlvyAddr}">
							</td>
						</tr>
						<tr>
							<td class="success">���ſ�û����</td>
							<td class="active">
								<input type = "text" name = "dlvyRequest" value = "${purchase.dlvyRequest}">
							</td>
						</tr>
						<tr>
							<td class="success">��������</td>
							<td class="active">
								<input type = "text" readonly="readonly" name = "dlvyDate" id="dlvyDate" value = "${purchase.dlvyDate}">
							</td>
						</tr>
					</tbody>
				</table>
				<div class = "Form-group">
					<input type ="hidden" name="tranNo" value="${purchase.tranNo}" id="tranNo">
					<button type=button class="btn btn-primary" data-tranNo ="${purchase.tranNo}">����</button>
					<button type=button class="btn btn-primary" id="undo">���</button>
				</div>	
				</form>
				
			</div>
		</div>
	</div>		

</body>
</html>