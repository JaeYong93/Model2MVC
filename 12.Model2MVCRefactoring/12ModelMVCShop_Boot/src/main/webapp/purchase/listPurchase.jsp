<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<title>���Ÿ����ȸ</title>
<head>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>	

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
	
		//���Ż�ǰ ��ȸ Event
		function fncGetPurchaseList(currentPage) {	
			$("#currentPage").val(currentPage)
			$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
		}

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
	
		// �ֹ��󼼺��� Event
		$(function() {
			$("td:nth-child(5n)").on("click", function() {
				var tranNo = $(this).data('tranno');
				self.location = "/purchase/getPurchase?tranNo="+tranNo;
			});				
		});
		
		// ���Ȯ�� Event
		$(function() {
			$("td:nth=child(7n)").on("click", function() {
				var tranNo = $(this).data('tranno');
				var tranCode2 = $(this).data('trancode');
				var tranCode = String(tranCode2);
				console.log(tranNo);
				self.location = "/purchase/updateTranCode?tranNo="+tranNo+"&tranCode="+tranCode;
			});				
		});

	</script>

	<style>
 		body {
			padding-top : 70px;
		}

		h4 {
			color : blue;
			font-weight : bold;
		}
		
		th {
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
							<a href="#">��ǰ�˻� <span class="badge" id="productCountBadge"></span></a>
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

				<div class="page-header text-left">
					<h4>���Ÿ����ȸ</h4>
				</div>
				
				<p class="text-primary">
					��ü ${resultPage.totalCount}��, ���� ${resultPage.currentPage}������
				</p>
			
				<table class="table table-bordered">
				<input type = "hidden" id = "currentPage" name = "currentPage" value="">
					<thead>
						<tr>
							<th>No</th>
							<th>�ֹ���ȣ</th>
							<th>��ǰ��</th>
							<th>�����ݾ�</th>
							<th>�ֹ��󼼺���</th>
							<th>�����Ȳ</th>
							<th>����Ȯ��</th>
						</tr>
					</thead>
					
					<tbody>
						<c:set var="i" value ="0"/>
						<c:forEach var = "purchase" items = "${list}">
							<c:set var ="i" value = "${i+1}"/>
							<tr>
								<td align="center">${i}</td>
								<td align="center">${purchase.tranNo}</td> 
								<td align="center">${purchase.purchaseProd.prodName}</td>
								<td align="right">${purchase.purchaseProd.price}��</td>
								<td align="center" data-tranNo = "${purchase.tranNo}">�󼼺���</td>
								<td align="left">
								<c:if test = "${purchase.tranCode == '2'}">
									���Ÿ� �Ϸ��߽��ϴ�.	
								</c:if>
								<c:if test = "${purchase.tranCode == '3'}">
									���� ��ǰ ������Դϴ�.
								</c:if>
								<c:if test = "${purchase.tranCode == '4'}">
									��ǰ�� ��ۿϷ� �Ǿ����ϴ�.
								</c:if>	
								</td>
								<td align="left"  data-tranNo = "${purchase.tranNo}" data-tranCode = "${purchase.tranCode}">	
								<c:if test = "${purchase.tranCode == '3'}">
			 						���Ȯ��
								</c:if>	
								</td>
							</tr>			
						</c:forEach>
					</tbody> 
				</table>
			</div>	
	
			<jsp:include page="../common/pageNavigator_new.jsp">	
				<jsp:param name = "listType" value = "purchase"/>
			</jsp:include>
		</div>				
	</div>

</body>
</html>