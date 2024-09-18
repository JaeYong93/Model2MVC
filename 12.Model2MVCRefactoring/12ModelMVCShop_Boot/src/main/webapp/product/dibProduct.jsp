<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<html lang="ko">
<title>����</title>
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
	
		//���ϱ� ���
		$(function() {
			$("td:nth-child(5n)").on("click", function() {
				var prodNo = $(this).data('prodno');
				alert("���ϱⰡ ��ҵǾ����ϴ�.");
				self.location = "dibCancleProduct?prodNo="+prodNo+"&menu=search";	
			});
		});

		//���� ��ǰ��ȸ
		$(function() {
			$("td:nth-child(2n)").on("click", function() {
				var prodNo = $(this).data('prodno');
				self.location = "getProduct?prodNo="+prodNo+"&menu=search";	
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
		
		h4 {
			color : red;
			font-weight : bold;
		}
		
		th {
			text-align : center;
		}
		
        img  {
        	width : 50px;
        	height : 50px;
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
				<div class ="page-header text-info">
					<h4>���ѻ�ǰ</h4>
				</div>
				
					<table class="table table-hover">
						<thead>
							<tr>
								<th>No</th>
								<th>��ǰ��</th>
								<th>��ǰ�̹���</th>
								<th>����</th>
								<th>����</th>
							</tr>	
						</thead>
						
						<tbody>
						<c:set var="i" value ="0"/>
						<c:forEach var = "product" items = "${list}">
							<c:set var ="i" value = "${i+1}"/>
							<tr>
								<td align="center">${i}</td>
								<td align="center" data-prodNo = "${product.prodNo}">${product.prodName}</td>
								<td align="center"><img src="/images/uploadFiles/${product.fileName}"></td>								 
								<td align="center"><fmt:formatNumber value="${product.price}" pattern = "#,###"/>��</td>
								<td align="center" data-prodNo = "${product.prodNo}">
								���ѻ��� ���ϱ� ���
								</td>
							</tr>			
						</c:forEach>						
						
						</tbody>
					</table>
			</div>
			<jsp:include page="../common/pageNavigator_new.jsp">	
				<jsp:param name = "listType" value = "dibProduct"/>
			</jsp:include>	
			
		</div>			
	</div>	
					

</body>