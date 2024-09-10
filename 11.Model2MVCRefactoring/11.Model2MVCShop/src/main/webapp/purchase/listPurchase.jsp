<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
<title>���� �����ȸ</title>
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
		function fncGetPurchaseList(currentPage) {	
			document.getElementById("currentPage").value = currentPage;
			document.detailForm.submit();
		}

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
				
			<div class="page-header text-left">
				<h4>���Ÿ����ȸ</h4>
			</div>	

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11" >��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>


	<c:set var = "i" value = "0"/>
	<c:forEach var = "purchase" items = "${list}">
		<c:set var ="i" value = "${i+1}"/>
		<tr class="ct_list_pop">
			<td align="center">
			<a href="/getPurchase?tranNo=${purchase.tranNo}">${i} </a>
			</td>
			<td></td>
		
			<td align="center">
				<a href="/getUser?userId=${purchase.buyer.userId}">${purchase.buyer.userId}</a>
			</td>
			<td></td>
			<td align="center">${purchase.receiverName}</td>
			<td></td>
			<td align="center">${purchase.buyer.phone}</td>
			<td></td>
			<td align="left">
			<c:if test = "${purchase.tranCode == '2'}">
				���� ���ſϷ� �����Դϴ�.	
			</c:if>
			<c:if test = "${purchase.tranCode == '3'}">
				���� ����� �����Դϴ�.
			</c:if>
			<c:if test = "${purchase.tranCode == '4'}">
				���� ��ۿϷ� �����Դϴ�.
			</c:if>										
			</td>
			<td></td>
			 <td align="left">
			 	<c:if test = "${purchase.tranCode == '3'}">
			 	<a href="updateTranCode?tranNo=${purchase.tranNo}&tranCode=${purchase.tranCode}">���ǵ���</a>
				</c:if>				 
			 </td>	
		<td></td>
			</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>			
					
	</c:forEach>

</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		<input type = "hidden" id = "currentPage" name = "currentPage" value=""/> 
			<jsp:include page="../common/pageNavigator_new.jsp">	
				<jsp:param name = "listType" value = "purchase"/>
			</jsp:include>		
		</td>	
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>