<%@ page contentType="text/html; charset=EUC-KR" %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<title>��� ��ǰ ����</title>
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
		
		// ���� Event
		$(function() { 
			$("a:contains('����')" ).on("click" , function() {
				$(self.location).attr("href","/product/dibProductList");
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
	<jsp:include page="/layout/toolbar.jsp"/>

	<br/><br/>
	

	
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

	<%
	    request.setCharacterEncoding("euc-kr");
	    response.setCharacterEncoding("euc-kr");
	
	    Cookie[] cookies = request.getCookies();
	    String history = null;
	
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("history")) {
	                history = cookie.getValue();
	                break;
	            }
	        }
	    }
	
	    String currentProduct = request.getParameter("prodNo");
	
	    if (currentProduct != null && !currentProduct.isEmpty()) {
	        int prodNo = Integer.parseInt(currentProduct);
	        
	        if (history == null) {
	            history = String.valueOf(prodNo);
	        } else {
	            history += "|" + prodNo;
	        }
	
	        Cookie historyCookie = new Cookie("history", history);
	        historyCookie.setMaxAge(24 * 60 * 60); 
	        response.addCookie(historyCookie);
	    }
	
	    if (history != null) {
	        String[] h = history.split("\\|");
	%>	
			<div class="col-md-9">
				<h4>�ֱٿ����ǰ</h4>
				<div>
	<%
			for (int i = 0; i < h.length; i++) {
	%>			
				<a href="/product/getProduct?prodNo=<%=h[i]%>&menu=search" target="rightFrame"><%=h[i]%></a> <br/>
	<%
			}
	%>			
				</div>
			</div>	
	<%
	    } else {
	%>  
	    	
	    	<div class="col-md-9">
			<h4>�ֱٿ����ǰ</h4>
			<div>
		</div>
	</div>
			
	<% 		
	    }
	%>				


	</div>			

</body>
</html>