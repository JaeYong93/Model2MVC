<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>

<html lang="ko">
<title>��ǰ��������</title>
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

		// ���� ���� ���� Event
		$(function() {
			$("button.btn.btn-primary:contains('����')").on("click", function() {
				fncUpdateProduct();	
			});
		});
		
		// ���� ������ Event
		$(function() {
			$("button.btn.btn-primary:contains('���')").on("click", function() {
				history.back();	
			});
		});	

		// ȸ��������ȸ Event
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('ȸ�������ȸ')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		// ����������ȸȸ Event
	 	$( "a:contains('����������ȸ')" ).on("click" , function() {
	 		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});

		// �ǸŻ�ǰ��� Event
	 	$( "a:contains('�ǸŻ�ǰ���')" ).on("click" , function() {
			$(self.location).attr("href","../product/addProductView.jsp");
		});		

		// �ǸŻ�ǰ���� Event
	 	$( "a:contains('�ǸŻ�ǰ����')" ).on("click" , function() {
			$(self.location).attr("href","/product/listProduct?menu=manage");
		});		
		
		// ��ǰ�˻� Event
	 	$( "a:contains('��ǰ�˻�')" ).on("click" , function() {
			$(self.location).attr("href","/product/listProduct?menu=search");
		});		
		
		// �����̷���ȸ Event
	 	$( "a:contains('�����̷���ȸ')" ).on("click" , function() {
			$(self.location).attr("href","/purchase/listPurchase");
		});

		// ���� Event
	 	$( "a:contains('����')" ).on("click" , function() {
			$(self.location).attr("href","/product/dibProductList");
		});			
		
		// �ֱٺ���ǰ Event
	 	$( "a:contains('�ֱٺ���ǰ')" ).on("click" , function() {
			$(self.location).attr("href","../history.jsp");
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
						alert("���� ������ ��¥�� ������ �� �ֽ��ϴ�.");
						$(this).val(''); 
					}
				} 
			});
		});	
	
		function fncUpdateProduct() {
			// Form ��ȿ�� ����
			var name=$("input[name='prodName']").val();
			var detail=$("input[name='prodDetail']").val();
			var date=$("input[name='manuDate']").val();
			var price=$("input[name='price']").val();
			
			if(name == null || name.length <1){
				alert("�̸��� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(detail == null || detail.length <1){
				alert("�������� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(date == null || date.length <8){
				alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			if(price == null || price.length <1){
				alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
				return;
			}
			$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").submit();
		}

	</script>

	<style>
 		body {
            padding-top : 70px;
        }
        
        h4 {
        	color : green;
        }
        
        .Form-group-defalut {
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
				<div class="page-header text-left">
					<h4>��ǰ��������</h4>
				</div>
				<form class= "form-horizontal" name="addProd" enctype="multipart/form-data">
					<input type = "hidden" name = "prodNo" value= "${product.prodNo}">

					<div class="form-group">
						<label for="prodName" class="col-sm-2 control-label" >��ǰ��</label>
		    			<div class="col-sm-4">
		    				<input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}"> 		
						</div>
					</div>	

					<div class="form-group">
						<label for="prodDetail" class="col-sm-2 control-label" >��ǰ������</label>
				    	<div class="col-sm-4">
				    		<input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}"> 		
						</div>
					</div>			
			
					<div class="form-group">
						<label for="manuDate" class="col-sm-2 control-label" >��������</label>
				    	<div class="col-sm-4">
				    		<input type="text" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate}">
						</div>
					</div>				
			
					<div class="form-group">
						<label for="price" class="col-sm-2 control-label">����</label>
				    	<div class="col-sm-4">
				    		<input type="text" class="form-control" id="price" name="price" value="${product.price}">	
						</div>
					</div>				
			
					<div class="form-group">
						<label for="fileName" class="col-sm-2 control-label" >��ǰ�̹���</label>
				    	<div class="col-sm-4">
				    		<input type="file" class="form-control" id="fileName" name="fileName"
				    			value= "/images/uploadFiles/${product.fileName}">	
						</div>
					</div>					
			
					<br/><br/><br/>			
				</form>	
					<div class = "Form-group-defalut">
						<button type=button class="btn btn-primary">����</button>
						<button type=button class="btn btn-primary">���</button>
					</div>		
			</div>
		</div>
	</div>s

</body>
</html>
