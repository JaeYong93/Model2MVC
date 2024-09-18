<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html lang="ko">
<title>��ǰ���</title>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script src="https:///javascript/bootstrap-dropdownhover.min.js"></script>
	
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
	
	
		// ��ǰ �߰� Event
		$(function() {
			$( "button.btn.btn-primary").on("click" , function() {
				fncAddProduct();
			});
		});	
	
		// �Է� ���� Event
		$(function() {
			$("a[href='#']").on("click" , function() {
				$("form")[0].reset();
			});
		});	

		// ȸ�������ȸ Event
		$(function() {
			$("a:contains('ȸ�������ȸ')").on("click" , function() {
				self.location = "/user/listUser"
			});
		});
		
		// ����������ȸ Event	
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
		
		// jQuery �޷� Event
		$(function(){
			$('#manuDate').datepicker({
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
					today.setHours(0,0,0,0);
					
					if (selectedDate > today) {
						alert("���� ���� ��¥�� ������ �� �ֽ��ϴ�.");
						$(this).val(''); 
					}
				} 
			});
		});
	
		function fncAddProduct() {
			// ������ ��ȿ�� ����
			var name=$("input[name='prodName']").val();
			var detail=$("input[name='prodDetail']").val();
			var date=$("input[name='manuDate']").val();
			var price=$("input[name='price']").val();
			
			if(name == null || name.length <1){
				alert("��ǰ���� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(detail == null || detail.length <1){
				alert("�������� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(date == null || date.length <8){
				alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ� �������ڸ� �������ּ���.");
				return;
			}
			if(price == null || price.length <1){
				alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			$("form").attr("method" , "POST").attr("action" , "/product/addProduct").submit();
		}
		
	</script>

	<style>
 		body {
			padding-top : 70px;
		}
		h4 {
			color : green;
			font-weight : bold;
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
					<h4>��ǰ���</h4>
				</div>
		
				<form class= "form-horizontal" name="addProd" enctype="multipart/form-data">
					<input type = "hidden" name = "menu" value = "${param.menu}">

					<div class="form-group">
						<label for="prodName" class="col-sm-2 control-label" >��ǰ��</label>
		    			<div class="col-sm-4">
		    				<input type="text" class="form-control" id="prodName" name="prodName"> 		
						</div>
					</div>	

					<div class="form-group">
						<label for="prodDetail" class="col-sm-2 control-label" >��ǰ������</label>
				    	<div class="col-sm-4">
				    		<input type="text" class="form-control" id="prodDetail" name="prodDetail"> 		
						</div>
					</div>			
			
					<div class="form-group">
						<label for="manuDate" class="col-sm-2 control-label" >��������</label>
				    	<div class="col-sm-4">
				    		<input type="text" class="form-control" id="manuDate" name="manuDate">
						</div>
					</div>				
			
					<div class="form-group">
						<label for="price" class="col-sm-2 control-label" >����</label>
				    	<div class="col-sm-4">
				    		<input type="text" class="form-control" id="price" name="price">	
						</div>
					</div>				
			
					<div class="form-group">
						<label for="fileName" class="col-sm-2 control-label" >��ǰ�̹���</label>
				    	<div class="col-sm-4">
				    		<input type="file" class="form-control" id="fileName" name="fileName">	
						</div>
					</div>					
			
					<br/><br/><br/>
			
					<div class="form-group">
				    	<div class="col-sm-4 text-center">
				    		<button type=button class="btn btn-primary">���</button>
							<a class="btn btn-primary btn" href="#" role="button">���</a>		    			
						</div>
					</div>
				</form>
			</div>
		</div>		
	</div>

</body>
</html>
