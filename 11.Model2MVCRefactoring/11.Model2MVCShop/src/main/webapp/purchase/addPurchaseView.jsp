<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html lang="ko">
<title>��ǰ����</title>
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
				fncAddPurchase();
			});
		});	
	
		$(function() {
			$("a[href='#']").on("click" , function() {
				$("form")[0].reset();
			});
		});	
	
		 $(function() {
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
		
		function fncAddPurchase() {
			$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
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
	<jsp:include page="/layout/toolbar.jsp"/>
	
	<div class="container">

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
		
			<div class="page-header text-info">
				<h4>��ǰ����</h4>
			</div>
		
			<form class= "form-horizontal" name="addPurchase">
				<input type = "hidden" name = "prodNo" value = "${param.prodNo}"/>
				<input type = "hidden" name = "userId" value = "${user.userId}"/>
				
				<div class="form-group">
					<label for="prodNo" class="col-sm-2 control-label" >��ǰ��ȣ</label>
			    	<div class="col-sm-4">${product.prodNo}</div>
				</div>
	
				<div class="form-group">
					<label for="prodName" class="col-sm-2 control-label" >��ǰ��</label>
			    	<div class="col-sm-4">${product.prodName}</div>
				</div>
				
				<div class="form-group">
					<label for="prodDetail" class="col-sm-2 control-label" >��ǰ������</label>
			    	<div class="col-sm-4">${product.prodDetail}</div>
				</div>					
				
				<div class="form-group">
					<label for="prodDetail" class="col-sm-2 control-label" >����</label>
			    	<div class="col-sm-4">${product.price}��</div>
				</div>			
	
				<div class="form-group">
					<label for="manuDate" class="col-sm-2 control-label" >��������</label>
			    	<div class="col-sm-4">${product.manuDate}</div>
				</div>
				
				<div class="form-group">
					<label for="userId" class="col-sm-2 control-label" >�����ھ��̵�</label>
			    	<div class="col-sm-4">${user.userId}</div>
				</div>			
	
				<div class="form-group">
					<label for="userId" class="col-sm-2 control-label" >�������̸�</label>
			    	<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">		    		
			    	</div>
				</div>
	
				<div class="form-group">
				    <label for="paymentOption" class="col-sm-2 control-label">���Ź��</label>
				    <div class="col-sm-4">
				        <select id="paymentOption" name="paymentOption" class="form-control">
				            <option value="1" ${purchase.paymentOption eq '1' ? 'selected' : ''}>���ݱ���</option>
				            <option value="2" ${purchase.paymentOption eq '2' ? 'selected' : ''}>�ſ뱸��</option>
				        </select>
				    </div>
				</div>
		
				<div class="form-group">
					<label for="receiverPhone" class="col-sm-2 control-label" >�����ڿ���ó</label>
			    	<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
			    	</div>
				</div>			
	
				<div class="form-group">
					<label for="dlvyAddr" class="col-sm-2 control-label" >�������ּ�</label>
			    	<div class="col-sm-4">
			    		<input type="text" class="form-control" id="dlvyAddr" name="dlvyAddr" value="${user.addr}">
			    	</div>
				</div>
				
				<div class="form-group">
					<label for="dlvyRequest" class="col-sm-2 control-label" >���ſ�û����</label>
			    	<div class="col-sm-4">				
			    		<input type="text" class="form-control" id="dlvyRequest" name="dlvyRequest">
			    	</div>	
				</div>		
				
				<div class="form-group">
					<label for="dlvyDate" class="col-sm-2 control-label" >����������</label>
			    	<div class="col-sm-4">				
			    		<input type="text" class="form-control" id="dlvyDate" name="dlvyDate" readyonly="readonly">
			    		<img src="../images/ct_icon_date.gif" width= "15" height= "15"
			    			onclick = "show_calendar('document.addPurchase.dlvyDate', document.addPurchase.dlvyDate.value)">
			    	</div>	
				</div>
			
				<br/>
				
				<div class="form-group">
			    	<div class="col-sm-4 text-center">
			    		<button type=button class="btn btn-primary">����</button>
						<a class="btn btn-primary btn" href="#" role="button">���</a>		    			
					</div>
				</div>
			</div>								
		</form>
	</div>	
	

</body>
</html>